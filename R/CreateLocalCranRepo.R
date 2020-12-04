#################################################################################################### .
#   Program/Function Name:
#   Author: Author Name
#   Description: Function to create local cran repo.
#   Change History:
#   Last Modified Date: 12/04/2020
#################################################################################################### .
#' @name CreateLocalCranRepo
#' @title CreateLocalCranRepo
#' @description { Description: Function to create local cran repo. }
#' @export
CreateLocalCranRepo <- function(strDirectoryForRepo = "")
{

    #################################################################################################### .
    # Create a local-cran ####
    #################################################################################################### .
    if( strDirectoryForRepo == "")
    {
        strDirectoryForRepo <- path.expand("~/local-cran")

    }

    if( !dir.exists( strDirectoryForRepo) )   # If the directory does not exist, then create it
    {
        dir.create( strDirectoryForRepo )
    }

    strLocalCRAN <- strDirectoryForRepo

    vstrFiles   <- dir( strLocalCRAN )

    bDirectoryEmpty <- (length( vstrFiles ) == 0)


    strContribDir <- file.path(strLocalCRAN, "src", "contrib")
    bContrDirExist <- dir.exists( strContribDir )

    if( !bDirectoryEmpty & !bContrDirExist )
    {
        # The contributed directory  does not exist and the repo directory is not empty so add to the directory to create the repo
        strLocalCRAN <- file.path( strLocalCRAN, "local-cran")
        dir.create( strLocalCRAN )
        bDirectoryEmpty <- TRUE

    }

    # Now, we’ll create the list ‘binary’ directories, where built binary versions of these packages (for the various architectures supported) live.
    # Note that these folders should exist, but it is not necessary to populate them. Binary packages are also keyed to certain R versions, of the
    # form <major>.<minor>. If you plan on distributing binary packages, be sure to create a sub-folder corresponding to each version of R you support!
    # Note: We only create the directories names for now but the directories are created if needed in the if()
    rVersion <- paste(unlist(getRversion())[1:2], collapse = ".")

    lBinPaths <- list(
        win.binary = file.path("bin/windows/contrib", rVersion),
        mac.binary = file.path("bin/macosx/contrib", rVersion),
        mac.binary.mavericks = file.path("bin/macosx/mavericks/contrib", rVersion),
        mac.binary.leopard = file.path("bin/macosx/leopard/contrib", rVersion)
    )

    lBinPaths <- lapply(lBinPaths, function(x) file.path(strLocalCRAN, x))

    if( bDirectoryEmpty )              # Need to create the repo
    {
        # Next, we create the src/contrib directory – this is where the source tarballs for uploaded packages will live.
        strContribDir <- file.path(strLocalCRAN, "src", "contrib")
        dir.create( strContribDir, recursive = TRUE )


        lapply(lBinPaths, function(path) {
            dir.create(path, recursive = TRUE)
        })

    }
    return( list( strLocalCRAN = strLocalCRAN, strContribDir = strContribDir, lBinPaths = lBinPaths ) )

}
