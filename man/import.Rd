% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/import.R
\name{import}
\alias{import}
\title{Import}
\usage{
import(pkg, fun, overwrite = FALSE)
}
\arguments{
\item{pkg}{String, name of the package}

\item{fun}{String, fun name of the function}

\item{overwrite}{Logical, if TRUE and \code{fun} is also found in the current
environment, will overwrite assignment}
}
\value{
None, called for side effects
}
\description{
Import a single function from a package
}
\examples{
# assigns `add` -- test with caution
import("magrittr", "add")
}
