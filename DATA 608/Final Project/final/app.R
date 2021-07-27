library(shiny)
library(ggplot2)
library(dplyr)
library(reshape2)
library(scales)

college_majors <- read.csv("https://raw.githubusercontent.com/bpersaud104/Data608/master/all-ages.csv")

ui <- fluidPage(
    tabsetPanel(

    tabPanel("Total Students in Major", titlePanel("List of Majors by Total Number of Students"), 
             selectInput(inputId = "Total", 
                         label = "Select Major Category",
                         choices = unique(college_majors$Major_category),
                         
             ),
             mainPanel(
                 plotOutput(outputId = "graph1") # Graph to show total students in major
             )
    ),
    tabPanel("Median Salary by Major", titlePanel("List of Majors by Median Salary"), 
             selectInput(inputId = "Salary", 
                         label = "Select Major Category",
                         choices = unique(college_majors$Major_category),
                         
             ),
             mainPanel(
                 plotOutput(outputId = "graph2") # Graph to show median salary for each major
             )
        ),
    tabPanel("Employed vs Unemployed", titlePanel("List of Majors by Employment"), 
             selectInput(inputId = "Employment", 
                         label = "Select Major",
                         choices = unique(college_majors$Major),
                         
             ),
             mainPanel(
                 plotOutput(outputId = "graph3") # Graph to show employment and unemployment for a major
             )
        )
    )
)

server <- function(input, output) {

    output$graph1 <- renderPlot({ 
        college_majors %>%
            filter(Major_category == input$Total) %>%
            ggplot(aes(x = reorder(Major, Total), y = Total)) + geom_bar(stat = "identity", fill = "orange")  + geom_text(aes(label = Total)) + xlab("Major") + ylab("Total Students") + scale_y_continuous(labels = comma) + coord_flip()
    })
    output$graph2 <- renderPlot({ 
        college_majors %>%
            filter(Major_category == input$Salary) %>%
            ggplot(aes(x = reorder(Major, Median), y = Median)) + geom_bar(stat = "identity", fill = "purple")  + geom_text(aes(label = Median)) + xlab("Major") + ylab("Salary") + coord_flip()
    })
    output$graph3 <- renderPlot({ 
        college_majors %>%
            select(Major, Employed, Unemployed) %>%
            filter(Major == input$Employment) %>%
            melt(id.vars = "Major") %>%
            ggplot(aes(x = Major, y = value, fill = variable)) + geom_bar(stat = "identity", position = "dodge") + geom_text(aes(label = value), position = position_dodge(width = 0.9)) + scale_y_continuous(labels = comma)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
