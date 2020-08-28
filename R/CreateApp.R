#' @name  CreateApp
#' @title  CreateApp
#' @description {Create an R Shiny app based on a template to help ease development.  The R Shiny App utilizes modeules which is very helpful for large scale applications.  }
#'
#' @param strDirectory {The directory where the project should be created.  If this parameter is left blank then the current working directory will be used.}
#' @param strName {The name of the folder where the R Shiny app is created.}
#' @param strDisplayName {The display name of the app. }
#' @param strAuthors {List of authors}
#' @param bPackage {Specifies whether the app should be wrapped in a pacakge. Default True}

#' @export

CreateApp <-
    function(strDirectory=getwd(),
             strName="NewApp",
             strDisplayName="",
             strAuthors="",
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
