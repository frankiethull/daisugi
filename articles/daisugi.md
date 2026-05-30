# daisugi

## Getting Started with daisugi

daisugi uses (x, y) nomenclature for fitting machines & primarily focus
is for classification and regression tasks. to fit a machine, typically
these machines are prefixed by `grow_` and to infer with a **grown**
machine, one will `harvest_`.

### A Classification Task

showcasing how to use daisugi for classification. our dataset comes from
forested, a tabular data repo which lists forest attributes & whether an
area is “forested” or “non-forested”.

``` r

library(daisugi)
library(forested)
library(rsample)

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
#> [1] Yes Yes Yes Yes No  No 
#> Levels: Yes No
```

#### yggdrasil decision forests

YDF provides various methods such as boosters, decisions, forests. what
is unique is the a oblique random split technique. daisugi provides the
boosted method with yggdrasil.

``` r

ydf_trees <- grow_yggdrasil_trees(
  x_train,
  y_train,
  trees = 20L
)
#> Downloading uv...Done!
#> Train model on 5330 examples
#> Model trained in 0:00:00.138209

harvest_yggdrasil_trees(ydf_trees, x_test) |> head()
#> [1] "Yes" "Yes" "Yes" "Yes" "No"  "No"
```

### snap boosting machines

SnapML is a IBM ML repository. within it, contains various ML engines,
including their own implementation called SnapBoost. SnapBoost differs
from XGBoost by using Heterogeneous Newton Boosting. In addition, for
each iteration, SnapBoost method randomly chooses whether to use a
decision tree with variable depth or a linear regressor with random
fourier features.

``` r

snap_trees <- grow_snap_trees(
  x_train,
  y_train,
  trees = 10L
)

harvest_snap_trees(snap_trees, x_test) |> head()
#> [1] "No" "No" "No" "No" "No" "No"
```

### perpetual

Perpetual is a budget-based boosting methodology. perpetual is designed
to be a drop-in automl-like booster that does not require hyperparameter
optimization. The idea being, a user can increase the budget, the
‘predictive power’ parameter, until loss plateaus.

``` r

perpetual_trees <- grow_perpetual_trees(
  x_train,
  y_train
)

harvest_perpetual_trees(perpetual_trees, x_test) |> head()
#> [1] 0 0 0 0 1 1
```

### wildwood

WildWood is a *new (2021)* & *advanced* random forest algorithm. …
“predictions produced by WildWood are an aggregation with exponential
weights (computed on out-of-bag samples) of the predictions given by all
the possible prunings of each tree.” which differs from a standard
random forest.

``` r

wild_trees <- grow_wild_trees(
  x_train,
  y_train,
  trees = 10L
)

harvest_wild_trees(wild_trees, x_test) |> head()
#> [1] "Yes" "Yes" "Yes" "Yes" "No"  "No"
```

### explainable boosting machines

“Explainable Boosting Machine (EBM) is a tree-based, cyclic gradient
boosting Generalized Additive Model with automatic interaction
detection.” EBMs are considered ‘glassbox’ as they are easier to
interpret, more effective than traditional GAMS, and “…often as accurate
as SOTA blackbox models” while maintaining interpetability.

``` r

explainable_trees <- grow_explainable_trees(
  x_train,
  y_train,
  trees = 100L
)

harvest_explainable_trees(wild_trees, x_test) |> head()
#> [1] "Yes" "Yes" "Yes" "Yes" "No"  "No"
```

### natural gradient boosting machines

NGBoost from Stanford ML Group. bringing uncertainty and probabilistic
estimation to gradient boosting.

``` r

natural_trees <- grow_natural_trees(
  x_train,
  y_train,
  trees = 100L
)
#> [iter 0] loss=0.6887 val_loss=0.0000 scale=4.0000 norm=8.0000

harvest_natural_trees(natural_trees, x_test) |> head()
#> [1] 0 0 0 0 1 1
```
