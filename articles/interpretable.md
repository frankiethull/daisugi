# interpretable

## Interpretable Trees with daisugi

showcasing interpretable tree engines: FIGS, SkopeRules, and TAO from
the imodels package, plus STreeD optimal sparse trees. our dataset comes
from forested, a tabular data repo which lists forest attributes &
whether an area is “forested” or “non-forested”.

#### Prepare Dataset

``` r

library(daisugi)
library(forested)
library(rsample)
set.seed(5311)

splits <- rsample::initial_split(forested::forested)
training <- rsample::training(splits)
testing <- rsample::testing(splits)

x_train <- training |>
  dplyr::select(-forested, -tree_no_tree, -land_type, -county)
y_train <- training |> dplyr::select(forested) |> dplyr::pull()

x_test <- testing |>
  dplyr::select(-forested, -tree_no_tree, -land_type, -county)
y_test <- testing |> dplyr::select(forested) |> dplyr::pull()
```

``` r

library(daisugi)
```

### FIGS (Fast Interpretable Greedy-tree Sums)

FIGS grows a small set of trees whose leaves sum to the prediction. Each
tree is interpretable on its own, and the sum stays readable.

``` r

figs_fit <- grow_figs(
  x_train,
  y_train,
  trees = 5L,
  task = "classification"
)

figs_pred <- harvest_figs(figs_fit, x_test)
head(figs_pred)
#> [1] 0 0 0 0 0 0
```

### SkopeRules (interpretable rule lists)

SkopeRules learns a compact set of high-precision rules from gradient
boosted trees.

``` r

skope_fit <- grow_skope_rules(
  x_train,
  y_train,
  trees = 10L,
  task = "classification"
)

skope_pred <- harvest_skope_rules(skope_fit, x_test)
head(skope_pred)
#> [1] 0 0 0 0 0 0
```

### TAO (Tree Alternating Optimization)

TAO optimizes the tree structure directly rather than growing greedily.

``` r

tao_fit <- grow_tao(
  x_train,
  y_train,
  trees = 10L,
  task = "classification"
)

tao_pred <- harvest_tao(tao_fit, x_test)
head(tao_pred)
#> [1] 0 0 0 0 0 0
```

### STreeD (optimal sparse trees)

STreeD finds provably optimal sparse decision trees via dynamic
programming.

``` r

streed_fit <- grow_streed(
  x_train,
  y_train,
  trees = 3L,
  task = "classification"
)

streed_pred <- harvest_streed(streed_fit, x_test)
head(streed_pred)
#> [1] 0 0 0 0 0 0
```
