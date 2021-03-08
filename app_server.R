library(tidyverse)
library(ggplot2)
library(shiny)

mental_health <- read.csv("https://raw.githubusercontent.com/info201a-w21/project-victoriathegr8/main/data/mental_health_in_tech/survey.csv?token=ASLIDHBRHUKBMN2U5RGAKW3AJF3YK")

server <- function(input, output) {
  mental_health <- mental_health %>%
    select(Age, work_interfere, no_employees, leave)
  
  # colnames(mental_health) <- c("Age", "Mental Health Interfere with Work",
  #                              "Number of Employees",
  #                              "Difficulty Taking Medical Leave")
  
  # output$plot <- renderPlot({
  #   mental_health <- mental_health %>%
  #     filter(14 < Age & Age < 118) %>%
  #     select(input$x_var, Age) %>%
  #     group_by(input$x_var) %>%
  #     mutate(avg_age = mean(Age, na.rm = T)) %>%
  #     summarize(avg_age = max(avg_age, na.rm = T))
  #   
  #   ggplot(data = mental_health) +
  #     geom_col(mapping = aes(x = mental_health[[input$x_var]], y = `avg_age`)) +
  #     labs(title = "Average Age of Respondants and", input$x_var,
  #          x = input$x_var,
  #          y = "Average Age")
  # })
  output$plot <- renderPlot({
    mental_health <- mental_health %>%
      filter(14 < Age & Age < 118) %>%
      select(input$x_var, Age) %>%
      group_by(input$x_var) %>%
      mutate(avg_age = mean(Age, na.rm = T)) %>%
      summarize(avg_age = max(avg_age, na.rm = T))
    
    ggplot(data = mental_health) +
      geom_col(mapping = aes(x = mental_health[[input$x_var]], y = `avg_age`)) +
      labs(title = "Average Age of Respondants and",
           y = "Average Age")
  })
  }