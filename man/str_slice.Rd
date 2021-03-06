% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/strings.R
\name{str_slice}
\alias{str_slice}
\alias{str_slice_by_word}
\title{String Slice}
\usage{
str_slice(x, n = 80L)

str_slice_by_word(x, n = 80L)
}
\arguments{
\item{x}{A character vector}

\item{n}{Integer, the length of the line split}
}
\value{
A \code{character} vector
}
\description{
Slice/split a string into multiple lines by the desired length of the line.
}
\examples{
if (requireNamespace("stringi")) {
  x <- stringi::stri_rand_lipsum(1)
  str_slice(x)
  str_slice_by_word(x, n = 50L)
}
}
