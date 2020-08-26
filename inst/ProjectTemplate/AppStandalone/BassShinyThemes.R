BassShinyDashboardThemes <- function( theme )
{

    vAvailableThemes <-  c( "Blue gradient"     = "blue_gradient",
                            "Flat Red   "       = "flat_red",
                            "Grey light"        = "grey_light",
                            "Grey dark"         = "grey_dark",
                            "OneNote"           = "onenote",
                            "Poor man's Flatly" = "poor_mans_flatly",
                            "Purple gradient"   = "purple_gradient"  )
    if( theme %in% vAvailableThemes )
    {
        selectedTheme <- shinyDashboardThemes( theme)
    }
    else   # It was a known theme from the package.
    {
        selectedTheme <- do.call( theme, list() )$theme

    }
    return( selectedTheme )
}


