
<!-- README.md is generated from README.Rmd. Please edit that file -->

# daisugi

<table>

<tr>

<td width="36%" valign="top">

<img src="man/figures/logo.png" height="190"/>

## daisugi: not-so-well-known tree machines

<table>

daisugi is an R package collecting experimental, obscure, and emerging
tree-based machine learning methods.

Rather than reproducing the mainstream boosting ecosystem, daisugi
focuses on:

- probabilistic forests
- hybrid boosting systems
- online learners
- interpretable ensembles
- experimental tree architectures
- research-oriented methods rarely exposed to R users

Popular libraries such as XGBoost, LightGBM, and CatBoost are
intentionally excluded and are better accessed through their native
packages or through tidymodels infrastructure.

</td>

<td width="44%" align="right">

<img src="man/figures/readme.png" height="460"/>
</td>

</tr>

</table>

<!-- badges: start -->

<!-- badges: end -->

------------------------------------------------------------------------

## Included Machines v0.0.5

| Status | Algorithm          | Focus                           |
|--------|--------------------|---------------------------------|
| 🚧     | Boulevard          | stochastic gradient boosting    |
| ✅     | Conditional Trees  | unbiased recursive partitioning |
| ✅     | EBM                | interpretable additive boosting |
| ✅     | Evolutionary Trees | genetic tree optimization       |
| 🚧     | FairGBM            | fairness-aware boosting         |
| 🚧     | GRANDE             | differentiable tree ensembles   |
| 🚧     | KTBoost            | kernel-tree hybrid boosting     |
| 🚧     | MorphBoost         | adaptive boosting structures    |
| 🚧     | MSBoost            | multi-stage boosting            |
| ✅     | NGBoost            | probabilistic prediction        |
| ✅     | NRGBoost           | natural gradient boosting       |
| ✅     | Perpetual          | continual tree learning         |
| ✅     | SnapBoost          | heterogeneous boosting systems  |
| ✅     | WildWood           | randomized online forests       |
| ✅     | Yggdrasil          | scalable tree ecosystems        |

------------------------------------------------------------------------

## Installation

You can install the development version of daisugi from GitHub:

``` r
# install.packages("pak")
pak::pak("frankiethull/daisugi")
```

------------------------------------------------------------------------

## Philosophy

daisugi explores tree systems outside the conventional gradient boosting
canon.

Many included methods emphasize:

- uncertainty estimation
- heterogeneous base learners
- recursive partition hybrids
- online adaptation
- probabilistic outputs
- alternative split mechanics
- interpretable ensemble structures

The package acts as both:

- a practical modeling toolkit
- a curated collection of unconventional tree algorithms

------------------------------------------------------------------------

## Example

``` r
library(daisugi)

model <- grow_yggdrasil_trees(
x = iris[, 1:4],
y = iris$Species
)

harvest_yggdrasil_trees(model, iris[, 1:4])
```

## Documentation

- [Getting
  Started](https://frankiethull.github.io/daisugi/articles/daisugi.html)
- [Glossary of
  Machines](https://frankiethull.github.io/daisugi/articles/glossary.html)
- [Package
  Reference](https://frankiethull.github.io/daisugi/reference/index.html)
- [Changelog](https://frankiethull.github.io/daisugi/news/index.html)
