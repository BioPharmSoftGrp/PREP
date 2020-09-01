#' @name  CreateApp
#' @title  CreateApp
#' @description {Create an R Shiny app based on a template to help ease development.  The R Shiny App utilizes modeules which is very helpful for large scale applications.  }
#'
#' @param strDirectory {The directory where the project should be created.  If this parameter is left blank then the current working directory will be used.}
#' @param strName {The name of the folder where the R Shiny app is created.}
#' @param strDisplayName {The display name of the app. }
#' @param strAuthors {List of authors}
#' @param vModuleIDs {list of module IDs to copy.  The function looks in inst/_shared/modules for files named "mod_{moduleID*}" for each value of vModuleIDs provided; matching files are copied to the new app and initialized as shiny modules in app_ui and app_server. See BaSS::add_module() for more detail.}
#' @param bPackage {Specifies whether the app should be wrapped in a pacakge. Default True}

#' @export

CreateApp <-
    function(strDirectory=getwd(),
             strName="NewApp",
             strDisplayName="",
             strAuthors="",
             vModuleIDs=c("Home","Simulation","Feedback"),
             bPackage=TRUE
    ){
        params<-as.list(environment())
        params$bPackage<-NULL
        if(bPackage){
            do.call(CreateAppPackage, params)
        }else{
            do.call(CreateAppStandalone, params)
        }
    }
