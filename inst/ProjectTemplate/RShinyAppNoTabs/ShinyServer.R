

library( shiny)
#library( "GoNG")

server <- function(input, output,session) {

    # Shiny Version 1.5 (not released yet so see moduleServer.R)

    FeedbackServer(  )
    ThemeSwitcherServer( )

# _ADD_NEW_TAB_SERVER_ #
    # Include the TAG for use with the AddNewTabToApp Function - if the previous line is removed the AddNewTabToApp will not correctly add the server command

}
