


library( shiny)
library( shinydashboard)
library( shinyBS )
library( ggplot2 )

library(shinydashboardPlus)

library( dashboardthemes)


# Include any other libraries
library( _CALCULATION_PACKAGE_NAME_ )  # If you have not built the R Calculation package then this likely needs to be commented out for the Shiny app to run


source( "BassShinyThemes.R")

source( "Modules/moduleServer.R")  # Starting with Shiny 1.5 we won't need this file as will be part of R Shiny

# Source the required Shiny components ####

source( "Modules/HomeUI.R")
source( "Modules/HomeServer.R")

# Optional Example Tabs
source( "Modules/SimulationUI.R")
source( "Modules/SimulationServer.R")

source( "Modules/DataAnalysisUI.R" )
source( "Modules/DataAnalysisIntroUI.R")
source( "Modules/DataAnalysisRunAnalysisUI.R")
source( "Modules/DataAnalysisRunAnalysisServer.R")

# _SOURCE_ADDITIONAL_TABS_ #
# Include the TAG for use with the AddNewTabToApp Function - if the previous line is removed the AddNewTabToApp will not correctly add the source commands.


#BaSS Shiny App Common Tabs
source( "Modules/FeedbackUI.R")
source( "Modules/FeedbackServer.R")

source( "Modules/OptionsUI.R")
source( "Modules/OptionsServer.R")

source( "Modules/ThemeSwitcherUI.R")
source( "Modules/ThemeSwitcherServer.R")



source( "ShinyUI.R" )
source( "ShinyServer.R" )


