# an S3 idea for printing model obj with a subclass of daisugi_mother

#' @export
print.daisugi_mother <- function(x, ...) {
  cat("\n")
  cat("  ██████   █████  ██ ███████ ██    ██  ██████  ██ \n")
  cat("  ██   ██ ██   ██ ██ ██      ██    ██ ██       ██ \n")
  cat("  ██   ██ ███████ ██ ███████ ██    ██ ██   ███ ██ \n")
  cat("  ██   ██ ██   ██ ██      ██ ██    ██ ██    ██ ██ \n")
  cat("  ██████  ██   ██ ██ ███████  ██████   ██████  ██ \n")
  cat("      (%%%%%%%%%)%%%%%)%%%%%%/%%%%%%%%)             \n")
  cat("          (%%%%%(%%%%%  (%%%// %%%%)               \n")
  cat("           (%%)  (%%)    %%%%   (%%)\n")
  cat("            ||    ||-   (%%)    ||\n")
  cat("          --||--  ||     ||   --||--\n")
  cat("            ||  --||-- --||--   ||\n")
  cat("            ||    ||     ||     ||\n")
  cat("        __  ||  __||__  _||_  _||_  __\n")
  cat("       (  `--'  `--'  `--'  `--'  `--'  )\n")
  cat("        `--.________________________.--'\n")
  cat("                  |      |\n")
  cat("                  |      |\n")
  cat("                  |      |\n")
  cat("            ______|      |______\n")
  cat("           |____________________|\n")
  cat("\n")

  # Model Summary Metadata
  cat(" Package:     daisugi\n")
  cat(" Machine:      ", class(x)[1], "\n")
  cat(" Trees:      ", x$trees, "\n")

  invisible(x)
}
