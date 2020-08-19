#################################################################################################### .
# AddFunctionToPkg                                                                              ####
#   Description - The function will add a new function file to the R directory with the
#   correct headers and also setup a test file in the test/tests directory
#################################################################################################### .
#' @name  AddFunctionToPkg
#' @title  AddFunctionToPkg
#' @description { Add a new function named strFunctionName to a package.  This function creates a file named R/strFunctionName.R
#' and adds a test function in the file tests/testthat/test-strFunctionName.R to be used with the testthat package. }
#' @param strFunctionName The name of the function to add.
#' @param strFunctionDescription A description to include at the top of the file with the function.
#' @param strPkgDir The directory of the package to add the function to.  If this parameter is left blank then the current working directory will be used.
#' @export
AddFunctionToPkg <- function(  strFunctionName, strFunctionDescription = "", strPkgDir = "" )
{

    if( !Provided( strPkgDir) )
        strPkgDir <- getwd()

    if( !Provided( strFunctionDescription ) )
        strFunctionDescription <- "Add Description"

    strFileName <- paste( strPkgDir, "/R/", strFunctionName, ".R", sep ="" )

    # Create the file name
    bFileExists <- file.exists( strFileName )
    # Need to find the file name since it already exists
    nIndex <- 0
    while( bFileExists )
    {
        nIndex      <- nIndex + 1
        strFileName <- paste( strPkgDir, "/R/", strFunctionName, nIndex, ".R", sep ="" )
        bFileExists <- file.exists( strFileName )
    }


    #Verify that the test function file does not exist
    strTestFileName <- paste( strPkgDir, "/tests/testthat/test-", strFunctionName,  ".R", sep ="" )
    bTestFileExists <- file.exists( strTestFileName )

    # Need to find the file name since it already exists
    nIndex <- 0
    while( bTestFileExists )
    {
        nIndex          <- nIndex + 1
        strTestFileName <- paste( strPkgDir, "/tests/testthat/test-", strFunctionName, nIndex, ".R", sep ="" )
        bTestFileExists <- file.exists( strTestFileName )
    }

    strTemplateFolder <- GetTemplateDirectory( "Templates" )

    strFunctionTemplateFile     <- paste( strTemplateFolder, "/", "FunctionTemplate.R", sep="")
    strTestFunctionTemplateFile <- paste( strTemplateFolder, "/",  "TestFunctionTemplate.R", sep="")

    bFileCoppied       <- file.copy( strFunctionTemplateFile, strFileName )
    bTestFileCoppied   <- file.copy( strTestFunctionTemplateFile, strTestFileName )

    strToday           <- format(Sys.Date(), format="%m/%d/%Y")

    # Replace the TAGS in the coppied files

    vTags    <- c("FUNCTION_NAME", "FILE_DESCRIPTION", "CREATION_DATE")
    vReplace <- c(strFunctionName, strFunctionDescription, strToday)
    ReplaceTagsInFile( strFileName, vTags, vReplace )

    # strFileLines       <- readLines( strFileName )
    # strFileLines       <- WhiskerReplace( "FUNCTION_NAME", strFunctionName, strFileLines )
    # strFileLines       <- WhiskerReplace( "FILE_DESCRIPTION", strFunctionDescription, strFileLines )
    # strFileLines       <- WhiskerReplace( "CREATION_DATE", strToday, strFileLines )
    # writeLines( strFileLines, con = strFileName )

    vTags    <- c("FUNCTION_NAME", "FILE_NAME", "CREATION_DATE")
    vReplace <- c(strFunctionName, strFunctionName, strToday)
    ReplaceTagsInFile( strTestFileName, vTags, vReplace )


    # strFileLines       <- readLines( strTestFileName )
    # strFileLines       <- WhiskerReplace( "FUNCTION_NAME", strFunctionName, strFileLines )
    # strFileLines       <- WhiskerReplace( "FILE_NAME", strFunctionName, strFileLines )
    # strFileLines       <- WhiskerReplace( "CREATION_DATE", strToday, strFileLines )
    # writeLines( strFileLines, con = strTestFileName )

    strRet <- "The following file(s) were created: "

    if( bFileCoppied )
    {
        strRet <- paste( strRet, strFileName, " - CREATED SUCCESSFULY. ")
    }
    else
    {
        strRet <- paste( strRet, " The new file for the function could not be created corectly. ")
    }


    if( bTestFileCoppied )
    {
        strRet <- paste( strRet, " The TEST file, ", strTestFileName, " - CREATED SUCCESSFULY. ")
    }
    else
    {
        strRet <- paste( strRet, " The new file for the TEST function could not be created corectly. ")
    }
    return( strRet )
}
