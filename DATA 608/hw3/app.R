library(shiny)
library(ggplot2)
library(dplyr)

Mortality_dataset <- read.csv("https://raw.githubusercontent.com/bpersaud104/Data608/master/cleaned-cdc-mortality-1999-2010-2.csv")

ui <- fluidPage(
    tabsetPanel(
        # Question 1
        tabPanel("2010 Crude Rate", titlePanel("Crude Rate for Year 2010 by State"), 
        selectInput(inputId = "Disease", 
                    label = "Select type of disease",
                    choices = unique(Mortality_dataset$ICD.Chapter),
                    selected = 'Neoplasms'
                    ),
        mainPanel(
            plotOutput(outputId = "Disease_graph")
                 )
            ),
        # Question 2
        tabPanel("State Crude Rate", titlePanel("State Crude Rate Compared to National Average"), 
        selectInput(inputId = "National_avg", 
                    label = "Select type of disease",
                    choices = unique(Mortality_dataset$ICD.Chapter),
                    selected = 'Neoplasms'
                    ),
        # Question 2
        selectInput(inputId = "State", 
                    label = "Select State",
                    choices = unique(Mortality_dataset$State),
                    selected = 'NY'
                    ),
        mainPanel(
            plotOutput(outputId = "State_graph")
                )
            )
        )
    )
server <- function(input, output) {
    # Question 1
    output$Disease_graph <- renderPlot({ 
        Mortality_dataset %>%
        filter(Year == 2010, Crude.Rate != 0) %>%
        filter(ICD.Chapter == input$Disease) %>%
        ggplot(aes(x = reorder(State, Crude.Rate), y = Crude.Rate)) + geom_bar(stat = "identity") + xlab("State") + ylab("Mortality Rate") + coord_flip()
    })
    # Question 2
    output$State_graph <- renderPlot({ 
        Mortality_dataset %>%
            filter(Crude.Rate != 0) %>%
            group_by(Year, ICD.Chapter) %>%
            mutate(National_average = round(sum(Deaths) / sum(Population) * 100000, 4)) %>%
            group_by(Year, ICD.Chapter, State) %>%
            filter(State == input$State, ICD.Chapter == input$National_avg) %>%
            ggplot(aes(x = Year, y = Crude.Rate)) + geom_bar(stat = "identity") + geom_line(aes(Year, National_average))
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
