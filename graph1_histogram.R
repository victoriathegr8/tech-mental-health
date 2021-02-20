library(tidyverse)
mental_health <- read.csv("https://raw.githubusercontent.com/info201a-w21/project-victoriathegr8/main/data/mental_health_in_tech/survey.csv?token=ASMBIFLEYLWXVAMZZG7G6DTAG7G7U") %>%
  filter(Age > 14 & Age < 118) %>%
  filter(leave != "Don't know")


age_vs_leave <- ggplot(data = mental_health) +
  geom_histogram(mapping = aes(x = Age)) +
  facet_wrap(~leave)
age_vs_leave <- age_vs_leave +
  labs(
    title = "Difficulty of Obtaining Medical Leave vs. Age",
    y = "Number of respondents"
    )