
################################################################################ .
# Description:
################################################################################ .
#SimulationProgram <- function( input, output, session, id2 )
SimulationProgramServer <- function(  )
{

    strID <- "SimulationProgram"
    retModule <- function( input, output, session ){
        observeEvent( input$btnSimulate ,{

            updateButton( session, inputId= "btnSimulate", label="Simulations Running", style = "danger",  size="large", disabled = TRUE)

            #Don't need the next part just an example of how to display the progress bar
            withProgress(message = 'Calculation in progress',
              detail = 'This may take a while...', value = 0, {
                 for (i in 1:15) {
                     incProgress(1/15)
                     Sys.sleep(0.25)
                 }
              })
            x1<- rnorm( input$nN1 )
            updateButton(session, inputId = "btnSimulate" , label="Run Simulation", style = "success",  size="large", disabled = FALSE)
            output$ctrlPlotOCs <- renderPlot({ plot( density( x1 ), type='l', main=paste("N = ", input$nN1,sep="") ) } )

        } )
    }



    retServer <- moduleServer( strID, module = retModule )
    return( retServer )
}

