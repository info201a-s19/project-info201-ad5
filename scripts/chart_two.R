# Script for returning chart 2
library("ggplot2")
library("dplyr")
library("tidyr")

data <- read.csv("data/volcano_1980.csv", stringsAsFactors = FALSE)

data_trim <- data %>%
  filter(Year, VEI,TOTAL_DEATHS)

total_death_vs_year <- ggplot(data_trim) +
  geom_col(mapping = aes(x = Year, y = TOTAL_DEATHS, fill = VEI))
