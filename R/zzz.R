.pkg_env <- new.env()

.pkg_env$grande <- NULL
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
  # EBM -------
  reticulate::py_require("interpret")
  .pkg_env$interpret <- reticulate::import(
    "interpret",
    delay_load = TRUE
  )
  # register tidymodels binding
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

  # YDF -------
  reticulate::py_require("ydf")
  .pkg_env$ydf <- reticulate::import(
    "ydf",
    delay_load = TRUE
  )
}
