
#' @title  RunApp
#' @name RunApp
#' @return
#' @export
RunApp = function() {

    appDir <- system.file("_SHINY{{PROJECT_NAME}}", package = "_SHINY{{PROJECT_NAME}}")
    shiny::runApp(paste( appDir,"/ShinyApp.R",sep=""), display.mode = "normal")

}
