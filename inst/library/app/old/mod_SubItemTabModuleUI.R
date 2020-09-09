{{TAB_NAME}}UI <- function()
{
    lRet <-  list( {{ADD_CALLS_TO_UI_TABS}}   )
    return( lRet )

}

{{TAB_NAME}}SideBarMenu <- function( )
{
    retMenuItem <- menuItem(
        text    = "{{TAB_NAME_WITH_SPACES}}",
        tabName = "{{TAB_NAME}}",
        icon = icon("calculator"),

        {{ADD_CALLS_TO_SIDE_BAR_MENU}}
    )
    return( retMenuItem )
}

