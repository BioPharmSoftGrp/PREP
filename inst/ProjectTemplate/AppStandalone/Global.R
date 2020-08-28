


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

# Source the required Shiny components ####

source( "Modules/mod_HomeUI.R" )
source( "Modules/mod_HomeServer.R" )

# Optional Example Tabs
source( "Modules/mod_SimulationUI.R" )
source( "Modules/mod_SimulationServer.R" )
source( "Modules/mod_Simulation_IntroUI.R" )
source( "Modules/mod_Simulation_IntroServer.R" )
source( "Modules/mod_Simulation_ProgramUI.R" )
source( "Modules/mod_Simulation_ProgramServer.R" )

source( "Modules/mod_DataAnalysisUI.R" )
source( "Modules/mod_DataAnalysisServer.R" )
source( "Modules/mod_DataAnalysis_IntroUI.R" )
source( "Modules/mod_DataAnalysis_IntroServer.R" )
source( "Modules/mod_DataAnalysis_RunAnalysisUI.R" )
source( "Modules/mod_DataAnalysis_RunAnalysisServer.R" )

# {{SOURCE_ADDITIONAL_TABS}}
# Include the TAG for use with the AddNewTabToApp Function - if the previous line is removed the AddNewTabToApp will not correctly add the source commands.

#BaSS Shiny App Common Tabs
source( "Modules/mod_FeedbackUI.R" )
source( "Modules/mod_FeedbackServer.R" )

source( "Modules/mod_OptionsUI.R" )
source( "Modules/mod_OptionsServer.R" )

source( "Modules/mod_ThemeSwitcherUI.R" )
source( "Modules/mod_ThemeSwitcherServer.R" )

source( "app_ui.R" )
source( "app_server.R" )


