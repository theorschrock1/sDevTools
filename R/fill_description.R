#' Create a description file for an R package.

#' @name fill_description
#' @param pkg_name  \code{[string]}  Defaults to \code{'PKG_NAME'}
#' @param pkg_title  \code{[string]}  Defaults to \code{'PKG_TITLE'}
#' @param pkg_description  \code{[string]}  Defaults to \code{'Package Description.'}
#' @param author_first_name  \code{[string]}  Defaults to \code{'Theo'}
#' @param author_last_name  \code{[string]}  Defaults to \code{'Schrock'}
#' @param author_email  \code{[string]}  Defaults to \code{'<theorschrock@gmail.com>'}
#' @param path  \code{[file]}  Defaults to \code{getwd()}
#' @return \code{fill_description}: [NULL]
#' @export
fill_description <- function(pkg_name = "PKG_NAME", pkg_title = "PKG_TITLE", pkg_description = "Package Description.",
    author_first_name = "Theo", author_last_name = "Schrock", author_email = "theorschrock@gmail.com",
    path = getwd()) {
    # Create a description file for an R package
    assert_string(pkg_name)
    assert_string(pkg_title)
    assert_string(pkg_description)
    assert_string(author_first_name)
    assert_string(author_last_name)
    assert_string(author_email)
    assert_directory(path)
    desc <- desc::description$new(file = paste0(path, "/DESCRIPTION"))
    if(!grepl(start_with("<"),author_email)&!grepl(ends_with(">"),author_email))
        author_email<-paste0('<',author_email,">")
    author<-paste(author_first_name,author_last_name)
    desc$set(Maintainer= author_email)
    desc$set(Author = author)
    desc$set_version(version = "0.0.0.9000")
    desc$set(Title =pkg_title)
    desc$set(Package = pkg_name)
    desc$set(Description = pkg_description)
    desc$write(file = "DESCRIPTION")
    cli::cat_bullet("DESCRIPTION file modified", bullet = "tick", bullet_col = "green")
    # Returns: [NULL]
}
