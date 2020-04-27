####################################################################################################.
# Description:
# Create a new function that is based on tabItems but allows the user to send in tabItem or a
# list of taItem, eg list( tabItem1, tabItem2) and will create the tabItems object
# by calling tabItems
####################################################################################################.
TabItems <- function( ... )
{

  args <- list(...)
  vArgs <- c()
  for (i in 1:length(args)) {
    #print( class(args[[i]] ))
    if (class(args[[i]]) == "shiny.tag"){
      vArgs <- c(vArgs, args[i])
    }
    else if (class(args[[i]]) == "list"){
      vArgs <- c(vArgs, c(args[[i]]))
    }
  }
  retTabItems <- do.call("tabItems", vArgs)
  return(retTabItems)
}




####################################################################################################.
# Header of Website ####
# Description: THis header will display the app name and tool tip to the right
####################################################################################################.
header <- dashboardHeader(
  title = span(img(src="logo.png", height=35), "_PROJECT_NAME_"),
  titleWidth = 300,

  ## Drop down menu
  dropdownMenu(
    type = "notifications",
    badgeStatus = NULL, icon = icon("question"),
    headerText = div(style = "color:purple; font-size:150%","About"),
    notificationItem(text="Version: Beta v0.1", icon=icon("angle-right")),
    notificationItem(text="Author: _AUTHOR_NAME_", icon=icon("angle-right")),
    notificationItem(text="Contact: _CONTACT_EMAIL_", icon=icon("angle-right")),
    notificationItem(text="Release Date: 2020-XXX-XX", icon=icon("angle-right"))
  )

)


####################################################################################################.
# Side bar Menu        ####
####################################################################################################.
sidebar <- dashboardSidebar(
  sidebarMenu(

    id = "sidebar_tabs",

    HomeSideBarMenu( ),

    SimulationSideBarMenu( ),

    DataAnalysisSideBarMenu( ),

## _ADD_NEW_TAB_SIDE_BAR_ ##

    FeedbackSideBarMenu( ),

    OptionsSideBarMenu( )
  )
)

####################################################################################################.
# Body         ####
####################################################################################################.
body <-  dashboardBody(
  ChangeThemeOutputUI(),   # Theme: This line will inject the theme options into the right place ####
  TabItems(   HomeUI( ),

               SimulationUI( ),

               DataAnalysisUI( ),

## _ADD_NEW_TAB_UI_CALL_ ##

               FeedbackUI( "Feedback" ),

               OptionsUI()
  )
)

####################################################################################################.
# The UI that is loaded in the ShinyApp.R file              ####
####################################################################################################.
ui <- dashboardPage( header  = header,
                     sidebar = sidebar,
                     body    = body)


