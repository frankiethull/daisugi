#' Grow Langevin Trees
#'
#' CatBoost Stochastic Gradient Langevin Boosting (SGLB): injects
#' calibrated Langevin diffusion noise into gradient updates, converting
#' boosting into a Markov chain sampler over function space. Guarantees
#' global convergence for non-convex losses where standard GBM can only
#' guarantee local optima. See <https://arxiv.org/abs/2001.07248>.
#'
#' When `exotic = FALSE` (default), parameters follow the SGLB paper:
#' Langevin mode with diffusion temperature and model shrink rate,
#' Lossguide growth, and iterated Newton leaf estimation.
#'
#' When `exotic = TRUE`, second-order split scoring (`NewtonL2`),
#' Bayesian bootstrap row weighting, and increased split candidate
#' density (`border_count`) are added — treating the Langevin chain
#' as a proper Bayesian posterior sampler over tree space.
#'
#' @param x a data X
#' @param y a data Y
#' @param trees num of boosting rounds
#' @param task a task
#' @param diffusion_temperature Langevin noise amplitude; higher = more exploration
#' @param model_shrink_rate shrinkage applied to older trees each round
#' @param exotic logical; if TRUE, apply additional exotic parameters
#' @param ... other eng args
#'
#' @returns a fitted model
#'
#' @export
grow_langevin_trees <- \(
  x,
  y,
  trees = 100L,
  task = "classification",
  diffusion_temperature = 10000,
  model_shrink_rate = 0.05,
  exotic = FALSE,
  ...
) {
  if (task == "classification") {
    loss_function <- "Logloss"
    y <- as.numeric(as.factor(y)) - 1L
  } else if (task == "regression") {
    loss_function <- "RMSE"
    y <- as.numeric(y)
  }

  # paper-faithful: SGLB with Lossguide + iterated Newton leaves
  params <- list(
    loss_function = loss_function,
    iterations = trees,
    langevin = TRUE,
    diffusion_temperature = diffusion_temperature,
    model_shrink_rate = model_shrink_rate,
    grow_policy = "Lossguide",
    max_leaves = 64L,
    leaf_estimation_method = "Newton",
    leaf_estimation_iterations = 10L,
    verbose = 0L,
    ...
  )

  if (exotic) {
    # second-order split scoring + Bayesian bootstrap + dense split candidates
    # treats the Langevin chain as a posterior sampler over tree space
    params$score_function <- "NewtonL2"
    params$bootstrap_type <- "Bayesian"
    params$bagging_temperature <- 1.0
    params$random_strength <- 0.5
    params$border_count <- 254L
  }

  model <- catboost::catboost.train(
    learn_pool = catboost::catboost.load_pool(data = x, label = y),
    params = params
  )

  ret <- list(fit = model, task = task)

  class(ret) <- c("daisugi_langevin_mother", "daisugi_mother", class(ret))

  ret
}


#' Harvest Langevin Trees
#'
#' @param fit a fitted langevin model
#' @param x a set of predictors
#' @param ... placeholder
#'
#' @returns predictions
#'
#' @export
harvest_langevin_trees <- \(fit, x, ...) {
  pool <- catboost::catboost.load_pool(data = x)
  catboost::catboost.predict(fit$fit, pool)
}
