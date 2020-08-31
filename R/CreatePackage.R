#' @name  CreatePackage
#' @title  CreatePackage
#' @description {Create an R package via usethis::create_package. Optionally include a sample functiona and a testthat unit test.   }
#' @param strDirectory {The directory where the project should be created.  If this parameter is left blank then the current working directory will be used.}
#' @param strName {The name of the package folder.}
#' @param bSampleFiles {copy sample files? Default: TRUE}
#' @export

CreatePackage <- function(
    strDirectory=getwd(),
    strName="newPackage",
    strAuthors = "",
    bSampleFiles=TRUE)
{
    strPackagePath<-paste0(strDirectory,"/",strName)
    opts <- list()
    if(strAuthors != "") opts[`Authors@R`]=strAuthors
    usethis::create_package(path=strPackagePath, fields=opts, check_name=FALSE, open=FALSE)
    usethis::with_project(path=strPackagePath,usethis::use_testthat())

    if(bSampleFiles){
        strSrcDir<-paste0(GetTemplateDirectory(),"/Pkg")
        strDestDir<- paste0(strPackagePath)
        CopyFiles(strSrcDir, strDestDir)
    }
}
