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

    #Create UI Module
    strUIPath <- paste0(strDestDirectory,"/mod_",strModuleID,"UI.R")
    strUI  <-whisker.render(strUITemplate, data=parameters)
    writeLines( strUI, con = strUIPath)

    #Create Server Module
    strServerPath <- paste0(strDestDirectory,"/mod_",strModuleID,"Server.R")
    strServer  <-whisker.render(strServerTemplate, data=parameters)
    writeLines( strServer, con = strServerPath)
}
