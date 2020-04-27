_TAB_NAME_UI <- function()
{
    lRet <-  list( _ADD_CALLS_TO_UI_TABS_   )
    return( lRet )

}

_TAB_NAME_SideBarMenu <- function( )
{
    retMenuItem <- menuItem(
        text    = "_TAB_NAME_WITH_SPACES_",
        tabName = "_TAB_NAME_",
        icon = icon("calculator"),

        _ADD_CALLS_TO_SIDE_BAR_MENU_
    )
    return( retMenuItem )
}

