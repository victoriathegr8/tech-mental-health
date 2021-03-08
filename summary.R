tech_data <- read.csv("https://raw.githubusercontent.com/info201a-w21/project-victoriathegr8/main/data/mental_health_in_tech/survey.csv?token=ASMBIFK6ZVKUWQ6L32NP6A3AIEOQS")
library(tidyverse)

# How many individuals responded to this survey?
num_respondents <- tech_data %>%
  nrow()

# Find the average age of the respondents.
avg_age <- tech_data %>%
  filter(14 < Age & Age < 118) %>%
  summarize(Age = mean(Age, na.rm = T)) %>%
  pull(Age)

# Find the number of participants from each state and the number of respondents
# in the state with the most respondents.
state_respondents <- tech_data %>%
  group_by(state) %>%
  summarize(num_of_state = length(state))

most_state_respondents <- tech_data %>%
  group_by(state) %>%
  summarize(num_of_state = length(state)) %>%
  filter(state == "CA") %>%
  pull(num_of_state)

# Find the company size with the largest number of respondents.
company_size <- tech_data %>%
  group_by(no_employees) %>%
  summarize(num_of_employees = length(no_employees)) %>%
  filter(num_of_employees == max(num_of_employees, na.rm = T)) %>%
  pull(no_employees)

# How frequently did a respondents mental health interfere with their work?
work_interfere <- tech_data %>%
  group_by(work_interfere) %>%
  summarize(num_of_responses = length(work_interfere)) %>%
  filter(work_interfere == "Sometimes") %>%
  pull(num_of_responses)

# How easy did respondents find taking medical leave for mental health to be?
take_leave <- tech_data %>%
  group_by(leave) %>%
  summarize(num_of_responses = length(leave)) %>%
  filter(leave == "Very difficult") %>%
  pull(num_of_responses)
