#' Server for options module
#'
#' @return moduleServer for options module - currently and empty shell

OptionsServer <- function(id="options"){
    retModule <- function( input, output, session ){
        return(
            list(
                theme=OptionsThemeSwitcherServer()
            )
        )
    }
    retServer <- moduleServer( id, module = retModule )
    return( retServer )
}
