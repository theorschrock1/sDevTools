% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add2Git.R
\name{add2Git}
\alias{add2Git}
\title{Add a file to git.}
\usage{
add2Git(
  file = NULL,
  message = NULL,
  commit = TRUE,
  push = TRUE,
  staged_only = TRUE,
  bump_version = TRUE
)
}
\arguments{
\item{file}{\code{[file]} The file to add to GIT. If NULL and also committing to GIT, a message is required.}

\item{message}{\code{[string]}  The commit message. Must have an exact length of \code{1}.  Defaults to \code{NULL}}

\item{commit}{\code{[logical]}  Should the added files be committed to GIT? Must have an exact length of \code{1}.  Defaults to \code{TRUE}}

\item{push}{\code{[logical]} If committing to GIT, should changes be pushed to Github? Must have an exact length of \code{1}.  Defaults to \code{TRUE}}

\item{bump_version}{\code{[logical]} Increase the package version number? Must have an exact length of \code{1}.  Defaults to \code{TRUE}}
}
\value{
\code{add2Git}: invisible([NULL])
}
\description{
Add a file to git.
}
