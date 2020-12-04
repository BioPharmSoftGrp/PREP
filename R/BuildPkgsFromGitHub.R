#################################################################################################### .
#   Program/Function Name: BuildPkgsFromGitHub
#   Author: J. Kyle Wathen
#   Description: This function pulls GitHub repositories, builds the packages, installs them
#' and copies it to a local cran like repository.
#   Change History:
#   Last Modified Date: 12/04/2020
#################################################################################################### .
#' @name BuildPkgsFromGitHub
#' @title BuildPkgsFromGitHub
#' @description { Description: This function pulls GitHub repositories, builds the packages, installs them
#' and copies it to a local cran like repository. }
#' @export
BuildPkgsFromGitHub <- function( vGitHubRepos, vPkgNames, vRefs,  vAuthTokens, strCloneDir = NULL, strLocalCranName = "", strDirectoryForLocalCran = "" )
{

    #TODO: for now the vGitHubRepos should include the token needed figure out a better way to do this
    #TODO: The vPkgNames should be read from the packages that are pulled from GitHub rather than sent
    #       in by the nuser.
    #TODO: Currently the vGitHubRepos needs to have the token in the address for private repos and
    #       vAuthTokes are ignored.

    # Clone the desired repos ####

    if( is.null( strCloneDir ) )
    {
        #if it was not supplied then create a directory in the the current wd called GitClone-Date
        #TODO: What should we do if the current directory with GitClone-Date is arealdy existing?
        strCloneDir <- path.expand(getwd())
        strCloneDir <- paste0( strCloneDir, "/GitClone-", Sys.Date() )

    }

    if( !dir.exists( strCloneDir) )   # If the directory does not exist, then create it
    {
        dir.create( strCloneDir )
    }

    nQtyReposToClone <- length( vGitHubRepos )
    vCloneDirs       <- paste0( strCloneDir, "/PkgRepo", 1:nQtyReposToClone)

    vGitCloneCmds <- paste0( "git clone ", vGitHubRepos,   " ", vCloneDirs  )
    lapply(vGitCloneCmds, system )
    print( "Cloning complete... Staring build...")

    #################################################################################################### .
    # Create local cran repo  ####
    #################################################################################################### .

    lCranRepoDetails <- CreateLocalCranRepo( strDirectoryForLocalCran )

    #################################################################################################### .
    # Build the packages and copy to local cran ####
    #################################################################################################### .

    strCurentWrkDir <- getwd()  # To build the packages we will update the working dir and will need to return to where we started

    for( iPkg in 1:nQtyReposToClone )
    {
        setwd( vCloneDirs[ iPkg ] )
        lRet <- BuildAndAddPkgToLocalCran( lCranRepoDetails, strLocalCranName, strDirectoryForLocalCran, strPkgName = vPkgNames[ iPkg ])

    }

    # Return to the original working directory
    setwd( strCurentWrkDir )

    print( "Build complete... Starting detach...")

    #################################################################################################### .
    # Install the packages ####
    #################################################################################################### .

    for( iPkg in 1:nQtyReposToClone )
    {
        strDetachPkg <- paste0( "package:", vPkgNames[ iPkg ])
        if( vPkgNames[ iPkg ] %in% search() ||  vPkgNames[ iPkg ] %in% (.packages()) ) # Need to remove
        {
            print( paste0( "Detaching ", strDetachPkg ))

            detach( strDetachPkg, unload = TRUE,character.only = TRUE )

        }
        else
            print( paste0( "Package ", vPkgNames[ iPkg ], " is not installed, no need to unload" ) )
    }

    print( "Detach complete... Starting install...")
    print( paste0( "Installing packages, using repo: ", lRet$strNewRepo ) )
    localRepo <- lRet$strNewRepo
    install.packages( vPkgNames, quiet = TRUE, repos = localRepo )

    return( NULL )
}
