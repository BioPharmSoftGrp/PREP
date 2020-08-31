#' @name AddModule
#' @title AddModule
#' @description { This function adds a module to a shiny app created by BaSS.  }
#'
#' @param strModuleID ID of the shiny module to be added to the application. The source code for the module should be saved in strModuleDirectory with files named "mod_{strModuleID}UI.R" and mod_{strModuleID}Server.R". If desired, submodules may also be included using the following naming convention "mod_{strModuleID}_XXX.R".
#' @param strPackageDirectory The directory where the BaSS shiny app located.
#' @param strModuleDirectory Location of the Module to be added ot the app. Defaults to inst/_shared/modules.
#' @param bTabItem Wrap the UI in a shinyDashboard::TabItem? default = TRUE
#'
#' @importFrom devtools build document
#' @importFrom stringr string_to_title
#'
#' @export
#'

AddModule <- function(
    strModuleID,
    strPackageDirectory=getwd(),
    strModuleDirectory="",
    strType="package",
    bTabItem=TRUE
){

    # 0. Parse Parameter Defaults
    stopifnot(
        nchar(strModuleID)>0,
        is.character(strModuleID)
    )

    #source location of modules to copy in to new pacakge
    strSrcDirectory <- ifelse(
        strModuleDirectory=="",
        paste0( GetTemplateDirectory(), "/_shared/modules"),
        strModuleDirectory
    )

    #destination locatation for modules in new pacakge
    strDestDirectory <- ifelse(strType=="package",
        paste0(strPackageDirectory,"/R"),
        paste0(strPackageDirectory,"/inst/modules")
    )

    # 1. Copy Files - Copy all files starting with `mod_{strMod}` to the package
    vModulePaths <- list.files(
        strSrcDirectory,
        pattern = paste0("mod_",strModuleID), #TODO: Update to ignore case conflicts?
        recursive = TRUE,
        full.names = TRUE
    )
   file.copy(from=vModulePaths, to=strDestDirectory)

    # 2. If using a standalone pacakge `source()` the modules in global.R
   if(tolower(strType) =="standalone"){
       vModuleFiles <- list.files(
           strSrcDirectory,
           pattern = paste0("mod_",strModuleID), #TODO: Update to ignore case conflicts?
           recursive = TRUE,
           full.names = TRUE
       )

       strGlobalPath <-  paste0(strDestDirectory,"/R/global.R")
       vSources <- paste0('source(',vModuleFiles,")/n")
       strInput <- readLines(strGlobalPath)
       strRet  <- paste(strInput,vSources)
       writeLines( strRet, con = strGlobalPath )

   }

    # 3. Update app_ui to call the module UI
    # UI Module Call
    strUI<-ifelse(bTabItem,
        paste0("tabItem(tabName =  '",strModuleID,"', ",strModuleID,"_UI())"),
        paste0(strModuleID,'UI()')
    )
    strUITemplate <- paste("{{ADD_MODULE_UI}} \n", strUI) #Keep the ADD_MODULE_UI Tag for future modules.

    # Sidebar Module Car
    strSidebar<-paste0(strModuleID, 'SideBarMenu(),')
    strSidebarTemplate<-paste("{{ADD_MODULE_SIDEBAR}} \n",strSidebar)

    # Update app_ui.R
    UIParameters<-list(ADD_MODULE_UI=strUITemplate, ADD_MODULE_SIDEBAR=strSidebarTemplate)
    strUIpath <- paste0(strDestDirectory,"/app_ui.R")
    strUIInput <- readLines(strUIpath)
    strUIRet  <-whisker.render(strUIInput, data=UIParameters)
    writeLines( strUIRet, con = strUIpath)

    # 4. update app_server to call module server
    strServer<-paste0(strModuleID,'Server()')
    strServerTemplate <- paste("{{ADD_MODULE_SERVER}} \n",strServer) #Keep the ADD_MODULE_UI Tag for future modules.
    ServerParameters<-list(ADD_MODULE_SERVER=strServerTemplate)
    strServerPath <- paste0(strDestDirectory,"/app_server.R")
    strServerInput <- readLines(strServerPath)
    strServerRet  <-whisker.render(strServerInput, data=ServerParameters)
    writeLines( strServerRet, con = strServerPath)

}
