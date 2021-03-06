library(tidyverse)

tech_data <- read.csv("https://raw.githubusercontent.com/info201a-w21/project-victoriathegr8/main/data/mental_health_in_tech/survey.csv?token=ASMBIFL6ND43XEW5XCUKBPDAIESBS")

age_parameters <- tech_data %>%
  filter(14 < Age & Age < 118) %>%
  group_by(Age)

age_chart <- ggplot(data = age_parameters) +
  geom_boxplot(mapping = aes(x = Age)) +
  labs(
    title = "Age Range of Survey Participants",
    x = "Age of Respondents",
    y = "Survey Participants"
  ) +
  theme(
    axis.text.y = element_blank()
  )