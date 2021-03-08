library(shiny)
library(plotly)
library(tidyverse)
library(ggplot2)

mental_health <- read.csv("https://raw.githubusercontent.com/info201a-w21/project-victoriathegr8/main/data/mental_health_in_tech/survey.csv?token=ASLIDHBRHUKBMN2U5RGAKW3AJF3YK")

mental_health <- mental_health %>%
  select(Age, work_interfere, no_employees, leave)

x_var <- selectInput(
  inputId = "x_var",
  label = "Choose an X Variable",
  choices = c("work_interfere", "no_employees",
              "leave")
)

ui <- fluidPage(
  x_var,
  plotOutput(outputId = "plot")
)