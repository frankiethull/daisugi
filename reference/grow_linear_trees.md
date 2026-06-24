# Grow Linear (Dart) Trees

LightGBM Piecewise-Linear DART: fits a ridge regression at each leaf
(rather than a constant) while applying tree dropout to prevent early
linear models from dominating later rounds. Inspired by GBDT-PL
<https://arxiv.org/abs/1802.05640> with DART regularization.

## Usage

``` r
grow_linear_trees(
  x,
  y,
  trees = 100L,
  task = "classification",
  drop_rate = 0.1,
  linear_lambda = 0.5,
  exotic = FALSE,
  ...
)
```

## Arguments

- x:

  a data X

- y:

  a data Y

- trees:

  num of boosting rounds

- task:

  a task

- drop_rate:

  fraction of previous trees dropped per round

- linear_lambda:

  L2 regularization on leaf linear models

- exotic:

  logical; if TRUE, apply additional exotic parameters

- ...:

  other eng args

## Value

a fitted model

## Details

When `exotic = FALSE` (default), parameters follow the GBDT-PL paper
spirit: linear leaves, DART dropout, forest normalization, path
smoothing for small-leaf stability.

When `exotic = TRUE`, ExtraTrees-style random split thresholds are added
(`extra_trees = TRUE`), creating triple stochasticity: random
thresholds + column subsampling + tree dropout. `one_drop = TRUE`
guarantees at least one tree is always dropped.
