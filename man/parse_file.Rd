% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/parse_file.R
\name{parse_file}
\alias{parse_file}
\title{Parse an r file.}
\usage{
parse_file(path, split = TRUE)
}
\arguments{
\item{path}{\code{[file_exists]}}

\item{split}{\code{[logical(1)]} split into a list of expressions? Defaults to \code{TRUE}.}
}
\value{
\code{parse_file}: \code{[list(exprs)|expr]} unevaluated R expression or list of expressions.
}
\description{
Parse an r file.
}
