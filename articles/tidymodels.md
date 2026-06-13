# tidymodels

[TABLE]

#### Prepare Dataset

following along with our getting started task, except with a tidymodels
perspective, we have the forested data setup below. we no longer need to
split into an (x, y) interface & will use the formula method for this
tidymodels vignette.

``` r

library(daisugi)
library(forested)
library(parsnip)
library(rsample)
set.seed(5311)

# defining splits for training and testing datasets
splits <- rsample::initial_split(forested::forested)
training <- rsample::training(splits)
testing <- rsample::testing(splits)
```

### EBMs

The Explainable Boosting Machine is registered as a `boost_tree` & as a
`explainable_boost` engine, it has a few similar parameters, and many
unique ones. a handful of the unique parameters were also registered to
dials within daisugi so full-on-total hyperparameter optimization can be
done within cross-validation in tidymodels.

#### boost_tree specification (lite):

``` r

ebm_cls_spec_lite <-
  boost_tree(
    # GBM parameters
    trees = 500,
    min_n = 2,
    tree_depth = 5,
    learn_rate = 0.015,
    stop_iter = 250
  ) |>
  set_mode("classification") |>
  set_engine("ebm")

ebm_cls_spec_lite
#> Boosted Tree Model Specification (classification)
#> 
#> Main Arguments:
#>   trees = 500
#>   min_n = 2
#>   tree_depth = 5
#>   learn_rate = 0.015
#>   stop_iter = 250
#> 
#> Computational engine: ebm
```

#### explainable_boost specification:

this contains more tunable parameters, adding additional slots than what
`boost_tree` contains. check out the registered & tunable parameters.

``` r

ebm_cls_spec <-
  explainable_boost(
    # GBM parameters
    trees = 500,
    min_n = 2,
    tree_depth = 5,
    learn_rate = 0.015,
    stop_iter = 250,
    # tier 1 ebm parameters
    num_interactions = 3L,
    max_bins = 1024L,
    greedy_ratio = 10L,
    smoothing_rounds = 75L,
    regularization_lambda = 0L,
    regularization_alpha = 0L,
    # tier 2 ebm parameters
    max_interaction_bins = 64L,
    interaction_smoothing_rounds = 75L,
    outer_bags = 14L,
    inner_bags = 0L
  ) |>
  set_mode("classification") |>
  set_engine("ebm")

ebm_cls_spec
#> explainable boost Model Specification (classification)
#> 
#> Main Arguments:
#>   trees = 500
#>   min_n = 2
#>   tree_depth = 5
#>   learn_rate = 0.015
#>   stop_iter = 250
#>   num_interactions = 3
#>   max_bins = 1024
#>   greedy_ratio = 10
#>   smoothing_rounds = 75
#>   regularization_lambda = 0
#>   regularization_alpha = 0
#>   max_interaction_bins = 64
#>   interaction_smoothing_rounds = 75
#>   outer_bags = 14
#>   inner_bags = 0
#> 
#> Computational engine: ebm
```

#### fit:

``` r

# fit --
ebm_cls_fit <- ebm_cls_spec |>
  fit(
    forested ~ .,
    data = training |> dplyr::select(-tree_no_tree, -land_type, -county)
  )
```

#### pred:

``` r

# predictions --
preds <- predict(ebm_cls_fit, testing, type = "raw")
preds |> head()
#> [1] "Yes" "Yes" "Yes" "Yes" "Yes" "Yes"
```

### YDFs

for the ‘ydf’ engine, this is specifically the boosting engine and
tethered to `boost_tree`.

``` r

ydf_cls_spec <-
  boost_tree(
    # GBM parameters
    trees = 500,
    min_n = 2,
    tree_depth = 5,
    learn_rate = 0.015,
    stop_iter = 250,
    mtry = 0.2,
    loss_reduction = 0.1,
    sample_size = 0.9
  ) |>
  set_mode("classification") |>
  set_engine("ydf")

ydf_cls_spec
#> Boosted Tree Model Specification (classification)
#> 
#> Main Arguments:
#>   mtry = 0.2
#>   trees = 500
#>   min_n = 2
#>   tree_depth = 5
#>   learn_rate = 0.015
#>   loss_reduction = 0.1
#>   sample_size = 0.9
#>   stop_iter = 250
#> 
#> Computational engine: ydf
```

``` r

ydf_cls_fit <- ydf_cls_spec |>
  fit(
    forested ~ .,
    data = training |> dplyr::select(-tree_no_tree, -land_type, -county)
  )
#> Train model on 5330 examples
#> Model trained in 0:00:01.121944
```

``` r

preds <- predict(ydf_cls_fit, testing, type = "raw")
preds |> head()
#> [1] "Yes" "Yes" "Yes" "Yes" "Yes" "Yes"
```

*type = ‘raw’ is the only method in daisugi 0.0.7, type probas and class
support will be added in the future*
