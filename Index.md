

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

Click on New Directory so that the various project types will show. You should now see Project Type where the PREP Project is listed.

![PREPProjectStep1](PREPProjectStep1.png)

Click on PREP Project to move to the next step.

![PREPProjectStep2](PREPProjectStep2.png)
