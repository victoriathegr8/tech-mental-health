library(tidyverse)
library(dplyr)
library(stringr)
library(lintr)
table_of_data <- read.csv("data/mental_health_in_tech/survey.csv") %>%
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

order <- c("1-5", "6-25", "26-100", "100-500", "500-1000", "More than 1000")

summary_table <- table_of_data %>%
  mutate(has_history = if_else(family_history_of_mental_illness == "Yes", 1, 0)) %>%
  mutate(got_treatment = if_else(previous_treatment_for_mental_illness == "Yes", 1, 0)) %>%
  mutate(benefits = if_else(mental_health_benefits_provided == "Yes", 1, 0)) %>%
  mutate(comfortable_coworkers = if_else(comfortable_discussing_mental_health_with_coworkers == "Yes" |
    comfortable_discussing_mental_health_with_coworkers == "Some of them", 1, 0)) %>%
  mutate(comfortable_supervisor = if_else(comfortable_discussing_mental_health_with_supervisor == "Yes" |
    comfortable_discussing_mental_health_with_supervisor == "Some of them", 1, 0)) %>%
  group_by(company_employee_total) %>%
  summarise(
    family_history_of_mental_illness_prop = round(sum(has_history / n()), digits = 3),
    previous_treatment_for_mental_illness_prop = round(sum(got_treatment) / n(), digits = 3),
    mental_health_benefits_provided_prop = round(sum(benefits / n()), digits = 3),
    comfortable_discussing_mental_health_with_coworkers_prop = round(sum(comfortable_coworkers / n()), digits = 3),
    comfortable_discussing_mental_health_with_supervisor_prop = round(sum(comfortable_supervisor / n()), digits = 3)
  ) %>%
  slice(match(order, company_employee_total))

summary_of_data <- table_of_data %>%
  filter(easy_to_take_leave != "Don't know") %>%
  filter(mental_health_benefits_provided != "Don't know") %>%
  drop_na(mental_illness_effects_work) %>% 
  mutate(leave_provided = if_else(easy_to_take_leave == "Very easy" |
                                    easy_to_take_leave == "Somewhat easy", 1, 0)) %>%
  mutate(benefits_provided = if_else(mental_health_benefits_provided == "Yes", 1, 0)) %>%
  mutate(comfortable = if_else(comfortable_discussing_mental_health_with_coworkers == "Yes" |
                                 comfortable_discussing_mental_health_with_coworkers == "Some of them", 1, 0)) %>%
  mutate(effects_work = if_else(mental_illness_effects_work == "Often" |
                                  mental_illness_effects_work == "Sometimes", 1, 0)) %>%
  group_by(tech_company) %>%
  summarise(
    leave_provided_prop = round(sum(leave_provided / n()), digits = 3),
    benefits_provided_prop = round(sum(benefits_provided / n()), digits = 3),
    comfortable_prop = round(sum(comfortable / n()), digits = 3),
    effects_work_prop = round(sum(effects_work / n()), digits = 3))