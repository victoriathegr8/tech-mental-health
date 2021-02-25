library(tidyverse)
library(ggplot2)

tech_data <- read.csv("https://raw.githubusercontent.com/info201a-w21/project-victoriathegr8/main/data/mental_health_in_tech/survey.csv?token=ASMBIFL6ND43XEW5XCUKBPDAIESBS")

order <- c("1-5", "6-25", "26-100", "100-500", "500-1000", "More than 1000")

number_of_employees <- tech_data %>%
  group_by(no_employees) %>%
  summarize(num_of_employees = length(no_employees)) %>%
  slice(match(order, no_employees))

bar_plot <- ggplot(data = number_of_employees) +
  geom_col(mapping = aes(x = no_employees, y = num_of_employees)) +
  scale_x_discrete(limits = order) +
  labs(title = "Size of Company at which the Respondents Work",
       x = "Size of Company",
       y = "Total Respondents"
  )
