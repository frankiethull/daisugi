#' Grow Yggdrasil Trees
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
grow_yggdrasil_trees <- \(
  x,
  y,
  task = "classification",
  trees = 300L,
  ...
) {
  xy <- as.data.frame(x)
  xy$target <- y
  #  xy <- cbind(x, 'target' = y)

  if (task == "classification") {
    ydf <- .pkg_env$ydf$GradientBoostedTreesLearner(
      label = 'target',
      num_trees = trees,
      ...
    )
  } else if (task == "regression") {
    ydf <- .pkg_env$ydf$GradientBoostedTreesLearner(
      label = 'target',
      task = .pkg_env$ydf$Task$REGRESSION,
      num_trees = trees,
      ...
    )
  }

  model <- ydf$train(xy)

  ret <- list(fit = model)

  class(ret) <- c("daisugi_ydf_mother", "daisugi_mother", class(ret))
  ret
}

#' Harvest Yggdrasil Trees
#'
#' @param fit a fitted snapboost model
#' @param x a set of predictors
#' @param ... placeholder
#'
#' @returns predictions
#'
#' @export
harvest_yggdrasil_trees <- \(fit, x, ...) {
  #TODO: probas
  fit$fit$predict_class(x)
}
