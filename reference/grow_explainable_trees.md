# Grow Explainable Trees

Grow Explainable Trees

## Usage

``` r
grow_explainable_trees(
  x,
  y,
  trees = 50000L,
  early_stop_tree = 100L,
  task = "classification",
  ...
)
```

## Arguments

- x:

  a data X

- y:

  a data Y

- trees:

  max num of trees (default: 50000)

- early_stop_tree:

  trigger early stopping if no improvement (default: 100)

- task:

  a task

- ...:

  other eng args

## Value

a fitted model
