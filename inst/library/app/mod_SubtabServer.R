#' {{MODULE_ID}} shiny Server
#'
#' @return {{MODULE_ID}} Server
#'
#'
#' @import shinyBS
#' @import shinydashboardPlus
#' 
{{MODULE_ID}}Server <- function(id)
{
    retModule <- function( input, output, session ){}

    {{ADD_SUBTAB_SERVER}}

    retServer <- moduleServer( strID, module = retModule )
    return( retServer )
}
