#' Percentile rank
#'
#' Returns the percentile rank of a vector of numbers.
#' Percentile rank is defines as the proportion of values that are at or below a selected value.
#' Unlike [dplyr::percent_rank()], `percentile_rank` does not return a percentile of 1.00.
#'
#'
#' @param x A vector of values
#' @examples
#' set.seed(42)
#' x <- sort(sample(60:98, 100, replace = TRUE))
#' percentile_rank(x)

percentile_rank <- function(x) {
  (rank(x, ties.method = "min", na.last = "keep") - 1) / (sum(!is.na(x)))
}
