library( shiny)
runApp()
runApp( "inst/ShinyApp" )

library( shinytest)
recordTest( "inst/ShinyApp")
