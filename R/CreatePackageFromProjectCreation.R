#################################################################################################### .
#   Program/Function Name:
#   Author: Author Name
#   Description: Add Description
#   Change History:
#   Last Modified Date: 10/01/2020
#################################################################################################### .
#' @name CreatePackageFromProjectCreation
#' @title CreatePackageFromProjectCreation
#' @description { Description: Add Description }
#' @export
CreatePackageFromProjectCreation <- function( path, ... )
{

    lInfo              <- GetDirectoryAndName( path )
    lArgs              <- list( ... )
    lArgs$strDirectory <- lInfo$strPath
    lArgs$strName      <- lInfo$strName

    do.call( CreatePackage, lArgs )
}
