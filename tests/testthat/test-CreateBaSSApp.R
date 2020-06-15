context( "CreateBaSSApp")
source( "MiscTestFunctions.R")

test_that("Test- CreateBaSSApp", {

    bSuccess <- FALSE
    strErr   <- "None of the projects were created."

    strWD               <- getwd()
    strProjDir          <- paste( strWD, "TestProject", sep = "/")

    CleanUpAfterTest( strProjDir ) # Clean up just in case a previous test failed and could not clean up
    strProjName         <- "TestProj"
    strCalcName         <- "TestCalc"
    strShinyName        <- "TestShiny"
    strShinyDispName    <- "Test App"

    strRet              <- CreateBaSSApp( strProjectDirectory       = strProjDir,
                                            strProjectName            = strProjName,
                                            strCalculationLibraryName = strCalcName,
                                            strShinyAppName           = strShinyName,
                                            strShinyAppDisplayName    = strShinyDispName,

                                            bCreateWithExampleTabs     = TRUE,
                                            bCreateShinyApp            = TRUE,
                                            bCreateCalculationPackage  = TRUE,
                                            bCreateShinyAppAsPackage   = FALSE
                                            )


    # Now check that the created project was correctly done.
    strProjectDirExp       <- paste( strProjDir, "/", strProjName, sep="" )
    bProjectDirectoryCreated <- dir.exists( strProjectDirExp )
    expect_true( bProjectDirectoryCreated, info = paste( "The project directory, ", strProjectDirExp, " was not created as expected. ", "Project Directory" ))

    vFilesInProject <- list.files( strProjectDirExp )
    nQtyFiles       <- length( vFilesInProject )
    nQtyFilesExp    <- 4

    expect_equal( nQtyFiles, nQtyFilesExp, info = paste( "Number of files in the project directory, expected", nQtyFilesExp, ", returned:", nQtyFiles), label ="Qty of files in project directory", tolerance = 0.1)

    # Now check the Calc package
    strTmpDir       <- paste( strProjectDirExp, "/", strCalcName, sep = "" )
    nQtyFilesExp    <- 8
    nQtyFiles       <- length( list.files( strTmpDir ) )
    expect_equal( nQtyFiles, nQtyFilesExp, info = paste( "Number of files in the R library, project directory, expected", nQtyFilesExp, ", returned:", nQtyFiles), label ="Qty of files in project directory", tolerance = 0.1)


    # Now check the Shiny package
    strTmpDir       <- paste( strProjectDirExp, "/", strShinyName, sep = "" )
    nQtyFilesExp    <- 13
    nQtyFiles       <- length( list.files( strTmpDir ) )
    expect_equal( nQtyFiles, nQtyFilesExp, info = paste( "Number of files in the Shiny project directory, expected", nQtyFilesExp, ", returned:", nQtyFiles), label ="Qty of files in project directory", tolerance = 0.1)

    CleanUpAfterTest( strProjDir )


})

test_that("Test- CreateBaSSAppShinyAsPkg", {

    bSuccess <- FALSE
    strErr   <- "None of the projects were created."

    strWD               <- getwd()
    strProjDir          <- paste( strWD, "TestProject", sep = "/")

    CleanUpAfterTest( strProjDir ) # Clean up just in case a previous test failed and could not clean up
    strProjName         <- "TestProj"
    strCalcName         <- "TestCalc"
    strShinyName        <- "TestShiny"
    strShinyDispName    <- "Test App"

    strRet              <- CreateBaSSApp( strProjectDirectory       = strProjDir,
                                          strProjectName            = strProjName,
                                          strCalculationLibraryName = strCalcName,
                                          strShinyAppName           = strShinyName,
                                          strShinyAppDisplayName    = strShinyDispName,

                                          bCreateWithExampleTabs     = TRUE,
                                          bCreateShinyApp            = TRUE,
                                          bCreateCalculationPackage  = TRUE,
                                          bCreateShinyAppAsPackage   = TRUE
    )


    # Now check that the created project was correctly done.
    strProjectDirExp       <- paste( strProjDir, "/", strProjName, sep="" )
    bProjectDirectoryCreated <- dir.exists( strProjectDirExp )
    expect_true( bProjectDirectoryCreated, info = paste( "The project directory, ", strProjectDirExp, " was not created as expected. ", "Project Directory" ))

    vFilesInProject <- list.files( strProjectDirExp )
    nQtyFiles       <- length( vFilesInProject )
    nQtyFilesExp    <- 4

    expect_equal( nQtyFiles, nQtyFilesExp, info = paste( "Number of files in the project directory, expected", nQtyFilesExp, ", returned:", nQtyFiles), label ="Qty of files in project directory", tolerance = 0.1)

    # Now check the Calc package
    strTmpDir       <- paste( strProjectDirExp, "/", strCalcName, sep = "" )
    nQtyFilesExp    <- 8
    nQtyFiles       <- length( list.files( strTmpDir ) )
    expect_equal( nQtyFiles, nQtyFilesExp, info = paste( "Number of files in the R library, project directory, expected", nQtyFilesExp, ", returned:", nQtyFiles), label ="Qty of files in Calc project directory", tolerance = 0.1)


    # Now check the Shiny package
    strTmpDir       <- paste( strProjectDirExp, "/", strShinyName, sep = "" )
    nQtyFilesExp    <- 9
    nQtyFiles       <- length( list.files( strTmpDir ) )
    expect_equal( nQtyFiles, nQtyFilesExp, info = paste( "Number of files in the Shiny project directory, expected", nQtyFilesExp, ", returned:", nQtyFiles), label ="Qty of files in ShinyApp directory", tolerance = 0.1)

    # For this  one it is important to make sure that the ShinyAppAsPakg/inst directory has the correct files
    strTmpDir       <- paste( strProjectDirExp, "/", strShinyName, "/inst/TestShiny", sep = "" )
    nQtyFilesExp    <- 13
    nQtyFiles       <- length( list.files( strTmpDir ) )
    expect_equal( nQtyFiles, nQtyFilesExp, info = paste( "Number of files in the Shiny/inst project directory, expected", nQtyFilesExp, ", returned:", nQtyFiles), label ="Qty of files in ShinyApp/inst directory", tolerance = 0.1)

    CleanUpAfterTest( strProjDir )


})
