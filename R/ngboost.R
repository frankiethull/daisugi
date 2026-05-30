#' Grow Natural Gradient Trees
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
grow_natural_trees <- \(
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
  if (!is.array(y)) {
    y <- as.array(y)
  }

  if (task == "classification") {
    ngboost <- daisugi:::.pkg_env$ngboost$NGBClassifier(
      n_estimators = trees,
      ...
    )
  } else if (task == "regression") {
    ngboost <- daisugi:::.pkg_env$ngboost$NGBRegressor(
      n_estimators = trees,
      ...
    )
  }

  model <- ngboost$fit(x, y)

  ret <- list(fit = model)

  class(ret) <- c("daisugi_natural_mother", class(ret))

  ret
}


#' Harvest Natural Gradient Trees
#'
#' @param fit a fitted ngboost model
#' @param x a set of predictors
#' @param ... placeholder
#'
#' @returns predictions
#'
#' @export
harvest_natural_trees <- \(fit, x, ...) {
  if (is.data.frame(x)) {
    x <- as.matrix(x)
  }
  #TODO: probas
  fit$fit$predict(x)
}
