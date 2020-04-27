#################################################################################################### .
# Test file for Add Description                                                                     ####
#################################################################################################### .


context( "AddNewTabToApp")
source( "MiscTestFunctions.R")

test_that("Test- AddNewTabToApp", {
    # Example test that will fail
    nRet         <- 1
    nExpectedRet <- 10

    expect_equal( strRet, strRetExp, info = "The return string did not match.", label = "Return string")

    expect_equal( nRet, nExpectedRet, info = "The test failed...", label ="Test for ..." )
})
