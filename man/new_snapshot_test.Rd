% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/new_snapshot_test.R
\name{new_snapshot_test}
\alias{new_snapshot_test}
\title{create a new snapshot test.}
\usage{
new_snapshot_test(
  name,
  code,
  overwrite = FALSE,
  commit_git = TRUE,
  push_github = TRUE
)
}
\arguments{
\item{name}{\code{[string]} the test name}

\item{code}{\code{[expr]} the code to test, wrapped in brackets.}

\item{overwrite}{\code{[logical]}  Must have an exact length of \code{1}.  Defaults to \code{FALSE}}

\item{commit_git}{\code{[logical]}  Must have an exact length of \code{1}.  Defaults to \code{TRUE}}

\item{push_github}{\code{[logical]}  Must have an exact length of \code{1}.  Defaults to \code{TRUE}}
}
\value{
\code{new_snapshot_test}: invisible(NULL) Writes a test file to the tests/thatthat directory
}
\description{
Any line without an assignment will be wrapped in \code{expect_snapshot()}.
}
