###############################################################################################.
# The UI Module is setup with several example code blocks for reference, delete as needed ####
###############################################################################################.

{{TAB_NAME}}UI <- function(  )
{
    strID <- "{{TAB_NAME}}"
    ns <- NS( strID )
    strNames <- setdiff(names(mtcars), "Features")
    #----- Sidebar Tab: ResultViewer -----#
    tTabItem <- tabItem(
        tabName =  "{{TAB_NAME}}",
        fluidRow(

            box(

                width = 12,
                title = "Clustering of Data mtcars",
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
        # Example Code 2 - This example includes the data selector and the plot for the result viewer ####
        ###############################################################################################.

        fluidRow(
            fluidRow(
                box(
                    selectInput(inputId = ns( 'xVar' ), 'X Variable', strNames, selected = "wt"),
                    selectInput(inputId = ns( 'yVar' ), 'Y Variable', strNames, selected = "mpg"),
                    numericInput(inputId = ns( 'nClusters' ), 'Number of Clusters', 4, min = 1, max = 9)
                )

            ),

            fluidRow(
                box(
                    title = "Clustering of the Selected Variables Using KMeans",
                    plotOutput( outputId = ns("plotCluster")), width = 8)

            ),

            fluidRow(
                box(
                    title = "Heatmap Plot",
                    plotOutput( outputId = ns("plotHeatmap")), width = 8)

            ),

            # verbatimTextOutput( outputId = ns( "info" ) ),

            tags$br(),

        ),

        fluidRow(
            box(title = "Data of mtcars",
                DT::dataTableOutput(ns( "dtTable" ) ), width = 8)

        )

    )
    return(tTabItem)

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
