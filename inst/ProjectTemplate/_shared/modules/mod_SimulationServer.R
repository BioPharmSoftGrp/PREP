
#' Server for simulation module
#'
#' @return moduleServer for simulation module - currently an empty shell

DataAnalysisIntroServer <- function(){
    strID <- "DataAnalysisIntro"
    retModule <- function( input, output, session ){}
    retServer <- moduleServer( strID, module = retModule )
    return( retServer )
}