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
#' @param strFunctionTemplatePath Path to a function template. /inst/Templates/FunctionTemplate.R used as default.
#' @param stTestTemplatePath Path to a test template. /inst/Templates/TestTemplate.R.
#' @export
AddFunctionToPkg <- function(
    strFunctionName="MyNewFunction",
    strFunctionDescription = "Add Description",
    strPkgDir = getwd(),
    strFunctionTemplate=NULL,
    strTestTemplate=NULL
    )
{

    # strFunctionName <- str_replace_all(strFunctionName, "[^[:alnum:]]", " ") #remove non alphanumerics
    strFunctionName <- str_replace_all(strFunctionName, "[^[:alnum:]_-[.]]", " ")
    strFunctionName <- str_replace_all(strFunctionName, " ", "")

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

    strTemplateFolder <- GetTemplateDirectory( "library" )


    strFunctionTemplateFile     <- ifelse(
        is.null(strFunctionTemplate),
        paste( strTemplateFolder, "/pkg/FunctionTemplate.R", sep=""),
        strFunctionTemplate
    )
    strTestFunctionTemplateFile <- ifelse(
        is.null(strTestTemplate),
        paste( strTemplateFolder, "/pkg/TestFunctionTemplate.R", sep=""),
        strTestTemplate
    )


    bFileCoppied       <- file.copy( strFunctionTemplateFile, strFileName )
    bTestFileCoppied   <- file.copy( strTestFunctionTemplateFile, strTestFileName )

    strToday           <- format(Sys.Date(), format="%m/%d/%Y")

    # Replace the TAGS in the coppied files

    vTags    <- c("FUNCTION_NAME", "FILE_DESCRIPTION", "CREATION_DATE")
    vReplace <- c(strFunctionName, strFunctionDescription, strToday)
    ReplaceTagsInFile( strFileName, vTags, vReplace )

    vTags    <- c("FUNCTION_NAME", "FILE_NAME", "CREATION_DATE")
    vReplace <- c(strFunctionName, strFunctionName, strToday)
    ReplaceTagsInFile( strTestFileName, vTags, vReplace )


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
