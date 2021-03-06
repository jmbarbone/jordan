#' Diff time wrappers
#'
#' Wrappers for computing diff times
#'
#' @details
#' A few significant differences exist with these functions
#'   * The class of the object returned is no longer `difftime` (but does print)
#'     with the `difftime` method.  This makes the exporting process easier as
#'     the data will not have to be converted back to `numeric`
#'   * `difftime()` computes the difference of `time1` - `time2`, but the
#'     inverse feels a bit more nature: time difference from `x` to `y`
#'   * Additional units can be used (detailed below)
#'   * Differences can be sensitive to time zones if time zones are passed to
#'     the `tz` parameter as a character vector
#'
#' @section Units:
#' Units can be used beyond those available in `base::difftime()`.  Some of
#'   these use assumptions in how units of time should be standardized and can
#'   be changed in the corresponding options.  Any of these can be calculated
#'   with `base::difftime()` through using `units = "days"` but the `dtime`
#'   class will print out with these specifications into the console for less
#'   potential confusion.
#'
#' \describe{
#'   \item{months}{Months by number of days `mark.days_in_month` (defaults: `30`)}
#'   \item{years}{Years by number of days `mark.days_in_year` (defaults: `365`)}
#'   \item{dyears}{Years by number of days `mark.days_in_year` (defaults: `365`) (same as `years`)}
#'   \item{myears}{Years by number of days in a month `mark.days_in_month` (defaults: `30`)}
#'   \item{wyears}{Years by number of weeks in a year `mark.weeks_in_year` (defaults: `52`)}
#' }
#'
#' @section Time zones:
#' Time zones can be passed as either a numeric vector of GMT/UTC offsets (the
#'   number of seconds from GMT) or as a character vector.  If the letter, these
#'   need to conform with values from `base::OlsonNames()`.
#'
#' @param x,y Vectors of times
#' @param method A method to report the difference in units of time (see
#'   **Units** section)
#' @param tzx,tzy time zones (see **Time zones** section)
#' @param ... Additional arguments passed to `diff_time()`
#' @return A `diff_time` vector, object
#'
#' @export
#' @name diff_time
diff_time <- function(
  x,
  y,
  method = c("secs", "mins", "hours", "days", "weeks", "months", "years", "dyears", "wyears", "myears"),
  tzx = NULL,
  tzy = tzx
) {
  method <- match_param(method)
  ux <- extract_numeric_time(x, tzx)

  if (inherits(x, "Date")) {
    y <- as.Date(y, optional = TRUE)
  }

  uy <- extract_numeric_time(y, tzy)
  # NB: This is time from X to Y
  z <- uy - ux

  out <- switch(
    method,
    secs   = z,
    mins   = z / 60,
    hours  = z / 3600,
    days   = z / 86400,
    weeks  = z / 604800,
    months = z / getOption("mark.days_in_month", 30) / 86400,
    years  = z / getOption("mark.days_in_year", 365) / 86400,
    dyears = z / getOption("mark.days_in_year", 365) / 86400,
    myears = z / getOption("mark.days_in_month", 30) / 1036800,
    wyears = z / getOption("mark.weeks_in_year", 52) / 604800
  )

  attributes(out) <- list(
    class = c("numeric", "diff_time"),
    units = method
  )

  out
}

extract_numeric_time <- function(x, tz) {
  if (is.numeric(tz)) {
    return(unclass(x) + tz)
  }

  if (is.null(tz)) {
    if (is.numeric(x)) {
      stop("Date times cannot be numeric", call. = FALSE)
    }

    gmt <- NULL

    if (is_POSIXct(x)) {
      gmt <- as.double(format(x, "%z"))
    } else if (!is_POSIXlt(x)) {
      x <- as.POSIXlt(x)
      gmt <- x$gmtoff
    }

    if (is.null(gmt)) {
      gmt <- 0.0
    } else {
      gmt[is.na(gmt)] <- 0.0
    }

    return(unclass(as.POSIXct(x)) + gmt)
  }

  to_numeric_with_tz(x, tz)
}

