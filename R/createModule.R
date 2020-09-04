#' Create Module
#'
#' @param strModuleID Module ID
#' @param strDestDirectory Directory to save new files
#' @param strUITemplate Module Template Path.
#' @param strServerTemplate Module Template Path.
#'
#' @import whisker
#'
#' @export

CreateModule <- function(
    strModuleID="newModule" ,
    strDestDirectory=paste0(getwd(),"/R"),
    strUITemplate=NULL,
    strServerTemplate=NULL,
    lCustomParameters=list()){

    #Simple Default Templates
    if(is.null(strUITemplate)){
        strUITemplate<-"{{MODULE_ID}}UI <- function(){
        return(span('placeholder for {{MODULE_ID}} module'))
        }"
    }

    if(is.null(strServerTemplate)){
        strServerTemplate<-"{{MODULE_ID}}Server <- function(){
        strID     <- '{{MODULE_ID}}';
        retModule <- function( input, output, session ){}
        retServer <- moduleServer( strID, module = retModule )
        return( retServer )
        }"
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
