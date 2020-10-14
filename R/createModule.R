#' Create Module
#'
#' @param strModuleID Module ID
#' @param strDestDirectory Directory to save new files
#' @param strUITemplate Module UI Template
#' @param strServerTemplate Module Server Template
#'
#' @import whisker
#'
#' @export

CreateModule <- function(
    strModuleID="newModule",
    strDestDirectory=paste0(getwd(),"/R"),
    strUITemplate=NULL,
    strServerTemplate=NULL,
    lCustomParameters=list()){

    #Set Default Templates
    strTemplatePath<-paste0(GetTemplateDirectory("library"),"/app/")
    if(is.null(strUITemplate)){
        uiPath<-paste0(strTemplatePath,"mod_DefaultUI.R")
        strUITemplate<-paste(readLines(uiPath),collapse="\n")
    }

    if(is.null(strServerTemplate)){
        serverPath<-paste0(strTemplatePath,"mod_DefaultServer.R")
        strServerTemplate<-paste(readLines(serverPath),collapse="\n")
    }

    #Merge in custom paramaters (if any)
    parameters <- c(list(MODULE_ID=strModuleID),lCustomParameters)

    # Test for existing files
    strUIPath <- paste0(strDestDirectory,"/mod_",strModuleID,"UI.R")
    strServerPath <- paste0(strDestDirectory,"/mod_",strModuleID,"Server.R")
    vDestPaths <- c(strUIPath, strServerPath)
    vCurrentFiles<-c(paste0("mod_",strModuleID,"UI.R"),paste0("mod_",strModuleID,"Server.R"))
    vDestExists <- vCurrentFiles[file.exists(vDestPaths)] 
    if(length(vDestExists > 0 )){
        print(paste0("Caution: The following file(s) for the '",strModuleID, "' module already exist in your app and will not be replaced; This may cause unexpected behavior.  You can delete the file(s) and rerun this command, or manually edit the existing file."))
        print(paste("File(s) not copied:", paste(vDestExists, collapse=", ")))
    }

    #Create UI Module
    if(!file.exists(strUIPath)){
        strUI  <-whisker.render(strUITemplate, data=parameters)
        writeLines( strUI, con = strUIPath)
    }

    #Create Server Module
    if(!file.exists(strServerPath)){
        strServer  <-whisker.render(strServerTemplate, data=parameters)
        writeLines( strServer, con = strServerPath)
    }
}
