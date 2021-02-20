library(tidyverse)
library(ggplot2)

tech_data <- read.csv("https://raw.githubusercontent.com/info201a-w21/project-victoriathegr8/main/data/mental_health_in_tech/survey.csv?token=ASMBIFLEYLWXVAMZZG7G6DTAG7G7U")

number_of_employees <- tech_data %>%
  group_by(no_employees) %>%
  summarize(num_of_employees = length(no_employees))

bar_plot <- ggplot(data = number_of_employees) +
  geom_col(mapping = aes(x = no_employees, y = num_of_employees)) +
  labs(title = "Size of Company at which the Respondents Work",
       x = "Company size",
       y = "Total Respondents"
  )
