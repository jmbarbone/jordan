#' To percentage
#'
#' Quick conversion of a numeric value to a "percentage"
#'
#' @param x A number
#' @param digits Optiona, numeric.  Defines the number of decimals for the percentage.
#' @export

to_percent <- function(x, digits = NULL) {
  round(x * 100, digits = ifelse(is.null(digits), n_digits(x), digits))
}
