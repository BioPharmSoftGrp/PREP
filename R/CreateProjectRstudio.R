
CreateAppRStudio <- function( path, ... )
{

    lArgs <- list(...)
    CreateBaSSApp(   strProjectDirectory              = path,
                     strProjectName                   = "",
                     strCalculationLibraryName        = lArgs[[ "strCalculationLibraryName"]],
                     strShinyAppName                  = lArgs[[ "strShinyAppName"]],
                     strShinyAppDisplayName           = lArgs[["strShinyAppDisplayName"]],
                     strAuthors                       = lArgs[["strAuthors"]],
                     bCreateWithExampleTabs           = lArgs[["bCreateWithExampleTabs"]],
                     bCreateShinyApp                  = lArgs[["bCreateShinyApp"]],
                     bCreateCalculationPackage        = lArgs[["bCreateCalculationPkg"]],
                     bCreateShinyAppAsPackage         = lArgs[["bCreateShinyAppAsPackage"]])


}
