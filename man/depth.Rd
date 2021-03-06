% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/depth.R
\name{depth}
\alias{depth}
\alias{depth.default}
\alias{depth.list}
\title{Depth}
\usage{
depth(x, ...)

\method{depth}{default}(x, ...)

\method{depth}{list}(x, ...)
}
\arguments{
\item{x}{An object}

\item{...}{Possible additional arguments passed to methods (not in use)}
}
\value{
A single \code{integer}
}
\description{
Functions to extract the 'depth' of an object
}
\details{
This function does not count an empty lists (\code{list()}) as a level or \code{NULL}
objects.
}
\examples{
a <- c(1, 2, 3)
depth(a) # Vectors are 1L

b <- list(a = 1, b = list(list(1)))
depth(b)
}
