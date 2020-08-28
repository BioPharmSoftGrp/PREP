#' Server for Simulation Intro submodule
#'
#' @return moduleServer for intro submodule - currently an empty shell

DataAnalysisIntroServer <- function(){
    strID <- "SimulationIntro"
    retModule <- function( input, output, session ){}
    retServer <- moduleServer( strID, module = retModule )
    return( retServer )
}