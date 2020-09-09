###############################################################################################.
# The UI Module is setup with several example code blocks for reference, delete as needed ####
###############################################################################################.

{{TAB_NAME}}UI <- function(  )
{
    strID <- "{{MODULE_ID}}"
    ns <- NS( strID )
    #----- Sidebar Tab: {{MODULE_ID}} -----#
    tTabItem <- tabItem(
        trow =  "{{MODULE_ID}}",
        fluidRow(

            box(

                width = 12,
                title = "ENTER TITLE",
                status = "primary",
                solidHeader = TRUE,

                ###############################################################################################.
                # Example Code 1 - Option 1  Included for a reference, delete as needed ####
                ###############################################################################################.

                accordion(


                    # Accordion items allow one item at a time to be exampnded
                    # This example loads a markdown file from text/HomeAbout.Rmd
                    accordionItem(
                        includeMarkdown("text/HomeAbout.Rmd"),
                        id = ns( "101" ),
                        title = "About This Application",
                        color = "primary"
                    ),

                    # Homepage: Acknowledgements
                    accordionItem(
                        includeMarkdown("text/HomeAcknowledgements.Rmd"),
                        id = ns( "102" ),
                        title = "Acknowledgements",
                        color = "success"
                    )

                )  # End Example Code Option 1



            )

        ),

        ###############################################################################################.
        # Example Code 2 - This example includes a 2 tabs with a progress bar updating (see the server side) ####
        ###############################################################################################.

        fluidRow(
            box( title="Simulation", solidHeader = TRUE,width=12, status = "primary",

                 tabsetPanel(
                     tabPanel("Setup",
                              box( width="300px",title="Trial Design Options",
                                   numericInput( ns( "nN1" ), "Number of Patients on Standard (S): ",     value = 100, max = 1000, step = 5,    min=10),
                                   numericInput( ns( "nN2" ), "Number of Patients on Experimental (E): ", value = 100, max = 1000, step = 5,    min=10)),
                              bsButton( ns( "btnSimulate" ), label="Run Simulation", style="success", block=F, size="large")
                     ),

                     tabPanel("Results",
                              plotOutput( ns( "ctrlPlotOCs" ), height="600px")
                     )
                 )
            )

        ),
        ###############################################################################################.
        # Example Code 3 - This example includes examples of a box ####
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
        ),

        ###############################################################################################.
        # Example Code 4 - This example includes examples of a valueBox ####
        ###############################################################################################.

        fluidRow(
            infoBox(
                "Orders", uiOutput( outputId = ns("orderNum2")), "Subtitle", icon = icon("credit-card")
            ),
            infoBox(
                "Approval Rating", "60%", icon = icon("line-chart"), color = "green",
                fill = TRUE
            ),
            infoBox(
                "Progress", uiOutput( outputId = ns("progress2")), icon = icon("users"), color = "purple"
            ),
            valueBox(
                htmlOutput(outputId = ns( "progress") ), "Progress", icon = icon("users"), color = "purple"
            )
        )


    return(trow)

}
{{TAB_NAME}}SideBarMenu <- function( ){
    #----- Sidebar Tab #1:{{TAB_NAME_WITH_SPACES}} -----####

    retMenuItem <- menuItem(
        text    = "{{TAB_NAME_WITH_SPACES}}",
        tabName = "{{TAB_NAME}}",
        icon    = icon("home")
    )

    return( retMenuItem )
}
