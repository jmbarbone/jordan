% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/stats.R
\name{range2}
\alias{range2}
\title{Range 2}
\usage{
range2(x, na.rm = FALSE)
}
\arguments{
\item{x}{A numeric (or character) vector (see Note in \link[base:Extremes]{base::min})}

\item{na.rm}{Logical, if \code{TRUE} removes missing values}
}
\value{
A \code{numeric} vector of length 2 of the minimum and maximum values,
respectively
}
\description{
Employs \code{min()} and \code{max()}.  However, \code{\link[base:range]{base::range()}}, there is no argument
for removing \code{Inf} values.
}
\examples{
\donttest{
x <- rep(1:1e5, 100)
system.time(rep(range(x),  100))
system.time(rep(range2(x), 100))
x[sample(x, 1e5)] <- NA

system.time(rep(range(x, na.rm = TRUE), 100))
system.time(rep(range2(x, na.rm = TRUE), 100))
}
}
