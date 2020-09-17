#' Home Page shiny UI
#'
#' @return home page UI
#'
#'
#' @import shinydashboard
#' @import shinydashboardPlus

HomeUI <- function(id="home"){
    ns <- NS( id )
    tWelcomerow <-
            fluidRow(
                box(
                    width = 12,
                    title = "About",
                    status = "primary",
                    solidHeader = TRUE,
                    includeMarkdown("inst/templates/HomeAbout.Rmd"),
                    id = 101
                ),
                box(
                    width=12,
                    title="Acknowledgments",
                    status="success",
                    solidHeader= TRUE,
                    includeMarkdown("inst/templates/HomeAcknowledgements.Rmd")
                ),
                box(
                    includeMarkdown("inst/templates/HomeGettingStarted.Rmd"),
                    id = 103,
                    title = "Getting Started",
                    status = "danger",
                    width=12,
                    solidHeader= TRUE,
                )
            )
        
    return(tWelcomerow)
}