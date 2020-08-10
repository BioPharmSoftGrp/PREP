################################################################################ .
# Description:
################################################################################ .
_TAB_NAME_Server <- function( )
{
    #The strID here must match what is in the UI file.
    strID     <- "_TAB_NAME_"
    retModule <- function( input, output, session ){

        lDataValues <- reactiveValues(dfAll = NULL, dfParas = NULL)


        ConvertParaToString <- function( InputValue )
        {
            return( toString(InputValue) )
        }

        SubsetData <- reactive({

            vParaLabels <- c("Number of cylinders",
                             "Transmission (0 = automatic, 1 = manual)",
                             "Number of forward gears",
                             "Number of carburetors"
                             )

            vParaValues <- c( ConvertParaToString(input$cyl),
                              ConvertParaToString(input$am),
                              ConvertParaToString(input$gear),
                              ConvertParaToString(input$carb)
                            )

            lDataValues$dfParas <- data.frame( Parameters = vParaLabels, Values = vParaValues)

            lDataValues$dfAll <- mtcars[ mtcars$cyl %in% input$cyl &
                                         mtcars$am %in% input$am &
                                         mtcars$gear %in% input$gear&
                                         mtcars$carb %in% input$carb,
                                         ]

        })

        DrawPlot <- function()
        {
            SubsetData()
            dfDat     <- lDataValues$dfAll
            dfDat$cyl <- as.factor(dfDat$cyl)

            if( !is.null(lDataValues$dfAll) )
            {
                plotGraphic <- ggplot(dfDat, aes(x = hp, y = mpg, color = cyl )) +
                    geom_point(size = 5)
                return(plotGraphic)
            }

        }

        # Note that here the name of the controls are just input$XXX and the moduleServer takes care of adding the correct Namespace NS
        output$plotData <- renderPlot({
            DrawPlot()
        })

        output$dtTable = DT::renderDataTable({
            lDataValues$dfAll
        })

        output$btnWord <- downloadHandler(

            filename = function() {
                paste0("Word", 'Report.docx')
            },
            content = function(file) {
                Sys.sleep(0.1)

                show_modal_progress_line(value = 0.2, text = "Downloading ...") # show the modal window

                lRes <-
                    list(
                        allDat = list(p = DrawPlot()),
                        ParaValues = lDataValues$dfParas,
                        Version = "0.2",
                        SelectedData = lDataValues$dfAll
                    )

                rmarkdown::render('Templates/_TAB_NAME_Word.Rmd',
                                  output_file = file,
                                  params = lRes)
                update_modal_progress(0.9) # update progress bar value
                Sys.sleep(2)
                remove_modal_progress() # remove it when done

            }
        )


        output$btnDownloadData <- downloadHandler(
            filename = function() {
                paste0("SelectedData.csv")
            },
            content = function(file) {
                show_modal_progress_line(value = 0.2, text = "Downloading ...") # show the modal window
                write.csv(lDataValues$dfAll, file)
                update_modal_progress(0.9) # update progress bar value
                Sys.sleep( 2 )
                remove_modal_progress() # remove it when done
            }
        )


        output$btnPPT <- downloadHandler(
            filename = function() {
                paste0("PPT", 'Report.pptx')
            },
            content = function(file) {

                Sys.sleep(0.1)
                show_modal_progress_line(value = 0.2, text = "Downloading ...") # show the modal window
                lRes <-
                    list(
                        allDat = list(p = DrawPlot()),
                        ParaValues = lDataValues$dfParas,
                        Version = "0.2",
                        SelectedData = lDataValues$dfAll
                    )

                rmarkdown::render('Templates/_TAB_NAME_PPT.Rmd',
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
