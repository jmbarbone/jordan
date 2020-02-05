#' Pipe message
#'
#' Send a message through a piped operation.
#'
#' @param x An object
#' @inheritDotParams message
#' @export
#' @examples
#' iris %>%
#'   p_message("Review the species column") %>%
#'   mutate(Species = as.character(Sp))

p_message <- function(x, ...) {
  message(...)
  x
}
