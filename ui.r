library(shiny)

shinyUI(
  pageWithSidebar(
    #Application title
  headerPanel("CPT Mutually Exclusive Edits Checker"),
  sidebarPanel( 
    selectizeInput('searchTerm', 'Enter column 1 code', choices = NULL),
    selectizeInput("dropdown", label = 'Select a possible matching code 2', choices = NULL)
   ),
   
  mainPanel(
    h3('Search Results:'),
    textOutput('text1'),
    tags$head(tags$style("#text1{color: red;
                                 font-size: 40px;
                                 font-style: bold;
                                 }"
    )
    ),
    textOutput('text2'),
    tags$head(tags$style("#text2{color: green;
                                 font-size: 40px;
                                 font-style: bold;
                                 }"
    )
    ),
    textOutput('text3'),
    tags$head(tags$style("#text3{color: black;
                                 font-size: 40px;
                                 font-style: bold;
                                 }"
    )
    ),
    textOutput('text4'),
    tags$head(tags$style("#text4{color: black;
                                 font-size: 20px;
                                 font-style: italic;
                                 }"
    )
    )
    )
 )
)