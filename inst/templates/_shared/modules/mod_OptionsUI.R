
#' Options Module UI
#'
#' @return tabItem() with Option module UI

OptionsUI <- function(id="options"){
    ns    <- NS( id )
    #ChangeThemeOutputUI(ns("ThemeOutput"))
    # Each new option should be created Similar to ThemeSwitcherUI which returns a box with width 4.
    # This will allow 3 options of width = 4 per row.
    fldRow <- fluidRow(OptionsThemeSwithcherUI( ns("themeswitcher"), defaultTheme = "Bold Red"))

    return( fldRow )
}
