#' Create a new shiny input binding.

#' @name new_shiny_input_binding
#' @param name
#' @return \code{new_shiny_input_binding}: \code{[invisible(NULL)]}
#' @export
new_shiny_input_binding <- function(name) {
    # Create a new shiny input binding
    if (dir.exists(glue("assests/{name}"))) 
        g_stop("html dependency `{name}` exists")
    dir.create(glue("inst/assets/{name}"))
    tmp <- readLines(paste0(system.file(package = "ShinyReboot"), "/templates/shinyInputTemplate.js")) %sep% 
        "\n"
    write(glue(tmp, .open = "&&", .close = "&&"), glue("inst/assets/{name}/{name}Binding.js"))
    write("", glue("inst/assets/{name}/{name}.css"))
    fn <- new_function(args = NULL, body = expr({
        htmlDependency(name = !!name, version = packageVersion(!!current_pkg()), src = !!glue("assets/{name}"), 
            package = !!current_pkg(), stylesheet = !!glue("{name}.css"), script = !!glue("{name}Binding.js"), 
            all_files = FALSE)
    }))
    out = expr(!!sym(glue("html_dependency_{name}")) <- !!fn)
    if (file.exists("R/dependencies.r")) {
        depends <- readLines("R/dependencies.r")
        writeLines(c(depends, "\n", "#' @export", exprs_deparse(list(out))[[1]]), 
            "R/dependencies.r")
    }
    if (!file.exists("R/dependencies.r")) {
        writeLines(c("#' @export", exprs_deparse(list(out))[[1]]), "R/dependencies.r")
    }
    g_success("JS and css templates written to inst/assets/{name}/")
    g_success("Dependency written to R/dependencies.R")
    file.edit(glue("inst/assets/{name}/{name}Binding.js"))
    # Returns: \code{[invisible(NULL)]}
}
