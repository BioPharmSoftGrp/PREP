## Biopharm pAckage Shared Software - Project Creation
The purpose of this document is to outline the important aspects of the projects that were created.  

You will find a folder for the Shiny app using the BioPharmSoft template which links to a R package for computation and utilizes modules to avoid the entire application residing in the server.r or ui.r files.  This was done to help with testing and validation.  

Each project, Shiny app and computational package,  where created as subdirectories of this folder.  Each folder consists of an R Studio project file with the extension .Rproj.  For each project, please open these files. Within each project there is a Instructions.Rmd file to provide specific details about that project. 

Before the Shiny app will run you must first build the R package or remove the reference in the Shiny app in the Global.R file. 

Please refer to the [BioPharmSoft Style Guide](https://biopharmsoftgrp.github.io/BioPharmSoftRStyleGuide/) for development best practices.

You may find the following functions in the PREP package helpful.

# For the Shiny App
AddNewTabToApp( strTabName, vSubMenuItemNames ) - This function will add a new tab to the Shiny App. This function assumes that the working directory
is the main directory of the Shiny app created by this package.  This function creates a module file for the UI and the Server in the Modules directory
of the app, it alters the ShinyUI.R file to insert the calls to  modules so the tab is added to the UI. 

To add a logo image to the app you must place a file named log.png in the www directory of the Shiny app. 

# For the Calculation Package
AddFunctionToPkg( strFunctionName, strFunctionDescription = "", strPkgDir = "" ) - Add a new function named strFunctionName to a package.  This function creates a file names R/strFunctionName.R
and adds a test function in the file tests/testthat/test-strFunctionName.R to be used with the testthat package.
