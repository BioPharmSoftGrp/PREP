################################################################################ .
# Description: This funciton will get the directory where this package is  ####
#               installed.
################################################################################ .

# This function will look in the directory where the BaSS package is installed for the strTemplateFolder
GetTemplateDirectory <- function( strTemplateFolder = "ProjectTemplate")
{
    strPackageTemplateDirectory <- "BaSS"
    strTemplateDirectory        <- system.file( strTemplateFolder, package = strPackageTemplateDirectory)


    return( strTemplateDirectory )
}


CreateProjectDirectory <- function( strProjectDirectory, strProjectName, bCreateProjectSubdirectory )
{
    if( !Provided( strProjectDirectory ) )
    {
        # Use the current working directory and create a folder named strProjectName
        strProjectDirectory  <- getwd()
    }

    if( strProjectName == "" )
    {
        strProjectName <- "NewProject"
    }

    #strTemplateDirectory        <- GetTemplateDirectory()

    if( bCreateProjectSubdirectory )
    {
        strNewProjectDirectory <- paste( strProjectDirectory, "/", strProjectName, sep="" )
        #strTemplateDirectory   <- paste( strTemplateDirectory, "/", strProjectName, sep="")
    }
    else
        strNewProjectDirectory <- strProjectDirectory

    dir.create( strNewProjectDirectory, recursive = TRUE )


    #strCopy <- CopyFiles( strTemplateDirectory, strNewProjectDirectory, recursive = FALSE )

    return( strNewProjectDirectory )

}

Provided <- function( argument )
{
    bProvided <- TRUE
    if( missing( argument ) )
    {
        bProvided <- FALSE
    }
    else if( any( is.null( argument ) )    )
    {
        # Return false
        bProvided <- FALSE
    }
    else if( any( is.na( argument ) ) )
    {
        bProvided <- FALSE
    }
    else if( any( argument == '' ) )
    {
        bProvided <- FALSE
    }
    return( bProvided )
}

ReplaceTagsInFile <- function( strFileName, vTags, vReplace )
{
    bFileExists     <- file.exists( strFileName )
    if( bFileExists )
    {
        strInput    <- readLines( strFileName )
        nQtyTags    <- length( vTags )
        for( iTag in 1:nQtyTags )
        {
            strInput <- gsub( vTags[ iTag ], vReplace[ iTag ], strInput, fixed=TRUE )

        }
    }

    writeLines( strInput, con = strFileName )

    return( bFileExists )

}
