
#' Options Module UI
#'
#' @return tabItem() with Option module UI

OptionsUI <- function(){
    strID <- "Options"
    ns    <- NS( strID )
    ChangeThemeOutputUI(ns("ThemeOutput"))
    # Each new option should be created Similar to ThemeSwitcherUI which returns a box with width 4.
    # This will allow 3 options of width = 4 per row.
    fldRow <- fluidRow(OptionsThemeSwithcherUI( ns("ThemeSwitcher"), defaultTheme = "Bold Red"))

    return( fldRow )
}

#' Option Sidebar Item
#'
#' @return menuItem() for Options module

OptionsSideBarMenu <- function( ){
    retMenuItem <-   menuItem(text = "Options", tabName = "Options", icon = icon("gear"))
    return( retMenuItem )
}

