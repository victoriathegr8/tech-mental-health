library(shiny)
library(ggplot2)
source("table.r")

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
}