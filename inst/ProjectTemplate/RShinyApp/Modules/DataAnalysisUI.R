DataAnalysisUI <- function()
{
    lRet <- list(   DataAnalysisIntroUI( "DataIntroduciton", strTabName = "DataAnalysisIntro" ),
                    DataAnalysisRunAnalysisUI( "DataAnalysisProg", strTabName = "DataAnalysisProgram") )
    return( lRet )

}

DataAnalysisSideBarMenu <- function( )
{
    retMenuItem <- menuItem(
        text    = "Data Analysis",
        tabName = "DataAnalysis",
        icon = icon("calculator"),

        menuSubItem(
            text    = "Introduciton",
            tabName = "DataAnalysisIntro"),

        menuSubItem(
            text    = "Run Analysis",
            tabName = "DataAnalysisProgram")
    )
    return( retMenuItem )
}
