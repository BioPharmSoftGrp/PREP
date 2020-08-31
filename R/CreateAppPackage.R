#' @name CreateAppPackage
#' @title CreateAppPackage
#' @description { This function creates a Shiny app as an R Package.  }
#'
#' @description {Create an R Shiny app based on a template to help ease development.  The R Shiny App utilizes modeules which is very helpful for large scale applications.  }
#' @param strDirectory The directory where the project folder is created.  If this parameter is left blank then the current working directory will be used.
#' @param strName {The folder where the app saved.}
#' @param strDisplayName {Display name for the app. strName is used by default}
#' @param strCalculationLibraryName {Name of the calculation library (if any)}
#' @param strAuthors {Author Names. Blank by default}
#' @param vModuleIDs {list of module IDs to copy.  The function looks in inst/_shared/modules for files named "mod_{moduleID*}" for each value of vModuleIDs provided; matching files are copied to the new app and initialized as shiny modules in app_ui and app_server. See BaSS::add_module() for more detail.}
#' @param bDocumentPackage {run devtools:document() on the new package once it is created? TRUE by default}
#'
#' @importFrom devtools build document
#' @export
#'

CreateAppPackage <- function(
    strDirectory=getwd(),
    strName="newApp",
    strDisplayName="",
    strAuthors="",
    vModuleIDs=c("Home","Feedback","Options"),
    bDocumentPackage=TRUE
){
    #### 0 - Parameter checks
    if(strDisplayName=="") strDisplayName <- strName

    #### 1 - File Management
    #### 1a - Clone package directory
    strProjectDirectory <- gsub( "\\\\", "/", strDirectory )
    strTemplateDirectory <- paste( GetTemplateDirectory(), "/AppPkg", sep="" )
    strDestDirectory <- CreateProjectDirectory(strProjectDirectory, strName, TRUE)
    print(strDestDirectory)
    CopyFiles(strTemplateDirectory, strDestDirectory)

    #### 1b - copy shared assets to new project
    strSharedDirectory <- paste0( GetTemplateDirectory(), "/_shared")
    strInstDest<-paste0(strDestDirectory,"/","inst")
    dir.create(strInstDest)

    # Templates
    strTemplatesSrc<-paste0(strSharedDirectory,"/templates")
    strTemplatesDest<-paste0(strInstDest,"/templates")
    dir.create(strTemplatesDest)
    CopyFiles(strTemplatesSrc, strTemplatesDest)

    # Themes
    strThemesSrc<-paste0(strSharedDirectory,"/themes")
    strThemesDest<-paste0(strInstDest,"/themes")
    dir.create(strThemesDest)
    CopyFiles(strThemesSrc, strThemesDest)

    # App Files - Server and UI
    strAppSrc<-paste0(strSharedDirectory,"/app")
    strAppDest<-paste0(strDestDirectory,"/R")
    CopyFiles(strAppSrc,strAppDest)

    # Shiny Modules
    #TODO - only copy required modules
    # strModulesSrc<-paste0(strSharedDirectory,"/modules")
    # strModulesDest<-paste0(strDestDirectory,"/R")
    # CopyFiles(strModulesSrc,strModulesDest)

    # Logo
    # TODO - allow user to select an image (using BaSS hex as placeholder for now)
    strLogoSrc<-paste0(strProjectDirectory,"/docs/logo.png")
    dir.create(paste0(strInstDest,"/www"))
    strLogoDest<-paste0(strInstDest,"/www/logo.png")
    file.copy(strLogoSrc,strLogoDest)

    #### 1c - rename the .rproj file
    strRProjName  <- paste(strDestDirectory, "/AppPkg.Rproj", sep="")
    strNewRProjName <- paste(strDestDirectory,"/",strName,".Rproj",sep ="")
    file.rename( strRProjName, strNewRProjName )

    #### 2 - Add Modules to Package
    for(mod in vModuleIDs){
        addModule(strModuleID = mod, strPackageDirectory = strDestDirectory, strType="package")
    }

    #### 3 - Update Metadata with Whisker templating
    tags <- list(
        AUTHOR_NAME=strAuthors,
        PACKAGE_NAME=strName,
        PROJECT_NAME=strDisplayName
    )

    vFileType <- c("\\.Rmd$", "\\DESCRIPTION$", "\\.html$","app_ui.R") #apply template to these file types
    vFileNames <- c()
    for(i in 1:length(vFileType)){
        newFiles <- list.files(
            strDestDirectory,
            pattern = vFileType[i],
            recursive = TRUE,
            full.names = TRUE
        )
        vFileNames<-c(vFileNames,newFiles)
    }
    if (length(vFileNames) > 0){
        for(i in 1:length(vFileNames)){
            strInput <- readLines( vFileNames[i] )
            strRet  <- WhiskerKeepUnrender(strInput, tags)
            writeLines( strRet, con = vFileNames[i] )
        }
    }

    #### 4 - generate the documentation and build the package
    if(bDocumentPackage){
        devtools::document(pkg=strDestDirectory)
    }

    return( "Built the app!!" ) # TODO: Reimplement text summary of updates
}


