make_boost_tree_ydf <- \() {
  # register engines ------------

  parsnip::set_model_engine(
    model = "boost_tree",
    mode = "regression",
    eng = "ydf"
  )

  parsnip::set_model_engine(
    model = "boost_tree",
    mode = "classification",
    eng = "ydf"
  )

  # register dependencies ----------
  parsnip::set_dependency(
    model = "boost_tree",
    eng = "ydf",
    pkg = "daisugi",
    mode = "regression"
  )

  parsnip::set_dependency(
    model = "boost_tree",
    eng = "ydf",
    pkg = "daisugi",
    mode = "classification"
  )

  parsnip::set_dependency(
    model = "boost_tree",
    eng = "ydf",
    pkg = "reticulate",
    mode = "classification"
  )

  parsnip::set_dependency(
    model = "boost_tree",
    eng = "ydf",
    pkg = "reticulate",
    mode = "regression"
  )

  # register eng args ------
  # ydf -> GBM shared arguments ---------
  parsnip::set_model_arg(
    model = "boost_tree",
    eng = "ydf",
    parsnip = "trees",
    original = "trees",
    func = list(pkg = "dials", fun = "trees"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "boost_tree",
    eng = "ydf",
    parsnip = "stop_iter",
    original = "stop_iter",
    func = list(pkg = "dials", fun = "stop_iter"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "boost_tree",
    eng = "ydf",
    parsnip = "learn_rate",
    original = "learn_rate",
    func = list(pkg = "dials", fun = "learn_rate"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "boost_tree",
    eng = "ydf",
    parsnip = "tree_depth",
    original = "tree_depth",
    func = list(pkg = "dials", fun = "tree_depth"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "boost_tree",
    eng = "ydf",
    parsnip = "min_n",
    original = "min_n",
    func = list(pkg = "dials", fun = "min_n"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "boost_tree",
    eng = "ydf",
    parsnip = "sample_size",
    original = "sample_size",
    func = list(pkg = "dials", fun = "sample_prop"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "boost_tree",
    eng = "ydf",
    parsnip = "mtry",
    original = "mtry",
    func = list(pkg = "dials", fun = "mtry_prop"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "boost_tree",
    eng = "ydf",
    parsnip = "loss_reduction",
    original = "loss_reduction",
    func = list(pkg = "dials", fun = "loss_reduction"),
    has_submodel = FALSE
  )

  # register fit, encode, pred interfaces -----
  parsnip::set_fit(
    model = "boost_tree",
    eng = "ydf",
    mode = "regression",
    value = list(
      interface = "data.frame",
      protect = c("x", "y", "weights"),
      func = c(pkg = "daisugi", fun = "train_ydf_regressor"),
      defaults = list()
    )
  )

  parsnip::set_encoding(
    model = "boost_tree",
    mode = "regression",
    eng = "ydf",
    options = list(
      predictor_indicators = "none",
      compute_intercept = FALSE,
      remove_intercept = FALSE,
      allow_sparse_x = FALSE
    )
  )

  parsnip::set_pred(
    model = "boost_tree",
    eng = "ydf",
    mode = "regression",
    type = "numeric",
    value = list(
      pre = NULL,
      post = NULL,
      func = c(pkg = "daisugi", fun = "predict_ydf_regression_numeric"),
      args = list(
        object = quote(object),
        new_data = quote(new_data)
      )
    )
  )

  parsnip::set_fit(
    model = "boost_tree",
    eng = "ydf",
    mode = "classification",
    value = list(
      interface = "matrix",
      protect = c("x", "y", "weights"),
      func = c(pkg = "daisugi", fun = "train_ydf_classifier"),
      defaults = list()
    )
  )
  parsnip::set_encoding(
    model = "boost_tree",
    mode = "classification",
    eng = "ydf",
    options = list(
      predictor_indicators = "none",
      compute_intercept = FALSE,
      remove_intercept = FALSE,
      allow_sparse_x = TRUE
    )
  )

  parsnip::set_pred(
    model = "boost_tree",
    eng = "ydf",
    mode = "classification",
    type = "class",
    value = parsnip::pred_value_template(
      pre = NULL,
      post = NULL,
      func = c(pkg = "daisugi", fun = "predict_ydf_classification_class"),
      object = quote(object),
      new_data = quote(new_data)
    )
  )

  parsnip::set_pred(
    model = "boost_tree",
    eng = "ydf",
    mode = "classification",
    type = "prob",
    value = parsnip::pred_value_template(
      pre = NULL,
      post = NULL,
      func = c(pkg = "daisugi", fun = "predict_ydf_classification_prob"),
      object = quote(object),
      new_data = quote(new_data)
    )
  )

  parsnip::set_pred(
    model = "boost_tree",
    eng = "ydf",
    mode = "classification",
    type = "raw",
    value = parsnip::pred_value_template(
      pre = NULL,
      post = NULL,
      func = c(pkg = "daisugi", fun = "predict_ydf_classification_raw"),
      object = quote(object),
      new_data = quote(new_data)
    )
  )
}
