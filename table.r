library(styler)
library(lintr)
style_file("analysis.R")
lint("analysis.R")
library(tidyverse)
library(dplyr)
library(stringr)
library(pscl)
table_by_country <- table(`survey.(1)`$Country) %>% 
#setnames(table_by_country, "Var1", "Country")
  #rename("Var1" == "Country")
  #rename("Freq" == "Total Respondents")
  #colnames(table_by_country)[colnames(table_by_country) == "Freq"] = "Total_Respondents"
  View()

