make_boost_tree_ebm <- \() {
  parsnip::set_model_engine(
    model = "boost_tree",
    mode = "regression",
    eng = "ebm"
  )

  parsnip::set_model_engine(
    model = "boost_tree",
    mode = "classification",
    eng = "ebm"
  )

  parsnip::set_dependency(
    model = "boost_tree",
    eng = "ebm",
    pkg = "daisugi",
    mode = "regression"
  )

  parsnip::set_dependency(
    model = "boost_tree",
    eng = "ebm",
    pkg = "daisugi",
    mode = "classification"
  )

  parsnip::set_dependency(
    model = "boost_tree",
    eng = "ebm",
    pkg = "reticulate",
    mode = "classification"
  )

  parsnip::set_dependency(
    model = "boost_tree",
    eng = "ebm",
    pkg = "reticulate",
    mode = "regression"
  )

  parsnip::set_fit(
    model = "boost_tree",
    eng = "ebm",
    mode = "regression",
    value = list(
      interface = "data.frame",
      protect = c("x", "y", "weights"),
      func = c(pkg = "daisugi", fun = "train_ebm_regressor"),
      defaults = list(NULL)
    )
  )

  parsnip::set_encoding(
    model = "boost_tree",
    mode = "regression",
    eng = "ebm",
    options = list(
      predictor_indicators = "none",
      compute_intercept = FALSE,
      remove_intercept = FALSE,
      allow_sparse_x = FALSE
    )
  )

  parsnip::set_pred(
    model = "boost_tree",
    eng = "ebm",
    mode = "regression",
    type = "numeric",
    value = list(
      pre = NULL,
      post = NULL,
      func = c(pkg = "daisugi", fun = "predict_ebm_regression_numeric"),
      args = list(
        object = quote(object),
        new_data = quote(new_data)
      )
    )
  )

  parsnip::set_fit(
    model = "boost_tree",
    eng = "ebm",
    mode = "classification",
    value = list(
      interface = "matrix",
      protect = c("x", "y", "weights"),
      func = c(pkg = "daisugi", fun = "train_ebm_classifier"),
      defaults = list(),
      args = list(
        x = rlang::expr(x),
        y = rlang::expr(y),
        weights = rlang::expr(weights),
        trees = rlang::expr(trees),
        min_n = rlang::expr(min_n),
        tree_depth = rlang::expr(tree_depth),
        learn_rate = rlang::expr(learn_rate),
        stop_iter = rlang::expr(stop_iter),
        num_interactions = rlang::expr(num_interactions),
        max_bins = rlang::expr(max_bins),
        greedy_ratio = rlang::expr(greedy_ratio),
        smoothing_rounds = rlang::expr(smoothing_rounds),
        regularization_lambda = rlang::expr(regularization_lambda),
        regularization_alpha = rlang::expr(regularization_alpha),
        max_interaction_bins = rlang::expr(max_interaction_bins),
        interaction_smoothing_rounds = rlang::expr(
          interaction_smoothing_rounds
        ),
        outer_bags = rlang::expr(outer_bags),
        inner_bags = rlang::expr(inner_bags)
      )
    )
  )
  parsnip::set_encoding(
    model = "boost_tree",
    mode = "classification",
    eng = "ebm",
    options = list(
      predictor_indicators = "none",
      compute_intercept = FALSE,
      remove_intercept = FALSE,
      allow_sparse_x = TRUE
    )
  )

  parsnip::set_pred(
    model = "boost_tree",
    eng = "ebm",
    mode = "classification",
    type = "class",
    value = parsnip::pred_value_template(
      pre = NULL,
      post = NULL,
      func = c(pkg = "daisugi", fun = "predict_ebm_classification_class"),
      object = quote(object),
      new_data = quote(new_data)
    )
  )

  parsnip::set_pred(
    model = "boost_tree",
    eng = "ebm",
    mode = "classification",
    type = "prob",
    value = parsnip::pred_value_template(
      pre = NULL,
      post = NULL,
      func = c(pkg = "daisugi", fun = "predict_ebm_classification_prob"),
      object = quote(object),
      new_data = quote(new_data)
    )
  )

  parsnip::set_pred(
    model = "boost_tree",
    eng = "ebm",
    mode = "classification",
    type = "raw",
    value = parsnip::pred_value_template(
      pre = NULL,
      post = NULL,
      func = c(pkg = "daisugi", fun = "predict_ebm_classification_raw"),
      object = quote(object),
      new_data = quote(new_data)
    )
  )

  # EBM -> GBM shared arguments ---------
  parsnip::set_model_arg(
    model = "boost_tree",
    eng = "ebm",
    parsnip = "trees",
    original = "trees",
    func = list(pkg = "dials", fun = "trees"),
    has_submodel = TRUE
  )

  parsnip::set_model_arg(
    model = "boost_tree",
    eng = "ebm",
    parsnip = "stop_iter",
    original = "stop_iter",
    func = list(pkg = "dials", fun = "stop_iter"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "boost_tree",
    eng = "ebm",
    parsnip = "learn_rate",
    original = "learn_rate",
    func = list(pkg = "dials", fun = "learn_rate"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "boost_tree",
    eng = "ebm",
    parsnip = "tree_depth",
    original = "tree_depth",
    func = list(pkg = "dials", fun = "tree_depth"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "boost_tree",
    eng = "ebm",
    parsnip = "min_n",
    original = "min_n",
    func = list(pkg = "dials", fun = "min_n"),
    has_submodel = FALSE
  )

  # EBM Tier 1 Implemented Arguments ---------
  parsnip::set_model_arg(
    model = "boost_tree",
    eng = "ebm",
    parsnip = "num_interactions",
    original = "num_interactions",
    func = list(pkg = "daisugi", fun = "num_interactions"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "boost_tree",
    eng = "ebm",
    parsnip = "max_bins",
    original = "max_bins",
    func = list(pkg = "daisugi", fun = "max_bins"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "boost_tree",
    eng = "ebm",
    parsnip = "greedy_ratio",
    original = "greedy_ratio",
    func = list(pkg = "daisugi", fun = "greedy_ratio"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "boost_tree",
    eng = "ebm",
    parsnip = "smoothing_rounds",
    original = "smoothing_rounds",
    func = list(pkg = "daisugi", fun = "smoothing_rounds"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "boost_tree",
    eng = "ebm",
    parsnip = "regularization_lambda",
    original = "regularization_lambda",
    func = list(pkg = "daisugi", fun = "regularization_lambda"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "boost_tree",
    eng = "ebm",
    parsnip = "regularization_alpha",
    original = "regularization_alpha",
    func = list(pkg = "daisugi", fun = "regularization_alpha"),
    has_submodel = FALSE
  )

  # EBM Tier 2 Implemented Arguments ---------

  parsnip::set_model_arg(
    model = "boost_tree",
    eng = "ebm",
    parsnip = "max_interaction_bins",
    original = "max_interaction_bins",
    func = list(pkg = "daisugi", fun = "max_interaction_bins"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "boost_tree",
    eng = "ebm",
    parsnip = "interaction_smoothing_rounds",
    original = "interaction_smoothing_rounds",
    func = list(pkg = "daisugi", fun = "interaction_smoothing_rounds"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "boost_tree",
    eng = "ebm",
    parsnip = "outer_bags",
    original = "outer_bags",
    func = list(pkg = "daisugi", fun = "outer_bags"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "boost_tree",
    eng = "ebm",
    parsnip = "inner_bags",
    original = "inner_bags",
    func = list(pkg = "daisugi", fun = "inner_bags"),
    has_submodel = FALSE
  )
}
