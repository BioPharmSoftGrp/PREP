#################################################################################################### .
#   Program/Function Name:
#   Author: Author Name
#   Description: Function to build a package and copy to the local cran repo.
#   Change History:
#   Last Modified Date: 12/04/2020
#################################################################################################### .
#' @name BuildAndAddPkgToLocalCran
#' @title BuildAndAddPkgToLocalCran
#' @description { Description: Function to build a package and copy to the local cran repo. }
#' @export
BuildAndAddPkgToLocalCran <- function( lCranRepoDetails, strLocalCranName = "localCRAN" ) #, strPkgName = "")
{

    #lRepo         <- CreateLocalCranRepo( strDirectoryForRepo )
    strContribDir <- lCranRepoDetails$strContribDir
    strLocalCRAN  <- lCranRepoDetails$strLocalCRAN
    lBinPaths     <- lCranRepoDetails$lBinPaths

    # In your R package that you want to add to this repo you need to add the following line to the package Description file
    # Repository: strLocalCranName

    # Update Description File - Add the repo line to the description file if the file is present and it does not have it ####

    strDescriptionFile <- file.path( "DESCRIPTION" )
    bFileExists <- file.exists( strDescriptionFile )
    if( bFileExists )
    {
        # First check to see if it lists a repo so we don't re add it
        strInput  <- readLines( strDescriptionFile )
        bContains <- any( grepl( "Repository", strInput, ignore.case = TRUE) )
        if( !bContains )
        {
            cat( paste( "Repository: ", strLocalCranName, sep = "" ), file= strDescriptionFile, append = TRUE, sep="\n")

        }

    }

    # Build the package and copy to the contributed directory in the new repo
    devtools::document(roclets = c('rd', 'collate', 'namespace', 'vignette'))

    strPkgTarZip <- devtools::build()
    strCopyTo    <- file.path( strContribDir, basename( strPkgTarZip) )

    if( file.exists( strCopyTo ) )
    {
        file.remove( strCopyTo )
    }
    file.copy( strPkgTarZip, strCopyTo )

    # Need to update the permissions
    strUpdatePermission <- paste0( "chmod 777 ", strCopyTo )
    system( strUpdatePermission )

    #Update the PACKAGES file in each subdirectory of the repo
    tools::write_PACKAGES( strContribDir, type = "source" )
    lapply( lBinPaths, function(path) {
        tools::write_PACKAGES(path)
    })


    bLinux <- TRUE
    if( bLinux )
        strNewRepo   <- paste("file://", normalizePath(strLocalCRAN, winslash = "/"), sep = "")
    else # Windows
        strNewRepo   <- paste("file:", normalizePath(strLocalCRAN, winslash = "/"), sep = "")

    return( list( strLocalCRAN = strLocalCRAN, strNewRepo = strNewRepo ) )
    #vOrigRepos <- UpdateRepoOption( strRepoName, strLocalCRAN)

    #return( list( vOrigRepos = vOrigRepos, strLocalCRAN = strLocalCRAN, strNewRepo = strNewRepo ) )

}
