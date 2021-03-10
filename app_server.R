library(shiny)
library(ggplot2)
source("table.r")

mental_health <- read.csv("https://raw.githubusercontent.com/info201a-w21/project-victoriathegr8/main/data/mental_health_in_tech/survey.csv?token=ASLIDHBRHUKBMN2U5RGAKW3AJF3YK")
  mental_health <- mental_health %>%
    select(Age, work_interfere, no_employees, leave)
  
  colnames(mental_health) <- c("Age" = "Age",
                               "Mental Health Intereference with Work" = "work_interfere",
                               "Number of Employees" = "no_employees",
                               "Difficulty Taking Medical Leave" = "leave")
  
  colnames(summary_table) = c("Company Size",
                              "Have Family History of Mental Illness",
                              "Have Received Mental Illness Treatment",
                              "Receive Mental Health Benefits from Work",
                              "Are Comfortable Discussing\nMental Health with Coworkers",
                              "Are Comfortable Discussing\nMental Health with Supervisor")

server <- function(input, output) {
  output$props_plot <- renderPlotly({
    props_chart <- ggplot(data = summary_table) +
      geom_col(mapping = aes(x = `Company Size`,
                                    y = summary_table[[input$prop]])) +
      ylim(0, 1) +
      scale_x_discrete(limits = order) +
      labs(title = "Company Size Effects on Mental Health Statistics",
           x = "Company Size",
           y = paste("Proportion of Respondents That\n", input$prop))
    ggplotly(props_chart)
  })

  output$plot <- renderPlotly({
    mental_health <- mental_health %>%
      filter(Age > 14 & Age < 118) %>%
      filter(leave != "Don't know") %>%
      group_by(input$x_var)
    
    age_plot <- ggplot(data = mental_health) +
      geom_histogram(mapping = aes(x = Age)) +
      facet_wrap(~mental_health[[input$x_var]]) +
      labs(
        title = 
          if (input$x_var == "work_interfere")
           title <- "Mental Health Interference with Work and Age"
          else if (input$x_var == "no_employees")
            title <- "Company Size and Age"
          else if (input$x_var == "leave")
            title <- "Difficulty Taking Medical Leave and Age",
        y = "Number of Respondents")
    ggplotly(age_plot)
  })
}
