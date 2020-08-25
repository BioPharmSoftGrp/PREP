#' Simulation shiny module UI
#'
#' For complex tabs it may be best to use an approach similar to this tab.   Have functions for each subtab of the tab that each reside in a seperate file. Then create a functionUI that would be the tab and all subtabs, in this example SimulationUI.   This approach keeps the main UI from having to call all subtab module UI functions. Note: for this simple tab  all UI functions for this tab are in this one file but in practice it may be best to seperate each subtab funciton to different files.
#'
#' @import shinydashboard
#'
#' @return shiny module
#'

SimulationUI <- function( ){
    tabIntro <-tabItem(
        tabName = "SimulationIntro",
        SimulationIntroUI("SimulationIntro")
    )
    
    tabSimulation <-tabItem(
        tabName = "SimulationProgram",
        SimulationProgramUI("SimulationProgram")
    )
    
    return(list(tabIntro,tabSimulation))
}


#' Simulation shiny module sidebar
#'
#' @return shinydashboard::menuItem() for the simulation module

SimulationSideBarMenu <- function( ){
    retMenuItem <-  menuItem(
        text    = "Simulation",
        tabName = "Simulation",
        icon    = icon("cogs"),
        menuSubItem(
            text = "Introduciton",
            tabName = "SimulationIntro"
        ),
        menuSubItem(
            text = "Program",
            tabName = "SimulationProgram"
        )
    )
    
    return(retMenuItem)
}