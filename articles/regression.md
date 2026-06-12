# regression

[TABLE]

showcasing how to use daisugi for regression. our dataset comes from
forested, a tabular data repo which lists forest attributes & whether an
area is “forested” or “non-forested”.

for regression, we’re switching the target variable (y) from the typical
classification, to a regression problem. Based on the information we
know, are we able to predict, or estimate, the annual precipitation?

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

``` r

library(daisugi)
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
  trees = 5L,
  task = "regression"
)

harvest_snap_trees(snap_trees, x_test) |> head()
#> [1] 1205.415 1098.448 1343.484 1403.593 1852.381 1642.116
```

### conditional trees

Conditional Trees (a conditional forest) are ported from the
{partykit::cforest} implementation. cforest is a bagging algorithm for
the ctree p-value tree-based algorithm.

``` r

conditional_trees <- grow_conditional_trees(
  x_train,
  y_train,
  trees = 10L,
  task = "regression"
)

harvest_conditional_trees(conditional_trees, x_test) |> head()
#>         1         2         3         4         5         6 
#> 1286.7545  974.8898 1408.4124 1733.1874 2755.1673 2413.9281
```

### Boulevard

Boulevard: Regularized Stochastic Gradient Boosted Trees and Their
Limiting Distribution. Boulevard introduces subsampling and employs a
modified shrinkage algorithm so that at every boosting stage the
estimate is given by an average of trees. Therefore as the tree number
increases, the prediction should converge.

*Boulevard boosting is specifically focused on regression tasks and does
not support classification by default.*

``` r

boulevard_trees <- grow_boulevard_trees(
  x_train,
  y_train,
  trees = 10L,
  task = "regression"
)

harvest_boulevard_trees(boulevard_trees, x_test) |> head()
#> [1] 1258.671 1725.029 1778.961 1426.504 2404.590 1642.045
```
