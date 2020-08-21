#' Data Analysis module - Run Analysis submodule UI
#'
#' @param strID namespace id
#' @param strTabName Tab name in sidebar
#'
#' @return tabItem() for run Analysis subtab of data anlysis module

DataAnalysisRunAnalysisUI <- function( strID, strTabName ){
    ns <- NS( strID )
    RunAnalysisButton <- bsButton( ns( "btnRunAnalysis" ), label="Run Analysis", style="success", block=F, size="large")
    fldRow <- fluidRow(
        box( 
            title="Analysis", 
            solidHeader = TRUE,
            width=12, 
            status = "primary",
            tabsetPanel(
                tabPanel(
                    "Input",
                    box( 
                        width="300px",title=NULL,
                        withMathJax(),
                        includeMarkdown( "inst/templates/DataAnalysisRunAnalysisModel.Rmd"),
                        numericInput( inputId = ns("dPostParam1S"), label = "Number of Successes in the Standard Treatment", min = 0.00001, value=1.0),
                        numericInput( inputId = ns("dPostParam2S"), label = "Number of Failures in the Standard Treatment", min = 0.00001, value=3.0),
                        numericInput( inputId = ns("dPostParam1E"), label = "Number of Successes in the Experimental Treatment", min = 0.00001, value=2.0),
                        numericInput( inputId = ns("dPostParam2E"), label = "Number of Failures in the Experimental Treatment", min = 0.00001, value=3.0),
                        numericInput( inputId = ns("dDelta1"), label = "dDelta1", min = 0.0, max=1.0, value=0.0),
                        numericInput( inputId = ns("dDelta2"), label = "dDelta2", min = 0.0, max=1.0, value=0.0),
                        RunAnalysisButton
                    )
                ),
                tabPanel(
                    "Results",
                    box(width=8, title="Computation Results", plotOutput(ns("ctrlDataAnalysisPlot" ))),
                    box("Pr( pe -ps > delta1 ) = ",  textOutput( ns( "txtPrGrtDelta1"))),
                    box( 
                        width=8,
                        downloadButton( ns( "btnWord" ), "Word Report"),
                        downloadButton( ns( "btnPPT" ), "PowerPoint Report") 
                    )
                )
            )
        )
    )
    
    tabDataAnalysisProgramUI <- tabItem(tabName = strTabName, fldRow)
    
    return(tabDataAnalysisProgramUI )
}

#' Data Analysis module - Run Analysis server
#'
#' @import ggplot2
#' @import shinybusy
#' @importFrom shinyBS updateButton
#'
#' @return moduleServer() for run Analysis subtab of data anlysis module

DataAnalysisRunAnalysisServer <- function( ){
    strID <- "DataAnalysisProg"
    retModule <- function( input, output, session ){
        lDataValues <- reactiveValues(dfAll = NULL, lResult = NULL)
        observeEvent( 
            input$btnRunAnalysis ,
            {
                dParam1S <- input$dPostParam1S
                dParam2S <- input$dPostParam2S
                dParam1E <- input$dPostParam1E
                dParam2E <- input$dPostParam2E
                dDelta1  <- input$dDelta1
                dDelta2  <- input$dDelta2
                
                #Don't need the next part just an example of how to display the progress bar
                withProgress(
                    message = 'Analysis in progress',
                    detail = 'This may take a while...', value = 0, 
                    {
                        #Note that the core calculation is contained in the calculation library, which should be tested.
                        lRet <- CalcPosteriorProbsBinom( dParam1S, dParam2S, dParam1E, dParam2E, dDelta1, dDelta2 )
                        for (i in 1:15) {
                            incProgress(1/15)
                            Sys.sleep(0.25)
                        }
                    }
                )
                
                nNum = 10000
                dfDat1 <- data.frame( Group = rep("Std." , nNum), Data = rbeta(nNum, dParam1S, dParam2S) )
                dfDat2 <- data.frame( Group = rep("Exp." , nNum), Data = rbeta(nNum, dParam1E, dParam2E) )
                
                lDataValues$dfAll   <- rbind( dfDat1, dfDat2 )
                lDataValues$lResult <- lRet
                print(lRet)
                updateButton(session, inputId = "btnRunAnalysis" , label="Run Analysis", style = "success",  size="large", disabled = FALSE)
                output$txtPrGrtDelta1 <- renderText( lRet$dPPGrtDelta1 )
            } 
        )

        DrawPlot <- reactive({
            if (!is.null(lDataValues$dfAll)){
                pRet <- ggplot(lDataValues$dfAll, aes(x = Data, fill = Group)) +
                    geom_density(alpha = 0.4)
                return(pRet)
            }
        })

        output$ctrlDataAnalysisPlot <- renderPlot({DrawPlot()})
        output$btnWord <- downloadHandler(
            filename = function() {
                paste0("Word", 'Report.docx')
            },
            content = function(file) {
                dParam1S <- input$dPostParam1S
                dParam2S <- input$dPostParam2S
                dParam1E <- input$dPostParam1E
                dParam2E <- input$dPostParam2E
                dDelta1  <- input$dDelta1
                dDelta2  <- input$dDelta2

                Sys.sleep(0.1)

                show_modal_progress_line(value = 0.2, text = "Downloading ...") # show the modal window
                lRes <- list(
                    allDat = list(p = DrawPlot()),
                    ParaValues = data.frame(Parameters = c(
                        "Successes in Standard",
                        "Failures in Standard",
                        "Successes in Experiment",
                        "Failures in Experiment"
                    ),
                    Values= c(dParam1S, dParam2S, dParam1E, dParam2E)),
                    Version = "0.2",
                    strResult = paste0( "Pr( pe -ps > delta1 ) = ", round(lDataValues$lResult$dPPGrtDelta1, 3) )
                )
                rmarkdown::render('inst/templates/WordOutput.Rmd', output_file = file, params = lRes)
                update_modal_progress(0.9) # update progress bar value
                Sys.sleep(2)
                remove_modal_progress() # remove it when done
            }
        )

        output$btnPPT <- downloadHandler(
            filename = function() {paste0("PPT", 'Report.pptx')},
            content = function(file) {
                dParam1S <- input$dPostParam1S
                dParam2S <- input$dPostParam2S
                dParam1E <- input$dPostParam1E
                dParam2E <- input$dPostParam2E
                dDelta1  <- input$dDelta1
                dDelta2  <- input$dDelta2

                show_modal_progress_line(value = 0.2, text = "Downloading ...") # show the modal window

                lRes <-list(
                    allDat = list(p = DrawPlot()),
                    ParaValues = data.frame(Parameters = c(
                        "Successes in Standard",
                        "Failures in Standard",
                        "Successes in Experiment",
                        "Failures in Experiment"
                    ),
                    Values= c(dParam1S, dParam2S, dParam1E, dParam2E)),
                    Version = "0.2",
                    strResult = paste0( "Pr( pe -ps > delta1 ) = ",  round(lDataValues$lResult$dPPGrtDelta1, 3))
                )
                rmarkdown::render('inst/templates/PowerPointOutput.Rmd', output_file = file, params = lRes)
                update_modal_progress(0.9) # update progress bar value
                Sys.sleep(2)
                remove_modal_progress() # remove it when done
            }
        )
    }
    retServer <- moduleServer( strID, module = retModule )
    return( retServer )
}