to_numeric_with_tz <- function(x, tz) {
  nas <- is.na(tz)

  if (any(nas)) {
    warning('NA found in timezones; setting to ""', call. = FALSE)
    tz[nas] <- ""
  }

  check_tz(tz)

  out <- mapply(
    function(xi, tzi) {
      o <- as.POSIXlt(xi, tz = tzi)
      off <- o$gmtoff %||% 0.0
      as.double(o) + off
    },
    xi = as.list(x),
    tzi = tz,
    USE.NAMES = FALSE,
    SIMPLIFY = FALSE
  )

  as.vector(out, "double")
}

check_tz <- function(x) {
  if (is.null(x) || all(x == "")) {
    return(invisible(NULL))
  }

  ux <- unique(x)
  bad <- ux %out% OlsonNames()
  if (any(bad)) {
    stop("Timezone(s) not found: ",
         collapse0(ux[bad], sep = ", "),
         "\n  Please check timezones in `OlsonNames()`",
         call. = FALSE)
  }

  invisible(NULL)
}

#' @exportS3Method
print.diff_time <- function(x, digits = getOption("digits"), ...) {
  xu <- attr(x, "units")
  u <- switch(
    xu,
    secs = "seconds",
    mins = "minutes",
    months = sprintf("months (%s days)", getOption("mark.days_in_month", 30)),
    years = sprintf("years (%s days)", getOption("mark.days_in_year", 365)),
    dyears = sprintf("years (%s days)", getOption("mark.days_in_year", 365)),
    myears = sprintf("years (%s-day months)", getOption("mark.days_in_month", 30)),
    wyears = sprintf("years (%s weeks)", getOption("mark.weeks_in_year", 52)),
    xu
  )
  cat("Time differences in ", u, "\n", sep = "")
  y <- unclass(x)
  attr(y, "units") <- NULL
  print(y, digits = digits, ...)
  invisible(x)
}


# Wrappers ----------------------------------------------------------------

#' @export
#' @rdname diff_time
diff_time_days <- function(x, y, ...) {
  diff_time(x, y, method = "days", ...)
}

#' @export
#' @rdname diff_time
diff_time_weeks <- function(x, y, ...) {
  diff_time(x, y, method = "weeks", ...)
}

#' @export
#' @rdname diff_time
diff_time_hours <- function(x, y, ...) {
  diff_time(x, y, method = "hours", ...)
}

#' @export
#' @rdname diff_time
diff_time_mins <- function(x, y, ...) {
  diff_time(x, y, method = "mins", ...)
}

#' @export
#' @rdname diff_time
diff_time_secs <- function(x, y, ...) {
  diff_time(x, y, method = "secs", ...)
}

#' @export
#' @rdname diff_time
diff_time_months <- function(x, y, ...) {
  diff_time(x, y, method = "months", ...)
}

#' @export
#' @rdname diff_time
diff_time_years <- function(x, y, ...) {
  diff_time(x, y, method = "years", ...)
}

#' @export
#' @rdname diff_time
diff_time_dyears <- function(x, y, ...) {
  diff_time(x, y, method = "dyears", ...)
}

#' @export
#' @rdname diff_time
diff_time_wyears <- function(x, y, ...) {
  diff_time(x, y, method = "wyears", ...)
}

#' @export
#' @rdname diff_time
diff_time_myears <- function(x, y, ...) {
  diff_time(x, y, method = "myears", ...)
}


# Inherits ----------------------------------------------------------------

#' Time inherits
#'
#' `inherits(x, ...)` wrappers
#'
#' @param x An object
#'
#' @seealso [mark::diff_time]
#' @name time_inherits
#' @noRd
is_POSIXlt <- function(x) {
  inherits(x, "POSIXlt")
}

#' @rdname time_inherits
#' @noRd
is_POSIXct <- function(x) {
  inherits(x, "POSIXct")
}

#' @rdname time_inherits
#' @noRd
is_diff_time <- function(x) {
  inherits(x, "diff_time")
}
