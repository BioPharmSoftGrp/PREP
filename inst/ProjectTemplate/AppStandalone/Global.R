


library( shiny )
library( shinydashboard )
library( shinyBS )
library( ggplot2 )
library( shinydashboardPlus )
library( dashboardthemes )
library( shinybusy )

# Include any other libraries
{{CALCULATION_LIBRARY}}  # If you have not built the R Calculation package then this likely needs to be commented out for the Shiny app to run


source( "BassShinyThemes.R")

source( "Modules/moduleServer.R")  # Starting with Shiny 1.5 we won't need this file as will be part of R Shiny


#BaSS Shiny App Common Tabs
source( "Modules/mod_FeedbackUI.R" )
source( "Modules/mod_FeedbackServer.R" )

source( "Modules/mod_OptionsUI.R" )
source( "Modules/mod_OptionsServer.R" )

source( "Modules/mod_ThemeSwitcherUI.R" )
source( "Modules/mod_ThemeSwitcherServer.R" )

source( "app_ui.R" )
source( "app_server.R" )

# Additional Modules Below
