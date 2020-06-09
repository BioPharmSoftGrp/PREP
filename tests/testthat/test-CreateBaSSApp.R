context( "CreateBaSSApp")
source( "MiscTestFunctions.R")

test_that("Test- CreateBaSSApp", {

    bSuccess <- FALSE
    strErr   <- "None of the projects were created."

    strWD               <- getwd()
    strProjDir          <- paste( strWD, "TestProject", sep = "/")

    CleanUpAfterTest( strProjDir ) # Clean up just incase a previous test failed and could not clean up
    strProjName         <- "TestProj"
    strCalcName         <- "TestCalc"
    strShinyName        <- "TestShiny"
    strShinyDispName    <- "Test App"

    strRet              <- CreateBaSSApp( strProjectDirectory       = strProjDir,
                                            strProjectName            = strProjName,
                                            strCalculationLibraryName = strCalcName,
                                            strShinyAppName           = strShinyName,
                                            strShinyAppDisplayName    = strShinyDispName,
                                            )

    strRetExp <- "Creating BaSS Projects...\n..... 2 file(s) were successfully coppied and 0 file(s) were not coppied correctly.\nBegin by reading the ProjectInstructions.html (or ProjectInstructions.Rmd)\nCreating Calculation Package...\n..... 8 file(s) were successfully coppied and 0 file(s) were not coppied correctly.\n.....Use R Studio to open the C:/Kyle/Software/GRApps/tests/testthat/TestProject/TestProj/TestCalc/TestCalc.Rproj project file and begin by reading the Instructions.Rmd file.\nCreating Shiny App...\n..... 13 file(s) were successfully coppied and 0 file(s) were not coppied correctly.\n.....Use R Studio to open the the  C:/Kyle/Software/GRApps/tests/testthat/TestProject/TestProj/TestShiny/TestShiny.Rproj project file and begin by reading the Instructions.Rmd file."
    #expect_true( bSuccess, info = strErr, label="Create Gilead App")
    expect_equal( strRet, strRetExp, info = "The return string did not match.", label = "Return string")

    # Now check that the created project was correctly done.
    strProjectDirExp       <- paste( strProjDir, "/", strProjName, sep="" )
    bProjectDirectoryCreated <- dir.exists( strProjectDirExp )
    expect_true( bProjectDirectoryCreated, info = paste( "The project directory, ", strProjectDirExp, " was not created as expected. ", "Project Directory" ))

    vFilesInProject <- list.files( strProjectDirExp )
    nQtyFiles       <- length( vFilesInProject )
    nQtyFilesExp    <- 4

    expect_equal( nQtyFiles, nQtyFilesExp, info = paste( "Number of files in the project directory, expected", nQtyFilesExp, ", returned:", nQtyFiles), label ="Qty of files in project directory", tolerance = 0.1)

    # Now check the Clac package
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
