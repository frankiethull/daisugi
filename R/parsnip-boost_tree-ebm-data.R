make_boost_tree_ebm <- \() {
  # register engines ------------

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

  # register dependencies ----------
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

  # register eng args ------
  # EBM -> GBM shared arguments ---------
  parsnip::set_model_arg(
    model = "boost_tree",
    eng = "ebm",
    parsnip = "trees",
    original = "trees",
    func = list(pkg = "dials", fun = "trees"),
    has_submodel = FALSE
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

  # register fit, encode, pred interfaces -----
  parsnip::set_fit(
    model = "boost_tree",
    eng = "ebm",
    mode = "regression",
    value = list(
      interface = "data.frame",
      protect = c("x", "y", "weights"),
      func = c(pkg = "daisugi", fun = "train_ebm_regressor_lite"),
      defaults = list()
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
      func = c(pkg = "daisugi", fun = "train_ebm_classifier_lite"),
      defaults = list()
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
}
