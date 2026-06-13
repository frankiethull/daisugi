#' Grow Conditional Forest
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
grow_conditional_trees <- \(
  x,
  y,
  trees = 100L,
  task = "classification",
  ...
) {
  xy <- cbind(x, y = y)

  if (task == "classification") {
    cforest <- partykit::cforest(y ~ ., xy, ntree = trees, ...)
  } else if (task == "regression") {
    cforest <- partykit::cforest(y ~ ., xy, ntree = trees, ...)
  }

  model <- cforest

  ret <- list(fit = model)

  class(ret) <- c("daisugi_conditional_mother", "daisugi_mother", class(ret))

  ret
}


#' Harvest Conditional Forest
#'
#' @param fit a fitted evtree model
#' @param x a set of predictors
#' @param ... placeholder
#'
#' @returns predictions
#'
#' @export
harvest_conditional_trees <- \(fit, x, ...) {
  #TODO: probas
  predict(fit$fit, x)
}
