#' @name AddTab
#'
#' @title AddTab
#'
#' @description { This function quickly adds a tab to the current app using the default parameters. Use addModules() when additional customization is needed.   }
#'
#' @param strModuleID ID for new module
#' @param bType Type of application. Valid options are 'standalone' or 'package'.
#' @param vSubtabIDs IDs for the sub tabs
#'
#' @export


AddTab<-function(strModuleID, strType="package", vSubtabIDs=c()){

    bHasSubtabs <- length(vSubtabIDs > 0)
    strTemplatePath<-paste0(GetTemplateDirectory("library"),"/app/")
    if(bHasSubtabs){
        strUITemplate<-readLines(paste0(strTemplatePath,"mod_SubtabUI.R"))
        strServerTemplate<-readLines(paste0(strTemplatePath,"mod_SubtabServer.R"))
    }else{
        strUITemplate<-readLines(paste0(strTemplatePath,"mod_DefaultUI.R"))
        strServerTemplate<-readLines(paste0(strTemplatePath,"mod_DefaultServer.R"))
    }
    strUITemplate <- paste(strUITemplate, collapse="\n") 
    strServerTemplate <- paste(strServerTemplate, collapse="\n")
    
    #Set up custom template if using subtabs
    
    strUI<-NULL
    strSidebar<-NULL
    strServer<-NULL
    if(bHasSubtabs){
        strUIWrapper <- "tabItem(tabName='{{MODULE_ID}}_{{SUBMODULE_ID}}', {{MODULE_ID}}_{{SUBMODULE_ID}}UI(id='{{MODULE_ID}}_{{SUBMODULE_ID}}'))"
        strSidebarWrapper <-"menuSubItem(text='{{SUBMODULE_ID}}', tabName='{{MODULE_ID}}_{{SUBMODULE_ID}}')"
        strServerWrapper <- "{{MODULE_ID}}_{{SUBMODULE_ID}}Server(id='{{MODULE_ID}}_{{SUBMODULE_ID}}')"
        
        strUI<-""
        strSidebar<-""
        strServer<-""
        for(strSubtabID in vSubtabIDs){
            lParams<-list(SUBMODULE_ID=strSubtabID, MODULE_ID=strModuleID)

            strUI <- paste0(strUI, whisker.render(strUIWrapper,lParams),",\n")
            strSidebar <- paste0(strSidebar, whisker.render(strSidebarWrapper,lParams),",\n")
            strServer<-paste0(strServer, whisker.render(strServerWrapper,lParams),"\n")
        }
        strUI <- substr(strUI, 1, nchar(strUI)-2)
        strSidebar <- substr(strSidebar, 1, nchar(strSidebar)-2)
        strSidebar <- paste0("menuItem(text='",strModuleID,"',tabName='",strModuleID,"',icon = icon('calculator'),",strSidebar,")")
    }

    # Create module that then calls the submodules
    AddModules(
        vModuleIDs=c(strModuleID), 
        strType=strType,
        strUIWrapper=strUI,
        strSidebarWrapper=strSidebar,
        strServerWrapper=strServer,
        strUITemplate=strUITemplate,
        strServerTemplate=strServerTemplate,
        bDashboard=TRUE #NOTE: Required for the AddTab() function. 
    )

    #Create subtabs from the standard template (or we can make an option that supports custom templates
    for(strSubModuleID in vSubtabIDs){
        CreateModule(strModuleID=
        paste0(strModuleID,"_",strSubModuleID))
    }
}
