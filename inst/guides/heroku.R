#make sure to have git / git hub installed see:
open_guide('git github.R')
#install heroku cli https://devcenter.heroku.com/articles/heroku-cli

##1) Build an app as an r package, push to git hub

##2) Create a shell project call deploy_[AppName] with a Run.R file
 #2.1)
   # port <- Sys.getenv('PORT')
   # options('shiny.port'=as.numeric(port),shiny.host='0.0.0.0')
   #
   # [package_name]::run_app()
 #2.2)
   #create an .Renviron file by running
   sDevTools::use_gitpat_renviron()
   #this creates .Renviron file  wd with the following
   #GIT_PAT:3a8b747cddfdffaa7312f3b2faad42dd3bec17a4


   #2.3)
      # from R, run:
      renv::init()

   #2.4)
      #install remotes package
      install.packages('remotes')
      #remote install app package and local dependencies using:
      remotes::install_github("theorschrock1/[PKGNAME]", auth_token = "3a8b747cddfdffaa7312f3b2faad42dd3bec17a4")
      #to update to packages source in renv, run:
      renv::snapshot()
   #2.5)
      #add any axillary folders or files the app will access locally
   #2.6) Go to the GIT tab in Rstudio, click cog -> SHELL...
      #run the following commands:
      git init
      git add --all
      git commit -m "initial"
      heroku create --buildpack https://github.com/virtualstaticvoid/heroku-buildpack-r.git
      git push heroku master
      heroku open

      #The app should open and be working


 #to update the app:

 # 1) make changes to the package app file and push to git hub.
 # 2) from deploy_[AppName], reinstall the package
 # 3) GIT tab in Rstudio, click cog -> SHELL...
       # run:
       #   git push heroku master
       #   heroku open




