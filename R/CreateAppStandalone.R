#' @name CreateAppStandalone
#' @title CreateAppStandalone
#' @description { This function creates a standalone Shiny app.  }
#'
#' @param strDirectory The directory where the project folder is created.  If this parameter is left blank then the current working directory will be used.
#' @param strName {The folder where the app saved.}
#' @param strDisplayName {Display name for the app. strName is used by default}
#' @param strAuthors {Author Names. Blank by default}
#' @param vModuleIDs {list of module IDs to copy.  The function looks in inst/_shared/modules for files named "mod_{moduleID*}" for each value of vModuleIDs provided; matching files are copied to the new app and initialized as shiny modules in app_ui and app_server. See PREP::add_module() for more detail.}

#' @export

CreateAppStandalone <-
    function(strDirectory=getwd(),
             strName="newApp",
             strDisplayName="",
             strAuthors="",
             vModuleIDs=c("Home","Simulation","Feedback","Options")
    ){
        #### 0 - Parameter checks
        if (!Provided(strDisplayName)) strDisplayName <- strName

        #### 1 - File Management
        #### 1a - Clone package directory
        strProjectDirectory <- gsub("\\\\", "/", strDirectory)
        strTemplateDirectory <- paste(GetTemplateDirectory(), "/AppStandalone",sep="")
        strDestDirectory  <- CreateProjectDirectory(strProjectDirectory, strName, TRUE)
        CopyFiles(strTemplateDirectory, strDestDirectory)

        #### 1b - copy shared assets to new project
        strSharedDirectory <- paste0( GetTemplateDirectory(), "/_shared")

        strInstDest<-paste0(strDestDirectory,"/","inst") #NOTE: not traditional to use /inst directory in standalone app, but greatly simplifies workflow with /inst/_shared here ...
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
        # #TODO - only copy required modules
        # strModulesSrc<-paste0(strSharedDirectory,"/modules")
        # strModulesDest<-paste0(strDestDirectory,"/modules")
        # dir.create(strModulesDest,'modules')
        # CopyFiles(strModulesSrc,strModulesDest)

        # App Files - Server and UI
        strAppSrc<-paste0(strSharedDirectory,"/app")
        CopyFiles(strAppSrc,strDestDirectory)

        # Logo
        # TODO - allow user to select an image (using PREP hex as placeholder for now)
        strLogoSrc<-paste0(strSharedDirectory,"/img/logo.png")
        strLogoDest<-paste0(strDestDirectory,"/www/logo.png")
        file.copy(strLogoSrc,strLogoDest)

        #### 1c - rename the .rproj file
        strRProjName  <- paste(strDestDirectory, "/AppStandalone.Rproj", sep="")
        strNewRProjName <- paste(strDestDirectory,"/",strName,".Rproj",sep ="")
        file.rename( strRProjName, strNewRProjName )

        #### 2 - Add Modules to Package
        strModulesDest<-paste0(strInstDest,"/modules")
        dir.create(strModulesDest)
        AddModules(vModuleIDs = vModuleIDs, strPackageDirectory = strDestDirectory, strType="standalone")

        #### 3 - Update Metadata with Whisker templating
        tags <- list(
            AUTHOR_NAME=strAuthors,
            PACKAGE_NAME=strName,
            PROJECT_NAME=strDisplayName,
            ADD_NEW_MODULE_SIDEBAR="{{ADD_NEW_MODULE_SIDEBAR}}",
            ADD_NEW_MODULE_UI="{{ADD_NEW_MODULE_UI}}"
        )

        vFileType <- c("\\.Rmd$", "\\DESCRIPTION$", "\\.html$", "Global.R", "app_ui.R") #apply template to these file types
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

        return( "Built the app!!" )
    }
