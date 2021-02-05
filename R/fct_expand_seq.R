#' Factor Expand by Sequence
#'
#' Expands an ordered factor from one level to another
#'
#' @details
#' Defaults for `min_lvl` and `max_lvl` are the minimum and maximum levels in the ordered vector `x`.
#' This can be adjusted if we
#'
#' @param x An ordered factor
#' @param min_lvl The start of the level sequence
#' @param max_lvl The end of the level sequence
#' @param by Integer, number of steps in between
#' @export
#' @examples
#' x <- ordered(letters[c(5:15, 2)], levels = letters)
#' fct_expand_seq(x)
#' fct_expand_seq(x, "g", "s", 3L) # from "g" to "s" by 3
#' fct_expand_seq(x, "g", "t", 3L) # same as above
#' fct_expand_seq(x, min(levels(x))) # from the first inherit level to the last observed

fct_expand_seq <- function(x,
                           min_lvl = min(x, na.rm = TRUE),
                           max_lvl = max(x, na.rm = TRUE),
                           by = 1L) {
  stopifnot("<< x >> must be a class ordered" = inherits(x, "ordered"),
            "<< by >> must be an integer >= 1L" = is.integer(by) & by >= 1L)

  lvls <- levels(x)
  if (is.character(min_lvl) | inherits(min_lvl, "factor")) {
    min_lvl <- which(lvls == min_lvl)
  }
  if (is.character(max_lvl) | inherits(max_lvl, "factor")) {
    max_lvl <- which(lvls == max_lvl)
  }
  stopifnot("<< min_level >> cannot be `NA`" = !is.na(min_lvl),
            "<< max_level >> cannot be `NA`" = !is.na(max_lvl))
  int <- seq(from = min_lvl, to = max_lvl, by = by)
  ordered(lvls[int], levels = lvls)
}