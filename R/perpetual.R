#' Grow perpetual Trees
#'
#' @param x a data X
#' @param y a data Y
#' @param task a task
#' @param budget the 'predictive power' of perpetual booster
#' @param ... other eng args
#'
#' @returns a fitted model
#'
#' @export
grow_perpetual_trees <- \(
  x,
  y,
  budget = 0.5,
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
    perpetual <- daisugi:::.pkg_env$perpetual$PerpetualClassifier(
      budget = budget,
      ...
    )
  } else if (task == "regression") {
    perpetual <- daisugi:::.pkg_env$perpetual$PerpetualRegressor(
      budget = budget,
      ...
    )
  }

  model <- perpetual$fit(x, y)

  ret <- list(fit = model)

  class(ret) <- c("daisugi_perpetual_mother", class(ret))

  ret
}


#' Harvest Perpetual Trees
#'
#' @param fit a fitted perpetual model
#' @param x a set of predictors
#' @param ... placeholder
#'
#' @returns predictions
#'
#' @export
harvest_perpetual_trees <- \(fit, x, ...) {
  if (is.data.frame(x)) {
    x <- as.matrix(x)
  }
  #TODO: probas
  fit$fit$predict(x)
}
