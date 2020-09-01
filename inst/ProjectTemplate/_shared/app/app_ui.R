#' app_ui
#'
#' Application UI
#'
#' @return shinydashboard::dashboardPage containing the app
#'
#' @import shiny
#' @import shinydashboard
#'
#' @export

app_ui <- function(){

  TabItems <- function( ... ){
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

  header <- dashboardHeader(
    title = span(img(src="www/logo.png", height=35), "{{PROJECT_NAME}}"),
    titleWidth = 300,

    ## Drop down menu
    dropdownMenu(
      type = "notifications",
      badgeStatus = NULL, icon = icon("question"),
      headerText = div(style = "color:purple; font-size:150%","About"),
      notificationItem(text="Version: Beta v0.1", icon=icon("angle-right")),
      notificationItem(text="Author: {{AUTHOR_NAME}}", icon=icon("angle-right")),
      notificationItem(text="Contact: _CONTACT_EMAIL_", icon=icon("angle-right")),
      notificationItem(text="Release Date: 2020-XXX-XX", icon=icon("angle-right"))
    )
  )

  sidebar <- shinydashboard::dashboardSidebar(
    shinydashboard::sidebarMenu(
      id = "sidebar_tabs",
      # whisker tag to add sidebar UI
      # {{ADD_MODULE_SIDEBAR}}
      #OptionsSideBarMenu()
    )
  )

  body <-  dashboardBody(
    #ChangeThemeOutputUI(),   # Theme: This line will inject the theme options into the right place ####
    TabItems(
      # whisker tag to add module UI
      # {{ADD_MODULE_UI}}
      #OptionsUI()
    )
  )
  return(dashboardPage(header=header, sidebar=sidebar, body=body))
}


