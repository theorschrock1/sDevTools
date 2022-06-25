#' Paste Html from clipboard into R.

#' @name clearEnv
#' @return \code{clearEnv}: [NULL]
#' @export
paste_html=function(){

  ShinyReboot::html2R(from_clip = T)

  # tidy_source()
  insertAtCursor(tidy_source()[[1]])
}
