#' @name  CreateBaSSRPackage
#' @title  CreateBaSSRPackage
#' @description {Create an R package complete with an example testthat unit test.   }
#' @param strProjectDirectory The directory where the project should be created.  If this parameter is left blank then the current working directory will be used.
#' @param strPackageName {The name of the package folder. If strPackageName  is blank or missing then the project is created in the strProjectDirectory.
#' if strPackageName is provided, is not blank and bCreateProjectSubdirectory == TRUE then a folder named  strPackageName is created in the strProjectDirectory directory.}
#' @param bCreateProjectSubdirectory {If bCreateProjectSubdirectory then then a subdirectory for the project is created in strProjectDirectory.  }
#' @export
CreateBaSSRPackage <- function( strProjectDirectory, strPackageName, strAuthors = NULL, bCreateProjectSubdirectory = TRUE )
{
    # Set the template directory to copy from
    strProjectDirectory         <- gsub( "\\\\", "/", strProjectDirectory )
    strTemplateDirectory        <- GetTemplateDirectory()
    strCalculationsDirectory    <- paste( strTemplateDirectory, "/CalculationPackage", sep="" )

    strDestDirectory <- CreateProjectDirectory( strProjectDirectory, strPackageName, bCreateProjectSubdirectory )


    #strDestDirectory            <- paste( strProjectDirectory, "/", strPackageName, sep="" )

    strRet        <- CopyFiles( strCalculationsDirectory, strDestDirectory )
    strCalcPkgRet <- UpdateCalculationPackageName( strProjectDirectory, strPackageName )
    strUpdateAuthor <- UpdateAuthors(
        paste( strProjectDirectory, "/", strShinyAppName, sep="" ),
        strAuthors
    )

    strRet <- paste( c("Creating Calculation Package...", strRet, strCalcPkgRet, strUpdateAuthor), collapse="\n" )
    return(strRet)
}


UpdateCalculationPackageName <- function(  strProjectDirectory, strPackageName )
{

    # Step 1: Rename project file ####
    strPackageDir <- paste( strProjectDirectory, "/", strPackageName, sep = "" )
    strRProjName  <- paste( strPackageDir, "/CalculationPackage.Rproj", sep="" )
    if( file.exists( strRProjName ) )
    {
        strNewRProjName <- paste(strPackageDir, "/", strPackageName,".Rproj", sep = "" )

        file.rename( strRProjName, strNewRProjName )
        strRProjName  <- strNewRProjName
    }
    strCalculationPkgInst <- paste( ".....Use R Studio to open the", strRProjName, "project file and begin by reading the Instructions.Rmd file.")

    # Step 2: Replace name in the description file
    strDescriptionFile <- paste( strPackageDir, "/DESCRIPTION", sep = "" )
    strFileLines       <- readLines( strDescriptionFile )
    #strFileLines       <- gsub( "_CALCULATION_PACKAGE_NAME_", strPackageName, strFileLines )
    strFileLines       <- whisker.render(strFileLines, list( CALCULATION_PACKAGE_NAME = strPackageName,
                                                             AUTHOR_NAME = "{{AUTHOR_NAME}}" ) )

    writeLines( strFileLines, con = strDescriptionFile )
    return( strCalculationPkgInst )

}
