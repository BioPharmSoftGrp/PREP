
#' Module Server wrapper
#'
#' Starting in Shiny 1.5 the recomdation will be to use a method for definding the server that calls a functionand will include a new function moduleServer that is below instead of use callModule that was in Shiny 1.4  
#' Reference: https://github.com/rstudio/shiny/blob/master/R/modules.R
#' For an example see https://mastering-shiny.org/action-modules.html
#' 
#' @param id 
#' @param module 
#' @param session 
#' 
#' @importFrom shiny callModule
#'
#' @return


moduleServer <- function(id, module, session = getDefaultReactiveDomain()) {
    callModule(module, id, session = session)
}