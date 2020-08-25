#' Server for options module
#'
#' @return moduleServer for options module - currently and empty shell

OptionsServer <- function(){
    strID <- "Options"
    retModule <- function( input, output, session ){}
    retServer <- moduleServer( strID, module = retModule )
    return( retServer )
}