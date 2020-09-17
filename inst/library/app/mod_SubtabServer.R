#' {{MODULE_ID}} shiny Server
#'
#' @return {{MODULE_ID}} Server
#'

{{MODULE_ID}}Server <- function(id="{{MODULE_ID}}")
{
    retModule <- function( input, output, session ){}

    retServer <- moduleServer( id, module = retModule )
    return( retServer )
}
