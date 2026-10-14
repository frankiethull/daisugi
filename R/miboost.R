#' Grow MIBoost Trees
#'
#' Multiple Imputation Boosting for data with missing values. Uses the
#' `booami` package's `impu_boost()` which fits boosting models on multiply
#' imputed datasets and pools the results. Handles missing values in
#' predictors via the multiple imputation framework.
#'
#' @param x a data frame of predictors (may contain missing values)
#' @param y a response vector
#' @param trees number of boosting iterations (maps to `mstop`)
#' @param task "classification" or "regression"
#' @param ny learning rate (shrinkage)
#' @param ... other arguments passed to `booami::impu_boost()`
#'
#' @returns a fitted MIBoost model
#' @export
grow_miboost_trees <- \(
  x,
  y,
  trees = 250L,
  task = "classification",
  ny = 0.1,
  ...
) {
  if (task == "classification") {
    type <- "logistic"
    y <- as.integer(as.factor(y)) - 1L
  } else if (task == "regression") {
    type <- "gaussian"
    y <- as.numeric(y)
  } else {
    stop("task must be 'classification' or 'regression'")
  }

  x <- as.data.frame(x)

  # impu_boost expects lists of imputed datasets; wrap single dataset
  X_list <- list(as.matrix(x))
  y_list <- list(y)

  fit <- booami::impu_boost(
    X_list = X_list,
    y_list = y_list,
    ny = ny,
    mstop = as.integer(trees),
    type = type,
    ...
  )

  structure(
    list(fit = fit, task = task),
    class = "daisugi_miboost_fit"
  )
}

#' Harvest MIBoost Trees
#'
#' Predict from a fitted MIBoost model.
#'
#' @param fit a fitted model from `grow_miboost_trees()`
#' @param x new predictor data
#' @param ... other arguments passed to `booami::booami_predict()`
#'
#' @returns predictions
#' @export
harvest_miboost_trees <- \(fit, x, ...) {
  x <- as.data.frame(x)
  preds <- booami::booami_predict(
    object = fit$fit,
    X_new = as.matrix(x),
    ...
  )
  as.numeric(preds)
}
