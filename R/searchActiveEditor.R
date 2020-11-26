#' Search the active Rstudio editor for regex patterns.

#' @name searchActiveEditor
#' @param pattern  [string]
#' @return \code{searchActiveEditor}: [data.table]  rowid, start, and end for all matches
#' @export
searchActiveEditor <- function(pattern) {
    # Search the active Rstudio editor for regex patterns
    assert_string(pattern)
    contents = getActiveDocumentContext()$contents
    rowid <- which(grepl(pattern, contents))
    matches <- str_locate_all(contents[rowid], pattern)
    df <- map2(rowid, matches, function(r, m) data.table(m)[, `:=`(rowid, 
        r)]) %>% rbindlist() %>% setcolorder("rowid")
    return(df)
    # Returns: [data.table] rowid, start, and end for all matches
}
