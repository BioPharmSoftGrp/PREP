#' @name AddTab
#'
#' @title AddTab
#'
#' @description { This function quickly adds a tab to the current app using the default parameters. Use addModules() when additional customization is needed.   }
#'
#' @param strModuleID ID for new module
#' @param bType Type of application. Valid options are 'standalone' or 'package'.
#' @param bSubModuleIDs IDs for the sub tabs
#'
#' @export


AddTab<-function(strModuleID, strType="package", vSubModuleIDs=c()){
    # Create module that then calls the submodules
    subModuleUI<-readLines("path/to/template.r")
    subModuleServer<-readLines("path/to/template.r")
    
    #parameters to be generated from vSubModuleIDs
    lCustomParameters(
        SUB_TAB_SERVER = "", 
        SUB_TAB_UI = "", 
        SUB_TAB_MENU = "" #update AddModules to be more flexible regarding custom menu items - this is probably the hardest part ... 
    )
    
    AddModules(
        vModuleIDs=c(strModuleID), 
        strType=strType
        strNewModuleUITemplate=subModuleUI
        strNewModuleServerTemplate=subModuleServer,
        bDashboard=TRUE, #NOTE: Might not always be the default, but will be always required for this helper function. 
        lCustomParameters=lCustomParameters
    )

    #Create subtabs from the standard template (or we can make an option that supports custom templates
    for(strSubModuleID in vSubModuleIDs){
        createModule(strModuleID=paste0(strModuleID,"_",strSubModuleID))
    }
    
#NOTE:Another option would be to update AddModules() to allow it to target existing modules, and then just call `AddModules(vModuleIDs = vSubModuleIDs, target=strModuleID, ... )`. This would be nice, but I suspect it would be fairly complex. 
}
