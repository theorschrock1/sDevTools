#' Creates template for run_app.R
#'
#' @noRd
devRunApp=function(){
  c(
    rox_comments(
      "Run the Shiny Application

      @inheritParams shiny::shinyApp

      @export"
    ),
    expr_deparse_lines({
      run_app <- function(onStart = NULL,
                          options = list(),
                          enableBookmarking = NULL) {
        shinyApp(
          ui = app_ui,
          server = app_server,
          onStart = onStart,
          options = options,
          enableBookmarking = enableBookmarking
        )
      }
    })
  )
}
#' Creates template for app_ui.R
#'
#' @noRd
devAppUi=function(){
  c(
  rox_comments(
  "The application User-Interface

   @param request Internal parameter for `{shiny}`.
       DO NOT REMOVE.
   @noRd"),
 expr_deparse_lines({
  app_ui <-
    function(request) {
    bs_global_theme()
    tagList(
      # Leave this function for adding external resources
      bs_dependencies(theme = bs_global_get()),
      # add_external_resources(),
      fluidPage(
        titlePanel('Old Faithful Geyser Data'),
        sidebarLayout(

          sidebarPanel(
            sliderInput('bins',
                        'Number of bins:',
                        min = 1,
                        max = 50,
                        value = 30)
          ),
          mainPanel(
            plotOutput('distPlot')
          )
        )
      )

    )
  }
})
)

}
#' Creates template for app_server.R
#'
#' @noRd
devAppServer=function(){
 c(rox_comments(
  "The application server-side

   @param input,output,session Internal parameters for {shiny}.
       DO NOT REMOVE.
   @noRd"),
   expr_deparse_lines({
    app_server <- function(input, output, session) {
      # Your application server logic
      output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x,
             breaks = bins,
             col = 'darkgray',
             border = 'white')
      })
    }
  }))
}
#' Creates template for app_config.R
#'
#' @noRd
devAppConfig=function(package_name){
  doc_app_sys<-rox_comments(
  "Access files in the current app

   NOTE: If you manually change your package name in the DESCRIPTION,
   don't forget to change it here too, and in the config file.
   For a safer name change mechanism, use the function.

   @param ... character vectors, specifying subdirectory and file(s)
   within your package. The default, none, returns the root of the app.

   @noRd")
  app_sys <- expr_deparse_lines({
    app_sys <-
      function(...) {
        system.file(..., package = !!package_name)
      }
  })

  dep_doc<-
    rox_comments(
  "Load all CSS and JS files in the www directory.

   Only CSS and JS files should be save in this dir.

   @noRd")


  loadAppDependencies <-
    expr_deparse_lines({

      loadAppDependencies <- function() {
        htmltools::htmlDependency(
          name = !!package_name,
          version = packageVersion(!!package_name),
          src = "app/www",
          package = !!package_name,
          all_files = TRUE
        )
      }

    })

  c(doc_app_sys,app_sys,dep_doc,loadAppDependencies)
}
#' Creates template for app_ui_utils.R
#'
#' @noRd
devAppUiUtils=function(){
  doc_add_external_resources=
  rox_comments(
  "Add external Resources to the Application

   This function is internally used to add external
   resources inside the Shiny application.

   @noRd"
  )
  add_external_resource <-
    expr_deparse_lines({
      add_external_resources <-
        function() {
          add_resource_path('www', app_sys('app/www'))
        }
    })

  doc_add_resource_path<-
    rox_comments(
  "Add resource path

   @noRd")

  add_resource_path <-
    expr_deparse_lines({
      add_resource_path <-
        function (prefix, directoryPath, warn_empty = FALSE)
        {
          list_f <- length(list.files(path = directoryPath)) == 0
          if (list_f & warn_empty) {
            warning("No resources to add from resource path (directory empty).")
          }
          else {
            addResourcePath(prefix, directoryPath)
          }
        }
    })

  c(
    doc_add_external_resources,
    add_external_resources,
    doc_add_resource_path,
    add_resource_path
  )
}
#' Creates template for app_server_utils.R
#'
#' @noRd
devAppServerUtils=function(){
  c(rox_commens(
  "Shorthand for reactiveValues

  @inheritParams reactiveValues
  @inheritParams reactiveValuesToList

  @noRd"),
 exprs_deparse_lines({
  rv <- shiny::reactiveValues
  rvtl <- shiny::reactiveValuesToList
  }))
}
#' Creates 'inst/app/www' directories
#'
#' @noRd
createAppDir=function(){
  if(!dir.exists('inst'))
     dir.create('inst')
  if(!dir.exists('inst/app'))
    dir.create('inst/app')
  if(!dir.exists('inst/app/www'))
    dir.create('inst/app/www')
}

