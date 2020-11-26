#' Check a function's usage across an environment.

#' @name checkFunctionUsage
#' @param name  \code{[string]}
#' @param package  \code{[subset]}  Possible values: \code{installed_packages()}.  Defaults to \code{current_pkg()}
#' @param env  \code{[environment]}  NULL is ok.  Defaults to \code{NULL}
#' @return \code{checkFunctionUsage}: data.table(obj_name,type,symbol_match,string_match)
#' @examples

#'  checkFunctionUsage('expr', package = 'sDevTools')
#' @export
checkFunctionUsage <- function(name, package = current_pkg(), env = NULL) {
    # Check a function's usage across an environment
    assert_string(name)
    assert_subset(package, choices = installed_packages())
    assert_environment(env, null.ok = TRUE)
    getR6Env = function(name, envir) {
        obj <- get(name, envir = envir)
        sd <- obj$public_methods
        env <- eval(expr(env(!!!c(sd[names(sd) %nin% "clone"], obj$active, obj$private_fields, 
            obj$private_methods, obj$public_fields))))
    }
    toplevel = is.null(env)
    if (is.null(env)) {
        env = package_env(package)
    }
    fns <- ls(env, all.names = TRUE)
    sd <- expr_glue(sDevTools::obj_detect_name(`{fns}`, name = "{name}"))
    out = unlist(lapply(sd, eval, envir = env), recursive = F)
    fnames = names(out)
    table <- rbindlist(out)
    table[, `:=`(obj_name, fnames)]
    setcolorder(table, c("obj_name", "type"))
    r6Classes = getObjClasses(env = env, "R6ClassGenerator")
    outR6 = list()
    for (i in names(r6Classes)) {
        r6evn <- getR6Env(i, env)
        tmp = checkFunctionUsage(name, package = package, env = r6evn)
        tmp[, `:=`(obj_name, paste0(i, ":", obj_name))]
        outR6[[i]] <- tmp
    }
    if (nlen0(outR6)) {
        table <- rbindlist(list(table, rbindlist(outR6)))
    }
    if (toplevel) {
        print(summary(table))
        g_print("SYM_MATCHES:\n{paste0('-',table[symbol_match==T]$obj_name)%sep%'\n'}")
        g_print("STR_MATCHES:\n{paste0('-',table[string_match==T]$obj_name)%sep%'\n'}")
    }
    return(invisible(table[symbol_match | string_match]))
    # Returns: data.table(obj_name,type,symbol_match,string_match)
}
