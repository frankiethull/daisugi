# ~~~ fitting helpers ~~~

#' @export
train_ebm_regressor_lite <- \(
  x,
  y,
  # gbm params
  trees = 1000L,
  stop_iter = 300L,
  learn_rate = 0.15,
  tree_depth = 2L,
  min_n = 4L
) {
  daisugi::grow_explainable_trees(
    x,
    y,
    task = "regression",
    trees = as.integer(trees),
    early_stop_tree = as.integer(stop_iter),
    learning_rate = learn_rate,
    max_leaves = as.integer(tree_depth),
    min_samples_leaf = as.integer(min_n)
  )
}

#' @export
train_ebm_classifier_lite <- \(
  x,
  y,
  # gbm params
  trees = 1000L,
  stop_iter = 300L,
  learn_rate = 0.15,
  tree_depth = 2L,
  min_n = 4L
) {
  daisugi::grow_explainable_trees(
    x,
    y,
    task = "classification",
    trees = as.integer(trees),
    early_stop_tree = as.integer(stop_iter),
    learning_rate = learn_rate,
    max_leaves = as.integer(tree_depth),
    min_samples_leaf = as.integer(min_n)
  )
}
