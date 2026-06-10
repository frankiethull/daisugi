# EBM dials parameters for daisugi provided by Claude:
# Naming convention: EBM param -> parsnip/dials param noted where renamed
# Use in set_model_arg() with the `original` argument pointing back to EBM name

# ------------------------------------------------------------------------------
# TIER 1
# ------------------------------------------------------------------------------

# interactions -> num_interactions
# Renamed: avoids collision with R's stats::interactions(); clearer semantics.
# Upper bound is data-dependent (n_features * multiplier); finalize() can adjust.
#' @export
num_interactions <- function(range = c(0L, 20L), trans = NULL) {
  dials::new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(num_interactions = "Number of Interaction Terms"),
    finalize = NULL
  )
}

# max_bins (name kept)
# Log2 scale: natural because EBM bins are power-of-2 aligned (32, 64, ..., 1024).
#' @export
max_bins <- function(range = c(32L, 1024L), trans = scales::transform_log2()) {
  dials::new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(max_bins = "Max Feature Bins (Main Effects)"),
    finalize = NULL
  )
}

# greedy_ratio (name kept)
# 0 = pure cyclic (pre-v0.5.1 behaviour); higher = more greedy boosting.
# Upper bound of 20 is generous; diminishing returns well before then.
#' @export
greedy_ratio <- function(range = c(0.0, 20.0), trans = NULL) {
  dials::new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(greedy_ratio = "Greedy Boosting Ratio"),
    finalize = NULL
  )
}

# smoothing_rounds (name kept)
# Integer; 0 disables smoothing entirely (old default pre-v0.5.1).
#' @export
smoothing_rounds <- function(range = c(0L, 200L), trans = NULL) {
  dials::new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(smoothing_rounds = "Main Effect Smoothing Rounds"),
    finalize = NULL
  )
}

# reg_lambda -> regularization_lambda
# Renamed: reg_lambda is too terse and collides visually with other engines'
# conventions. No log transform: EBM default is 0, log would exclude that.
#' @export
regularization_lambda <- function(range = c(0.0, 10.0), trans = NULL) {
  dials::new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(regularization_lambda = "L2 Regularization (lambda)"),
    finalize = NULL
  )
}

# reg_alpha -> regularization_alpha
# Same rationale as regularization_lambda.
#' @export
regularization_alpha <- function(range = c(0.0, 10.0), trans = NULL) {
  dials::new_quant_param(
    type = "double",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(regularization_alpha = "L1 Regularization (alpha)"),
    finalize = NULL
  )
}


# ------------------------------------------------------------------------------
# TIER 2
# ------------------------------------------------------------------------------

# max_interaction_bins (name kept)
# Log2 scale mirrors max_bins. Naturally tuned alongside num_interactions.
#' @export
max_interaction_bins <- function(
  range = c(16L, 256L),
  trans = scales::transform_log2()
) {
  dials::new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(max_interaction_bins = "Max Feature Bins (Interactions)"),
    finalize = NULL
  )
}

# interaction_smoothing_rounds (name kept)
# Mirrors smoothing_rounds but for the interaction boosting stage.
#' @export
interaction_smoothing_rounds <- function(range = c(0L, 200L), trans = NULL) {
  dials::new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(interaction_smoothing_rounds = "Interaction Smoothing Rounds"),
    finalize = NULL
  )
}

# outer_bags (name kept)
# Controls ensemble size for variance/uncertainty. Default 14; rarely needs
# to go below 8 or above 28 before cost outweighs benefit.
#' @export
outer_bags <- function(range = c(8L, 28L), trans = NULL) {
  dials::new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(outer_bags = "Outer Bags"),
    finalize = NULL
  )
}

# inner_bags (name kept)
# 0 = off (default). Low ceiling; meaningful range is small.
#' @export
inner_bags <- function(range = c(0L, 10L), trans = NULL) {
  dials::new_quant_param(
    type = "integer",
    range = range,
    inclusive = c(TRUE, TRUE),
    trans = trans,
    label = c(inner_bags = "Inner Bags"),
    finalize = NULL
  )
}

# ------------------------------------------------------------------------------
# PARAMETER MAP SUMMARY
# (for set_model_arg() calls in the parsnip binding)
# ------------------------------------------------------------------------------
#
#  dials name                    | EBM (Python) name            | notes
#  ------------------------------|------------------------------|--------------------
#  num_interactions              | interactions                 | renamed
#  max_bins                      | max_bins                     | kept
#  greedy_ratio                  | greedy_ratio                 | kept
#  smoothing_rounds              | smoothing_rounds             | kept
#  regularization_lambda         | reg_lambda                   | renamed
#  regularization_alpha          | reg_alpha                    | renamed
#  max_interaction_bins          | max_interaction_bins         | kept
#  interaction_smoothing_rounds  | interaction_smoothing_rounds | kept
#  outer_bags                    | outer_bags                   | kept
#  inner_bags                    | inner_bags                   | kept
#
#  boost_tree mapped params (no new dial needed):
#  trees         -> max_rounds
#  learn_rate    -> learning_rate
#  min_n         -> min_samples_leaf
#  tree_depth    -> max_leaves          (approximate; see binding notes)
#  stop_iter     -> early_stopping_rounds
