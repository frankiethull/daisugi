.pkg_env <- new.env()

.pkg_env$interpret <- NULL
.pkg_env$KTBoost <- NULL
.pkg_env$ngboost <- NULL
.pkg_env$nrgboost <- NULL
.pkg_env$perpetual <- NULL
.pkg_env$snapml <- NULL
.pkg_env$wildwood <- NULL
.pkg_env$ydf <- NULL

.onLoad <- function(...) {
  # Boulevard -------

  # EBM -------
  reticulate::py_require("interpret")
  .pkg_env$interpret <- reticulate::import(
    "interpret",
    delay_load = TRUE
  )

  # FairGBM -------

  # GRANDE -------
  # https://github.com/s-marton/grande

  # KTBoost -------
  reticulate::py_require("KTBoost")
  .pkg_env$KTBoost <- reticulate::import(
    "KTBoost",
    delay_load = TRUE
  )

  # MorphBoost -------
  # https://github.com/BorisKriuk/morphboost

  # MSBoost -------
  # https://github.com/Agnij-Moitra/MSBoost

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
