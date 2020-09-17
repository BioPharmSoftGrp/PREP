#' {{MODULE_ID}} shiny UI
#'
#' @return {{MODULE_ID}} UI
#'
#' @import shinyBS
#' @import shinydashboardPlus
#'
{{MODULE_ID}}UI <- function(  )
{
    lRet <-  list( {{ADD_SUBTAB_UI}}   )
    return( lRet )
}

#' {{MODULE_ID}} sidebar UI
#'
#' @return {{MODULE_ID}} sidebar UI
#'
#' @import shinyBS
#' @import shinydashboardPlus
#'

{{MODULE_ID}}SideBarMenu <- function( )
{
    retMenuItem <- menuItem(
        text    = "{{MODULE_ID}}",
        tabName = "{{MODULE_ID}}",
        icon = icon("calculator"),

        {{ADD_SUBTAB_SIDEBAR}}
    )
    return( retMenuItem )
}

