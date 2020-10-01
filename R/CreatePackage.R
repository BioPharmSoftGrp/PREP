#' @name  CreatePackage
#' @title  CreatePackage
#' @description {Create an R package complete with an example testthat unit test.   }
#' @param strDirectory The directory where the project should be created.  If this parameter is left blank then the current working directory will be used.
#' @param strName {The folder where the app saved.}
#' @param strAuthors {Author Names. Blank by default}
#' 
#' @export

CreatePackage <- function( 
    strDirectory=getwd(), 
    strName="newPackage", 
    strAuthors=""
){
    # Set the template directory to copy from
    strDirectory <- gsub( "\\\\", "/", strDirectory )
    strTemplateDirectory <- paste0(GetTemplateDirectory(), "/Pkg")
    strDestDirectory <- CreateProjectDirectory( strDirectory, strName, TRUE )
    strRet <- CopyFiles( strTemplateDirectory, strDestDirectory )

    # Step 1: Rename project file
    strRProjName  <- paste( strDirectory, "/CalculationPackage.Rproj", sep="" )
    if( file.exists( strRProjName ) )
    {
        strNewRProjName <- paste(strDirectory, "/", strName,".Rproj", sep = "" )

        file.rename( strRProjName, strNewRProjName )
        strRProjName  <- strNewRProjName
    }
    strPkgRet <- paste( ".....Use R Studio to open the", strRProjName, "project file and begin by reading the Instructions.Rmd file.")

    # Step 2: Replace name in the description file
    strDescriptionFile <- paste( strDestDirectory, "/DESCRIPTION", sep = "" )
    strFileLines       <- readLines( strDescriptionFile )
    strFileLines       <- gsub( "_CALCULATION_PACKAGE_NAME_", strName, strFileLines )
    writeLines( strFileLines, con = strDescriptionFile )

    strUpdateAuthor <- UpdateAuthors(strDestDirectory, strAuthors)

    strRet <- paste( c("Creating Calculation Package...", strRet, strPkgRet, strUpdateAuthor), collapse="\n" )
    return(strRet)
}

