#################################################################################################### .
# Add Description  ####
#################################################################################################### .
#' @name CreateBaSSShinyAppAsPkg
#' @title CreateBaSSShinyAppAsPkg
#' @description { This function creates a Shiny app as an R Package.  }
#' @export
CreateBaSSShinyAppAsPkg <- function( strProjectDirectory, strShinyAppName, strShinyAppDisplayName,  strCalculationLibraryName, strAuthors,
                                     bCreateProjectSubdirectory = TRUE, bCreateWithExampleTabs = TRUE  )
{

    #TODO: Validate input
    if( !Provided( strShinyAppDisplayName ) )
        strShinyAppDisplayName <- strShinyAppName
    if( !Provided( strCalculationLibraryName ) )
    {
        strCalculationLibraryName <- ""
        #TODO WOuld be much better to delete the line that references the calculation package if it does not need one.
    }

    strProjectDirectory         <- gsub( "\\\\", "/", strProjectDirectory )
    strTemplateDirectory        <- GetTemplateDirectory()
    strTemplateDirectory        <- paste( strTemplateDirectory, "/RShinyAppAsPkg", sep="" )

    strDestDirectory <- CreateProjectDirectory( strProjectDirectory, strShinyAppName, bCreateProjectSubdirectory )

    # Step 1 - Create the Shiny App Package project - This will not have the shiny app yet
    strRet            <- CopyFiles( strTemplateDirectory, strDestDirectory )
    strPackageUpdates <- UpdateCalculationPackageName(strProjectDirectory, strShinyAppName )
    strUpdateAuthor1 <- UpdateAuthors(
        paste( strProjectDirectory, "/", strShinyAppName, sep="" ),
        strAuthors
    )



    # Step 2 - Create the Shiny app in the inst directory of the package created in the previous step.  By creating it in the inst folder
    #          the shiny app is deployed when the package is installed and can be executed with the RunApp function in the package created in the previous step
    strProjectInstDir <- paste( strDestDirectory , "/inst", sep = ""  )
    strShinyApp       <- CreateBaSSShinyApp ( strProjectInstDir, strShinyAppName, strShinyAppDisplayName, strCalculationLibraryName, strAuthors,
                                              bCreateProjectSubdirectory = bCreateProjectSubdirectory, bCreateWithExampleTabs = bCreateWithExampleTabs )


    # Step 3: Replace name in the ShinyUI.R file
    # At this point the R package for the Shiny app was created, the Shiny app was setup in the strShinyAppName/inst/strShinyAppName
    # so now we need to update the RunApp.R file accordingly
    strRunAppFile <- paste( strDestDirectory, "/R/RunApp.R",  sep = "" )
    strFileLines  <- readLines( strRunAppFile )
    #strFileLines  <- gsub( "_SHINY_PROJECT_NAME_", strShinyAppName, strFileLines )
    strFileLines  <- WhiskerKeepUnrender(strFileLines, list( SHINY_PROJECT_NAME = strShinyAppName,
                                                        AUTHOR_NAME = strAuthors ) )
    writeLines( strFileLines, con = strRunAppFile )

    strRet <- paste( c("Creating Shiny App as a package...", strPackageUpdates, strUpdateAuthor1, strShinyApp,
                       paste( "The Shiny app  in ", strDestDirectory, "/inst directory was renamed to ", strShinyApp, sep = ""  )), collapse="\n" )
    return( strRet )

}


UpdateShinyAppAsAPackageInfo <- function(  strProjectDirectory, strShinyAppName, strShinyAppDisplayName, strCalculationLibraryName = NA )
{

    # Step 1: Rename project file ####
    strPackageDir <- paste( strProjectDirectory, "/", strShinyAppName, sep = "" )
    strRProjName  <- paste( strPackageDir, "/RShinyApp.Rproj", sep="" )
    if( file.exists( strRProjName ) )
    {
        strNewRProjName <- paste(strPackageDir, "/", strShinyAppName,".Rproj", sep = "" )

        file.rename( strRProjName, strNewRProjName )
        strRProjName  <- strNewRProjName
    }
    strRShinyInst <- paste( ".....Use R Studio to open the the ", strRProjName, "project file and begin by reading the Instructions.Rmd file.")

    # Step 2: Replace name in the ShinyUI.R file
    strDescriptionFile <- paste( strPackageDir, "/ShinyUI.R", sep = "" )
    strFileLines       <- readLines( strDescriptionFile )
    #strFileLines       <- gsub( "_PROJECT_NAME_", strShinyAppDisplayName, strFileLines )
    strFileLines       <- WhiskerKeepUnrender (strFileLines, list( PROJECT_NAME = strShinyAppDisplayName,
                                                             AUTHOR_NAME = "{{AUTHOR_NAME}}" ) )
    writeLines( strFileLines, con = strDescriptionFile )

    # Replace the R App name if one was provided, if not remove that line in the global.r file
    if( !is.na( strCalculationLibraryName ) )
    {
        strFileName        <- paste( strPackageDir, "/Global.R", sep = "" )
        strFileLines       <- readLines( strFileName )
        # strFileLines       <- gsub( "_CALCULATION_PACKAGE_NAME_", strCalculationLibraryName, strFileLines )

        strFileLines       <- WhiskerKeepUnrender(strFileLines, list( CALCULATION_PACKAGE_NAME = strCalculationLibraryName,
                                                                 AUTHOR_NAME = "{{AUTHOR_NAME}}" ) )

        writeLines( strFileLines, con = strFileName )

    }
    return( strRShinyInst  )
}
