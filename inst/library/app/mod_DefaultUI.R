#' {{MODULE_ID}} shiny UI
#'
#' @return {{MODULE_ID}} UI
#'
#' @import shinyBS
#' @import shinydashboardPlus
#'

{{MODULE_ID}}UI <- function(  )
{
    strID <- "{{MODULE_ID}}"
    ns <- NS( strID )
    #----- Sidebar Tab: {{MODULE_ID}} -----#
    ui_div <-
    div(
        fluidRow(
            box(
                width = 12,
                title = "ENTER TITLE",
                status = "primary",
                solidHeader = TRUE,

                span("[Summary text goes here]")

                )  # End Example Code Option 1
            ),


        ###############################################################################################.
        # Example Code 2 - This example includes examples of a box ####
        ###############################################################################################.

        fluidRow(
            box(status = "primary",
                sliderInput( inputId =  ns( "orders" ), "Orders", min = 1, max = 2000, value = 650),
                selectInput( inputId =  ns( "progress" ), "Progress",
                            choices = c("0%" = 0, "20%" = 20, "40%" = 40, "60%" = 60, "80%" = 80,
                                        "100%" = 100)
                )
            ),
            box(title = "Histogram box title",
                status = "warning", solidHeader = TRUE, collapsible = TRUE,
                plotOutput( outputId =  ns( "plot" ), height = 250)
            )
        )
    )

    return(ui_div)
}
