
#' Function to intialize shiny app
#' 
#' @import shiny
#' @import shinydashboard
#' 
#' @export

run_app <- function() {
    app <- shinyApp(
        ui = app_ui,
        server = app_server
    )
    shiny::runApp(app, launch.browser=TRUE)

}
