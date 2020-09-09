#' {{MODULE_ID}} shiny Server
#'
#' @return {{MODULE_ID}} Server
#'
#'
#' @import shinyBS
#' @import shinydashboardPlus
#'
{{MODULE_ID}}Server <- function( )
{
    #The strID here must match what is in the UI file.
    strID     <- "{{MODULE_ID}}"
    retModule <- function( input, output, session ){

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
