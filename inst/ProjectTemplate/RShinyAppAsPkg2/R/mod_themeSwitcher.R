#' Theme switcher module UI
#'
#' @param dropDownLabel 
#' @param defaultTheme 
#'
#' @return UI for theme selector

ThemeSwithcherUI <- function(dropDownLabel = "Change Theme", defaultTheme = "grey_light"){

    # Look in the Themes directory and every file there should contain a theme.
    # This code block will add the new themes.
    vFiles     <- list.files( "inst/themes" )
    vNewThemes <- c()
    iFile      <- 1
    for( iFile in 1:length(vFiles ) )
    {
        source( paste( "inst/themes/",vFiles[ iFile ], sep="") )
        strFileName <- vFiles[ iFile ]
        strFileName <- substr( strFileName, 1, nchar( strFileName ) - 2 ) # Drop the .R
        vNewThemes  <- c( vNewThemes, do.call( strFileName, list() )$ddlItem )
    }


    # Add the existing themes to the list
    changeThemeChoices <- c(vNewThemes,
                            "Blue gradient"     = "blue_gradient",
                            "Flat Red   "       = "flat_red",
                            "Grey light"        = "grey_light",
                            "Grey dark"         = "grey_dark",
                            "OneNote"           = "onenote",
                            "Poor man's Flatly" = "poor_mans_flatly",
                            "Purple gradient"   = "purple_gradient"    )

    #Build the UI components
    ns <- NS("ThemeSwitcher")
    ddlTheme <- tagList(
        selectizeInput(
            inputId = ns("dbxChangeTheme"),
            label = dropDownLabel,
            choices = changeThemeChoices,
            selected = defaultTheme
        )
    )

    retBox   <- box( title  = "Theme Selection", solidHeader = TRUE,
                     width  = 4,
                     status = "primary",
                     "This section allows you to change the color of the application by selecting a theme from below. ",
                     ddlTheme )

    return( retBox )
}

#' Theme Switcher - theme css tags to be added to the overall app
#'
#' @return theme tags

ChangeThemeOutputUI <- function(){
    ns <- NS("ThemeSwitcher")
    themeOutput <- tagList(
        uiOutput(ns("uiChangeTheme"))
    )
    return(themeOutput)
}


#' Theme Switcher Module Server
#'
#' @return moduleServer() for theme switcher module

ThemeSwitcherServer <- function( ){
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

