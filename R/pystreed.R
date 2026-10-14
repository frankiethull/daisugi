#' Grow STreeD (optimal sparse trees via dynamic programming)
#'
#' @param x a data X
#' @param y a data Y
#' @param task a task
#' @param trees max depth of tree
#' @param ... other eng args
#'
#' @returns a fitted model
#'
#' @export
grow_streed <- \(
  x,
  y,
  trees = 3L,
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
    streed <- daisugi:::.pkg_env$pystreed$STreeDClassifier(
      max_depth = as.integer(trees),
      ...
    )
  } else if (task == "regression") {
    streed <- daisugi:::.pkg_env$pystreed$STreeDRegressor(
      max_depth = as.integer(trees),
      ...
    )
  }

  model <- streed$fit(x, y)

  ret <- list(fit = model)

  class(ret) <- c("daisugi_streed_mother", "daisugi_mother", class(ret))

  ret
}


#' Harvest STreeD
#'
#' @param fit a fitted STreeD model
#' @param x a set of predictors
#' @param ... placeholder
#'
#' @returns predictions
#'
#' @export
harvest_streed <- \(fit, x, ...) {
  if (is.data.frame(x)) {
    x <- as.matrix(x)
  }
  fit$fit$predict(x)
}
