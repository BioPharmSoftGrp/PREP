
################################################################################ .
# Description:
################################################################################ .
#SimulationProgram <- function( input, output, session, id2 )
# SimulationProgramServer <- function(  )
# {
#
#     strID <- "SimulationProgram"
#     retModule <- function( input, output, session ){
#         observeEvent( input$btnSimulate ,{
#
#             updateButton( session, inputId= "btnSimulate", label="Simulations Running", style = "danger",  size="large", disabled = TRUE)
#
#             #Don't need the next part just an example of how to display the progress bar
#             withProgress(message = 'Calculation in progress',
#               detail = 'This may take a while...', value = 0, {
#                  for (i in 1:15) {
#                      incProgress(1/15)
#                      Sys.sleep(0.25)
#                  }
#               })
#             x1<- rnorm( input$nN1 )
#             updateButton(session, inputId = "btnSimulate" , label="Run Simulation", style = "success",  size="large", disabled = FALSE)
#             output$ctrlPlotOCs <- renderPlot({ plot( density( x1 ), type='l', main=paste("N = ", input$nN1,sep="") ) } )
#
#         } )
#     }
#
#
#
#     retServer <- moduleServer( strID, module = retModule )
#     return( retServer )
# }

SimulationProgramServer <- function(  )
{

    strID <- "SimulationProgram"
    retModule <- function( input, output, session ){
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

            # browser()
            # Sys.sleep(1)
            lDataValues$dfAll  <- rbind( dfDat1, dfDat2 )
            updateButton(session, inputId = "btnSimulate" , label="Run Simulation", style = "success",  size="large", disabled = FALSE)
        } )

        DrawPlot <- reactive({

            if (!is.null(lDataValues$dfAll))
            {
                # pRet <- ggplot(lDataValues$dfAll, aes(x = Data))+
                #     geom_density(color="darkblue", fill="lightblue") + ggtitle( paste("Number of Data Points = ", input$nN1 + input$nN2 ,sep="") )
                # print(lDataValues$dfAll)
                pRet <- ggplot(lDataValues$dfAll, aes(x = Data, fill = Group)) +
                    geom_density(alpha = 0.4)
                return(pRet)
            }
        })

        output$ctrlPlotOCs <- renderPlot({
            DrawPlot()
            ##plot( density( x1 ), type='l', main=paste("N = ", input$nN1,sep="") )
        } )


        output$btnWord <- downloadHandler(
            filename = function() {
                paste0("Word", 'Report.docx')
            },
            content = function(file) {

                #DisableDownload()

                Sys.sleep(0.1)
                #EnableDownload()
                #
                # shiny::withProgress(
                #     message = paste0("Downloading", input$dataset, " Data"),
                #     value = 0,
                #     {
                #         shiny::incProgress(1/10)
                #         Sys.sleep(1)
                #         shiny::incProgress(5/10)
                #
                #         lReport <- GetReportData()
                #         rmarkdown::render('WordOutput.Rmd',
                #                           output_file = file,
                #                           params = lReport)
                #
                #     }
                # )
                #


                show_modal_progress_line(value = 0.2, text = "Downloading ...") # show the modal window
                # update_modal_progress(0.2) # update progress bar value
                # Sys.sleep(0.2)

                lRes <-
                    list(
                        allDat = list(p = DrawPlot()),
                        ParaValues = data.frame(Parameters = c("Number of Patients in Group 1",
                                                               "Number of Patients in Group 2" ),
                                                Values= c(input$nN1, input$nN2)),
                        Version = "0.2"
                    )
                rmarkdown::render('Templates/WordOutput.Rmd',
                                  output_file = file,
                                  params = lRes)
                update_modal_progress(0.9) # update progress bar value
                Sys.sleep(2)
                remove_modal_progress() # remove it when done

                #shinyjs::enable("downloadWordRpt")

            }
        )

        output$btnPPT <- downloadHandler(
            filename = function() {
                paste0("PPT", 'Report.pptx')
            },
            content = function(file) {

                # #DisableDownload()
                # shiny::withProgress(
                #     message = paste0("Downloading", input$dataset, " Data"),
                #     value = 0,
                #     {
                #         shiny::incProgress(1/10)
                #         Sys.sleep(1)
                #         shiny::incProgress(5/10)
                #         lReport <- GetReportData()
                #         rmarkdown::render('PowerPointOutput.Rmd',
                #                           output_file = file,
                #                           params = lReport)
                #
                #     }
                # )
                #EnableDownload()

                show_modal_progress_line(value = 0.2, text = "Downloading ...") # show the modal window
                # update_modal_progress(0.2) # update progress bar value
                # Sys.sleep(0.2)
                lRes <-
                    list(
                        allDat = list(p = DrawPlot()),
                        ParaValues = data.frame(Parameters = c("Number of Patients in Group 1",
                                                               "Number of Patients in Group 2" ),
                                                Values= c(input$nN1, input$nN2)),
                        Version = "0.2"
                    )
                rmarkdown::render('Templates/PowerPointOutput.Rmd',
                                  output_file = file,
                                  params = lRes)
                update_modal_progress(0.9) # update progress bar value
                Sys.sleep(2)
                remove_modal_progress() # remove it when done

            }
        )
    }



    retServer <- moduleServer( strID, module = retModule )
    return( retServer )
}
