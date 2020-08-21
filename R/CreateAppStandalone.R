#' @name  CreateAppStandalone
#' @title  CreateAppStandalone
#' @description {Create an R Shiny app based on a template to help ease development.  The R Shiny App utilizes modeules which is very helpful for large scale applications.  }
#' @param strProjectDirectory The directory where the project should be created.  If this parameter is left blank then the current working directory will be used.
#' @param strShinyAppName {The name of the folder where the R Shiny app is created. If strShinyAppName  is blank or missing then the project is created in the strProjectDirectory.
#' If strPackageName is provided, is not blank and bCreateProjectSubdirectory == TRUE then a folder named  strShinyAppName is created in the strProjectDirectory directory.}
#' @param bCreateProjectSubdirectory {If bCreateProjectSubdirectory then then a subdirectory for the project is created in strProjectDirectory.  }
#' @param bCreateWithExampleTabs {By default, the R Shiny app will contain two example tabs (Simulation and Data analyusis), if bCreateWithExampleTabs = FALSE those tabs are removed.}
#' @param bAppInRFolder {Create }
#' @export

CreateAppStandalone <-
    function(strProjectDirectory,
             strShinyAppName,
             strShinyAppDisplayName,
             strCalculationLibraryName,
             strAuthors,
             bCreateProjectSubdirectory = TRUE,
             bCreateWithExampleTabs = TRUE)
    {
        #TODO: Validate input
        if (!Provided(strShinyAppDisplayName))
            strShinyAppDisplayName <- strShinyAppName
        if (!Provided(strCalculationLibraryName))
        {
            strCalculationLibraryName <- ""
            #TODO WOuld be much better to delete the line that references the calculation package if it does not need one.
        }
        # Set the template directory to copy from
        strProjectDirectory     <-
            gsub("\\\\", "/", strProjectDirectory)
        strTemplateDirectory    <- GetTemplateDirectory()

        if (bCreateWithExampleTabs)
            strAppDirectory         <-
            paste(strTemplateDirectory, "/RShinyApp", sep = "")
        else
            strAppDirectory         <-
            paste(strTemplateDirectory, "/RShinyAppNoTabs", sep = "")


        # strDestDirectory        <- paste( strProjectDirectory, "/", strShinyAppName, sep="" )
        strDestDirectory         <-
            CreateProjectDirectory(strProjectDirectory,
                                   strShinyAppName,
                                   bCreateProjectSubdirectory)


        strRet                  <-
            CopyFiles(strAppDirectory, strDestDirectory)
        strShinyApp             <-
            UpdateShinyAppName(
                strProjectDirectory,
                strShinyAppName,
                strShinyAppDisplayName,
                strCalculationLibraryName
            )
        strUpdateAuthor <- UpdateAuthors(paste(strProjectDirectory, "/", strShinyAppName, sep =
                                                   ""),
                                         strAuthors)

        strRet <-
            paste(c(
                "Creating Shiny App...",
                strRet,
                strShinyApp,
                strUpdateAuthor
            ),
            collapse = "\n")
        return(strRet)
    }

UpdateShinyAppName <-
    function(strProjectDirectory,
             strShinyAppName,
             strShinyAppDisplayName,
             strCalculationLibraryName = NA)
    {
        # Step 1: Rename project file ####
        strPackageDir <-
            paste(strProjectDirectory, "/", strShinyAppName, sep = "")
        strRProjName  <-
            paste(strPackageDir, "/RShinyApp.Rproj", sep = "")
        if (file.exists(strRProjName))
        {
            strNewRProjName <-
                paste(strPackageDir, "/", strShinyAppName, ".Rproj", sep = "")

            file.rename(strRProjName, strNewRProjName)
            strRProjName  <- strNewRProjName
        }
        strRShinyInst <-
            paste(
                ".....Use R Studio to open the the ",
                strRProjName,
                "project file and begin by reading the Instructions.Rmd file."
            )

        # Step 2: Replace name in the ShinyUI.R file
        strDescriptionFile <-
            paste(strPackageDir, "/ShinyUI.R", sep = "")
        strFileLines       <- readLines(strDescriptionFile)
        #strFileLines       <- gsub( "_PROJECT_NAME_", strShinyAppDisplayName, strFileLines )
        strFileLines       <-
            whisker.render(
                strFileLines,
                list(
                    PROJECT_NAME = strShinyAppDisplayName,
                    AUTHOR_NAME = "{{AUTHOR_NAME}}",
                    ADD_NEW_TAB_SIDE_BAR = "{{ADD_NEW_TAB_SIDE_BAR}}",
                    ADD_NEW_TAB_UI_CALL = "{{ADD_NEW_TAB_UI_CALL}}"
                )
            )
        writeLines(strFileLines, con = strDescriptionFile)

        # Replace the R App name if one was provided, if not remove that line in the global.r file
        if (!is.na(strCalculationLibraryName))
        {
            strFileName        <- paste(strPackageDir, "/Global.R", sep = "")
            strFileLines       <- readLines(strFileName)
            strFileLines       <-
                whisker.render(
                    strFileLines,
                    list(
                        CALCULATION_PACKAGE_NAME = strCalculationLibraryName,
                        AUTHOR_NAME = "{{AUTHOR_NAME}}",
                        SOURCE_ADDITIONAL_TABS = "{{SOURCE_ADDITIONAL_TABS}}"
                    )
                )

            #strFileLines       <- gsub( "_CALCULATION_PACKAGE_NAME_", strCalculationLibraryName, strFileLines )
            writeLines(strFileLines, con = strFileName)

        }
        return(strRShinyInst)
    }
