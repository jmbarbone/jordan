% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{ept}
\alias{ept}
\title{Parse and evaluate text}
\usage{
ept(x, envir = parent.frame())
}
\arguments{
\item{x}{A character string to parse}

\item{envir}{The environment in which to evaluate the code}
}
\value{
The evaluation of \code{x} after parsing
}
\description{
A wrapper for eval(parse(text = .))
}
