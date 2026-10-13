#' Grow FIGS (Fast Interpretable Greedy-tree Sums)
#'
#' @param x a data X
#' @param y a data Y
#' @param task a task
#' @param trees num of trees
#' @param max_rules max number of rules
#' @param ... other eng args
#'
#' @returns a fitted model
#'
#' @export
grow_figs <- \(
  x,
  y,
  trees = 12L,
  task = "classification",
  max_rules = 12L,
  ...
) {
  if (is.data.frame(x)) {
    x <- as.matrix(x)
  }
  if (is.factor(y) && task == "classification") {
    y <- as.integer(y) - 1L
  }

  if (task == "classification") {
    figs <- daisugi:::.pkg_env$imodels$FIGSClassifier(
      max_rules = as.integer(max_rules),
      max_trees = as.integer(trees),
      ...
    )
  } else if (task == "regression") {
    figs <- daisugi:::.pkg_env$imodels$FIGSRegressor(
      max_rules = as.integer(max_rules),
      max_trees = as.integer(trees),
      ...
    )
  }

  model <- figs$fit(x, y)

  ret <- list(fit = model)

  class(ret) <- c("daisugi_figs_mother", "daisugi_mother", class(ret))

  ret
}


#' Harvest FIGS
#'
#' @param fit a fitted FIGS model
#' @param x a set of predictors
#' @param ... placeholder
#'
#' @returns predictions
#'
#' @export
harvest_figs <- \(fit, x, ...) {
  if (is.data.frame(x)) {
    x <- as.matrix(x)
  }
  fit$fit$predict(x)
}


#' Grow SkopeRules (interpretable rule lists)
#'
#' @param x a data X
#' @param y a data Y
#' @param task a task (classification only)
#' @param trees num of trees (n_estimators)
#' @param ... other eng args
#'
#' @returns a fitted model
#'
#' @export
grow_skope_rules <- \(
  x,
  y,
  trees = 10L,
  task = "classification",
  ...
) {
  if (is.data.frame(x)) {
    x <- as.matrix(x)
  }
  if (is.factor(y)) {
    y <- as.integer(y) - 1L
  }

  rules <- daisugi:::.pkg_env$imodels$SkopeRulesClassifier(
    n_estimators = as.integer(trees),
    ...
  )

  model <- rules$fit(x, y)

  ret <- list(fit = model)

  class(ret) <- c("daisugi_skope_mother", "daisugi_mother", class(ret))

  ret
}


#' Harvest SkopeRules
#'
#' @param fit a fitted SkopeRules model
#' @param x a set of predictors
#' @param ... placeholder
#'
#' @returns predictions
#'
#' @export
harvest_skope_rules <- \(fit, x, ...) {
  if (is.data.frame(x)) {
    x <- as.matrix(x)
  }
  fit$fit$predict(x)
}


#' Grow TAO (Tree Alternating Optimization)
#'
#' @param x a data X
#' @param y a data Y
#' @param task a task
#' @param trees num of trees (n_iters)
#' @param ... other eng args
#'
#' @returns a fitted model
#'
#' @export
grow_tao <- \(
  x,
  y,
  trees = 20L,
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
    tao <- daisugi:::.pkg_env$imodels$tao$TaoTreeClassifier(
      n_iters = as.integer(trees),
      ...
    )
  } else if (task == "regression") {
    tao <- daisugi:::.pkg_env$imodels$tao$TaoTreeRegressor(
      n_iters = as.integer(trees),
      ...
    )
  }

  model <- tao$fit(x, y)

  ret <- list(fit = model)

  class(ret) <- c("daisugi_tao_mother", "daisugi_mother", class(ret))

  ret
}


#' Harvest TAO
#'
#' @param fit a fitted TAO model
#' @param x a set of predictors
#' @param ... placeholder
#'
#' @returns predictions
#'
#' @export
harvest_tao <- \(fit, x, ...) {
  if (is.data.frame(x)) {
    x <- as.matrix(x)
  }
  fit$fit$predict(x)
}
