# glossary

``` r

library(daisugi)
```

## Glossary

[TABLE]

------------------------------------------------------------------------

### Core Verbs

daisugi standardizes machine workflows through a small set of
forestry-inspired verbs.

“`grow_*()`”: fit or train a machine  
“`harvest_*()`”: generate predictions  
“`trees"`: unified argument for rounds / iterations / estimators

------------------------------------------------------------------------

### Machine Registry

The following registry links implemented engines to their originating
projects, papers, or repositories. Registy also lists the alias in
daisugi as well as a set of haikus for TL/DR referencing.

[TABLE]

### Supported Tasks

| Machine            | Classification | Regression |
|--------------------|----------------|------------|
| Boulevard          | ❌             | ✅         |
| Conditional Trees  | ✅             | ✅         |
| EBM                | ✅             | ✅         |
| Evolutionary Trees | ✅             | ✅         |
| NGBoost            | ✅             | ✅         |
| NRGBoost           | ✅             | ✅         |
| Perpetual          | ✅             | ✅         |
| SnapBoost          | ✅             | ✅         |
| WildWood           | ✅             | ✅         |
| Yggdrasil          | ✅             | ✅         |

### tidymodels interface

| Machine   | Supported? |
|-----------|------------|
| EBM       | ✅         |
| Yggdrasil | ✅         |

EBM is supported as a `boost_tree` as well as an `explainable_boost`
model engine. This allows lite-weight as well as additional control over
the model specification & hyperparameter optimization. daisugi contains
the additional `dials` necessary for tuning EBMs. Read more about this
in [the tidymodels
vignette.](https://frankiethull.github.io/daisugi/articles/tidymodels.html)
