# ~~~ fitting helpers ~~~

#' @export
train_ydf_regressor <- \(
  x,
  y,
  # gbm params
  trees = 300L,
  stop_iter = 100L,
  learn_rate = 0.1,
  tree_depth = 6L,
  min_n = 5L,
  sample_size = 1,
  mtry = -1L,
  loss_reduction = 0
) {
  daisugi::grow_yggdrasil_trees(
    x,
    y,
    task = "regression",
    trees = as.integer(trees),
    early_stopping_initial_iteration = as.integer(stop_iter),
    shrinkage = learn_rate,
    max_depth = as.integer(tree_depth),
    min_examples = as.integer(min_n),
    subsample = sample_size,
    sampling_method = "RANDOM",
    num_candidate_attributes_ratio = as.numeric(mtry),
    l2_regularization = loss_reduction
  )
}

#' @export
train_ydf_classifier <- \(
  x,
  y,
  # gbm params
  trees = 300L,
  stop_iter = 100L,
  learn_rate = 0.1,
  tree_depth = 6L,
  min_n = 5L,
  sample_size = 1,
  mtry = -1L,
  loss_reduction = 0
) {
  daisugi::grow_yggdrasil_trees(
    x,
    y,
    task = "classification",
    trees = as.integer(trees),
    early_stopping_initial_iteration = as.integer(stop_iter),
    shrinkage = learn_rate,
    max_depth = as.integer(tree_depth),
    min_examples = as.integer(min_n),
    subsample = sample_size,
    sampling_method = "RANDOM",
    num_candidate_attributes_ratio = mtry,
    l2_regularization = loss_reduction
  )
}


# ~~~ inference helpers ~~~

#' @export
predict_ydf_regression_numeric <- \(object, new_data, ...) {
  preds <- daisugi::harvest_yggdrasil_trees(
    fit = object$fit,
    x = as.data.frame(new_data),
    ...
  )

  tibble::as_tibble(data.frame(.pred = preds))
}
#' @export
predict_ydf_classification_raw <- \(object, new_data, ...) {
  daisugi::harvest_yggdrasil_trees(
    fit = object$fit,
    x = as.data.frame(new_data),
    ...
  )
}

#' @export
predict_ydf_classification_class <- \(object, new_data, ...) {
  preds <- daisugi::harvest_yggdrasil_trees(
    fit = object$fit,
    x = as.data.frame(new_data),
    ...
  )

  tibble::as_tibble(data.frame(.pred_class = preds))
}

# predict_ydf_classification_prob
