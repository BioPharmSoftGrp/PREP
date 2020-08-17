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


WhiskerReplace <- function(strTag, strReplace, strTemplate)
{
    lData           <- list()
    lData[[strTag]] <- strReplace

    strRet  <- whisker.render(strTemplate, lData)
    return(strRet)

    # Handle a text with multiple lines
    # strRet <- strTemplate
    # if ( length(strTemplate) > 0 )
    # {
    #     lData           <- list()
    #     lData[[strTag]] <- strReplace
    #     for ( i in 1:length(strTemplate))
    #     {
    #         strRet[i]  <- whisker.render(strTemplate[i], lData)
    #     }
    # }
    # return( strRet )
}

ReplaceTagsInFile <- function( strFileName, vTags, vReplace )
{
    bFileExists     <- file.exists( strFileName )
    if( bFileExists )
    {
        strInput    <- readLines( strFileName )
        lData <- list()
        nQtyTags <- length(vTags)
        for( iTag in 1:nQtyTags )
        {
            lData[[vTags[ iTag ]]] <- vReplace[ iTag ]
        }

        strRet  <- whisker.render(strInput, lData)
        writeLines( strRet, con = strFileName )

        # #browser()
        # strInput    <- readLines( strFileName )
        # nQtyTags    <- length( vTags )
        # for( iTag in 1:nQtyTags )
        # {
        #     #strInput <- gsub( vTags[ iTag ], vReplace[ iTag ], strInput, fixed=TRUE )
        #     strInput <- WhiskerReplace( vTags[ iTag ], vReplace[ iTag ], strInput )
        #
        # }
    }

    return( bFileExists )

}

ReplaceTagsMultipleFiles <- function( vFileNames, vTags, vReplace )
{
    nNumFiles <- length( vFileNames )
    if (nNumFiles > 0)
    {
        for(i in 1:nNumFiles)
        {
            ReplaceTagsInFile( vFileNames[i], vTags, vReplace )
        }
    }
}

# Help function to replace tags in multiple files with the new Whisker format
ReplaceTags <- function()
{
    stop("stop here")

    vFileType <- c("\\.Rmd$", "\\DESCRIPTION$", "\\.html$")
    vFileType <- c("\\.html$")
    vFileType <- c("\\.R$")
    strPath   <- "../inst"
    vTags     <- c("_FILE_NAME_")
    vReplace  <- c("{{FILE_NAME}}")


    vFileNames <- list.files( strPath, pattern = vFileType[1], recursive = TRUE )
    print(vFileNames)


    if (length(vFileNames) > 0)
    {
        vFilePaths <- paste0(strPath, "/", vFileNames)

        nNumFiles <- length( vFilePaths)
        if (nNumFiles > 0)
        {
            for(i in 1:nNumFiles)
            {
                #ReplaceTagsInFile( vFilePaths[i], vTags, vReplace )
                nQtyTags <- length(vTags)
                for( iTag in 1:nQtyTags )
                {
                    #strInput <- gsub( vTags[ iTag ], vReplace[ iTag ], strInput, fixed=TRUE )
                    strInput    <- readLines( vFilePaths[i] )
                    strRet <- gsub( vTags[ iTag ], vReplace[ iTag ], strInput, fixed=TRUE )
                    writeLines( strRet, con = vFilePaths[i])
                }
            }
        }

        #ReplaceTagsMultipleFiles (vFilePaths, "_AUTHOR_NAME_", strAuthor)
        #ReplaceTagsMultipleFiles (vFilePaths, "_AUTHOR_NAME_", "{{AUTHOR_NAME}}")
        #ReplaceTagsMultipleFiles (vFilePaths, "_CALCULATION_PACKAGE_NAME_", "{{CALCULATION_PACKAGE_NAME}}")

        #ReplaceTagsMultipleFiles (vFilePaths, "_FUNCTION_NAME_", "{{FUNCTION_NAME}}")
        #ReplaceTagsMultipleFiles (vFilePaths, "_FILE_NAME_", "{{FILE_NAME}}")
        #ReplaceTagsMultipleFiles (vFilePaths, "_CREATION_DATE_", "{{CREATION_DATE}}")
        #ReplaceTagsMultipleFiles (vFilePaths, "_FILE_DESCRIPTION_", "{{FILE_DESCRIPTION}}")

    }


}

UpdateAuthors <- function(strPath, strAuthor)
{

    strRet <- ""
    if ( !is.null(strAuthor) )
    {
        vFileType <- c("\\.Rmd$", "\\DESCRIPTION$", "\\.html$")
        for (i in 1:length( vFileType ))
        {
            vFileNames <- list.files( strPath, pattern = vFileType[i], recursive = TRUE )
            if (length(vFileNames) > 0)
            {
                vFilePaths <- paste0( strPath, "/", vFileNames )
                ReplaceTagsMultipleFiles ( vFilePaths, "AUTHOR_NAME", strAuthor )
            }
        }
        strRet <- paste0("Update the author names to: ", strAuthor)
    }
    return(strRet)

}



