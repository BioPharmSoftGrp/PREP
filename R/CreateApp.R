
CreateApp <- function( path, ... )
{

    lArgs <- list(...)
    CreateBaSSdApp( path,
                     strProjectName = "",
                     strCalculationLibraryName  =lArgs[[ "strCalculationLibraryName"]],
                     strShinyAppName = lArgs[[ "strShinyAppName"]],
                     strShinyAppDisplayName = lArgs[["strShinyAppDisplayName"]],
                     bCreateWithExampleTabs = lArgs[["bCreateWithExampleTabs"]] )


}
