# Script for returning chart 2
library("ggplot2")
library("dplyr")
library("tidyr")

# Average total death versus year
total_death_vs_year <- function (data_set) {
  data_trim <- data_set %>%
    select(Year, TOTAL_DEATHS, VEI) %>%
    group_by(Year) %>%
    na.omit() %>%
    filter(Year > 1979 & Year < 2001) %>%
    summarise_each(list(mean)) %>%
    mutate_if(is.numeric, ~round(., 0))

  ggplot(data = data_trim, aes(x = Year, y = TOTAL_DEATHS)) +
    geom_line(aes(color = VEI)) +
    ggtitle("Average Total Deaths per Year") +
    ylab("Total Deaths")
}
