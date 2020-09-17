#' Simulation shiny module UI
#'
#' For complex tabs it may be best to use an approach similar to this tab.   Have functions for each subtab of the tab that each reside in a seperate file. Then create a functionUI that would be the tab and all subtabs, in this example SimulationUI.   This approach keeps the main UI from having to call all subtab module UI functions. Note: for this simple tab  all UI functions for this tab are in this one file but in practice it may be best to seperate each subtab funciton to different files.
#'
#' @import shinydashboard ggplot2 shinyBS
#'
#' @return shiny module
#'

SimulationUI <- function(id="simulation"){
    ns <- NS( id )
    fldRow<-
        fluidRow(
            box(
                width = 12,
                title = "Introduction",
                status = "primary",
                solidHeader = TRUE,
                includeMarkdown( "inst/templates/SimulationIntro.Rmd")
            ),
            box(
                width = 12,
                title = "Instructions",
                status = "primary",
                solidHeader = TRUE,
                includeMarkdown( "inst/templates/SimulationInstructions.Rmd")
            ),
            box(
                width = 12,
                title = "Simulation - Options",
                status = "primary",
                solidHeader = TRUE,

                numericInput( ns( "nN1" ), "Number of Patients on Standard (S): ",     value = 100, max = 1000, step = 5,    min=10),
                numericInput( ns( "nN2" ), "Number of Patients on Experimental (E): ", value = 100, max = 1000, step = 5,    min=10),
                bsButton( ns( "btnSimulate" ), label="Run Simulation", style="success", block=F, size="large")
            ),
            box(
                width = 12,
                title="Simultation - Computation Results",
                status = "primary",
                solidHeader = TRUE,
                plotOutput( ns( "ctrlPlotOCs" )),
                downloadButton( ns( "btnWord" ), "Word Report"),
                downloadButton( ns( "btnPPT" ), "PowerPoint Report")
            )
        )
    
    return(fldRow)
}