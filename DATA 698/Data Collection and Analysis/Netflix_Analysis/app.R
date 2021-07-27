library(shiny)
library(tidyverse)
library(scales)

Netflix_subs <- read.csv("https://raw.githubusercontent.com/bpersaud104/Data698/main/Data%20Collection%20and%20Analysis/Datasets/DataNetflixSubscriber2020_V2.csv")

ui <- fluidPage(

    titlePanel("Netflix Subscriptions by Area"),

             selectInput(inputId = "Subscribers", 
                         label = "Select Area",
                         choices = unique(Netflix_subs$Area),
                         
             ),
             mainPanel(
                 plotOutput(outputId = "graph") 
             )
    )

server <- function(input, output) {

    output$graph <- renderPlot({ 
        Netflix_subs %>%
            filter(Area == input$Subscribers) %>%
            ggplot(aes(x = reorder(Years, Subscribers), y = Subscribers)) + geom_bar(stat = "identity", fill = "red") + geom_text(aes(label = Subscribers), position = position_dodge(width = 0.9)) + xlab("Yearly Quarters") + ylab("Total Subscribers") + scale_y_continuous(labels = comma)
    }) 
}

# Run the application 
shinyApp(ui = ui, server = server)