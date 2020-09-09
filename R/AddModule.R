#' @name AddModule
#'
#' @title AddModule
#'
#' @description { This function quickly adds a module to the current app using the default parameters. Use addModules() when additional customization is needed.   }
#'
#' @param strModuleID ID for new module
#' @param bType Type of application. Valid options are 'standalone' or 'package'.
#'
#' @export


AddModule<-function(strModuleID, strType="package"){
    AddModules(vModuleIDs=c(strModuleID), strType=strType)
}
