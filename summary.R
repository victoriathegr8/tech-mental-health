tech_data <- read.csv("survey.csv")
library(tidyverse)

# How many individuals responded to this survey?

num_respondents <- tech_data %>%
  nrow()

# Find the average age of the respondents.

avg_age <- tech_data %>%
  mutate(age_no_outliers = if_else(Age > 118, 0, Age)) %>%
  filter(age_no_outliers == max(age_no_outliers, na.rm = T)) %>%
  pull(age_no_outliers)

# Find the number of participants from each state.

state_respondents <- tech_data %>%
  group_by(state) %>%
  summarize(num_of_state = length(state)) %>%
  View()

# Find the number of respondents from each company size.
company_size <- tech_data %>%
  group_by(no_employees) %>%
  summarize(num_of_employees = length(no_employees)) %>%
  View()

# How frequently did a respondents mental health interfere with their work?  
work_interfere <- tech_data %>%
  group_by(work_interfere) %>%
  summarize(num_of_responses = length(work_interfere)) %>%
  View()

# How easy did respondents find taking medical leave for mental health to be?
take_leave <- tech_data %>%
  group_by(leave) %>%
  summarize(num_of_responses = length(leave)) %>%
  View()