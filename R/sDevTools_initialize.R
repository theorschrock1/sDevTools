#' Generate a sDevTools start up R script.

#' @name sDevTools_initialize
#' @param package_name  \code{[string]}
#' @return \code{sDevTools_initialize}: [Character]
#' @export
sDevTools_initialize <- function(package_name) {
    # Generate a sDevTools start up R script
    assert_string(package_name)
    if (file.exists(".sDevToolsProj"))
        g_stop("Start up file has already been generated")
    file.remove("NAMESPACE")
    file.remove("R/hello.R")
    build_dirs_for_sdev()
    out = c(devCheck(package_name), devSetup(package_name), devDev(fn_name = NULL,
        type = "standard", package_name)) %sep% "\n"
    write(out, "dev/DEV.R")
    description <- expr_deparse(expr(use_this::use_description(fields = list(Package = !!package_name,
        Title = "PKG_TITLE", Version = "0.1.0", Author = "Theo Schrock", Maintainer = "theorschrock@gmail.com",
        Description = "PKG_DESC."))))
    imports <- exprs_deparse(call_args(expr({
        imports <- c("sUtils", "glue", "stringr", "checkmate", "rlang")
        imports_pkg(imports)
    })))
    out = c("###Welcome to sDevTools package start up!", "", "#NOTE:The following code is intented to only be run once",
        "", "#Package metadata", "", description, "", "# Package dependencies (IMPORTS)",
        "", imports, "", "#Use Git and create a Github repo", "", "create_github_repo()",
        "", "#Start developement", "", "go_to_dev()")
    write(out %sep% "\n", "START_UP.R")
    write("TRUE", ".sDevToolsProj")
    file.edit("START_UP.R")
    # Returns: [Character]
}
