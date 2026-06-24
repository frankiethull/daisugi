# Grow Langevin Trees

CatBoost Stochastic Gradient Langevin Boosting (SGLB): injects
calibrated Langevin diffusion noise into gradient updates, converting
boosting into a Markov chain sampler over function space. Guarantees
global convergence for non-convex losses where standard GBM can only
guarantee local optima. See <https://arxiv.org/abs/2001.07248>.

## Usage

``` r
grow_langevin_trees(
  x,
  y,
  trees = 100L,
  task = "classification",
  diffusion_temperature = 10000,
  model_shrink_rate = 0.05,
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

- diffusion_temperature:

  Langevin noise amplitude; higher = more exploration

- model_shrink_rate:

  shrinkage applied to older trees each round

- exotic:

  logical; if TRUE, apply additional exotic parameters

- ...:

  other eng args

## Value

a fitted model

## Details

When `exotic = FALSE` (default), parameters follow the SGLB paper:
Langevin mode with diffusion temperature and model shrink rate,
Lossguide growth, and iterated Newton leaf estimation.

When `exotic = TRUE`, second-order split scoring (`NewtonL2`), Bayesian
bootstrap row weighting, and increased split candidate density
(`border_count`) are added — treating the Langevin chain as a proper
Bayesian posterior sampler over tree space.
