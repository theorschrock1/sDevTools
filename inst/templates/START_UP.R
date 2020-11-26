
##Go to Build Tab --->
##Click 'More'->
  #Configure Build Tools...
    #Check the box 'Generate documentation with Roxygen':
      # Configure:
      # Select options:
        #- RD Files
        #- Collate Fields
        #- NAMESPACE
        #
        #- Install and Restart


##Package Start up
use_this::use_description(
  fields = list(
    Package = '{pkg_name}',
    Title = "PKG_TITLE",
    Version = '0.1.0',
    Author = 'Theo Schrock',
    Maintainer = 'theorschrock@gmail.com',
    Description = "PKG_DESC."
  )
)

## IMPORTS
imports <-
  c('SUlits',
    "glue",
    'stringr',
     'checkmate')

sDevTools::generate_utils_file(imports)

## Go To Dev
sDevTools::go_to_dev()


