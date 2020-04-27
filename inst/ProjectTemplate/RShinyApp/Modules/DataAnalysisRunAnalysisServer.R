

DataAnalysisRunAnalysisServer <- function( )
{
    strID <- "DataAnalysisProg"
    retModule <- function( input, output, session ){
        observeEvent( input$btnRunAnalysis ,{

            #ns <- NS( strID )
            #strBtnID <- paste( id2, "-btnRunAnalysis", sep="")  # For some reason the updateButton Does not work without prefixing the ID

            dParam1S <- input$dPostParam1S
            dParam2S <- input$dPostParam2S
            dParam1E <- input$dPostParam1E
            dParam2E <- input$dPostParam2E
            dDelta1  <- input$dDelta1
            dDelta2  <- input$dDelta2

            #Don't need the next part just an example of how to display the progress bar
            withProgress(message = 'Analysis in progress',
                         detail = 'This may take a while...', value = 0, {
                             #Note that the core calculation is contained in the library, which should be tested.
                             lRet <- CalcPosteriorProbsBinom( dParam1S, dParam2S, dParam1E, dParam2E, dDelta1, dDelta2 )
                             for (i in 1:15) {
                                 incProgress(1/15)
                                 Sys.sleep(0.25)
                             }

                         })
            x1<- rnorm( 100 )
            updateButton(session, inputId = "btnRunAnalysis" , label="Run Analysis", style = "success",  size="large", disabled = FALSE)
            output$ctrlDataAnalysisPlot <- renderPlot({ plot( density( x1 ), type='l', main=paste("Analysis Results", input$nN1,sep="") ) } )
            output$txtPrGrtDelta1 <- renderText( lRet$dPPGrtDelta1 )
        } )
    }

    retServer <- moduleServer( strID, module = retModule )
    return( retServer )



}
