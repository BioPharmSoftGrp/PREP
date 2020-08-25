#' UI for feedback module
#'
#' @param strID 
#'
#' @return tabItem() for feedback UI

FeedbackUI <- function( strID ){
    
    ns <- NS( strID )
    fldRow <- fluidRow(
        box(
            width = 12,
            title = "Feedback",
            status = "primary",
            solidHeader = TRUE,
            "Thank you for providing feedback on this application.  Your opinion and input is very valuable.  
            
            If providing a bug report, please provide as much detail as possible.",
            textInput( inputId = ns("txtName"), value="Your Name", label=NULL ),
            textInput( inputId = ns("txtEmail"), value="Your Email", label=NULL ),
            selectInput( inputId = ns( "selType" ), label = "Feedback Type", 
                         choices = c( "Please Select ...", "Bug report", "Feature request", "Question", "General Feedback", "Other"),
                         selected = "Please Select ..."),
            
            conditionalPanel(
                condition ="input.selType =='Other'",
                textInput( inputId = ns("txtOther"), value = "Other Reason, please specify", label = NULL  ),
                ns = NS( strID )
            ),
            
            conditionalPanel(
                condition ="input.selType =='Bug report'",
                selectInput( inputId = ns("selBugLevel"), label = "Bug Severity",
                             choices = c( "Please select..", "1 - Low impact, minor issue", "2 - Medium Impact", "3 - Major impact or incorrect results") ),
                ns = NS( strID )
            ),
            
            textAreaInput( inputId = ns("strFeedback"), value="", label="Feedback Details", rows=10 ),
            
            bsButton( inputId = ns( "btnSubmit" ), label="Submit", style="success", block=F, size="large")
        )
        
    )
    
    tabFeedback <- tabItem(tabName = strID, fldRow)
    
    return( tabFeedback )
}

#' Feedback sidebar item
#'
#' @return menuItem() for feedback
#' @export

FeedbackSideBarMenu <- function( ){
    retMenuItem <- menuItem(text = "Feedback", tabName = "Feedback", icon = icon("envelope-square"))
    return( retMenuItem )
}    

