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
    description <- expr_deparse(expr(fill_description(
        pkg_name = !!package_name,
        pkg_title = "PKG_TITLE",
        pkg_description = "The package description.",
        author_first_name = "Theo",
        author_last_name = 'Schrock',
        author_email = "<theorschrock@gmail.com>"
    )))
    imports <- exprs_deparse(call_args(expr({
        imports <- c("sUtils", "glue", "stringr", "checkmate", "rlang")
        sDevTools::import_pkg(imports)
    })))
    out = c(
        "###Welcome to sDevTools package start up!",
        "",
        "#NOTE:The following code is intented to only be run once",
        "library(sDevTools)",
        "",
        "#Package metadata",
        "",
        description,
        "",
        "# Package dependencies (IMPORTS)",
        "",
        imports,
        "",
        "#initialize testthat and build testing directories",
        "",
        'initializeTestthat(test_deps=c("checkmate","sDevTest"))',
        "",
        "#Use Git and create a Github repo",
        "",
        "sDevTools::create_github_repo()",
        "",
        "#Initialize a shiny package if this is a shiny app",
        "",
        "is_shiny_app=FALSE",
        "",
        glue("if(is_shiny_app)initializeShinyPackage('{package_name}')"),
        "",
        "#Start developement",
        "",
        "sDevTools::go_to_dev()"
    )
    write(out %sep% "\n", "START_UP.R")
   suppressMessages(tidy_file( "START_UP.R"))
    write("TRUE", ".sDevToolsProj")
    file.edit("START_UP.R")
    # Returns: [Character]
}
