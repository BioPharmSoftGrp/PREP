DataAnalysisIntroUI <- function( strID, strTabName )
{
    
    ns <- NS( strID )
    fldRow <- fluidRow(
        
        box(
            
            width = 12,
            title = "Introduction",
            status = "primary",
            solidHeader = TRUE,
            includeMarkdown( "text/DataAnalysisIntro.Rmd")
        ),
        box(
            
            width = 12,
            title = "Instructions",
            status = "primary",
            solidHeader = TRUE,
            includeMarkdown( "text/DataAnalysisInstructions.Rmd")
            
            
        )
        
    )
    
    tabDataAnalysisIntroUI <- tabItem(
        tabName = strTabName,
        fldRow
    )
    return( tabDataAnalysisIntroUI )
    
    
    
}
