
#' Simulation shiny module UI - Intro subtab
#'
#' @param strID namespace id
#'
#' @return UI for intro subtab of simulation module

SimulationIntroUI <- function(strID){
    ns <- NS( strID )
    fldRow <- fluidRow(
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
        )
    )
    return(fldRow)
}
