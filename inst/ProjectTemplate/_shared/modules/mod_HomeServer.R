#' Server for home tab
#'
#' @param strID Tab ID
#'
#' @return

HomeServer <- function( strID="Home" ){
    retModule <- function( input, output, session ){}
    retServer <- moduleServer( strID, module = retModule )
    return( retServer )
}

