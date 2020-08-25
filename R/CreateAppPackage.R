#' @name CreateAppPackage
#' @title CreateAppPackage
#' @description { This function creates a Shiny app as an R Package.  }
#'
#' @importFrom devtools build document
#' @export
#'

CreateAppPackage <- function(
    strProjectDirectory=getwd(),
    strName="newApp",
    strDisplayName="",
    strAuthors="",
    strModules=c("Home","Feedback","Options"),
    bDocumentPackage=TRUE
){
    #### 0 - Parameter checks
    if(strDisplayName=="") strDisplayName <- strName

    #### 1 - File Management
    #### 1a - Clone package directory
    strProjectDirectory <- gsub( "\\\\", "/", strProjectDirectory )
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

    # Shiny Modules
    #TODO - only copy required modules
    strModulesSrc<-paste0(strSharedDirectory,"/modules")
    strModulesDest<-paste0(strDestDirectory,"/R")
    CopyFiles(strModulesSrc,strModulesDest)

    # Logo
    # TODO - allow user to select an image (using BaSS hex as placeholder for now)
    strLogoSrc<-paste0(strProjectDirectory,"/hex-BaSS.png")
    dir.create(paste0(strInstDest,"/www"))
    strLogoDest<-paste0(strInstDest,"/www/logo.png")
    file.copy(strLogoSrc,strLogoDest)

    #### 1c - rename the .rproj file
    strRProjName  <- paste(strDestDirectory, "/AppPkg.Rproj", sep="")
    strNewRProjName <- paste(strDestDirectory,"/",strName,".Rproj",sep ="")
    file.rename( strRProjName, strNewRProjName )

    #### 2 - Update Metadata with Whisker templating
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
            strRet  <- whisker.render(strInput, tags)
            writeLines( strRet, con = vFileNames[i] )
        }
    }

    #### 3 - generate the documentation and build the package
    if(bDocumentPackage){
        devtools::document(pkg=strDestDirectory)
    }

    return( "Built the app!!" ) # TODO: Reimplement text summary of updates
}


