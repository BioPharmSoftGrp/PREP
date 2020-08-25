#' Server for data analysis module
#'
#' @return moduleServer for data analysis module - currently an empty shell

DataAnalysisServer <- function(){
    strID <- "DataAnalysis"
    retModule <- function( input, output, session ){}
    retServer <- moduleServer( strID, module = retModule )
    return( retServer )
}