library(shiny)
library(data.table)

#setwd ="/Users/paigehurtig-crosby/Documents/ryan/CPT_website/"
file= 'input.csv'
mueResult <- ''

shinyServer( 
  function(input, output, session){   
    observe({
      searchResult <- input$searchTerm
      inputFile <- fread(file, header=T, sep=",", stringsAsFactors=F)      
      
      d <- data.frame(inputFile[,1, with=FALSE], inputFile[,1, with=FALSE])
      colnames(d) <- c("value", "label")
      
      #initial case
      if(searchResult == ""){
        updateSelectizeInput(session, 'searchTerm', choices = d, server = TRUE)
      }
      #every other time
      if(searchResult != ""){
        updateSelectizeInput(session, 'searchTerm', choices = d, selected = input$searchTerm, server = TRUE)  
      }
      
      #initial case
      if(input$dropdown == ""){
        code2values <- subset(inputFile, code1 == searchResult)
        
        secondDropdown <- data.frame(code2values[,2, with=FALSE], code2values[,2, with=FALSE])
        print(secondDropdown)
        colnames(secondDropdown) <- c("value", "label")
        updateSelectizeInput(session, 'dropdown', choices = secondDropdown, server = TRUE)
      }
      #every other time
      if(input$dropdown != ""){
        code2values <- subset(inputFile, code1 == searchResult)
        
        secondDropdown <- data.frame(code2values[,2, with=FALSE], code2values[,2, with=FALSE])
        print(secondDropdown)
        colnames(secondDropdown) <- c("value", "label")
        updateSelectizeInput(session, 'dropdown', choices = secondDropdown, server = TRUE)  
        
        #check mue
        mue <- subset(code2values, code2 == input$dropdown)
        
        if(as.character(mue[,5, with=FALSE]) == 0){
          output$text1 <- renderText({ paste("You cannot bill that") })
          output$text2 <- renderText({ paste("") })
          output$text3 <- renderText({ paste("") })
          output$text4 <- renderText({(paste('Explanation given by Medicare:', as.character(mue[,6, with=FALSE])))})
        }
        if(as.character(mue[,5, with=FALSE]) == 1){
          if(as.character(mue[,4, with=FALSE]) == '*'){
            output$text1 <- renderText({ paste("") })
            output$text2 <- renderText({ paste("You can totally bill that") })
            output$text3 <- renderText({ paste("") })
            output$text4 <- renderText({(paste('Explanation given by Medicare:', as.character(mue[,6, with=FALSE])))})
        }
        else{
          output$text1 <- renderText({ paste("You cannot bill that") })
          output$text2 <- renderText({ paste("") })
          output$text3 <- renderText({ paste("") })
          output$text4 <- renderText({(paste('Explanation given by Medicare:', as.character(mue[,6, with=FALSE])))})
        }
        }
        if(as.character(mue[,5, with=FALSE]) == 9){
          output$text1 <- renderText({ paste("") })
          output$text2 <- renderText({ paste("") })
          output$text3 <- renderText({ paste("No information for these codes") })
          output$text4 <- renderText({(paste('Explanation given by Medicare:', as.character(mue[,6, with=FALSE])))})
        }      
      }     
    })
  }
)
