BassShinyDashboardThemes <- function( theme )
{

    selectedTheme <- shinyDashboardThemes( theme)
    if( length( selectedTheme ) == 1  )  # It was a known theme from the package.
    {
        selectedTheme <- do.call( theme, list() )$theme

    }
    return( selectedTheme )
}

