#Update Decription File

use_this::use_description(fields = list(Package = "test", Title = "PKG_TITLE",
  Version = "0.1.0", Author = "Theo Schrock", Maintainer = "theorschrock@gmail.com",
  Description = "PKG_DESC."))

# Package Dependencies (IMPORTS)

imports <- c("sUtils", "glue", "stringr", "checkmate", "rlang")
generate_utils_file(imports)

#Use Git and create a github repo

create_github_repo()

#Start Developement

go_to_dev()
