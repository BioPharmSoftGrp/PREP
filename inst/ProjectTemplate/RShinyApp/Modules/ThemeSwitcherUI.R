# Ui functions ------------------------------------------------------------
ThemeSwithcherUI <- function(dropDownLabel = "Change Theme", defaultTheme = "grey_light")
{

    # Look in the Themes directory and every file there should contain a theme.
    # This code block will add the new themes.
    vFiles     <- list.files( "./Themes" )
    vNewThemes <- c()
    iFile      <- 1
    for( iFile in 1:length(vFiles ) )
    {
        source( paste( "./Themes/",vFiles[ iFile ], sep="") )
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

ChangeThemeOutputUI <- function()
{
    ns <- NS("ThemeSwitcher")
    themeOutput <- tagList(
        uiOutput(ns("uiChangeTheme"))
    )

    return(themeOutput)
}

