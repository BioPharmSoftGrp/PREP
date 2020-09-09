
#' Function to intialize shiny app
#'
#' @import shiny
#' @import shinydashboard
#'
#' @export

RunApp <- function() {
    app <- shinyApp(
        ui =  {
            # Set up aliases for /inst folder
            addResourcePath("www", 'inst/www')
            addResourcePath("templates", 'inst/templates')
            addResourcePath("themes", 'inst/themes')
            app_ui()
        },
        server = app_server
    )
    shiny::runApp(app, launch.browser=TRUE)

}
