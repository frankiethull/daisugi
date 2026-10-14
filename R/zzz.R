.pkg_env <- new.env()

.pkg_env$grande <- NULL
.pkg_env$imodels <- NULL
.pkg_env$pystreed <- NULL
.pkg_env$chimeraboost <- NULL
.pkg_env$cycgbm <- NULL
.pkg_env$fairgbm <- NULL
.pkg_env$interpret <- NULL
.pkg_env$KTBoost <- NULL
.pkg_env$morph <- NULL
.pkg_env$ngboost <- NULL
.pkg_env$nrgboost <- NULL
.pkg_env$msboost <- NULL
.pkg_env$perpetual <- NULL
.pkg_env$snapml <- NULL
.pkg_env$wildwood <- NULL
.pkg_env$ydf <- NULL

.onLoad <- function(...) {
  # Pin Python to 3.11: snapml has no cp313 wheels (only cp39-cp312)
  reticulate::py_require(python_version = "3.11")

  # EBM -------
  reticulate::py_require("interpret")
  .pkg_env$interpret <- reticulate::import(
    "interpret",
    delay_load = TRUE
  )
  # register tidymodels bindings
  make_explainable_boost_ebm()
  make_boost_tree_ebm()

  # FairGBM -------
  # notetoself: fairgbm may require separate env ...
  # reticulate::py_require("fairgbm")
  # reticulate::py_require(
  #   "git+https://github.com/feedzai/fairgbm/tree/main-fairgbm/python-package"
  # )
  # .pkg_env$fairgbm <- reticulate::import(
  #  "fairgbm",
  #  delay_load = TRUE
  # )

  # GRANDE -------
  # https://github.com/s-marton/grande
  reticulate::py_require("git+https://github.com/s-marton/GRANDE.git")
  .pkg_env$grande <- reticulate::import(
    "GRANDE",
    delay_load = TRUE
  )

  # imodels ------- (FIGS, SkopeRules, TAO)
  # https://github.com/csinva/imodels
  reticulate::py_require("imodels")
  .pkg_env$imodels <- reticulate::import(
    "imodels",
    delay_load = TRUE
  )

  # KTBoost -------
  # notetoself: KTBoost will require separate env for older scikit(?)...
  #reticulate::py_require("KTBoost")
  #.pkg_env$KTBoost <- reticulate::import(
  #  "KTBoost",
  #  delay_load = TRUE
  #)

  # MorphBoost -------
  # https://github.com/BorisKriuk/morphboost
  # does not contain setup.py or pyproject.toml but requirements.txt
  #   py_require("morphboost@git+https://github.com/BorisKriuk/morphboost.git")
  #  .pkg_env$morph <- reticulate::import(
  #    "morphboost",
  #    delay_load = TRUE
  #  )

  # MSBoost -------
  # https://github.com/Agnij-Moitra/MSBoost
  #  reticulate::py_require("git+https://github.com/Agnij-Moitra/MSBoost.git")
  #  .pkg_env$msboost <- reticulate::import(
  #    "MSBoost",
  #    delay_load = TRUE
  #  )

  # NGBoost -------
  reticulate::py_require("ngboost")
  .pkg_env$ngboost <- reticulate::import(
    "ngboost",
    delay_load = TRUE
  )

  # NRGBoost -------
  reticulate::py_require("nrgboost")
  .pkg_env$nrgboost <- reticulate::import(
    "nrgboost",
    delay_load = TRUE
  )
  # Perpetual -------
  reticulate::py_require("perpetual")
  .pkg_env$perpetual <- reticulate::import(
    "perpetual",
    delay_load = TRUE
  )

  # SnapBoost -------
  reticulate::py_require("snapml")
  .pkg_env$snapml <- reticulate::import(
    "snapml",
    delay_load = TRUE
  )

  # WildWood -------
  reticulate::py_require("wildwood")
  .pkg_env$wildwood <- reticulate::import(
    "wildwood",
    delay_load = TRUE
  )

  # pystreed ------- (optimal sparse trees)
  # https://github.com/xuemei1997/pystreed
  reticulate::py_require("pystreed")
  reticulate::py_require("scikit-survival")
  .pkg_env$pystreed <- reticulate::import(
    "pystreed",
    delay_load = TRUE
  )

  # chimeraboost -------
  # https://github.com/ChimeraBoost/chimeraboost
  reticulate::py_require("chimeraboost")
  .pkg_env$chimeraboost <- reticulate::import(
    "chimeraboost",
    delay_load = TRUE
  )

  # cyc-gbm ------- (distributional boosting)
  # https://github.com/cyc-gbm/cyc-gbm
  reticulate::py_require("cyc-gbm")
  .pkg_env$cycgbm <- reticulate::import(
    "cyc_gbm",
    delay_load = TRUE
  )

  # YDF -------
  reticulate::py_require("ydf")
  .pkg_env$ydf <- reticulate::import(
    "ydf",
    delay_load = TRUE
  )
  # register tidymodels binding
  make_boost_tree_ydf()
}
