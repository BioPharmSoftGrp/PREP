#################################################################################################### .
#   Program/Function Name:
#   Author: Author Name
#   Description: Add Description
#   Change History:
#   Last Modified Date: 10/01/2020
#################################################################################################### .
#' @name CreateAppStandaloneFromProjectCreation
#' @title CreateAppStandaloneFromProjectCreation
#' @description { Description: Add Description }
#' @export
CreateAppStandaloneFromProjectCreation <- function( path, ... )
{

    # From the R Studio widget the path will have the last folder as the project name that we want to use so need to pull it off and make the
    # last folder the project name.
    lInfo              <- GetDirectoryAndName( path )
    lArgs              <- list( ... )
    lArgs$strDirectory <- lInfo$strPath
    lArgs$strName      <- lInfo$strName
    #lArgs$bPackage     <- FALSE


    if( lArgs$bSimulationMod )
    {
        lArgs$vModuleIDs <- c( "Home", "Simulation", "Feedback", "Options" )

    }
    else
    {
        lArgs$vModuleIDs <- c( "Home", "Feedback", "Options" )
    }
    lArgs$bSimulationMod <- NULL
    do.call( CreateAppStandalone, lArgs )
}
