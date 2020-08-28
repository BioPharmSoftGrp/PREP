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
    tWelcomeTabItem <- tabItem(
        tabName =  "Home",
        fluidRow(

            box(

                width = 12,
                title = "Welcome!",
                status = "primary",
                solidHeader = TRUE,

                accordion(

                    # Homepage: About This Application
                    accordionItem(
                        includeMarkdown("inst/templates/HomeAbout.Rmd"),
                        id = 101,
                        title = "About This Application",
                        color = "primary",
                        collapsed = FALSE
                    ),

                    # Homepage: Acknowledgements
                    accordionItem(
                        includeMarkdown("inst/templates/HomeAcknowledgements.Rmd"),
                        id = 102,
                        title = "Acknowledgements",
                        color = "success"
                    ),

                    # Homepage: Getting Started
                    accordionItem(
                        includeMarkdown("inst/templates/HomeGettingStarted.Rmd"),
                        id = 103,
                        title = "Getting Started",
                        color = "danger"
                    )

                )

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

