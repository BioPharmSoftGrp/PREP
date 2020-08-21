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


AddUnrenderToList <- function(sTemplate, lList)
{
    lRes     <- stringr::str_extract_all(sTemplate, "\\{\\{[^{}]*\\}\\}")
    vTags    <- lRes[[1]]
    lRetList <- lList

    if (length(vTags) > 0)
    {
        for( iTag in 1:length(vTags))
        {
            vNames <- names(lRetList)
            strFullTag <- vTags[iTag]
            if (nchar(strFullTag) <= 4)
            {
                next
            }
            sTag   <- substring( strFullTag, 3, nchar(vTags[iTag]) - 2)
            if (length(vNames) == 0)
            {
                lRetList[[sTag]] <- vTags[iTag]
            } else if (!sTag %in% vNames)
            {
                lRetList[[sTag]] <- vTags[iTag]
            }
        }

    }

    return(lRetList)

}

WhiskerKeepUnrender <- function(sTemplate, lList)
{
    lExList  <- AddUnrenderToList(sTemplate, lList)
    sRes     <- whisker.render(sTemplate, lExList)
    return (sRes)
}

WhiskerReplace <- function(strTag, strReplace, strTemplate)
{
    lData           <- list()
    lData[[strTag]] <- strReplace

    strRet  <- WhiskerKeepUnrender(strTemplate, lData)
    return(strRet)
}


ReplaceTagsInFileGSub <- function( strFileName, vTags, vReplace )
{
    bFileExists <- file.exists( strFileName )
    nQtyTags    <- length( vTags )
    if (nQtyTags > 0)
    {
        if( bFileExists )
        {
            strInput <- readLines( strFileName )

            for( iTag in 1:nQtyTags )
            {
                strInput <- gsub( vTags[ iTag ], vReplace[ iTag ], strInput, fixed=TRUE )

            }
            writeLines( strInput, con = strFileName )
        }
    }

    return( bFileExists )

}

ReplaceTagsInFile <- function( strFileName, vTags, vReplace )
{
    bFileExists     <- file.exists( strFileName )
    if( bFileExists )
    {
        strInput <- readLines( strFileName )
        lData    <- list()
        nQtyTags <- length(vTags)
        for( iTag in 1:nQtyTags )
        {
            lData[[vTags[ iTag ]]] <- vReplace[ iTag ]
        }

        strRet  <- WiskerKeepUnrender(strInput, lData)
        writeLines( strRet, con = strFileName )

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


#################################################################################################### .
#  Help function to replace tags in multiple files with the new Whisker format ####
#################################################################################################### .

ReplaceTags <- function()
{
    stop("stop here")

    vFileType <- c("\\.Rmd$", "\\DESCRIPTION$", "\\.html$")
    vFileType <- c("\\.html$")
    vFileType <- c("\\.R$")

    strPath   <- "../inst"

    vReplace  <- c( "## {{ADD_NEW_TAB_SIDE_BAR}} ", "## {{ADD_NEW_TAB_UI_CALL}}  " , "# {{ADD_NEW_TAB_SERVER}} ",
                    "# {{SOURCE_ADDITIONAL_TABS}} ")
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



