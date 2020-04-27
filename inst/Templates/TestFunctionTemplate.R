#################################################################################################### .
# Test file for _FILE_NAME_                                                                     ####
#################################################################################################### .


context( "_FUNCTION_NAME_")

test_that("Test- _FUNCTION_NAME_", {
    # Example test that will fail
    nRet         <- 1
    nExpectedRet <- 10


    expect_equal( nRet, nExpectedRet, info = "The test failed...", label ="Test for ..." )
})
