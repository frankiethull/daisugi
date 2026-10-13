#' Grow ChimeraBoost (numba-accelerated gradient boosting)
#'
#' @param x a data X
#' @param y a data Y
#' @param task a task
#' @param trees num of trees
#' @param ... other eng args
#'
#' @returns a fitted model
#'
#' @export
grow_chimera <- \(
  x,
  y,
  trees = 100L,
  task = "classification",
  ...
) {
  if (is.data.frame(x)) {
    x <- as.matrix(x)
  }
  if (is.factor(y) && task == "classification") {
    y <- as.integer(y) - 1L
  }

  if (task == "classification") {
    chimera <- daisugi:::.pkg_env$chimeraboost$ChimeraBoostClassifier(
      n_estimators = as.integer(trees),
      ...
    )
  } else if (task == "regression") {
    chimera <- daisugi:::.pkg_env$chimeraboost$ChimeraBoostRegressor(
      n_estimators = as.integer(trees),
      ...
    )
  }

  model <- chimera$fit(x, y)

  ret <- list(fit = model)

  class(ret) <- c("daisugi_chimera_mother", "daisugi_mother", class(ret))

  ret
}


#' Harvest ChimeraBoost
#'
#' @param fit a fitted ChimeraBoost model
#' @param x a set of predictors
#' @param ... placeholder
#'
#' @returns predictions
#'
#' @export
harvest_chimera <- \(fit, x, ...) {
  if (is.data.frame(x)) {
    x <- as.matrix(x)
  }
  fit$fit$predict(x)
}
