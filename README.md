
<!-- README.md is generated from README.Rmd. Please edit that file -->

# daisugi

<table>

<tr>

<td width="40%" valign="top">

<img src="man/figures/logo.png" height="400"/>

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

**Note:** popular libraries such as XGBoost, LightGBM, & CatBoost *are
included* but modified to use `daisugi` defaults.

</td>

<td width="44%" align="right">

<img src="man/figures/readme.png" height="460"/>
</td>

</tr>

</table>

<!-- badges: start -->

<!-- badges: end -->

------------------------------------------------------------------------

## Included Machines v0.0.10

| Status | Algorithm          | Focus                               |
|--------|--------------------|-------------------------------------|
| ✅     | Boulevard          | stochastic gradient boosting        |
| ✅     | ChimeraBoost       | numba-accelerated boosting          |
| ✅     | CycGBM             | distributional boosting             |
| ✅     | FIGS               | interpretable greedy tree sums      |
| ✅     | Conditional Trees  | unbiased recursive partitioning     |
| ✅     | EBM                | interpretable additive boosting     |
| ✅     | Evolutionary Trees | genetic tree optimization           |
| ✅     | Extreme            | eXtreme gradient boosted **forest** |
| 🚧     | FairGBM            | fairness-aware boosting             |
| ✅     | GRANDE             | differentiable tree ensembles       |
| ✅     | Langevin           | Catboost with SGLB                  |
| ✅     | Linear             | LightGBM with GBDT-PL               |
| ✅     | MIBoost            | multiple imputation boosting        |
| ✅     | MorphBoost         | adaptive boosting structures        |
| 🚧     | MSBoost            | multi-stage boosting                |
| ✅     | NGBoost            | natural gradient prediction         |
| ✅     | NRGBoost           | energy-based generative boosting    |
| ✅     | Perpetual          | continual tree learning             |
| ✅     | SkopeRules         | interpretable rule lists            |
| ✅     | SnapBoost          | heterogeneous boosting systems      |
| ✅     | STreeD             | optimal sparse trees                |
| ✅     | TAO                | tree alternating optimization       |
| ✅     | WildWood           | randomized online forests           |
| ✅     | Yggdrasil          | scalable tree ecosystems            |

------------------------------------------------------------------------

### Dropped engines

| Algorithm     | Reason                                                         |
|---------------|----------------------------------------------------------------|
| scikit-garden | abandoned upstream since 2017, does not build on modern Python |
| PkBoost       | no Linux/macOS wheels, sdist requires Rust toolchain          |
| KTBoost       | abandoned upstream since 2021; author moved to GPBoost (#23)   |

### Blocked engines

FairGBM and pysortd break on scikit-learn >= 1.6 due to removed APIs
(`force_all_finite`, `_validate_data`). These need vendoring with patches
or upstream fixes before they can be added.

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

## Further Documentation

- [Get
  Started](https://frankiethull.github.io/daisugi/articles/daisugi.html)
  with a Classification Task  
- Or maybe you prefer
  [Regression](https://frankiethull.github.io/daisugi/articles/regression.html)
- Learn more about daisugi via the
  [Glossary.](https://frankiethull.github.io/daisugi/articles/glossary.html)  
- A full list of models & their methods can be found in the [Package
  Index](https://frankiethull.github.io/daisugi/reference/index.html)
- daisugi also contains
  [tidymodels](https://frankiethull.github.io/daisugi/articles/tidymodels.html)
  implementations for Explainable & Yggdrasil Boosting Machines  
- Notes on each verstion at the
  [Changelog](https://frankiethull.github.io/daisugi/news/index.html)
