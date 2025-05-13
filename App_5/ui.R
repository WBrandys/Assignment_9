library(shiny)

fluidPage(
  
    titlePanel("Different Gene Expression"),

    sidebarLayout(
        sidebarPanel(
          #Menu to select GeneID (choices will be updated in server.R)
            selectInput("GeneID", "Choose GeneID:", choices = NULL)
        ),
        mainPanel(
            plotOutput("distPlot")
        )
    )
)
