#' Grow kernel-Based Generative Trees
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
grow_kernel_trees <- \(
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
    KTBoost <- daisugi:::.pkg_env$KTBoost$KTBoost$BoostingClassifier(
      n_estimators = trees,
      ...
    )
  } else if (task == "regression") {
    KTBoost <- daisugi:::.pkg_env$KTBoost$KTBoost$BoostingRegressor(
      n_estimators = trees,
      ...
    )
  }

  model <- KTBoost$fit(x, y)

  ret <- list(fit = model)

  class(ret) <- c("daisugi_kernel_mother", class(ret))

  ret
}


#' Harvest kernel-Based Generative Trees
#'
#' @param fit a fitted KTboost model
#' @param x a set of predictors
#' @param ... placeholder
#'
#' @returns predictions
#'
#' @export
harvest_kernel_trees <- \(fit, x, ...) {
  if (is.data.frame(x)) {
    x <- as.matrix(x)
  }
  #TODO: probas
  fit$fit$predict(x)
}
