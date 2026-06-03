#' Grow GRANDE Trees
#'
#' @param x a data X
#' @param y a data Y
#' @param task a task
#' @param trees num of trees
#' @param ... other eng args
#'
#' @returns a fitted model
#'
#' @export
grow_grande_trees <- \(
  x,
  y,
  trees = 100L,
  task = "classification",
  ...
) {
  if (is.data.frame(x)) {
    x <- as.matrix(x)
  }

  pd <- reticulate::import("pandas")

  if (is.factor(y) && task == "classification") {
    y_levels <- levels(y)
    y <- as.integer(y) - 1L
    classes <- length(y_levels)
    type <- ifelse(classes > 2, "multiclass", "binary")

    # Convert to pandas Series so autogluon's .value_counts() works
    y <- pd$Series(y)
  } else if (
    task == "classification" && !inherits(y, "pandas_core_series_Series")
  ) {
    # For non-factor classification targets, also use Series
    y <- pd$Series(y)
  }
  # For regression, keep as numpy array (autogluon accepts that)

  if (task == "classification") {
    grande <- daisugi:::.pkg_env$grande$GRANDE(
      params = list(
        n_estimators = trees,
        problem_type = type,
        ...
      )
    )
  } else if (task == "regression") {
    grande <- daisugi:::.pkg_env$grande$GRANDE(
      params = list(
        n_estimators = trees,
        problem_type = "regression",
        ...
      )
    )
  }

  model <- grande$fit(x, y)

  ret <- list(fit = model)
  class(ret) <- c("daisugi_grande_mother", class(ret))

  ret
}

#' Harvest GRANDE Trees
#'
#' @param fit a fitted ngboost model
#' @param x a set of predictors
#' @param ... placeholder
#'
#' @returns predictions
#'
#' @export
harvest_grande_trees <- \(fit, x, ...) {
  if (is.data.frame(x)) {
    x <- as.matrix(x)
  }
  #TODO: probas
  fit$fit$predict(x)
}

# GRANDE requires all params to be set
# it also does a few checks on data downstream
# there are a handful of quirks trying to be handled below

initialize_grande_and_control <- \(trees = 10L) {
  grande <- daisugi:::.pkg_env$grande$GRANDE(
    params = list(
      n_estimators = trees, # trees
      problem_type = 'binary',
      depth = 6L, # Often required as a default
      learning_rate_weights = 0.001,
      learning_rate_index = 0.01,
      learning_rate_values = 0.05,
      learning_rate_leaf = 0.05,
      learning_rate_embedding = 0.02, # used if embeddings are enabled

      # Embeddings (set True to enable)
      use_category_embeddings = FALSE, # True to enable
      embedding_dim_cat = 8L,
      use_numeric_embeddings = FALSE, # True to enable
      embedding_dim_num = 8L,
      embedding_threshold = 1L, # low-cardinality split for categorical embeddings
      loo_cardinality = 10L, # high-cardinality split for encoders

      dropout = 0.2,
      selected_variables = 0.8,
      data_subset_fraction = 1.0,
      bootstrap = FALSE,
      missing_values = FALSE,

      optimizer = 'adam', # options= nadam, radam, adamw, adam
      cosine_decay_restarts = FALSE,
      reduce_on_plateau_scheduler = TRUE,
      label_smoothing = 0.0,
      use_class_weights = FALSE,
      focal_loss = FALSE,
      swa = FALSE,
      es_metric = TRUE, # AUC for binary, MSE for regression, val_loss for multiclass

      epochs = 250L,
      batch_size = 256L,
      early_stopping_epochs = 50L,

      use_freq_enc = FALSE,
      use_robust_scale_smoothing = FALSE,
      verbose = 2L,
      random_seed = 42L
    )
  )

  grande
}

force_grande_fit <- \(
  x_train,
  y_train,
  grande_control = initialize_grand_and_control()
) {
  reticulate::py_run_string(
    "
import torch
import pandas as pd
import numpy as np
# DISABLE TORCH COMPILATION TO BYPASS MISSING HEADERS
torch._dynamo.config.disable = True

def force_fit_grande(model, x, y):
    # Convert to DataFrame and FORCE string column names
    x_pd = pd.DataFrame(x)
    x_pd.columns = x_pd.columns.astype(str)
    
    y_pd = pd.Series(y)
    if y_pd.dtype == 'object':
        y_pd = pd.Series(pd.factorize(y_pd)[0])
    
    y_pd.index = x_pd.index
    
    # We must also tell the model which columns are numeric/cat 
    # if it hasn't inferred them correctly yet.
    model.num_columns = x_pd.columns.tolist()
    model.cat_columns = []

    model.device = torch.device('cpu')
    
    return model.fit(x_pd, y_pd)
"
  )

  fit <- reticulate::py$force_fit_grande(
    grande,
    as.matrix(x_train),
    as.vector(y_train |> as.integer() - 1)
  )
  return(fit)
}
