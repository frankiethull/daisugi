# daisugi

[TABLE]

### Workflow Overview

A typical daisugi workflow:

1.  prepare predictors and targets
2.  grow a machine
3.  harvest predictions
4.  evaluate externally using your preferred tooling

daisugi intentionally avoids imposing a modeling framework and instead
focuses on exposing novel algorithms through a lightweight interface.

### A Classification Task

showcasing how to use daisugi for classification. our dataset comes from
forested, a tabular data repo which lists forest attributes & whether an
area is “forested” or “non-forested”.

#### Prepare Dataset

``` r

library(daisugi)
library(forested)
library(rsample)
set.seed(5311)

# defining splits for training and testing datasets
splits <- rsample::initial_split(forested::forested)
training <- rsample::training(splits)
testing <- rsample::testing(splits)


# (x, y) Training:
x_train <- training |>
  # target (and factors as not all engines handle cats)
  dplyr::select(-forested, -tree_no_tree, -land_type, -county)

# our target variable:
y_train <- training |> dplyr::select(forested) |> dplyr::pull()

# (x, y) Testing:
x_test <- testing |>
  dplyr::select(-forested, -tree_no_tree, -land_type, -county)

y_test <- testing |> dplyr::select(forested) |> dplyr::pull()

head(y_test)
#> [1] No  Yes Yes Yes Yes Yes
#> Levels: Yes No
```

### yggdrasil decision forests

Yggdrasil Decision Forests (YDF) is Google’s high-performance tree
ecosystem supporting gradient boosted trees, random forests, and
specialized split strategies.

The implementation exposed through daisugi emphasizes:

- oblique random splits
- scalable forest construction
- modern decision forest infrastructure

``` r

ydf_trees <- grow_yggdrasil_trees(
  x_train,
  y_train,
  trees = 5L
)
#> Downloading uv...Done!
#> Train model on 5330 examples
#> Model trained in 0:00:00.038857

harvest_yggdrasil_trees(ydf_trees, x_test) |> head()
#> [1] "Yes" "Yes" "Yes" "Yes" "Yes" "Yes"
```

### snap boosting machines

SnapBoost originates from IBM’s Snap ML ecosystem.

Unlike traditional gradient boosting systems, SnapBoost uses
heterogeneous Newton boosting where each iteration may alternate
between:

- decision trees
- linear regressors
- random Fourier feature approximators

This creates a hybrid ensemble structure rather than a purely tree-based
booster.

``` r

snap_trees <- grow_snap_trees(
  x_train,
  y_train,
  trees = 5L
)

harvest_snap_trees(snap_trees, x_test) |> head()
#> [1] "No" "No" "No" "No" "No" "No"
```

### perpetual

Perpetual is a budget-driven boosting methodology designed around
adaptive predictive scaling rather than extensive hyperparameter tuning.

The core idea is:

- increase predictive budget
- monitor loss stabilization
- stop when improvement plateaus

This creates an AutoML-like boosting workflow with minimal tuning
overhead.

``` r

perpetual_trees <- grow_perpetual_trees(
  x_train,
  y_train
)

harvest_perpetual_trees(perpetual_trees, x_test) |> head()
#> [1] 0 0 0 0 0 0
```

### wildwood

WildWood is an advanced probabilistic random forest algorithm
emphasizing aggregation over multiple possible tree prunings.

Unlike standard random forests, WildWood combines:

- randomized forests
- exponential weighting
- out-of-bag pruning aggregation

This produces highly adaptive ensemble behavior.

``` r

wild_trees <- grow_wild_trees(
  x_train,
  y_train,
  trees = 5L
)

harvest_wild_trees(wild_trees, x_test) |> head()
#> [1] "Yes" "No"  "Yes" "Yes" "Yes" "Yes"
```

### explainable boosting machines

Explainable Boosting Machines (EBMs) are interpretable generalized
additive boosting systems developed by Microsoft’s InterpretML project.

EBMs aim to balance:

- predictive performance
- transparency
- interaction discovery
- human interpretability

They are often considered “glassbox” models because their learned
structure remains directly inspectable.

``` r

explainable_trees <- grow_explainable_trees(
  x_train,
  y_train,
  trees = 5L
)

harvest_explainable_trees(wild_trees, x_test) |> head()
#> [1] "Yes" "No"  "Yes" "Yes" "Yes" "Yes"
```

### natural gradient boosting machines

NGBoost introduces probabilistic prediction into gradient boosting
systems.

Rather than predicting only point estimates, NGBoost models predictive
distributions directly using natural gradients.

This enables:

- uncertainty estimation
- probabilistic forecasting
- calibrated predictive intervals

``` r

natural_trees <- grow_natural_trees(
  x_train,
  y_train,
  trees = 5L
)
#> [iter 0] loss=0.6879 val_loss=0.0000 scale=4.0000 norm=8.0000

harvest_natural_trees(natural_trees, x_test) |> head()
#> [1] 0 0 0 0 0 0
```

### energy-based generative boosted trees

NRGBoost is an energy-based generative boosting algorithm. The design
does not require a target(y) variable but this logic is added for
daisugi for ease-of-use.

``` r

energy_trees <- grow_energy_trees(
  x_train,
  y_train |> as.integer() - 1,
  trees = 5L
)

harvest_energy_trees(energy_trees, x_test) |> head()
#> [1] 0.07347243 0.45393993 0.07087025 0.45357028 0.19876139 0.18953708

# fun fact: NRG can draw samples: energy_trees$fit$sample(5L)
```

### evolutionary trees

Evolutionary Trees comes from {evtree} R package. Which involves
evolutionary learning of global optimal trees for both classification
and regression.

``` r

evolutionary_trees <- grow_evolutionary_trees(
  x_train,
  y_train,
  trees = 10L
)

harvest_evolutionary_trees(evolutionary_trees, x_test) |> head()
#>   1   2   3   4   5   6 
#> Yes Yes Yes Yes Yes Yes 
#> Levels: Yes No
```

### conditional trees

Conditional Trees (a conditional forest) are ported from the
{partykit::cforest} implementation. cforest is a bagging algorithm for
the ctree p-value tree-based algorithm.

``` r

conditional_trees <- grow_conditional_trees(
  x_train,
  y_train,
  trees = 10L
)

harvest_conditional_trees(conditional_trees, x_test) |> head()
#>   1   2   3   4   5   6 
#> Yes Yes Yes Yes Yes Yes 
#> Levels: Yes No
```
