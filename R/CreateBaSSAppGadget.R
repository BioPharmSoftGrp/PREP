#' #' @name  CreateBaSSAppGadget
#' #' @title  CreateBaSSAppGadget
#' #' @description {R Studio Gadget to create an application that consists of a Shiny app and a R library package complete with an example testthat unit test.   The Shiny app will reference
#' #' the R library so you should build the R library first before trying to run the Shiny app.  }
#' #'
#' #' @export
#' CreateBaSSAppGadget <- function( )
#' {
#'     strHeight <- "75px"
#'     ui <- miniPage(
#'         gadgetTitleBar("Create BaSS Shiny App", left=miniTitleBarButton("btnExit", label="Exit"), right =miniTitleBarButton("btnCreateProject", label = "Create Project", primary = TRUE)),
#'          HTML( "This Shiny Gadget is intended to help you setup a new project
#'                        that inlcudes an R package for compuation with an example of a testthat unit test,
#'                        a R Shiny app based on the BaSS Template that links
#'                        to the R compuation package that is created. <br><br> "),
#'         fillRow( HTML("<b>Project Directory</b>"), height = "30px" ),
#'         fillRow( fillCol( textInput("txtDirectory", label=NULL, width="300px")), fillCol( actionButton("btnSelectDir","Select Directory"), align ='left', width="100px"), height=strHeight ),
#'         fillRow( textInput( "txtProjectName", "Project Name"), height=strHeight ),
#'         fillRow( textInput( "txtCalculationLibraryName", "Calculation R Library Name"), height=strHeight ),
#'         fillRow( textInput( "txtShinyAppName", "Shiny App Name"), height=strHeight ),
#'         fillRow( textInput( "txtShinyDisplayName", "Shiny App Display Name"), height=strHeight ),
#'         fillRow( HTML("<b>Results</b>"), height = "30px" ),
#'         fillRow( htmlOutput( "htmlOutput"  ), height = "250px")
#'     )
#'
#'     server <- function(input, output, session) {
#'
#'
#'         observeEvent( input$btnSelectDir, {
#'
#'                      strUpdate <- choose.dir()
#'                      updateTextInput( session, "txtDirectory",label = NULL, value=strUpdate )
#'         } )
#'         observeEvent(input$btnCreateProject, {
#'
#'             strPath <- input$txtDirectory
#'             strResult <- CreateGileadApp( strPath, input$txtProjectName, input$txtCalculationLibraryName, input$txtShinyAppName, input$txtShinyDisplayName )
#'
#'             strResult <- gsub( "\\n", "<\\br>", strResult )
#'             output$htmlOutput <- renderText(  strResult  )
#'
#'         })
#'         observeEvent(input$btnExit, {stopApp()})
#'
#'
#'
#'     }
#'
#'     runGadget(ui, server, viewer=paneViewer( minHeight = 750) )#,viewer = dialogViewer("GRApp Gadget", width = 600, height=700), stopOnCancel = FALSE)
#'
#'
#' }
#'
#'
#'
#'
