% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/note.R
\name{note}
\alias{note}
\alias{note<-}
\alias{print.note}
\title{Append a note to an object}
\usage{
note(x) <- value

note(x)

\method{print}{note}(x, ...)
}
\arguments{
\item{x}{An object}

\item{value}{The note to attach; if \code{NULL} will remove the note and the
class \code{noted} from the object.}

\item{...}{Additional arguments passed from methods (not used)}
}
\value{
\itemize{
\item \verb{note<-} will return \code{x} (with the \code{"note"} attribute assigned)
\item \code{note()} will retrieve the \code{"note"} attribute
}
}
\description{
An alternative to the \code{\link[base:comment]{base::comment()}}.
}
\details{
When the note is assigned to an object a new class will be added,
\code{note}, so that a \code{print} function can call an S3 method.  The print for
this can be adjusted for it's width by using the option
\code{mark.note.width} which defaults to the option \code{width} when not set.

The type of object assigned to the note is not restricted, so user beware
of odd prints or additional features added to the notes fun.

When assigning a note (with \verb{note<-}) the \code{noted} class is added to the
object.  This allows the \code{print.noted} class to be distracted and for the
note to be printed (with the \code{print.note} method) every time the object is
called/printed.  However, it will not be called when not \code{interactive()}
}
\examples{
x <- c("x", "k", "c", "d")
comment(x) <- "This is just a comment"
comment(x)

# Comment is intentionally hidden
x
note(x) <- "Just some random letters"
note(x)

# Note is now present every time
x

# Assigning `NULL` will remove note (and class)
note(x) <- NULL
note(x) # NULL
x       # No more note

}
