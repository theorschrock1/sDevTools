#INSTALL shrtcts
if(!package_exists("shrtcts")){
  remotes::install_github("gadenbuie/shrtcts")
}
#Add short cut to the YAML File
if(!file.exists("~/.config/.shrtcts.yaml")){
  write('- Name: Say something nice
  Description: Says something nices
  Binding:praise::praise
  Interactive: true',"~/.config/.shrtcts.yaml")

}else{
  file.edit("~/.config/.shrtcts.yaml")
}

#Add short cut and restart
shrtcts::add_rstudio_shortcuts()
rstudioapi::restartSession()


#Once you’ve installed your shortcut addins, you can then assign a keyboard shortcut to run your addin. Select Modify Keyboard Shortcuts… from the Tools menu
