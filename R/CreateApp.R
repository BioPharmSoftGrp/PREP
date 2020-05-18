
CreateApp <- function( path, ... )
{

    lArgs <- list(...)
    CreateBaSSApp(   path,
                     strProjectName                   = "",
                     strCalculationLibraryName        = lArgs[[ "strCalculationLibraryName"]],
                     strShinyAppName                  = lArgs[[ "strShinyAppName"]],
                     strShinyAppDisplayName           = lArgs[["strShinyAppDisplayName"]],
                     bCreateWithExampleTabs           = lArgs[["bCreateWithExampleTabs"]],
                     bCreateShinyApp                  = lArgs[["bCreateShinyApp"]],
                     bCreateCalculationPackage        = lArgs[["bCreateCalculationPkg"]])


}
