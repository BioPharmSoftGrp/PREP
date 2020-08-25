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

