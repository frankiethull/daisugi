# probabilistic

[TABLE]

showcasing how to use daisugi for probabilistic regression. our dataset
comes from forested, a tabular data repo which lists forest attributes &
whether an area is “forested” or “non-forested”.

for regression, we’re switching the target variable (y) from the typical
classification, to a regression problem. Based on the information we
know, are we able to predict, or estimate, the annual precipitation?

for this probablility section, we’ll focus on the coverage moreso than
the point prediction itself.

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
y_train <- training |> dplyr::select(precip_annual) |> dplyr::pull()

# (x, y) Testing:
x_test <- testing |>
  dplyr::select(-forested, -tree_no_tree, -land_type, -county)

y_test <- testing |> dplyr::select(precip_annual) |> dplyr::pull()

head(y_test)
#> [1] 1297 1036 1611 1736 2883 2312
```

### Machines with Prediction Intervals

#### NGBoost

##### natural gradient boosting machines

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
  trees = 5L,
  task = "regression"
)
#> [iter 0] loss=8.3240 val_loss=0.0000 scale=1.0000 norm=813.1857

harvest_natural_trees(natural_trees, x_test) |> head()
#> [1] 1147.312 1120.466 1183.283 1183.283 1272.094 1223.306
```

#### NRGBoost

##### energy-based generative boosted trees

NRGBoost is an energy-based generative boosting algorithm. The design
does not require a target(y) variable but this logic is added for
daisugi for ease-of-use.

``` r

energy_trees <- grow_energy_trees(
  x_train,
  y_train,
  trees = 5L,
  task = "regression"
)

harvest_energy_trees(energy_trees, x_test) |> head()
#> [1] 1532.965 1740.489 1466.145 1493.910 1494.399 1494.236

# fun fact: NRG can draw samples: energy_trees$fit$sample(5L)
```

### Model Agnostic Conformity with {predictset}

#### perpetual with predictset

predictset is a newer R library (2026) for model-agnostic and
distribution-free uncertainty quantification. predictset contains
methods for both classification & regression, works with any model, &
contains what i would call ‘not-so-well-known’ conformal prediction for
R.

we’ll use the perpetual machine for this example, but any of the
machines could be used here.

##### perpetual

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
#> [1]  905 1804  905 1718 2446 2638
```

##### jackknife+ intervals (WIP)

<https://github.com/charlescoverdale/predictset>
