#' Simulation shiny module UI
#'
#' For complex tabs it may be best to use an approach similar to this tab.   Have functions for each subtab of the tab that each reside in a seperate file. Then create a functionUI that would be the tab and all subtabs, in this example SimulationUI.   This approach keeps the main UI from having to call all subtab module UI functions. Note: for this simple tab  all UI functions for this tab are in this one file but in practice it may be best to seperate each subtab funciton to different files.
#'
#' @import shinydashboard
#'
#' @return shiny module
#'

SimulationUI <- function( ){
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


#' Simulation shiny module sidebar
#'
#' @return shinydashboard::menuItem() for the simulation module

SimulationSideBarMenu <- function( ){
    retMenuItem <-  menuItem(
        text    = "Simulation",
        tabName = "Simulation",
        icon    = icon("cogs"),
        menuSubItem(
            text = "Introduciton",
            tabName = "SimulationIntro"
        ),
        menuSubItem(
            text = "Program",
            tabName = "SimulationProgram"
        )
    )
    
    return(retMenuItem)
}



#' Simulation shiny module UI - Intro subtab
#'
#' @param strID namespace id
#'
#' @return UI for intro subtab of simulation module

SimulationIntroUI <- function(strID){
    ns <- NS( strID )
    fldRow <- fluidRow(
        box(
            width = 12,
            title = "Introduction",
            status = "primary",
            solidHeader = TRUE,
            includeMarkdown( "inst/templates/SimulationIntro.Rmd")
        ),
        box(
            width = 12,
            title = "Instructions",
            status = "primary",
            solidHeader = TRUE,
            includeMarkdown( "inst/templates/SimulationInstructions.Rmd")
        )
    )
    return(fldRow)
}

#' Simulation shiny module UI - Program subtab
#'
#' @param strID namespace id
#'
#' @importFrom shinyBS bsButton
#' 
#' @return UI for Program subtab of simulation module

SimulationProgramUI <- function(strID){
    
    ns <- NS( strID )
    btn <- bsButton( ns( "btnSimulate" ), label="Run Simulation", style="success", block=F, size="large")
    fldRow <- fluidRow(
        box( 
            title="Simulation", 
            solidHeader = TRUE,
            width=12, 
            status = "primary",
            tabsetPanel(
                tabPanel(
                    "Setup",
                    box( 
                        width="300px",title="Trial Design Options",
                        numericInput( ns( "nN1" ), "Number of Patients on Standard (S): ",     value = 100, max = 1000, step = 5,    min=10),
                        numericInput( ns( "nN2" ), "Number of Patients on Experimental (E): ", value = 100, max = 1000, step = 5,    min=10)),
                        bsButton( ns( "btnSimulate" ), label="Run Simulation", style="success", block=F, size="large")
                 ),
                tabPanel(
                    "Results",
                    box( 
                        width=8, title="Computation Results",
                        plotOutput( ns( "ctrlPlotOCs" ))),
                        box( 
                            width=8,
                            downloadButton( ns( "btnWord" ), "Word Report"),
                            downloadButton( ns( "btnPPT" ), "PowerPoint Report"
                        ) 
                    )
                )
            )
        )
    )
    return( fldRow )
}

#' Simulation Shiny Module Server
#'
#' @import ggplot2
#' @import shinybusy
#' @importFrom shinyBS updateButton
#'
#' @return Shiny module

SimulationProgramServer <- function(){
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
            
            lDataValues$dfAll  <- rbind( dfDat1, dfDat2 )
            updateButton(session, inputId = "btnSimulate" , label="Run Simulation", style = "success",  size="large", disabled = FALSE)
        } )
        
        DrawPlot <- reactive({
            
            if (!is.null(lDataValues$dfAll))
            {
                pRet <- ggplot(lDataValues$dfAll, aes(x = Data, fill = Group)) +
                    geom_density(alpha = 0.4)
                return(pRet)
            }
        })
        
        output$ctrlPlotOCs <- renderPlot({
            DrawPlot()
        } )
        
        
        output$btnWord <- downloadHandler(
            filename = function() { paste0("Word", 'Report.docx') },
            content = function(file) {
                Sys.sleep(0.1)
                show_modal_progress_line(value = 0.2, text = "Downloading ...") # show the modal window
                lRes <- list(
                    allDat = list(p = DrawPlot()),
                    ParaValues = data.frame(
                        Parameters = c("Number of Patients in Group 1","Number of Patients in Group 2" ),
                        Values= c(input$nN1, input$nN2)
                    ),
                    Version = "0.2"
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
                show_modal_progress_line(value = 0.2, text = "Downloading ...")
                lRes <-list(
                    allDat = list(p = DrawPlot()),
                    ParaValues = data.frame(
                        Parameters = c("Number of Patients in Group 1","Number of Patients in Group 2" ),
                        Values= c(input$nN1, input$nN2)
                    ),
                    Version = "0.2"
                )
                rmarkdown::render('inst/templates/PowerPointOutput.Rmd',output_file = file,params = lRes)
                update_modal_progress(0.9) # update progress bar value
                Sys.sleep(2)
                remove_modal_progress() # remove it when done
            }
        )
    }
    
    retServer <- moduleServer( strID, module = retModule )
    return( retServer )
}
