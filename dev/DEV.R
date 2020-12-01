#Check Usage -----
checks=checkPackageUsage()
runTests(package="sDevTools")
#Dismiss Usage Warnings -----
#  suppressUsageWarnings(checks)
###Dev Setup -----
## INSTALL: CTRL + SHIFT + B
sDevTools::clearEnv() ## CTRL + SHIFT + R
library(sDevTools)
loadUtils()
#Dev -----
assert_reactive<-
 function(id,x,type=NULL,...){
   v_collect()
   #Documentation
   fdoc("check if an object is a reactive expression","TRUE if valid, message if invalid")
   #Assertions
   assert_string(id)
   assert_string(type, null.ok = TRUE)
   #TO DO
   res<-is(x,'reactiveExpr')
   dots=list(...)
   if(!isTRUE(res)){
     g_stop("{.x} must be a reactive expression")
   }

   if(nnull(type)){
     assert<-eval(expr_glue('expr(check_{type}(x(),!!!dots))')[[1]])

     return(reactive({

       message<-eval(assert)
       if(!isTRUE(message))
         g_stop("invalid input in module with id='{id}':{.x} {message} ")
       x
       }))
   }
   return(invisible(NULL))
 }
#document------
 fn_document(assert_reactive,{
   if(interactive()){
     mod_ui <- function(id){
       ns <- NS(id)
       tagList(

       )
     }
     mod_server <- function(id,x){
       moduleServer(id, function(input, output, session){
         ns <- session$ns

         x<-assert_reactive(id,x,type='character')
         observe({
           print(x())
         })
       })
     }
     library(shiny)

     ui <- fluidPage(
       tags$h1("mod"),
     )
     server <- function(input, output, session) {

       t<-reactive({1})
       mod_server('test',x=t)
     }
     shinyApp(ui, server)
   }

 })

