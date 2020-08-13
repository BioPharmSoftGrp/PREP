#' @name  CreateBaSSApp
#' @title  CreateBaSSApp
#' @description {Create an application that consists of a Shiny app and a R library package complete with an example testthat unit test.   The Shiny app will reference
#' the R library so you should build the R library first before trying to run the Shiny app.  }
#' @param strProjectDirectory The directory where the project should be created.  If this parameter is left blank then the current working directory will be used.
#' @param strPojectName {The name of the project folder. If strProjectName  is blank or missing then a then the R package and R shiny app projects are created in the strProjectDirectory.
#' if strProjectName is provided and is not blank then a folder named  strProjectName is created in the strProjectDirectory directory.}
#' @param strCalculationLibraryName { The name of the R package that is created to contain the calculations for the application and is referenced in the Shiny app. A folder is created for the
#' library and the R Studio project file will be named, strCalculationLibraryName.Rproj}
#' @param strShinyAppName {The name of the R Shiny project.  The project file will  be called strShinyAppName.Rproj and will load the strCalculationLibraryName library as part of the Shiny
#' app.   }
#' @param strShinyAppDisplayName {The name of the applciation to be displayed on the UI that is created.}
#' @export
CreateBaSSApp <-  function( strProjectDirectory        = "",
                             strProjectName             = "MyNewProject",
                             strCalculationLibraryName  = "MyCalculationLibrary",
                             strShinyAppName            = "MyShinyApp",
                             strShinyAppDisplayName     = "My Shiny App",
                             strAuthors                 = "AUTHOR NAME",
                             bCreateWithExampleTabs     = TRUE,
                             bCreateShinyApp            = TRUE,
                             bCreateCalculationPackage  = TRUE,
                             bCreateShinyAppAsPackage   = TRUE )
{
    strRet <- ""
    if( !Provided( strProjectDirectory ) )
    {
        # Use the current working directory and create a folder named strProjectName
        strProjectDirectory  <- getwd()
    }
    bCreateProjectSubdirectory  <- Provided( strProjectName )
    strNewProjectDirectory      <- CreateProjectDirectory( strProjectDirectory, strProjectName, bCreateProjectSubdirectory )

    strTemplateDirectory        <- GetTemplateDirectory()
    strRet                      <- CopyFiles( strTemplateDirectory, strNewProjectDirectory, FALSE )

    if( bCreateCalculationPackage )
    {
        # Create the R package - Complete with testthat example
        strCalcPkgRet               <- CreateBaSSRPackage( strProjectDirectory      = strNewProjectDirectory,
                                                         strPackageName             = strCalculationLibraryName,
                                                         strAuthors                 = strAuthors)
    }

    if( bCreateShinyApp )
    {
        # Create the Shiny App - App will reference the R Package
        if( !bCreateShinyAppAsPackage )
        {
            strRShinyRet    <- CreateBaSSShinyApp( strProjectDirectory               = strNewProjectDirectory,
                                                           strShinyAppName           = strShinyAppName,
                                                           strShinyAppDisplayName    = strShinyAppDisplayName,
                                                           strCalculationLibraryName = strCalculationLibraryName,
                                                           strAuthors                = strAuthors,
                                                           bCreateProjectSubdirectory= TRUE,
                                                           bCreateWithExampleTabs    = bCreateWithExampleTabs)
        }
        else
        {
            strRShinyRet <- CreateBaSSShinyAppAsPkg( strProjectDirectory      = strNewProjectDirectory,
                                                    strShinyAppName           = strShinyAppName,
                                                    strShinyAppDisplayName    = strShinyAppDisplayName,
                                                    strCalculationLibraryName = strCalculationLibraryName,
                                                    strAuthors                = strAuthors,
                                                    bCreateProjectSubdirectory= TRUE,
                                                    bCreateWithExampleTabs    = bCreateWithExampleTabs )


        }

    }


    strAppInstructions <- "In the project dierectory, please view the ProjectInstructions.html or ProjectInstructions.Rmd "
    strRet <- paste( c("Creating BaSS App...",strRet,  "Begin by reading the ProjectInstructions.html (or ProjectInstructions.Rmd)",strCalcPkgRet, strRShinyRet), collapse = "\n")
    return( strRet )

}
