#' Paste Html from clipboard into R.

#' @name paste_html
#' @return \code{paste_html}: [NULL]
#' @export
paste_html=function(){

  ShinyReboot::html2R(from_clip = T)

  # tidy_source()
  insertAtCursor(tidy_source()[[1]])
}

