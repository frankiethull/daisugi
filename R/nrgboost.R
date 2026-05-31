#' Grow Energy-Based Generative Trees
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
grow_energy_trees <- \(
  x,
  y,
  trees = 100L,
  task = "classification",
  ...
) {
  xy <- cbind(x, 'target' = y)
  xy_ds <- daisugi:::.pkg_env$nrgboost$Dataset(xy)

  if (task == "classification") {
    model <- daisugi:::.pkg_env$nrgboost$NRGBooster$fit(
      xy_ds,
      params = list(num_trees = trees, ...)
    )
  } else if (task == "regression") {
    model <- daisugi:::.pkg_env$nrgboost$NRGBooster$fit(
      xy_ds,
      params = list(num_trees = trees, ...)
    )
  }

  ret <- list(fit = model)

  class(ret) <- c("daisugi_energy_mother", class(ret))

  ret
}


#' Harvest Energy-Based Generative Trees
#'
#' @param fit a fitted nrgboost model
#' @param x a set of predictors
#' @param ... placeholder
#'
#' @returns predictions
#'
#' @export
harvest_energy_trees <- \(fit, x, ...) {
  if (is.data.frame(x)) {
    x <- as.matrix(x)
  }
  #TODO: probas
  fit$fit$predict(x, 'target')
}
