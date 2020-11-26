## INSTALL: CTRL + SHIFT + B

###Dev Setup -----
library(sDevTools)
loadDependencies()
loadUtils()
#Check Usage -----
# test_package(sDevTools)
wn<-checkPackageUsage()
# testthat::test_package("sDevTools")
#Dismiss Usage Warnings -----
 #  suppressUsageWarnings(wn)
#Dev ----
 #new_dev_function()

#document ----


devDoc()

selectAll=function(file='dev/Dev.R'){
  navigateToFile(
    file = file,
    line = -1L,
    column = -1L,
    moveCursor = TRUE
  )
ranges<-document_range(document_position(1,1),document_position(Inf,Inf))
setSelectionRanges(ranges)
}
selectAll()
#test ----
## INSTALL: CTRL + SHIFT + B

# Refresh Dev =====
#refresh_dev()
navigateToFile(
  file = file,
  line = -1L,
  column = -1L,
  moveCursor = TRUE
)
ranges<-document_range(document_position(1,1),document_position(Inf,Inf))
setSelectionRanges(ranges)
