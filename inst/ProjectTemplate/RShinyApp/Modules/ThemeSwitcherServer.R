
# Server functions --------------------------------------------------------
ThemeSwitcherServer <- function( )
{

    retModule <- function( input, output, session ){

        observeEvent(
            input$dbxChangeTheme,
            {
                output$uiChangeTheme <- renderUI({
                    BassShinyDashboardThemes(theme = input$dbxChangeTheme)
                })
            }
        )
    }

    retServer <- moduleServer( "ThemeSwitcher", module = retModule )
    return( retServer )
}
