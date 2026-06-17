#' Grow Linear (Dart) Trees
#'
#' LightGBM Piecewise-Linear DART: fits a ridge regression at each leaf
#' (rather than a constant) while applying tree dropout to prevent early
#' linear models from dominating later rounds. Inspired by GBDT-PL
#' <https://arxiv.org/abs/1802.05640> with DART regularization.
#'
#' When `exotic = FALSE` (default), parameters follow the GBDT-PL paper
#' spirit: linear leaves, DART dropout, forest normalization, path
#' smoothing for small-leaf stability.
#'
#' When `exotic = TRUE`, ExtraTrees-style random split thresholds are
#' added (`extra_trees = TRUE`), creating triple stochasticity: random
#' thresholds + column subsampling + tree dropout. `one_drop = TRUE`
#' guarantees at least one tree is always dropped.
#'
#' @param x a data X
#' @param y a data Y
#' @param trees num of boosting rounds
#' @param task a task
#' @param drop_rate fraction of previous trees dropped per round
#' @param linear_lambda L2 regularization on leaf linear models
#' @param exotic logical; if TRUE, apply additional exotic parameters
#' @param ... other eng args
#'
#' @returns a fitted model
#'
#' @export
grow_linear_trees <- \(
  x,
  y,
  trees = 100L,
  task = "classification",
  drop_rate = 0.1,
  linear_lambda = 0.5,
  exotic = FALSE,
  ...
) {
  if (task == "classification") {
    objective <- "binary"
    y <- as.integer(as.factor(y)) - 1L
  } else if (task == "regression") {
    objective <- "regression"
    y <- as.numeric(y)
  }

  dtrain <- lightgbm::lgb.Dataset(data = as.matrix(x), label = y)

  # paper-faithful: linear leaves + DART with forest normalization + path smooth
  params <- list(
    objective = objective,
    boosting = "dart",
    linear_tree = TRUE,
    linear_lambda = linear_lambda,
    drop_rate = drop_rate,
    skip_drop = 0.5,
    normalize_type = "forest",
    path_smooth = 10,
    num_leaves = 63L,
    colsample_bytree = 0.8,
    min_data_in_leaf = 20L,
    ...
  )

  if (exotic) {
    # triple stochasticity: random thresholds + column sampling + dropout
    # one_drop guarantees dropout never gets skipped entirely
    params$extra_trees <- TRUE
    params$one_drop <- TRUE
    params$max_drop <- 10L
  }

  model <- lightgbm::lgb.train(
    params = params,
    data = dtrain,
    nrounds = trees,
    verbose = -1L
  )

  ret <- list(fit = model, task = task)

  class(ret) <- c("daisugi_linear_mother", "daisugi_mother", class(ret))

  ret
}


#' Harvest Linear Trees
#'
#' @param fit a fitted linear dart model
#' @param x a set of predictors
#' @param ... placeholder
#'
#' @returns predictions
#'
#' @export
harvest_linear_trees <- \(fit, x, ...) {
  predict(fit$fit, as.matrix(x))
}
