library(tidyverse)
library(dplyr)
library(stringr)
library(ggplot2)
table_of_data <- read.csv("https://raw.githubusercontent.com/info201a-w21/project-victoriathegr8/main/data/mental_health_in_tech/survey.csv?token=ASMBIFOVTDWFI54FR2XRHWTAGWL6G") %>% 
  select(-Timestamp) %>% 
  drop_na(state) %>% 
  select(-Country) %>% 
  select(-comments) %>% 
  mutate(family_history_of_mental_illness = family_history) %>% 
  select(-family_history) %>% 
  mutate(previous_treatment_for_mental_illness = treatment) %>% 
  select(-treatment) %>%
  mutate(mental_illness_effects_work = work_interfere) %>% 
  select(-work_interfere) %>% 
  mutate(company_employee_total = no_employees) %>% 
  select(-no_employees) %>% 
  mutate(majority_of_worktime_remote = remote_work) %>% 
  select(-remote_work) %>% 
  mutate(mental_health_benefits_provided = benefits) %>%
  select(-benefits) %>% 
  select(-Gender) %>% 
  mutate(aware_of_mental_health_care_provided = care_options) %>% 
  select(-care_options) %>% 
  select(-wellness_program) %>% 
  select(-seek_help) %>% 
  select(-anonymity) %>% 
  mutate(easy_to_take_leave = leave) %>% 
  select(-leave) %>% 
  select(-mental_health_consequence) %>% 
  select(-phys_health_consequence) %>% 
  mutate(comfortable_discussing_mental_health_with_coworkers = coworkers) %>%
  select(-coworkers) %>% 
  mutate(comfortable_discussing_mental_health_with_supervisor = supervisor) %>% 
  select(-supervisor) %>% 
  select(-mental_health_interview) %>% 
  select(-phys_health_interview) %>% 
  select(-mental_vs_physical) %>% 
  select(-obs_consequence) %>%
  arrange(state, by_group = T)

number_of_employees <- as.data.frame(table(table_of_data$company_employee_total)) 
number_of_employees$Var1 <- factor(number_of_employees$Var1, levels = c("1-5", "6-25", "26-100", "100-500", "500-1000", "More than 1000"))
bar_plot <- ggplot(number_of_employees, aes(Var1, Freq)) + 
  geom_bar(stat = "identity") + 
  labs(title = "Respondent Total For Company Size",
       x = "Company size",
       y = "Total Respondents"
  )