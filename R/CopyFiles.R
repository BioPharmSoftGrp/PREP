
CopyFiles <- function( strSourceDirectory, strDestinationDirectory, recursive = TRUE )
{
    #dir.create(  strDestinationDirectory )
    vFilesToCopy    <- list.files( strSourceDirectory )
    vResults        <- file.copy( file.path(strSourceDirectory, vFilesToCopy ), strDestinationDirectory, recursive = recursive ) #file.copy( file.path( strSourceDirectory, vFilesToCopy ), strDestinationDirectory )
    nCopySuccess    <- sum( vResults )


    nQtyFilesToCopy <- length( vResults )


    if( !recursive  )
    {
        nQtyFilesToCopy <- nQtyFilesToCopy - length( list.dirs( strSourceDirectory, recursive = FALSE ) )
    }
    nCopyFail       <- nQtyFilesToCopy - nCopySuccess
    strRet          <- paste( ".....", nCopySuccess, "file(s) were successfully coppied and", nCopyFail, "file(s) were not coppied correctly.")
    return( strRet )
}

# This function will copy the file strTemplateFileName from the Templates subdiretory of this package to the
# strDestinationFile.  The strDestinationFile should include the directory if it is not the current working diretory and
# if the destination file already exists it will add a number to the file name.
CopyTemplateFile <- function( strTemplateFileName, strDestinationFile)
{

    bFileExists <- file.exists( strDestinationFile )
    # Need to find the file name since it already exists
    nIndex <- 0
    while( bFileExists )
    {
        strDestinationFile <- sub( ".R", "", strDestinationFile, ignore.case = TRUE )
        nIndex             <- nIndex + 1
        strFileName        <- paste( strDestinationFile, nIndex, ".R", sep ="" )
        bFileExists        <- file.exists( strFileName )
    }

    strTemplateFloder           <- GetTemplateDirectory( "Templates" )
    strFunctionTemplateFile     <- paste( strTemplateFloder, "/", strTemplateFileName, sep="")

    bFileCoppied                <- file.copy( strFunctionTemplateFile, strDestinationFile )
    return( list( bFileCoppied = bFileCoppied, strDestinationFile = strDestinationFile ))
}
