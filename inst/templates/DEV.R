## INSTALL: CTRL + SHIFT + B

###Dev Setup -----
library(sDevTools)
#library(&&package&&)
loadDependencies()
loadUtils()
#Check Usage -----
wn<-checkPackageUsage()
#testthat::test_package("&&package&&")
#Dismiss Usage Warnings -----
 #  suppressUsageWarnings(wn)
#Dev ----
  # new_dev_function()

hello<-function(){
  fdoc("Say Hello",'[character]')
  print("Hello")
  return('Hello')
}

#document ----

fn_document(hello,{
  hello()
})

#test ----
## INSTALL: CTRL + SHIFT + B
build_test('hello',
  init=NULL,
  test_code=!!hello_examples, #fn_document() assigns examples to the global env
)

# Refresh Dev =====
  #refresh_dev()

