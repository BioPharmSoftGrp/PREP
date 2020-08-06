###############################################################################################.
# The UI Module is setup with several example code blocks for reference, delete as needed ####
###############################################################################################.

_TAB_NAME_UI <- function(  )
{
    strID <- "_TAB_NAME_"
    ns <- NS( strID )
    #----- Sidebar Tab: ResultViewer -----#
    tTabItem <- tabItem(
        tabName =  "_TAB_NAME_",
        fluidRow(

            box(

                width = 12,
                title = "Result Viewer",
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
                 box( checkboxGroupInput( inputId = ns( "cyl" ),            label = "Number of cylinders", choices=sort( unique( mtcars$cyl )), selected=sort( unique( mtcars$cyl )) ), width = 3),

                 box( checkboxGroupInput( inputId = ns( "am" ),             label = "Transmission", choices=sort( unique( mtcars$am )), selected=sort( unique( mtcars$am ))), width = 3),
                 bsTooltip(id=ns("am"), " (0 = automatic, 1 = manual)"),
                 box( checkboxGroupInput( inputId = ns( "gear" ),           label = "Number of forward gears", choices=sort( unique( mtcars$gear )), selected=sort( unique( mtcars$gear )) ), width = 3),
                 box( checkboxGroupInput( inputId = ns( "carb" ),          label = "Number of carburetors", choices=sort( unique(mtcars$carb)), selected=sort( unique( mtcars$carb ) ) ), width = 3)
            ),



            fluidRow(
                box(
                    downloadButton( ns('btnWord'), 'Download Word Report'),
                    downloadButton( ns('btnPPT'), 'Download PowerPoint Report'),
                    downloadButton( ns('btnDownloadData'), 'Download Selected Data'),
                    width = 8)
            ),

            fluidRow(
                box(
                    title = "Plot of Selected Results",
                    plotOutput( outputId = ns( "plotData")), width = 8)
            ),


            # verbatimTextOutput( outputId = ns( "info" ) ),

            tags$br(),

        ),
        ###############################################################################################.
        # Example Code 3 - This example includes examples of a box ####
        ###############################################################################################.

        fluidRow(
            box(title = "Data of Selected Results",
                DT::dataTableOutput(ns( "dtTable" ) ), width = 8)

        )

    )
    return(tTabItem)

}
_TAB_NAME_SideBarMenu <- function( ){
    #----- Sidebar Tab #1:_TAB_NAME_WITH_SPACES_ -----####

    retMenuItem <- menuItem(
        text    = "_TAB_NAME_WITH_SPACES_",
        tabName = "_TAB_NAME_",
        icon    = icon("home")
    )

    return( retMenuItem )
}
