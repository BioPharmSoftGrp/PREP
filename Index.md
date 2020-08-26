

# Biopharm pAckage for Shared Software (BaSS) - Project Creation  <img src="logo.png" align="right" alt="" width="120" />
This project is package in R used to create a Shiny app with a default template and also creates a R package project that the Shiny app links to.

The default Shiny app has a common layout that utilizes modules rather than two long server.r and ui.r files.  This helps to create a common look and feel across apps as well as organize the apps such that they are more suitable for team development and testing. 

The BaSS project may be installed using the remotes package with the following command. 

 
```
remotes::install_github("BioPharmSoftGrp/BaSS")
```

# Utilizing Within R Studio
Likely the most convenient way to utilize this package is through R studio.  

Once the package has been installed, restart R Studio so that the BaSS project will be loaded.   

To create a new Project click on File->New Project and you should get the following:
![Create Project](CreateProject.png)

Click on New Directory so that the various project types will show. You should now see Project Type where the BaSS Project is listed.

![BassProjectStep1](BaSSProjectStep1.png)

Click on BaSS Project to move to the next step.

![BassProjectStep2](BaSSProjectStep2.png)
