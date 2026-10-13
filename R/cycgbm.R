#' Grow Cyclical Gradient Booster (distributional boosting)
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
grow_cyc_gbm <- \(
  x,
  y,
  trees = 100L,
  task = "regression",
  ...
) {
  if (is.data.frame(x)) {
    x <- as.matrix(x)
  }
  if (!is.array(y)) {
    y <- as.array(y)
  }

  cyc <- daisugi:::.pkg_env$cycgbm$CyclicalGradientBooster(
    n_estimators = as.integer(trees),
    ...
  )

  # NB: fit() returns None (not self), so keep the fitted object
  cyc$fit(x, y)

  ret <- list(fit = cyc)

  class(ret) <- c("daisugi_cycgbm_mother", "daisugi_mother", class(ret))

  ret
}


#' Harvest Cyclical Gradient Booster
#'
#' Returns the mean (first distribution parameter) for point prediction.
#'
#' @param fit a fitted CyclicalGradientBooster model
#' @param x a set of predictors
#' @param ... placeholder
#'
#' @returns predictions (mean of predictive distribution)
#'
#' @export
harvest_cyc_gbm <- \(fit, x, ...) {
  if (is.data.frame(x)) {
    x <- as.matrix(x)
  }
  preds <- fit$fit$predict(x)
  # predict returns distribution params (2 x n for normal);
  # first row is the mean
  preds_r <- reticulate::py_to_r(preds)
  as.vector(preds_r[1, ])
}
