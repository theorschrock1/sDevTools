#' Get the current cursor position in the Rstudio editor.

#' @name currentCursor
#' @return \code{currentCursor}: [named list('row.start','col.start','row.end','col.start','text')]
#' @export
currentCursor <- function() {
    # Get the current cursor position in the Rstudio editor
    df <- getActiveDocumentContext()
    if(df$id!='#console'){
      #  print("active")
    out = unlist(df$selection)
    nums = as.numeric(out[names(out) %nin% "text"])
    out = c(as.list(nums), out[names(out) %in% "text"])
    names(out) <- c("row.start", "col.start", "row.end", "col.end", "text")
    return(out)
    }
    #print("last")
    id=getLastEditedDocumentId()
    cursor=getDocumentContext(id=id)$cursor
    text=getSelection(id)
    lines=str_split(text,"\n") %>% unlist()
    cursor=cursor+1
    row.end= cursor[1]+ len( lines)-1
    col.end= cursor[2]+ str_length( last(lines))
    list(
        row.start = cursor[1],
        col.start = cursor[2],
        row.end=row.end,
        col.end = col.end,
        text = text
    )
    # Returns: [named
    # list('row.start','col.start','row.end','col.end','text')]
}
#' @export
getSelection <- function(id=NULL) {
    # Get the current selected text in the Rstudio editor
    selectionGet(id=id%or%getLastEditedDocumentId())
    # Returns: [named
    # list('row.start','col.start','row.end','col.start','text')]
}
