

# Packages fRom tEmPlates (PREP) - Project Creation  <img src="logo.png" align="right" alt="" width="120" />
This project is package in R used to create a Shiny app with a default template and also creates a R package project that the Shiny app links to.

The default Shiny app has a common layout that utilizes modules rather than two long server.r and ui.r files.  This helps to create a common look and feel across apps as well as organize the apps such that they are more suitable for team development and testing. 

The PREP project may be installed using the remotes package with the following command. 

 
```
remotes::install_github("BioPharmSoftGrp/PREP")
```

# Utilizing Within R Studio
Likely the most convenient way to utilize this package is through R studio.  

Once the package has been installed, restart R Studio so that the PREP project will be loaded.   

To create a new Project click on File->New Project and you should get the following:
![Create Project](CreateProject.png)

Click on New Directory so that the various project types will show. You should now see Project Type where the three PREP Projects is listed.

![PREPProjectStep1](PREPProjectStep1.png)

For this point you can select to either setup {PREP} Package, {PREP} Shiny as a Package or {PREP} Shiny App.  

## {PREP} Shiny as a Package
This option creates a package for a shiny app where all modules are in the R directory and all usual package development approaches apply.   To start this type of project, just fill in the desired info. 
![PREP Shiny as a Package](PrepShinyAsPkg.png)

## {PREP} Package
This option creates a package with testing via {testthat} already setup.   The desired information is below:
![PREP Package](PrepPkg.png)

## {PREP} Shiny App
This option createsa Shiny app utilizing modules and a default theme.  This option is NOT a package so is more easier to understand if you have not developed packages. 

The required information is shown below.
![PREP Package](PrepShinyApp.png)




