library(shiny)
library(ggplot2)
library(readr)
library(tidyr)
library(dplyr)

#Loading the CSV file
table_width <- read.csv("TPMs_table_100genes.csv")

#Converting data from wide to long format
table_long <- pivot_longer(table_width,
                           cols=-GeneID,
                           names_to="Sample",
                           values_to="TPMs")

function(input, output, session) {
  #Updating dropdown choices with GeneID
  observe({
    updateSelectInput(session, "GeneID",
                      label = "Choose a gene:",
                      choices = unique(table_long$GeneID),
                      selected = unique(table_long$GeneID)[1])
  })

    output$distPlot <- renderPlot({
      #Filter data for selected gene
      gene_data <- subset(table_long, GeneID == input$GeneID)
      
      #Creating bar plot
      ggplot(gene_data,aes(x=Sample, y=TPMs))+
        geom_bar(stat="identity", fill="lightpink")+
        geom_text(aes(label = round(TPMs,2)), vjust = -0.5, size=3.5)+
        theme_minimal()+
        labs(
          x= input$GeneID,
          y= "TPMs"
        )
    })
}
