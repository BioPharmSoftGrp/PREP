#################################################################################################### .
# AddTestToPkg                                                                              ####
#   Description - The function will add a new test function to the calculation package.
#   This function is intended to be used when a file in the package was already created but
#   a test file was not created.
#################################################################################################### .
#' @name  AddTestToPkg
#' @title  AddTestToPkg
#' @description { Description - The function will add a new test function to the calculation package.
#'   This function is intended to be used when a file in the package was already created but
#'   a test file was not created.  This fuction will create a file named /tests/testthat/test-strTestFileName.R }
#' @param strFunctionName The name of the function to add.
#' @examples
#' \dontrun{
#'     AddTestToPkg( "RunSimulation" )  # This would create a test file at /tests/testthat/test-RunSimulation.R
#' }
#' @export
AddTestToPkg <- function(  strTestFileName )
{

    strPkgDir <- getwd()
    #Verify that the test function file does not exist
    strTestFileNameFull <- paste( strPkgDir, "/tests/testthat/test-", strTestFileName,  ".R", sep ="" )
    bTestFileExists     <- file.exists( strTestFileNameFull )

    # Need to find the file name since it already exists
    nIndex <- 0
    while( bTestFileExists )
    {
        nIndex              <- nIndex + 1
        strTestFileNameFull <- paste( strPkgDir, "/tests/testthat/test-", strTestFileName, nIndex, ".R", sep ="" )
        bTestFileExists     <- file.exists( strTestFileNameFull )
    }

    strTemplateFloder <- GetTemplateDirectory( "Templates" )

    strTestFunctionTemplateFile <- paste( strTemplateFloder, "/",  "TestFunctionTemplate.R", sep="")

    bTestFileCoppied   <- file.copy( strTestFunctionTemplateFile, strTestFileNameFull )

    # Replace the TAGS in the coppied files

    #strFileLines       <- readLines( strTestFileName )
    #strFileLines       <- gsub( "_FUNCTION_NAME_", strTestFileName, strFileLines )
    #strFileLines       <- gsub( "_FILE_NAME_", strFunctionDescription, strFileLines )
    # writeLines( strFileLines, con = strTestFileName )

    strRet <- "The following file(s) were created: "

    if( bTestFileCoppied )
    {
        strRet <- paste( strRet, " The TEST file, ", strTestFileNameFull, " - CREATED SUCCESSFULY. ")
    }
    else
    {
        strRet <- paste( strRet, " The new file for the TEST function could not be created corectly. ")
    }
    return( strRet )
}
