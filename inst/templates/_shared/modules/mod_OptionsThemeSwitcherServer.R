#' Theme Switcher Module Server
#'
#' @return moduleServer() for theme switcher module

OptionsThemeSwitcherServer <- function( ){
    BassShinyDashboardThemes <- function(theme){
        vAvailableThemes <-  c( "Blue gradient"     = "blue_gradient",
                                "Flat Red   "       = "flat_red",
                                "Grey light"        = "grey_light",
                                "Grey dark"         = "grey_dark",
                                "OneNote"           = "onenote",
                                "Poor man's Flatly" = "poor_mans_flatly",
                                "Purple gradient"   = "purple_gradient"  )
        if( theme %in% vAvailableThemes ) {
            selectedTheme <- shinyDashboardThemes( theme)
        } else {
            selectedTheme <- do.call( theme, list() )$theme    # It was a known theme from the package.
        }
        return( selectedTheme )
    }

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
