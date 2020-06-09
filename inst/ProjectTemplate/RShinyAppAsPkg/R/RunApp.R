
#' @title  RunApp
#' @name RunApp
#' @return
#' @export
RunApp = function() {

    appDir <- system.file("_SHINY_PROJECT_NAME_", package = "_SHINY_PROJECT_NAME_")
    shiny::runApp(paste( appDir,"/ShinyApp.R",sep=""), display.mode = "normal")

}
