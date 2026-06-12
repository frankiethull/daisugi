make_explainable_boost_ebm <- \() {
  # new type of model & modes -----------
  parsnip::set_new_model("explainable_boost")

  parsnip::set_model_mode("explainable_boost", "classification")
  parsnip::set_model_mode("explainable_boost", "regression")
  # register engines ------------

  parsnip::set_model_engine(
    model = "explainable_boost",
    mode = "regression",
    eng = "ebm"
  )

  parsnip::set_model_engine(
    model = "explainable_boost",
    mode = "classification",
    eng = "ebm"
  )

  # register dependencies ----------
  parsnip::set_dependency(
    model = "explainable_boost",
    eng = "ebm",
    pkg = "daisugi",
    mode = "regression"
  )

  parsnip::set_dependency(
    model = "explainable_boost",
    eng = "ebm",
    pkg = "daisugi",
    mode = "classification"
  )

  parsnip::set_dependency(
    model = "explainable_boost",
    eng = "ebm",
    pkg = "reticulate",
    mode = "classification"
  )

  parsnip::set_dependency(
    model = "explainable_boost",
    eng = "ebm",
    pkg = "reticulate",
    mode = "regression"
  )

  # register eng args ------
  # EBM -> GBM shared arguments ---------
  parsnip::set_model_arg(
    model = "explainable_boost",
    eng = "ebm",
    parsnip = "trees",
    original = "trees",
    func = list(pkg = "dials", fun = "trees"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "explainable_boost",
    eng = "ebm",
    parsnip = "stop_iter",
    original = "stop_iter",
    func = list(pkg = "dials", fun = "stop_iter"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "explainable_boost",
    eng = "ebm",
    parsnip = "learn_rate",
    original = "learn_rate",
    func = list(pkg = "dials", fun = "learn_rate"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "explainable_boost",
    eng = "ebm",
    parsnip = "tree_depth",
    original = "tree_depth",
    func = list(pkg = "dials", fun = "tree_depth"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "explainable_boost",
    eng = "ebm",
    parsnip = "min_n",
    original = "min_n",
    func = list(pkg = "dials", fun = "min_n"),
    has_submodel = FALSE
  )

  # EBM Tier 1 Implemented Arguments ---------
  parsnip::set_model_arg(
    model = "explainable_boost",
    eng = "ebm",
    parsnip = "num_interactions",
    original = "num_interactions",
    func = list(pkg = "daisugi", fun = "num_interactions"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "explainable_boost",
    eng = "ebm",
    parsnip = "max_bins",
    original = "max_bins",
    func = list(pkg = "daisugi", fun = "max_bins"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "explainable_boost",
    eng = "ebm",
    parsnip = "greedy_ratio",
    original = "greedy_ratio",
    func = list(pkg = "daisugi", fun = "greedy_ratio"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "explainable_boost",
    eng = "ebm",
    parsnip = "smoothing_rounds",
    original = "smoothing_rounds",
    func = list(pkg = "daisugi", fun = "smoothing_rounds"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "explainable_boost",
    eng = "ebm",
    parsnip = "regularization_lambda",
    original = "regularization_lambda",
    func = list(pkg = "daisugi", fun = "regularization_lambda"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "explainable_boost",
    eng = "ebm",
    parsnip = "regularization_alpha",
    original = "regularization_alpha",
    func = list(pkg = "daisugi", fun = "regularization_alpha"),
    has_submodel = FALSE
  )

  # EBM Tier 2 Implemented Arguments ---------

  parsnip::set_model_arg(
    model = "explainable_boost",
    eng = "ebm",
    parsnip = "max_interaction_bins",
    original = "max_interaction_bins",
    func = list(pkg = "daisugi", fun = "max_interaction_bins"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "explainable_boost",
    eng = "ebm",
    parsnip = "interaction_smoothing_rounds",
    original = "interaction_smoothing_rounds",
    func = list(pkg = "daisugi", fun = "interaction_smoothing_rounds"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "explainable_boost",
    eng = "ebm",
    parsnip = "outer_bags",
    original = "outer_bags",
    func = list(pkg = "daisugi", fun = "outer_bags"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "explainable_boost",
    eng = "ebm",
    parsnip = "inner_bags",
    original = "inner_bags",
    func = list(pkg = "daisugi", fun = "inner_bags"),
    has_submodel = FALSE
  )

  # register fit, encode, pred interfaces -----
  parsnip::set_fit(
    model = "explainable_boost",
    eng = "ebm",
    mode = "regression",
    value = list(
      interface = "data.frame",
      protect = c("x", "y", "weights"),
      func = c(pkg = "daisugi", fun = "train_ebm_regressor"),
      defaults = list()
    )
  )

  parsnip::set_encoding(
    model = "explainable_boost",
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
    model = "explainable_boost",
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
    model = "explainable_boost",
    eng = "ebm",
    mode = "classification",
    value = list(
      interface = "matrix",
      protect = c("x", "y", "weights"),
      func = c(pkg = "daisugi", fun = "train_ebm_classifier"),
      defaults = list()
    )
  )
  parsnip::set_encoding(
    model = "explainable_boost",
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
    model = "explainable_boost",
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
    model = "explainable_boost",
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
    model = "explainable_boost",
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
}
