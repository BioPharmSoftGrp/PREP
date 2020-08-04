

DataAnalysisRunAnalysisUI <- function( strID, strTabName )
{

    ns <- NS( strID )
    RunAnalysisButton <- bsButton( ns( "btnRunAnalysis" ), label="Run Analysis", style="success", block=F, size="large")
    fldRow <- fluidRow(
        box( title="Analysis", solidHeader = TRUE,width=12, status = "primary",

        tabsetPanel(
            tabPanel("Input",
                     box( width="300px",title=NULL,
                          withMathJax(),
                          includeMarkdown( "text/DataAnalysisRunAnalysisModel.Rmd"),
                          numericInput( inputId = ns("dPostParam1S"), label = "dPostParam1S", min = 0.00001, value=1.0),
                          numericInput( inputId = ns("dPostParam2S"), label = "dPostParam2S", min = 0.00001, value=3.0),
                          numericInput( inputId = ns("dPostParam1E"), label = "dPostParam1E", min = 0.00001, value=2.0),
                          numericInput( inputId = ns("dPostParam2E"), label = "dPostParam2E", min = 0.00001, value=3.0),
                          numericInput( inputId = ns("dDelta1"), label = "dDelta1", min = 0.0, max=1.0, value=0.0),
                          numericInput( inputId = ns("dDelta2"), label = "dDelta2", min = 0.0, max=1.0, value=0.0),
                          RunAnalysisButton
                        )
                    ),

            tabPanel("Results",
                     box( width=8, title="Computation Results",
                          plotOutput( ns( "ctrlDataAnalysisPlot"  ))),
                     box( "Pr( pe -ps > delta1 ) = ",  textOutput( ns( "txtPrGrtDelta1") ) ),
                     box( width=8,
                          downloadButton( ns( "btnWord" ), "Word Report"),
                          downloadButton( ns( "btnPPT" ), "PowerPoint Report") )
            )

        )
        )

    )

    tabDataAnalysisProgramUI <- tabItem( tabName = strTabName,
                                         fldRow )


    return( tabDataAnalysisProgramUI )



}
