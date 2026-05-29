#' Grow Snap Trees
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
grow_snap_trees <- \(
  x,
  y,
  trees = 100L,
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
    snapboost <- daisugi:::.pkg_env$snapml$SnapBoostingMachineClassifier(
      num_round = trees,
      ...
    )
  } else if (task == "regression") {
    snapboost <- daisugi:::.pkg_env$snapml$SnapBoostingMachineRegressor(
      num_round = trees,
      ...
    )
  }

  model <- snapboost$fit(x, y)

  ret <- list(fit = model)

  class(ret) <- c("daisugi_snap_mother", class(ret))

  ret
}

#' Harvest Snap Trees
#'
#' @param fit a fitted snapboost model
#' @param x a set of predictors
#' @param ... placeholder
#'
#' @returns predictions
#'
#' @export
harvest_snap_trees <- \(fit, x, ...) {
  if (is.data.frame(x)) {
    x <- as.matrix(x)
  }
  #TODO: probas
  fit$fit$predict(x)
}
