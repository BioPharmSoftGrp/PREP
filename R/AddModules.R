#' @name AddModules
#' @title AddModules
#' @description { This function adds a module to a shiny app created by BaSS.  }
#'
#' @param vModuleIDs IDs of the shiny module to be added to the application. The source code for each module should be saved in strModuleDirectory with files named "mod_{strModuleID}UI.R" and mod_{strModuleID}Server.R". If desired, submodules may also be included using the following naming convention "mod_{strModuleID}_XXX.R".
#' @param strPackageDirectory The directory where the BaSS shiny app located.
#' @param strModuleDirectory Location of the Module to be added ot the app. Defaults to inst/_shared/modules.
#' @param strType type of application - valid options are "package" and "standalone"

#' @importFrom devtools build document
#'
#' @export
#'

AddModules <- function(
    vModuleIDs,
    strPackageDirectory=getwd(),
    strModuleDirectory="",
    strType="package",
    bUseTab=TRUE,
    strCustomUITemplate=NULL
){

    # 0. Parse Parameter Defaults
    stopifnot(
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
        vModulePaths<-c(vModulePaths,vCurrentPaths)

        #Also get file names for update to global.R below.
        vCurrentFiles <- list.files(
            strSrcDirectory,
            pattern = paste0("mod_",strModuleID), #TODO: Update to ignore case conflicts?
            recursive = TRUE,
            full.names = FALSE
        )
        vModuleFiles <- c(vModuleFiles,vCurrentFiles)
    }
   file.copy(from=vModulePaths, to=strDestDirectory)

    # 2. If using a standalone package `source()` the modules in global.R
   if(tolower(strType) =="standalone"){
       strGlobalPath <-  paste0(strPackageDirectory,"/global.R")
       vSources <- paste0('source("inst/modules/',vModuleFiles,'")',collapse="\n")
       strInput <- readLines(strGlobalPath)
       strRet  <- paste(strInput,"\n",vSources)
       writeLines( strRet, con = strGlobalPath )
   }

    # Note/TODO : User must currently load all needed libraries in standalone apps. We could consider adding library calls for @imports in a future release.

    # 3. Update app_ui to call the module UI
    # UI Module Call

    if(is.null(strCustomUITemplate)){
       strUITemplate <- ifelse(
        bUseTab,
        "tabItem(tabName='{{MODULE_ID}}', {{MODULE_ID}}UI())",
        "{{MODULE_ID}}UI()"
       )
    }else{
        strUITemplate <- strCustomUITemplate
    }

    strUI <- "{{ADD_MODULE_UI}}" #Keep the ADD_MODULE_UI Tag for future modules.
    for(strModuleID in vModuleIDs){
        strModuleCall <- whisker.render(strUITemplate, list(MODULE_ID=strModuleID))
        strUI <- paste0(strUI, "\n", strModuleCall,",")
    }
    strUI<-substr(strUI,1,nchar(strUI)-1) #remove trailing comma

    # Sidebar Module
    strSidebar<-paste0(vModuleIDs, 'SideBarMenu()',collapse =", \n")
    strSidebar<-paste("{{ADD_MODULE_SIDEBAR}} \n",strSidebar)
    strSidebar<-substr(strSidebar,1,nchar(strSidebar)) #remove trailing comma

    # Update app_ui.R
    strAppDir<-ifelse(strType=="package", strDestDirectory, strPackageDirectory)
    UIParameters<-list(ADD_MODULE_UI=strUI, ADD_MODULE_SIDEBAR=strSidebar)
    strUIpath <- paste0(strAppDir,"/app_ui.R")
    strUIInput <- readLines(strUIpath)
    strUIRet  <-whisker.render(strUIInput, data=UIParameters)
    writeLines( strUIRet, con = strUIpath)

    # 4. update app_server to call module server at end of file
    strServer<-paste0(vModuleIDs,'Server()',collapse="\n")
    strServerTemplate <- paste("{{ADD_MODULE_SERVER}} \n",strServer) #Keep the ADD_MODULE_UI Tag for future modules.
    ServerParameters<-list(ADD_MODULE_SERVER=strServerTemplate)
    strServerPath <- paste0(strAppDir,"/app_server.R")
    strServerInput <- readLines(strServerPath)
    strServerRet  <-whisker.render(strServerInput, data=ServerParameters)
    writeLines( strServerRet, con = strServerPath)

}
