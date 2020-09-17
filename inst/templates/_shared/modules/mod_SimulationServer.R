
#' Server for simulation module
#'
#' @return moduleServer for simulation module - currently an empty shell

SimulationServer <- function(id="simulation"){
    retModule <- function( input, output, session){
        lDataValues <- reactiveValues(dfAll = NULL)
        
        observeEvent( input$btnSimulate , {
            
            updateButton( session, inputId= "btnSimulate", label="Simulations Running", style = "danger",  size="large", disabled = TRUE)
            
            #Don't need the next part just an example of how to display the progress bar
            withProgress(message = 'Calculation in progress',
                         detail = 'This may take a while...', value = 0, {
                             for (i in 1:15) {
                                 incProgress(1/15)
                                 Sys.sleep(0.25)
                             }
                         })
            dfDat1 <- data.frame( Group = rep("Group 1" , input$nN1), Data = rnorm( input$nN1, mean = 0, sd = 1) )
            dfDat2 <- data.frame( Group = rep("Group 2" , input$nN2), Data = rnorm( input$nN2, mean = 2, sd = 1) )
            
            lDataValues$dfAll  <- rbind( dfDat1, dfDat2 )
            updateButton(session, inputId = "btnSimulate" , label="Run Simulation", style = "success",  size="large", disabled = FALSE)
        } )
        
        DrawPlot <- reactive({
            
            if (!is.null(lDataValues$dfAll))
            {
                pRet <- ggplot(lDataValues$dfAll, aes(x = Data, fill = Group)) +
                    geom_density(alpha = 0.4)
                return(pRet)
            }
        })
        
        output$ctrlPlotOCs <- renderPlot({
            DrawPlot()
        } )
        
        
        output$btnWord <- downloadHandler(
            filename = function() { paste0("Word", 'Report.docx') },
            content = function(file) {
                lRes <- list(
                    allDat = list(p = DrawPlot()),
                    ParaValues = data.frame(
                        Parameters = c("Number of Patients in Group 1","Number of Patients in Group 2" ),
                        Values= c(input$nN1, input$nN2)
                    ),
                    Version = "0.2"
                )
                rmarkdown::render('inst/templates/WordOutput.Rmd', output_file = file, params = lRes)
            }
        )
        
        output$btnPPT <- downloadHandler(
            filename = function() {paste0("PPT", 'Report.pptx')},
            content = function(file) {
                lRes <-list(
                    allDat = list(p = DrawPlot()),
                    ParaValues = data.frame(
                        Parameters = c("Number of Patients in Group 1","Number of Patients in Group 2" ),
                        Values= c(input$nN1, input$nN2)
                    ),
                    Version = "0.2"
                )
                rmarkdown::render('inst/templates/PowerPointOutput.Rmd',output_file = file,params = lRes)            
            }
        )
    }
    retServer <- moduleServer( id, module = retModule )
    return( retServer )
}

