#' Grow Extreme Trees
#'
#' XGBoost Boosted Forest: each boosting round grows a forest of
#' `num_parallel_tree` trees rather than a single tree. Based on the
#' XGBoost random forest + boosting hybrid described at
#' <https://xgboost.readthedocs.io/en/stable/tutorials/rf.html>.
#'
#' When `exotic = FALSE` (default), parameters follow the paper-faithful
#' boosted random forest configuration: gradient-based row sampling with
#' moderate column subsampling per node.
#'
#' When `exotic = TRUE`, additional daisugi params are applied:
#' cumulative column sampling across all three `colsample_by*` levels,
#' reduced lambda for deeper trees, and leaf-wise (`lossguide`) growth
#' within each forest member.
#'
#' @param x a data X
#' @param y a data Y
#' @param trees num of boosting rounds (each round grows a forest)
#' @param task a task
#' @param num_parallel_tree number of trees per forest per round
#' @param exotic logical; if TRUE, apply additional exotic parameters
#' @param ... other eng args
#'
#' @returns a fitted model
#'
#' @export
grow_extreme_trees <- \(
  x,
  y,
  trees = 50L,
  task = "classification",
  num_parallel_tree = 10L,
  exotic = FALSE,
  ...
) {
  if (task == "classification") {
    objective <- "binary:logistic"
    y <- as.numeric(as.factor(y)) - 1L
  } else if (task == "regression") {
    objective <- "reg:squarederror"
    y <- as.numeric(y)
  }

  dtrain <- xgboost::xgb.DMatrix(data = as.matrix(x), label = y)

  # paper-faithful: boosted forest with gradient-based row sampling
  params <- list(
    booster = "gbtree",
    objective = objective,
    tree_method = "hist",
    # keep off for CPUs:
    #sampling_method = "gradient_based",
    num_parallel_tree = num_parallel_tree,
    subsample = 0.5,
    colsample_bynode = 0.6,
    ...
  )

  if (exotic) {
    # cumulative column sampling across all levels, reduced lambda,
    # leaf-wise growth within each forest member
    params$colsample_bylevel <- 0.8
    params$colsample_bytree <- 0.8
    params$reg_lambda <- 0.1
    params$max_depth <- 8L
    params$grow_policy <- "lossguide"
    params$max_leaves <- 64L
  }

  model <- xgboost::xgb.train(
    params = params,
    data = dtrain,
    nrounds = trees
  )

  ret <- list(fit = model, task = task)

  class(ret) <- c("daisugi_extreme_mother", "daisugi_mother", class(ret))

  ret
}


#' Harvest extreme Trees
#'
#' @param fit a fitted extreme model
#' @param x a set of predictors
#' @param ... placeholder
#'
#' @returns predictions
#'
#' @export
harvest_extreme_trees <- \(fit, x, ...) {
  dtest <- xgboost::xgb.DMatrix(data = as.matrix(x))
  predict(fit$fit, dtest)
}
