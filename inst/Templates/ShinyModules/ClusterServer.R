################################################################################ .
# Description:
################################################################################ .
{{TAB_NAME}}Server <- function( )
{
    #The strID here must match what is in the UI file.
    strID     <- "{{TAB_NAME}}"
    retModule <- function( input, output, session ){


        GetValues <- reactive({
            mtcars[, c(input$xVar, input$yVar)]
        })

        GetClusters <- reactive({
            kmeans(GetValues(), input$nClusters)
        })

        output$plotCluster <- renderPlot({
            palette(c("#E21B1A", "#377EB8", "#4DAF4A", "#984EA3",
                      "#FF7F04", "#FFFF31", "#A65428", "#F281BF", "#999999"))

            par(mar = c(5.1, 4.1, 0, 1))
            lCluster <- GetClusters()
            plot(GetValues(),
                 col = lCluster$cluster,
                 pch = 20, cex = 3)
            points(lCluster$centers, pch = 1, cex = 3, lwd = 4, col = "blue")
        })




        output$plotHeatmap <- renderPlot({
            # library(pheatmap)
            # mtscaled <- as.matrix(scale(mtcars))
            # pheatmap(mtscaled,
            #         col = topo.colors(200, alpha=0.5),
            #         Colv=F, scale="none")
            # d <- dist(mtcars)
            # treeComp <- hclust(d, method = "complete")
            # plot(treeComp)

            # scale data to mean=0, sd=1 and convert to matrix
            mtscaled <- as.matrix(scale(mtcars))

            # create heatmap and don't reorder columns
            heatmap(mtscaled, Colv=F, scale='none')
        })


        output$dtTable = DT::renderDataTable({
            mtcars
        })


    }

    retServer <- moduleServer( strID, module = retModule )
    return( retServer )
}
