#################################################################################################### .
#   Program/Function Name: UpdateRepoOption
#   Author: J. Kyle Wathen
#   Description: This function modifies options( repos ) to include a new cran repo and is used for listing a local CRAN like repository if needed.
#   Change History:
#   Last Modified Date: 12/04/2020
#################################################################################################### .
#' @name UpdateRepoOption
#' @title UpdateRepoOption
#' @description { Description: This function modifies options( repos ) to include a new cran repo and is used for listing a local CRAN like repository if needed. }
#' @export
UpdateRepoOption <- function( strRepoName = "lcran", strLocalCRAN = "", strURL = "", bLinux = TRUE )
{
    vOrigRepos <- getOption( "repos" )
    if( strLocalCRAN != "" )
    {

        if( bLinux )
            strNewRepo   <- paste("file://", normalizePath(strLocalCRAN, winslash = "/"), sep = "")
        else # Windows
            strNewRepo   <- paste("file:", normalizePath(strLocalCRAN, winslash = "/"), sep = "")
        names( strNewRepo ) <- strRepoName

    }
    else if( strURL != "")
    {
        names( strURL ) <- strRepoName
        strNewRepo      <- strURL
    }
    if( !(strNewRepo %in% vOrigRepos) )
        options( repos = c( vOrigRepos, strNewRepo ))
    return( vOrigRepos )

}
