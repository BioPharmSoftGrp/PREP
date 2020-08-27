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
    packagePath<-paste0(strDirectory,"/",strName)
    opts <- list()
    if(strAuthors != "") opts[`Authors@R`]=strAuthors
    usethis::create_package(path=packagePath, fields=opts, check_name=FALSE, open=FALSE)
    usethis::with_project(path=packagePath,usethis::use_testthat())

    strSharedDirectory <- paste0(GetTemplateDirectory(), "/_shared/package")
    ReadmeSrc<-paste0(strSharedDirectory,"/README.md")
    ReadmeDest<-paste0(packagePath,"/README.md")
    file.copy(ReadmeSrc,ReadmeDest)

    if(bSampleFiles){
        RSrc<-paste0(strSharedDirectory,"/CalcPosteriorProbsBinom.R")
        RDest<-paste0(packagePath,"/R")
        file.copy(RSrc,RDest)

        TestSrc<-paste0(strSharedDirectory,"/test-CalcPosteriorProbsBinom.R")
        TestDest<-paste0(packagePath,"/tests/testthat")
        file.copy(TestSrc, TestDest)
    }
}
