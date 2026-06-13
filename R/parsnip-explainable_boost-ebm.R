# ~~~ fitting helpers ~~~

#' @export
train_ebm_regressor <- \(
  x,
  y,
  # gbm params
  trees = 1000L,
  stop_iter = 300L,
  learn_rate = 0.15,
  tree_depth = 2L,
  min_n = 4L,
  # tier 1
  num_interactions = 3L,
  max_bins = 1024L,
  greedy_ratio = 10L,
  smoothing_rounds = 75L,
  regularization_lambda = 0L,
  regularization_alpha = 0L,
  # tier 2
  max_interaction_bins = 64L,
  interaction_smoothing_rounds = 75L,
  outer_bags = 14L,
  inner_bags = 0L
) {
  daisugi::grow_explainable_trees(
    x,
    y,
    task = "regression",
    trees = as.integer(trees),
    early_stop_tree = as.integer(stop_iter),
    learning_rate = learn_rate,
    max_leaves = as.integer(tree_depth),
    min_samples_leaf = as.integer(min_n),
    interactions = as.integer(num_interactions),
    max_bins = as.integer(max_bins),
    greedy_ratio = as.integer(greedy_ratio),
    smoothing_rounds = as.integer(smoothing_rounds),
    reg_alpha = (regularization_alpha),
    reg_lambda = (regularization_lambda),
    max_interaction_bins = as.integer(max_interaction_bins),
    interaction_smoothing_rounds = as.integer(interaction_smoothing_rounds),
    outer_bags = as.integer(outer_bags),
    inner_bags = as.integer(inner_bags)
  )
}

#' @export
train_ebm_classifier <- \(
  x,
  y,
  # gbm params
  trees = 1000L,
  stop_iter = 300L,
  learn_rate = 0.15,
  tree_depth = 2L,
  min_n = 4L,
  # tier 1
  num_interactions = 3L,
  max_bins = 1024L,
  greedy_ratio = 10L,
  smoothing_rounds = 75L,
  regularization_lambda = 0L,
  regularization_alpha = 0L,
  # tier 2
  max_interaction_bins = 64L,
  interaction_smoothing_rounds = 75L,
  outer_bags = 14L,
  inner_bags = 0L
) {
  daisugi::grow_explainable_trees(
    x,
    y,
    task = "classification",
    trees = as.integer(trees),
    early_stop_tree = as.integer(stop_iter),
    learning_rate = learn_rate,
    max_leaves = as.integer(tree_depth),
    min_samples_leaf = as.integer(min_n),
    interactions = as.integer(num_interactions),
    max_bins = as.integer(max_bins),
    greedy_ratio = as.integer(greedy_ratio),
    smoothing_rounds = as.integer(smoothing_rounds),
    reg_alpha = (regularization_alpha),
    reg_lambda = (regularization_lambda),
    max_interaction_bins = as.integer(max_interaction_bins),
    interaction_smoothing_rounds = as.integer(interaction_smoothing_rounds),
    outer_bags = as.integer(outer_bags),
    inner_bags = as.integer(inner_bags)
  )
}

# ~~~ inference helpers ~~~

#' @export
predict_ebm_regression_numeric <- \(object, new_data, ...) {
  preds <- daisugi::harvest_explainable_trees(
    fit = object$fit,
    x = new_data,
    ...
  )

  tibble::as_tibble(data.frame(.pred = preds))
}
#' @export
predict_ebm_classification_raw <- \(object, new_data, ...) {
  daisugi::harvest_explainable_trees(fit = object$fit, x = new_data, ...)
}

#' @export
predict_ebm_classification_class <- \(object, new_data, ...) {
  preds <- daisugi::harvest_explainable_trees(
    fit = object$fit,
    x = new_data,
    ...
  )
  tibble::as_tibble(data.frame(.pred_class = preds))
}
# predict_ebm_classification_prob
