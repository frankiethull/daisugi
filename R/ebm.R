#' Grow Explainable Trees
#'
#' @param x a data X
#' @param y a data Y
#' @param task a task
#' @param trees max num of trees (default: 50000)
#' @param early_stop_tree trigger early stopping if no improvement (default: 100)
#' @param ... other eng args
#'
#' @returns a fitted model
#'
#' @export
grow_explainable_trees <- \(
  x,
  y,
  trees = 50000L,
  early_stop_tree = 100L,
  task = "classification",
  ...
) {
  if (is.data.frame(x)) {
    x <- as.matrix(x)
  }
  if (!is.array(y)) {
    y <- as.array(y)
  }

  if (task == "classification") {
    ebm <- daisugi:::.pkg_env$interpret$glassbox$ExplainableBoostingClassifier(
      max_rounds = trees,
      early_stopping_rounds = early_stop_tree,
      ...
    )
  } else if (task == "regression") {
    ebm <- daisugi:::.pkg_env$interpret$glassbox$ExplainableBoostingRegressor(
      max_rounds = trees,
      early_stopping_rounds = early_stop_tree,
      ...
    )
  }

  model <- ebm$fit(x, y)

  ret <- list(fit = model)

  class(ret) <- c("daisugi_ebm_mother", class(ret))

  ret
}


#' Harvest Explainable Trees
#'
#' @param fit a fitted ebm model
#' @param x a set of predictors
#' @param ... placeholder
#'
#' @returns predictions
#'
#' @export
harvest_explainable_trees <- \(fit, x, ...) {
  if (is.data.frame(x)) {
    x <- as.matrix(x)
  }
  #TODO: probas
  fit$fit$predict(x)
}
