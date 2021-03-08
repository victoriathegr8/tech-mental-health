library(shiny)
library(ggplot2)
library(plotly)
library(tidyverse)

mental_health <- read.csv("https://raw.githubusercontent.com/info201a-w21/project-victoriathegr8/main/data/mental_health_in_tech/survey.csv?token=ASLIDHBRHUKBMN2U5RGAKW3AJF3YK")

source("app_ui.R")
source("app_server.R")

shinyApp(ui = ui, server = server)