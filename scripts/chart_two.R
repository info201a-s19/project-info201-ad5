# Script for returning chart 2
library("ggplot2")
library("dplyr")
library("tidyr")

total_death_vs_year <- function (data_set) {
  data_trim <- data_set %>%
    select(Year, VEI,TOTAL_DEATHS) %>%
    replace(is.na(.), 0) %>%
    filter(Year > 1979 & Year < 2001)
  
  ggplot(data_trim) +
    geom_col(mapping = aes(x = Year, y = TOTAL_DEATHS, fill = VEI))
}
