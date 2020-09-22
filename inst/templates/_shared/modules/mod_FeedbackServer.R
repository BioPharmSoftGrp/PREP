#' Server for feedback module
#'
#' @return moduleServer for feedback module

FeedbackServer <- function(id="feedback"){

    retModule <- function(input, output, session ){
        observeEvent( 
            input$btnSubmit ,
            {
                updateButton( session, inputId="strBtnID", label="Please Wait...", style = "danger",  size="large", disabled = TRUE)
            
                #Don't need the next part just an example of how to display the progress bar
                withProgress(message = 'Submitting feedback',
                         detail = '...', value = 0, {
                             for (i in 1:15) {
                                 incProgress(1/15)
                                 Sys.sleep(0.25)
                             }
                         })
            updateButton(session, inputId = "btnSubmit" , label="Submit", style = "success",  size="large", disabled = FALSE)
            
        } )
    }
    
    retServer <- moduleServer(id, module = retModule )
    return( retServer )
}


