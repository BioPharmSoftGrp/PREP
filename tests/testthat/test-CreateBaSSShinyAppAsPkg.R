#################################################################################################### .
# Test file for Add Description                                                                     ####
#################################################################################################### .


context( "CratePREPShinyAppAsPkg")

source( "MiscTestFunctions.R")

test_that("Test- CreatePREPShinyAppAsPkg", {


    bSuccess <- FALSE
    strErr   <- "None of the projects were created."

    strWD               <- getwd()
    strProjDir          <- paste( strWD, "TestProject", sep = "/")

    CleanUpAfterTest( strProjDir ) # Clean up just in case a previous test failed and could not clean up
    strProjName         <- "TestProj"
    strShinyName        <- "TestShiny"
    strShinyDispName    <- "Test App"

    strRet <-  CreatePREPShinyAppAsPkg( strProjDir, strShinyName  )
    print( strRet )

    strTmpDir       <- paste( strWD, "TestProject", strShinyName, sep = "/")
    nQtyFilesExp    <- 9
    nQtyFiles       <- length( list.files( strTmpDir ) )
    expect_equal( nQtyFiles, nQtyFilesExp, info = paste( "Number of files in the Shiny project directory, expected", nQtyFilesExp, ", returned:", nQtyFiles), label ="Qty of files in project directory", tolerance = 0.1)


    strProjectFile <- paste( strTmpDir, "TestShiny.Rproj", sep = "/" )
    expect_true( file.exists( strProjectFile ), info = "Failed to rename the project file name." )

    strProjectFile <- paste( strTmpDir, "inst/TestShiny", sep = "/" )
    expect_true( file.exists( strProjectFile ), info = "Failed to rename or create the shiny project file in the inst directory." )


    strProjectFile <- paste( strTmpDir, "R/RunApp.R", sep = "/" )
    expect_true( file.exists( strProjectFile ), info = "Failed to copy or create the R/RunApp.R file." )

    strFileLines       <- readLines( strProjectFile  )

    vMatch   <- regexpr( strShinyName, strFileLines)
    bUpdated <- any( vMatch != -1 )
    expect_true( bUpdated, info = "Failed to update the R/RunApp.R file to contain the name of the Shiny app" )

    CleanUpAfterTest( strProjDir )

})
