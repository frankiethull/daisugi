#' Grow Fair Trees
#'
#' @param x a data X
#' @param y a data Y
#' @param s a contraint group sensitivity for fairness
#' @param task a task
#' @param trees num of trees
#' @param ... other eng args
#'
#' @returns a fitted fairgbm model
#'
#' @export
grow_fair_trees <- \(
  x,
  y,
  s,
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
    y <- as.numeric(as.array(y))
  }
  if (is.factor(s)) {
    s <- as.numeric(as.integer(s) - 1L)
  }
  if (!is.array(s)) {
    s <- as.array(s)
  }

  if (task == "classification") {
    fair <- daisugi:::.pkg_env$fairgbm$FairGBMClassifier(
      n_estimators = trees,
      ...
    )
  } else if (task == "regression") {
    fair <- daisugi:::.pkg_env$fairgbm$FairGBMRegressor(
      n_estimators = trees,
      ...
    )
  }

  model <- fair$fit(x, y, constraint_group = s)

  ret <- list(fit = model)

  class(ret) <- c("daisugi_fair_mother", class(ret))

  ret
}


#' Harvest Fair Trees
#'
#' @param fit a fitted fairgbm model
#' @param x a set of predictors
#' @param ... placeholder
#'
#' @returns predictions
#'
#' @export
harvest_fair_trees <- \(fit, x, ...) {
  if (is.data.frame(x)) {
    x <- as.matrix(x)
  }
  #TODO: probas
  fit$fit$predict(x)
}
