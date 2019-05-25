# Script for returning chart 3

library("dplyr")
library("ggplot2")

top_five_country_greaest_damage <- function (data_set) {
  data_trim <- data_set %>%
    select(Country, VEI, TOTAL_DAMAGE_MILLIONS_DOLLARS) %>%
    replace(is.na(.), 0) %>%
    group_by(Country) %>%
    summarize(total_damage = sum(TOTAL_DAMAGE_MILLIONS_DOLLARS)) %>%
    top_n(5, total_damage) %>%
    arrange(-total_damage)

  ggplot(data = data_trim) +
    geom_col(mapping = aes(x = Country, y = total_damage)) +
    ggtitle("Top 5 Countries Most Impacted") +
    ylab("Total Damage")
}
