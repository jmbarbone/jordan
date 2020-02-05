#' N digits
#'
#' Returns the number of digits.  Trailing zeros not included.
#'
#' @param x A numeric vector.
#'
#' @export
#' @examples
#' n_digits(1)
#' n_digits(1.00001)
#' n_digits(1.00000000000001)


n_digits <- function(x) {
  # if(integer_like(x)) return(0)
  nchar(sub("^[[:digit:]]+\\.+([[:digit:]]*)$", "\\1", paste(x)))
}

integer_like <- function(x) {
  as.integer(x) == x
}


find_decimal_mark <- function(x) {
  res <- which(unlist(strsplit(paste(x), "")) == ".")
  if(length(res) == 0) return(0)
  res
}

find_decimal_mark(c(0.1, .1, 10))
