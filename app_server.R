library(shiny)
library(ggplot2)
library(plotly)
library(lintr)
library(reshape2)
source("table.r")

mental_health <- read.csv("data/mental_health_in_tech/survey.csv")
mental_health <- mental_health %>%
  select(Age, work_interfere, no_employees, leave)
table_of_data <- table_of_data %>%
  select(
    tech_company, easy_to_take_leave, mental_health_benefits_provided,
    comfortable_discussing_mental_health_with_coworkers
  )

colnames(mental_health) <- c(
  "Age" = "Age",
  "Mental Health Intereference with Work"
  = "work_interfere",
  "Number of Employees" = "no_employees",
  "Difficulty Taking Medical Leave" = "leave"
)

colnames(summary_table) <- c(
  "Company Size",
  "Have Family History of Mental Illness",
  "Have Received Mental Illness Treatment",
  "Receive Mental Health Benefits from Work",
  "Are Comfortable Discussing\nMental Health with Coworkers",
  "Are Comfortable Discussing\nMental Health with Supervisor"
)

colnames(summary_of_data) <- c(
  "Company", "Easily Able to Take Medical Leave\nDue to Mental Health",
  "Provided Mental Health Benefits",
  "Comfortable Discussing Mental Health With Coworkers",
  "Effected at Work by Mental Health"
)

server <- function(input, output) {
  output$props_plot <- renderPlotly({
    summary_table2 <- melt(summary_table, id.vars = 'Company Size') %>%
      filter(variable %in% input$prop)
    props_chart <- ggplot(summary_table2, aes(x = `Company Size`,
                                             y = value,
                                             fill = variable)) +
      geom_bar(position = "dodge", stat = "identity") +
      ylim(0, 1) +
      scale_x_discrete(limits = order) +
      labs(
        title = "Company Size Effects on Mental Health Statistics",
        x = "Company Size",
        y = "Proportion",
        fill = "Proportion of Respondents That:"
      )
    ggplotly(props_chart)
  })

  output$plot <- renderPlotly({
    mental_health <- mental_health %>%
      filter(Age > 14 & Age < 118) %>%
      filter(leave != "Don't know") %>%
      drop_na(work_interfere) %>%
      group_by(input$x_var)
    
      mental_health$no_employees =
          factor(mental_health$no_employees, levels = order)

    age_plot <- ggplot(data = mental_health) +
      geom_histogram(mapping = aes(x = Age),
                     fill = "darkslateblue") +
      facet_wrap(~ mental_health[[input$x_var]]) +
      labs(
        title =
          if (input$x_var == "work_interfere") {
            "Mental Health Interference with Work and Age"
          } else if (input$x_var == "no_employees") {
            "Company Size and Age"
          } else if (input$x_var == "leave") {
            "Difficulty Taking Medical Leave and Age"
          },
        y = "Number of Respondents"
      ) +
      scale_x_continuous(limits = input$age_range)
    ggplotly(age_plot)
  })

  output$comp_plot <- renderPlotly({
    company_plot <- ggplot(data = summary_of_data) +
      geom_col(mapping = aes(
        x = `Company`,
        y = summary_of_data[[input$axis]],
        text = paste("Proportion:", summary_of_data[[input$axis]])),
        fill = "darkslateblue") +
      ylim(0,1) +
      labs(
        title =
          paste("Company Type Effect on Proportion that are", input$axis),
        x = "Working For Company in Tech Industry",
        y = paste("Proportion of Respondents that are\n", input$axis, 
                  "\r\n\r\n")
      )
    ggplotly(company_plot,
             tooltip = c("text"))
  })
}
