#' Data Analysis Module - Intro Subtab UI
#'
#' @param strID namespace ID
#' @param strTabName Tab name in sidebar
#'
#' @return tabItem() for run intro subtab of data anlysis module

DataAnalysisIntroUI <- function( strID, strTabName ){
    ns <- NS( strID )
    fldRow <- fluidRow(
        box(
            width = 12,
            title = "Introduction",
            status = "primary",
            solidHeader = TRUE,
            includeMarkdown( "inst/templates/DataAnalysisIntro.Rmd")
        ),
        box(
            width = 12,
            title = "Instructions",
            status = "primary",
            solidHeader = TRUE,
            includeMarkdown( "inst/templates/DataAnalysisInstructions.Rmd")
        )
    )
    
    tabDataAnalysisIntroUI <- tabItem(
        tabName = strTabName,
        fldRow
    )
    
    return( tabDataAnalysisIntroUI )
}

