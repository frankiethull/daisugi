#' Grow Wild Trees
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
grow_wild_trees <- \(
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
    wildwood <- daisugi:::.pkg_env$wildwood$ForestClassifier(
      n_estimators = trees,
      ...
    )
  } else if (task == "regression") {
    wildwood <- daisugi:::.pkg_env$wildwood$ForestRegressor(
      n_estimators = trees,
      ...
    )
  }

  model <- wildwood$fit(x, y)

  ret <- list(fit = model)

  class(ret) <- c("daisugi_wild_mother", "daisugi_mother", class(ret))

  ret
}


#' Harvest Wild Trees
#'
#' @param fit a fitted wildwood model
#' @param x a set of predictors
#' @param ... placeholder
#'
#' @returns predictions
#'
#' @export
harvest_wild_trees <- \(fit, x, ...) {
  if (is.data.frame(x)) {
    x <- as.matrix(x)
  }
  #TODO: probas
  fit$fit$predict(x)
}
