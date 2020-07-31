# For complex tabs it may be best to use an approach similar to this tab.   Have functions for each subtab of the tab that each reside in a seperate file.
# Then create a functionUI that would be the tab and all subtabs, in this example SimulationUI.   This approach keeps the main UI from having to call
# all subtab module UI functions.
# Note: for this simple tab  all UI functions for this tab are in this one file but in practice it may be best to seperate each subtab funciton to different files.

SimulationUI <- function( )
{
    tabIntro <-tabItem(
            tabName = "SimulationIntro",
            SimulationIntroUI("SimulationIntro")


        )

      tabSimulation <-tabItem(
            tabName = "SimulationProgram",
            SimulationProgramUI("SimulationProgram")
        )


    return(list(tabIntro,tabSimulation))


}

SimulationSideBarMenu <- function( )
{

      retMenuItem <-  menuItem(
                        text    = "Simulation",
                        tabName = "Simulation",
                        icon    = icon("cogs"),
                            menuSubItem(
                              text = "Introduciton",
                              tabName = "SimulationIntro"),

                            menuSubItem(
                              text = "Program",
                              tabName = "SimulationProgram")
                      )
      return( retMenuItem )
}


SimulationIntroUI <- function( strID )
{

    ns <- NS( strID )
    fldRow <- fluidRow(

        box(

            width = 12,
            title = "Introduction",
            status = "primary",
            solidHeader = TRUE,
            includeMarkdown( "text/SimulationIntro.Rmd")
        ),
        box(

            width = 12,
            title = "Instructions",
            status = "primary",
            solidHeader = TRUE,
            includeMarkdown( "text/SimulationInstructions.Rmd")


        )

    )
    return( fldRow )



}

SimulationProgramUI <- function( strID )
{

    ns <- NS( strID )
    btn <- bsButton( ns( "btnSimulate" ), label="Run Simulation", style="success", block=F, size="large")
    #print( paste( btn$attribs$id))
    fldRow <- fluidRow(
        box( title="Simulation", solidHeader = TRUE,width=12, status = "primary",

        tabsetPanel(
            tabPanel("Setup",
                     box( width="300px",title="Trial Design Options",
                          numericInput( ns( "nN1" ), "Number of Patients on Standard (S): ",     value = 100, max = 1000, step = 5,    min=10),
                          numericInput( ns( "nN2" ), "Number of Patients on Experimental (E): ", value = 100, max = 1000, step = 5,    min=10)),
                          bsButton( ns( "btnSimulate" ), label="Run Simulation", style="success", block=F, size="large")
            ),

            tabPanel("Results",
                     box( width="300px",title="Computation Results",
                          plotOutput( ns( "ctrlPlotOCs" ), height="600px"),
                          downloadButton( ns( "btnWord" ), "Word Report"),
                          downloadButton( ns( "btnPPT" ), "PowerPoint Report") )
            )
        )
        )

    )



    return( fldRow )



}

