#' @name AddModules
#'
#' @title AddModules
#' @description { This function adds a module to a shiny app created by BaSS.  }
#'
#' @param vModuleIDs IDs of the shiny module to be added to the application. The source code for each module should be saved in strModuleDirectory with files named "mod_{strModuleID}UI.R" and mod_{strModuleID}Server.R". If desired, submodules may also be included using the following naming convention "mod_{strModuleID}_XXX.R".
#' @param strPackageDirectory The directory where the BaSS shiny app located.
#' @param strModuleDirectory Location of the Module to be added ot the app. Defaults to inst/_shared/modules.
#' @param strType type of application - valid options are "package" and "standalone"
#' @param bDashboard should modules be added to a shinyDashboard? If True,  module UI is wrapped in a shinyDashboard::tabItem and a shinyDashboard::menuItem is added. Default: True
#' @param strUIWrapper Wrapper for calling module UI
#' @param strSidebarWrapper Wrapper for calling sidebar UI
#' @param strServerWrapper Wrapper for calling UI code
#' @param strUITemplate UI whisker Template to use when creating new Modules
#' @param strServerTemplate Server whisker Template to use when creating new Modules
#' @param lCustomParameters List of Custom Parameters for new modules
#'
#' @importFrom devtools build document
#' @importFrom whisker whisker.render
#'
#' @export
#'

AddModules <- function(
    vModuleIDs=c(),
    strPackageDirectory=getwd(),
    strModuleDirectory="",
    strType="package",
    bDashboard=TRUE,
    strUIWrapper=NULL,
    strSidebarWrapper=NULL,
    strServerWrapper=NULL,
    strUITemplate=NULL,
    strServerTemplate=NULL,
    lCustomParameters=NULL
){

    # 0. Parse Parameter Defaults
    stopifnot(
        length(vModuleIDs)>0,
        all(nchar(vModuleIDs)>0),
        all(is.character(vModuleIDs))
    )



    #source location of modules to copy in to new package
    strSrcDirectory <- ifelse(
        strModuleDirectory=="",
        paste0( GetTemplateDirectory(), "/_shared/modules"),
        strModuleDirectory
    )

    #destination location for modules in new package
    strDestDirectory <- ifelse(strType=="package",
        paste0(strPackageDirectory,"/R"),
        paste0(strPackageDirectory,"/inst/modules")
    )

    # 1. Copy Files - Copy all files starting with `mod_{strMod}` to the package
    vModulePaths <- c()
    vModuleFiles <- c()
    for(strModuleID in vModuleIDs){
        vCurrentPaths <- list.files(
            strSrcDirectory,
            pattern = paste0("mod_",strModuleID), #TODO: Update to ignore case conflicts?
            recursive = TRUE,
            full.names = TRUE
        )

        #Also get file names for update to global.R below.
        vCurrentFiles <- list.files(
            strSrcDirectory,
            pattern = paste0("mod_",strModuleID), #TODO: Update to ignore case conflicts?
            recursive = TRUE,
            full.names = FALSE
        )
        vModuleFiles <- c(vModuleFiles,vCurrentFiles)

        if(length(vCurrentPaths)>0){
            file.copy(from=vCurrentPaths, to=strDestDirectory)
        }else{
            #If no matching files are found create a new module using a template
            CreateModule(
                strModuleID=strModuleID,
                strDestDirectory=strDestDirectory,
                strUITemplate = strUITemplate,
                strServerTemplate = strServerTemplate,
                lCustomParameters= lCustomParameters
            )
            vModuleFiles <- c(vModuleFiles,paste0("mod_",strModuleID,"UI.R"),paste0("mod_",strModuleID,"Server.R"))
        }

    }

    # 2. If using a standalone package `source()` the modules in global.R
   if(tolower(strType) =="standalone"){
       strGlobalPath <-  paste0(strPackageDirectory,"/global.R")
       vSources <- paste0('source("inst/modules/',vModuleFiles,'")',collapse="\n")
       strInput <- paste(readLines(strGlobalPath),collapse="\n")
       strRet  <- paste(strInput,"\n",vSources)
       writeLines( strRet, con = strGlobalPath )
   }

    # Note/TODO : User must currently load all needed libraries in standalone apps. We could consider adding library calls for @imports in a future release.

    # 3. Update app_ui to call the module UI
    # UI Module Call

    if(is.null(strUIWrapper)){
        strUIWrapper <- ifelse(
        bDashboard,
        "tabItem(tabName='{{MODULE_ID}}', {{MODULE_ID}}UI())",
        "{{MODULE_ID}}UI()"
       )
    }

    if(is.null(strSidebarWrapper)){
        strSidebarWrapper<-"menuItem(text = '{{MODULE_ID}}', tabName = '{{MODULE_ID}}', icon = icon('angle-right'))"
    }

    strUI <- ""
    strSidebar<- ""
    for(strModuleID in vModuleIDs){
        strModuleCall <- whisker.render(strUIWrapper, list(MODULE_ID=strModuleID))
        strUI <- paste0(strUI, "\n,", strModuleCall)
        strSidebarCall<- whisker.render(strSidebarWrapper, list(MODULE_ID=strModuleID))
        strSidebar<-paste0(strSidebar, "\n,", strSidebarCall)
    }
    strUI <- paste0(strUI,"\n #{{ADD_NEW_MODULE_UI}}") #Keep the ADD_MODULE_UI Tag for future modules.
    strSidebar<- paste0(strSidebar,"\n #{{ADD_NEW_MODULE_SIDEBAR}}")
    strUI_first<-paste0("\n",substr(strUI,3,nchar(strUI))) #hack to leading comma when initializing app
    strSidebar_first<-paste0("\n",substr(strSidebar,3,nchar(strSidebar)))

    # Update app_ui.R
    strAppDir<-ifelse(strType=="package", strDestDirectory, strPackageDirectory)
    #NOTE - _FIRST vs. _NEW is needed to deal with trailing commas :/
    UIParameters<-list(
        ADD_FIRST_MODULE_UI=strUI_first,
        ADD_FIRST_MODULE_SIDEBAR=strSidebar_first,
        ADD_NEW_MODULE_UI=strUI,
        ADD_NEW_MODULE_SIDEBAR=strSidebar,
        PROJECT_NAME="{{PROJECT_NAME}}",
        AUTHOR_NAME="{{AUTHOR_NAME}}"
    )
    strUIpath <- paste0(strAppDir,"/app_ui.R")
    strUIInput <- readLines(strUIpath)
    strUIRet  <-whisker.render(strUIInput, data=UIParameters)
    writeLines( strUIRet, con = strUIpath)

    # 4. update app_server to call module server at end of file
    if(is.null(strServerWrapper)){
        strServerWrapper <- "{{MODULE_ID}}Server()"
    }
    strServer<-""
    for(strModuleID in vModuleIDs){
        strServerCall <- whisker.render(strServerWrapper, list(MODULE_ID=strModuleID))
        strServer <- paste0(strServer, "\n", strServerCall)
    }
    strServerTemplate <- paste("{{ADD_MODULE_SERVER}} \n",strServer) #Keep the ADD_MODULE_UI Tag for future modules.
    ServerParameters<-list(ADD_MODULE_SERVER=strServerTemplate)
    strServerPath <- paste0(strAppDir,"/app_server.R")
    strServerInput <- readLines(strServerPath)
    strServerRet  <-whisker.render(strServerInput, data=ServerParameters)
    writeLines( strServerRet, con = strServerPath)

}
