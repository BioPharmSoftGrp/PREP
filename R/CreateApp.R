#' @name  CreateApp
#' @title  CreateApp
#' @description {Create an R Shiny app based on a template to help ease development.  The R Shiny App utilizes modeules which is very helpful for large scale applications.  }
#' @param strProjectDirectory {The directory where the project should be created.  If this parameter is left blank then the current working directory will be used.}
#' @param strName {The name of the folder where the R Shiny app is created.}
#' @param strDisplayName {The display name of the app. }
#' @param strAuthors {List of authors}
#' @param strModules {List of Modules to include.  Modules should be named xxx.R, mod_xxx.R or mod_xxx_ui.r and mod_xxx_server.r. Files should be saved in /{strModulePath} or in /inst/modules. A future release may support adding modules loaded in current session}
#' @param bModulesAsTabs {add modules as tabs}
#' @param bPackage {Specifies whether the app should be wrapped in a pacakge. Default True}

#' @export

CreateApp <-
    function(strProjectDirectory,
             strShinyAppName="NewApp",
             strShinyAppDisplayName=NULL,
             strAuthors=NULL,
             strModules=c("home","feedback","options"),
             strModulesPath="",
             bPackage=TRUE
    ){
        if(bPackage){
            createAppPkg(...)
        }else{
            createAppInst(...)
        }
    }
