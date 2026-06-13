#' @export
explainable_boost <-
  function(
    mode = "unknown",
    engine = "ebm",
    # gbm parameters
    trees = NULL,
    min_n = NULL,
    tree_depth = NULL,
    learn_rate = NULL,
    stop_iter = NULL,
    # tier 1 ebm parameters
    num_interactions = 3L,
    max_bins = 1024L,
    greedy_ratio = 10L,
    smoothing_rounds = 75L,
    regularization_lambda = 0L,
    regularization_alpha = 0L,
    # tier 2 ebm parameters
    max_interaction_bins = 64L,
    interaction_smoothing_rounds = 75L,
    outer_bags = 14L,
    inner_bags = 0L
  ) {
    args <- list(
      trees = rlang::enquo(trees),
      min_n = rlang::enquo(min_n),
      tree_depth = rlang::enquo(tree_depth),
      learn_rate = rlang::enquo(learn_rate),
      stop_iter = rlang::enquo(stop_iter),
      num_interactions = rlang::enquo(num_interactions),
      max_bins = rlang::enquo(max_bins),
      greedy_ratio = rlang::enquo(greedy_ratio),
      smoothing_rounds = rlang::enquo(smoothing_rounds),
      regularization_lambda = rlang::enquo(regularization_lambda),
      regularization_alpha = rlang::enquo(regularization_alpha),
      # tier 2 ebm parameters
      max_interaction_bins = rlang::enquo(max_interaction_bins),
      interaction_smoothing_rounds = rlang::enquo(interaction_smoothing_rounds),
      outer_bags = rlang::enquo(outer_bags),
      inner_bags = rlang::enquo(inner_bags)
    )

    parsnip::new_model_spec(
      "explainable_boost",
      args,
      eng_args = NULL,
      mode = mode,
      user_specified_mode = !missing(mode),
      method = NULL,
      engine = engine,
      user_specified_engine = !missing(engine)
    )
  }


# ------------------------------------------------------------------------------

#' @method update explainable_boost
#' @rdname parsnip_update
#' @export
update.explainable_boost <-
  function(
    object,
    parameters = NULL,
    # gbm parameters
    trees = NULL,
    min_n = NULL,
    tree_depth = NULL,
    learn_rate = NULL,
    stop_iter = NULL,
    # tier 1 ebm parameters
    num_interactions = 3L,
    max_bins = 1024L,
    greedy_ratio = 10L,
    smoothing_rounds = 75L,
    regularization_lambda = 0L,
    regularization_alpha = 0L,
    # tier 2 ebm parameters
    max_interaction_bins = 64L,
    interaction_smoothing_rounds = 75L,
    outer_bags = 14L,
    inner_bags = 0L,
    fresh = FALSE,
    ...
  ) {
    args <- list(
      trees = rlang::enquo(trees),
      min_n = rlang::enquo(min_n),
      tree_depth = rlang::enquo(tree_depth),
      learn_rate = rlang::enquo(learn_rate),
      stop_iter = rlang::enquo(stop_iter),
      num_interactions = rlang::enquo(num_interactions),
      max_bins = rlang::enquo(max_bins),
      greedy_ratio = rlang::enquo(greedy_ratio),
      smoothing_rounds = rlang::enquo(smoothing_rounds),
      regularization_lambda = rlang::enquo(regularization_lambda),
      regularization_alpha = rlang::enquo(regularization_alpha),
      # tier 2 ebm parameters
      max_interaction_bins = rlang::enquo(max_interaction_bins),
      interaction_smoothing_rounds = rlang::enquo(interaction_smoothing_rounds),
      outer_bags = rlang::enquo(outer_bags),
      inner_bags = rlang::enquo(inner_bags)
    )

    parsnip::update_spec(
      object = object,
      parameters = parameters,
      args_enquo_list = args,
      fresh = fresh,
      cls = "explainable_boost",
      ...
    )
  }

# ------------------------------------------------------------------------------

#' @export
translate.explainable_boost <- function(x, engine = x$engine, ...) {
  x <- parsnip::translate.default(x, engine = engine, ...)

  # slightly cleaner code using
  arg_vals <- x$method$fit$args
  arg_names <- names(arg_vals)

  x$method$fit$args <- arg_vals

  x
}

# ------------------------------------------------------------------------------

#' @export
check_args.explainable_boost <- function(object, call = rlang::caller_env()) {
  invisible(object)
}
