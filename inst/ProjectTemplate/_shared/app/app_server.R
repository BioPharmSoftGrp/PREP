#' Overall App Server
#'
#' @param input 
#' @param output 
#' @param session 
#'
#' @return shiny server objects


app_server <- function(input, output,session) {
    # whisker tag to add new module servers
    #{{ADD_MODULE_SERVER}}
    ThemeSwitcherServer()
}
