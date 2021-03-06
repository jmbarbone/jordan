% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/directory.R
\name{file_name}
\alias{file_name}
\title{File name}
\usage{
file_name(x, compression = FALSE)
}
\arguments{
\item{x}{character vector giving file paths.}

\item{compression}{logical: should compression extension \file{.gz},
    \file{.bz2} or \file{.xz} be removed first?}
}
\value{
The file name of the path without the extension
}
\description{
Basename of file without extension
}
