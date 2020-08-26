#' Overall App Server
#'
#' @param input 
#' @param output 
#' @param session 
#'
#' @return shiny server objects


app_server <- function(input, output,session) {
    SimulationProgramServer()
    DataAnalysisRunAnalysisServer()
    FeedbackServer()
    ThemeSwitcherServer()
    # _ADD_NEW_TAB_SERVER_ #
    # Include the TAG for use with the AddNewTabToApp Function - if the previous line is removed the AddNewTabToApp will not correctly add the server command
}
