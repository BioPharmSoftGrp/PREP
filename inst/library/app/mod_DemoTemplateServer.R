#' {{MODULE_ID}} shiny Server
#'
#' @return {{MODULE_ID}} Server
#'
#'
#' @import shinyBS
#' @import shinydashboardPlus
#' 
{{MODULE_ID}}Server <- function( id="{{MODULE_ID}}")
{

    retModule <- function( input, output, session ){


        ## Enter any observer events here  - The code block provides an example using a progress updater
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

        output$orderNum <- renderText({
            prettyNum(input$orders, big.mark=",")
        })

        output$orderNum2 <- renderText({
            prettyNum(input$orders, big.mark=",")
        })

        output$progress <- renderUI({
            tagList(input$progress, tags$sup(style="font-size: 20px", "%"))
        })

        output$progress2 <- renderUI({
            paste0(input$progress, "%")
        })

        output$status <- renderText({
            paste0("There are ", input$orders,
                   " orders, and so the current progress is ", input$progress, "%.")
        })

        output$status2 <- renderUI({
            iconName <- switch(input$progress,
                               "100" = "ok",
                               "0" = "remove",
                               "road"
            )
            p("Current status is: ", icon(iconName, lib = "glyphicon"))
        })


        # Note that here the name of the controls are just input$XXX and the moduleServer takes care of adding the correct Namespace NS
        output$plot <- renderPlot({
            hist(rnorm(input$orders))
        })
    }

    retServer <- moduleServer( strID, module = retModule )
    return( retServer )
}
