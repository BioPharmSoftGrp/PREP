#' Home Page shiny UI
#'
#' @return home page UI
#'
#'
#' @import shinydashboard
#' @import shinydashboardPlus

HomeUI <- function(  ){
    strID <- "Welcome"
    ns <- NS( strID )
    tWelcomeTabItem <-
        tabItem(
            tabName="Home",
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
        )
    return(tWelcomeTabItem)
}

#' Side bar menu item for home page
#'
#' @importFrom shinydashboard menuItem
#'
#' @return menuItem

HomeSideBarMenu <- function( ){
    retMenuItem <- menuItem(text = "Home", tabName = "Home", icon = icon("home"))
    return( retMenuItem )
}

