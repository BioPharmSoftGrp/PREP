#' Data Analysis Shiny Module UI
#'
#' @return Data analysis module UI

DataAnalysisUI <- function(){
    lRet <- list(  
        DataAnalysisIntroUI( "DataIntroduciton", strTabName = "DataAnalysisIntro" ),
        DataAnalysisRunAnalysisUI( "DataAnalysisProg", strTabName = "DataAnalysisProgram") )
    return( lRet )
}

#' Data Analysis Shiny Module Sidebar items
#'
#' @return shinydashboard::menuItem() for data analysis module

DataAnalysisSideBarMenu <- function( ){
    retMenuItem <- menuItem(
        text = "Data Analysis",
        tabName = "DataAnalysis",
        icon = icon("calculator"),
        menuSubItem(text = "Introduction", tabName = "DataAnalysisIntro"),
        menuSubItem(text = "Run Analysis", tabName = "DataAnalysisProgram")
    )
    return( retMenuItem )
}


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

