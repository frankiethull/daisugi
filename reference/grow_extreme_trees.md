# Grow Extreme Trees

XGBoost Boosted Forest: each boosting round grows a forest of
`num_parallel_tree` trees rather than a single tree. Based on the
XGBoost random forest + boosting hybrid described at
<https://xgboost.readthedocs.io/en/stable/tutorials/rf.html>.

## Usage

``` r
grow_extreme_trees(
  x,
  y,
  trees = 50L,
  task = "classification",
  num_parallel_tree = 10L,
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

  num of boosting rounds (each round grows a forest)

- task:

  a task

- num_parallel_tree:

  number of trees per forest per round

- exotic:

  logical; if TRUE, apply additional exotic parameters

- ...:

  other eng args

## Value

a fitted model

## Details

When `exotic = FALSE` (default), parameters follow the paper-faithful
boosted random forest configuration: gradient-based row sampling with
moderate column subsampling per node.

When `exotic = TRUE`, additional daisugi params are applied: cumulative
column sampling across all three `colsample_by*` levels, reduced lambda
for deeper trees, and leaf-wise (`lossguide`) growth within each forest
member.
