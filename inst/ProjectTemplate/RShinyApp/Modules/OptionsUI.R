
OptionsUI <- function(  )
{
    strID <- "Options"
    ns    <- NS( strID )

    # Each new option should be created imilar to ThemeSwitcherUI which returns a box with width 4.
    # This will allow 3 options of width = 4 per row.
    fldRow <- fluidRow(
        ThemeSwithcherUI( defaultTheme = "Bold Red")
    )

    tabOptions<- tabItem(
        tabName = strID,
        fldRow
    )

    return( tabOptions )
}

OptionsSideBarMenu <- function( )
{
    retMenuItem <-   menuItem(
                        text = "Options",
                        tabName = "Options",
                        icon = icon("gear")
                    )
    return( retMenuItem )
}
