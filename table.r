library(tidyverse)
library(dplyr)
library(stringr)
table_of_data <- `survey.(1)` %>% 
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
  View()