
## Git / Git hub How to guide
browseURL('https://r-pkgs.org/git.html')

#Github
  #username:theorschrock@gmail.com
  #password:Bq5OK5oUdG3SCl6u1LPZkaIVb
  #token:3a8b747cddfdffaa7312f3b2faad42dd3bec17a4

#1)Create new repo on GIT

  #Get the url: something like
    'git remote add origin https://github.com/theorschrock1/{name).git'


#2)Click Git tab -> Option Wheel -> Shell...
   # Run the url
    'git remote add origin https://github.com/theorschrock1/sUtils.git'
  # run
    'git push -u origin master'

#3) Try to install
  # sDevTools::installPrivate("{package}")
    git_protocol()

# From the Beginning ----


    #1)Install Git:
      # Windows: https://git-scm.com/download/win.

    #2)From command terminal Run
      # git config --global user.name "YOUR FULL NAME"
      # git config --global user.email "YOUR EMAIL ADDRESS"

    #3)Create a github account 'https://github.com'

    #4)From R, you can check if you already have an SSH key-pair by running:
     #file.exists("~/.ssh/id_rsa.pub")

        #4.1) IF FALSE, Go to RStudio’s global options, choose the Git/SVN panel, and click “Create RSA key…”:

    #5) Give GitHub your SSH public key: https://github.com/settings/ssh. The easiest way to find the key is to click “View public key” in RStudio’s Git/SVN preferences pane.

    #6)Restart R(necessary). Restart your computer(recommended)

       #6.1) IF you see GIT tab in the project pane, skip 6.1.
        #If NOT, go to:
             # Tools->
             #   version control->
             #       project setup, ->
             #            Version control system:select [GIT] ...
    #7) Go to https://github.com/settings/tokens and generate a personal access token. Dont lose!  Store this in a safe place. use this 'AUTH_TOKEN' below.

    #8) From an R project, run:

        #8.1 usethis::use_git(message = "Initial commit")
        #8.2 usethis::use_github(private = TRUE,
                              # protocol = "https",
                              # auth_token = [AUTH_TOKEN])


    #9) To install your package from github, run:

     #devtools::install_github(glue("[USER_NAME]/[PACKAGE_NAME]"), auth_token = ['AUTH_TOKEN'])

    #If experiencing issues:
    #   browseURL('https://r-pkgs.org/git.html')
