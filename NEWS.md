# daisugi (development)

* add support for **KTBoost**
    - fit with `grow_kernel_trees`
    - predict with `harvest_kernel_trees`
    - each boosting iteration chooses either tree or RKHS regression 

* add support for **NRGBoost**
    - fit with `grow_energy_trees`
    - predict with `harvest_energy_trees`
    - a tree-based generative algorithm for tabular data
        - "Unlike discriminative methods, NRGBoost can be used to predict any column in the data, not just a specific "target" column."

# daisugi 0.0.4
* added support for **NGBoost**
    - fit with `grow_natural_trees`
    - predict with `harvest_natural_trees`
    - a natural gradient booster from Stanford ML Group

* added documentation for package. 
    - `daisugi.Rmd`
        - getting started vignette
    - `glossary.Rmd`
        - a note on machines & nomenclature 
* added images for vignettes and README documentation


# daisugi 0.0.3
* added support for **EBMs**
    - fit with `grow_explainable_trees`
    - predict with `harvest_explainable_trees`
    - a 'glassbox' novel gam boosting machine

# daisugi 0.0.2

* added support for **WildWood**
    - fit with `grow_wild_trees`
    - predict with `harvest_wild_trees`
    - a *newer and advanced* random forest algorithm 

* added support for **Perpetual**
    - fit with `grow_perpetual_trees`
    - predict with `harvest_perpetual_trees`
    - a budget-based autoML-type tree machine

# daisugi 0.0.1

* added support for **Yggdrasil Decision Forest**
    - fit with `grow_yggdrasil_trees`
    - predict with `harvest_yggdrasil_trees`
    - YDF Gradient Boosted Trees (Google)

* added support for **SnapBoost**
    - fit with `grow_snap_trees`
    - predict with `harvest_snap_trees`
    - Snap ML's Boosting Machine (IBM)