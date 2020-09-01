
#' Server for simulation module
#'
#' @return moduleServer for simulation module - currently an empty shell

SimulationServer <- function(){
    strID <- "Simulation"
    retModule <- function( input, output, session){
        SimulationIntroServer()
        SimulationProgramServer()
    }
    retServer <- moduleServer( strID, module = retModule )
    return( retServer )
}
