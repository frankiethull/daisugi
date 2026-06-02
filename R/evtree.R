#' Grow Evolutionary Trees
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
grow_evolutionary_trees <- \(
  x,
  y,
  trees = 100L,
  task = "classification",
  ...
) {
  xy <- cbind(x, y = y)

  if (task == "classification") {
    evtree <- evtree::evtree(
      y ~ .,
      xy,
      control = evtree::evtree.control(ntrees = trees, ...)
    )
  } else if (task == "regression") {
    evtree <- evtree::evtree(
      y ~ .,
      xy,
      control = evtree::evtree.control(ntrees = trees, ...)
    )
  }

  model <- evtree

  ret <- list(fit = model)

  class(ret) <- c("daisugi_evolutionary_mother", class(ret))

  ret
}


#' Harvest Evolutionary Trees
#'
#' @param fit a fitted evtree model
#' @param x a set of predictors
#' @param ... placeholder
#'
#' @returns predictions
#'
#' @export
harvest_evolutionary_trees <- \(fit, x, ...) {
  #TODO: probas
  predict(fit$fit, x)
}
