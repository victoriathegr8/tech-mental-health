library(shiny)
library(ggplot2)
source("table.r")

mental_health <- read.csv("https://raw.githubusercontent.com/info201a-w21/project-victoriathegr8/main/data/mental_health_in_tech/survey.csv?token=ASLIDHBRHUKBMN2U5RGAKW3AJF3YK")
  mental_health <- mental_health %>%
    select(Age, work_interfere, no_employees, leave)
  table_of_data <- table_of_data %>% 
    select(tech_company, easy_to_take_leave, mental_health_benefits_provided, comfortable_discussing_mental_health_with_coworkers)
  
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
  
  colnames(summary_of_data) = c("Company" = "tech_company",
                                "Easy Taking Medical Leave" = "leave_provided_prop",
                                "Provided Mental Health Benefits" = "benefits_provided_prop",
                                "Comfortable Discussing Mental Health With Coworkers" = "comfortable_prop",
                                "Mental Health Effects Work" = "effects_work_prop")
  
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
  
  output$comp_plot <- renderPlotly({
    company_plot <- ggplot(data = summary_of_data) +
      geom_col(mapping = aes(x = tech_company,
                             y = summary_of_data[[input$axis]])) +
      labs(
        title = 
          if (input$axis == "leave_provided_prop")
            title <- "Company Type Effect on Proportion With Ability to Take
              Leave Due to Mental Health"
        else if (input$axis == "comfortable_prop")
          title <- "Company Type Effect on Proportion Comfortable Discussing
              Mental Health With Coworkers"
        else if (input$axis == "benefits_provided_prop")
          title <- "Company Type Effect on Proportion With
              Mental Health Benefits Provided"
        else if (input$axis == "effects_work_prop")
          title <- "Company Type Effect on Proportion With Mental Health
              Inhibiting Work",
        x = "Working For Company in Tech Industry",
        y = "Proportion of Respondents")
    ggplotly(company_plot)
  })
}
