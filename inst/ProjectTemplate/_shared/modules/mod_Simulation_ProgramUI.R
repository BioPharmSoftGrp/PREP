#' Simulation shiny module UI - Program subtab
#'
#' @param strID namespace id
#'
#' @importFrom shinyBS bsButton
#' 
#' @return UI for Program subtab of simulation module

SimulationProgramUI <- function(strID){
    
    ns <- NS( strID )
    btn <- bsButton( ns( "btnSimulate" ), label="Run Simulation", style="success", block=F, size="large")
    fldRow <- fluidRow(
        box( 
            title="Simulation", 
            solidHeader = TRUE,
            width=12, 
            status = "primary",
            tabsetPanel(
                tabPanel(
                    "Setup",
                    box( 
                        width="300px",title="Trial Design Options",
                        numericInput( ns( "nN1" ), "Number of Patients on Standard (S): ",     value = 100, max = 1000, step = 5,    min=10),
                        numericInput( ns( "nN2" ), "Number of Patients on Experimental (E): ", value = 100, max = 1000, step = 5,    min=10)),
                        bsButton( ns( "btnSimulate" ), label="Run Simulation", style="success", block=F, size="large")
                 ),
                tabPanel(
                    "Results",
                    box( 
                        width=8, title="Computation Results",
                        plotOutput( ns( "ctrlPlotOCs" ))),
                        box( 
                            width=8,
                            downloadButton( ns( "btnWord" ), "Word Report"),
                            downloadButton( ns( "btnPPT" ), "PowerPoint Report"
                        ) 
                    )
                )
            )
        )
    )
    return( fldRow )
}
