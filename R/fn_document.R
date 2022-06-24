#' Create function documentation for R packages.

#' @name fn_document
#' @param fn  [function]
#' @param examples  [call]  NULL is ok.  Defaults to NULL
#' @param rdname  [string]  NULL is ok.  Defaults to NULL
#' @param open  [logical]  Defaults to TRUE
#' @param overwrite  [logical]  Defaults to FALSE
#' @param package  [subset]  Possible values: c('installed_packages').  Defaults to current_pkg()
#' @return \code{fn_document}: [invisible(path)]
#' @export
fn_document <- function(fn, examples = NULL,snaptest_examples=TRUE, rdname = NULL, open = FALSE, overwrite = FALSE,git_commit=TRUE,git_push=TRUE,package = current_pkg()) {
    # Create function documentation for an R package
    fn_name <- deparse(enexpr(fn))
    examples = enexpr(examples)
    examplesout = examples
    assert_function(fn)
    assert_call(examples, "{", null.ok = TRUE)
    assert_string(rdname, null.ok = TRUE)
    assert_logical(open)
    assert_logical(overwrite)
    assert_subset(package, choices = installed_packages())
    func <- fn
    params = build_params(func)
    c(description,returns,func)%<-%get_fdoc(func)


    res <- checkUsageFn(func, fn_name = fn_name, package = package)
    if (!isTRUE(res)) {
        readInput()
    }


    fnbody =  exprs_deparse(call_args(fn_body(func)))
    fnHead <- expr_deparse(func, width=5000)[1]
    fnHead = str_replace(fnHead, "\\<", glue("{fn_name}<-"))
    funcout = c(fnHead, glue("  # {description}"), fnbody, glue("  # Returns: {returns}"), "}")
    description <- str_trim(unlist(str_split(str_replace(description, "\\.", "!!!"), "!!!")))
    description[1] <- paste0(description[1], ".")
    description <- paste0("#' ", description, "\n")
    description <- paste(description, collapse = "#'\n")
    return <- glue("#' @return \\code{&&fn_name&&}: &&returns&&\n", .open = "&&", .close = "&&")
    if (!is.null(examples)) {
        examples <- deparse(examples)
        xlen <- l(examples) - 1
        examples <- str_trim(examples[2:xlen])
        examples <- c("#' @examples\n", paste("#' ", examples))
    }
    if (!is.null(rdname))
        rdname = glue("#' @rdname {rdname}")

    path = glue("~/{package}")
    fncFile <- str_replace_all(fn_name, "%", "")
    name <- paste0("#' @name ", fn_name)
    out <- c(description, name, unlist(params), return, examples, rdname, "#' @export", funcout)
    pathout = paste0(path, "/R/", fncFile, ".R")
    if (file.exists(pathout) & overwrite == FALSE)
        stop(glue("Function name 'fncFile' exists.  Use overwrite=TRUE to overwrite"))

    writeLines(out, con = pathout)
    suppressMessages(tidy_file(pathout))
    g_success("Writing '{fncFile}' to package '{package}'")
    rm(list=fn_name,envir = global_env())

    suppressMessages(
    devtools::document(roclets = c('rd', 'collate', 'namespace'),quiet=TRUE)
    )
    devtools::load_all(quiet=TRUE)
    if(!is_dir_using_git()&git_commit){
     #If dir isn't using git warn and set 'git_commit' to FALSE
        cli::cli_alert_warning("Not commiting to git: directory is not using GIT")
        git_commit=FALSE
    }

    if(snaptest_examples&nnull(examplesout)&&!grepl('shinyApp|interactive\\(\\)',examples%sep%"")){
    #Build snap shot test if 'snaptest_examples=TRUE' and examples are provided.
       eval(expr(build_snapshot_test(
            fn_name,
            code = !!examplesout,
            overwrite = overwrite,
            commit_git  = git_commit,
            push_github = FALSE
        )))
    }
    if(git_commit){
        bump_pkg_version()
        newfiles = c(pathout,
                     path("~", package, "man", paste0(fncFile, ".Rd")),
                     "NAMESPACE",
                     "DESCRIPTION")
        if(nnull(rdname))
            newfiles=pathout

        add2Git( newfiles,bump_version=FALSE)
     }
    if(!snaptest_examples&&isEditorDev()&&nnull(examplesout)&&!grepl('shinyApp',examples%sep%"")){
        text<-devTest(fn_name,examples=examplesout)
        rowid<-currentCursor()$row.end+1
        insertText(location=document_position(rowid,1),text=text,id=getDocumentId("DEV"))
    }
    if (open)
        file.edit(pathout)


    #assign(paste0(fn_name,"_examples"), examplesout,envir=globalenv())
    invisible(pathout)
    # Returns: [invisible(path)]
}
