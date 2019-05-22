# Script for calculating summary information
library(dplyr)

# Summary info
get_summary_info <- function(vol_df) {
  vol <- list()
    # What was the name of the volcano with the highest elevation?
    vol$volcano_with_highest_elevation <- vol_df %>%
      filter(Elevation == max(Elevation, na.rm = TRUE)) %>%
      pull(Name)

    # Number of eruptions between 1980 to 2018
    vol$num_eruption <- nrow(vol_df) - 1

    # Which month had the most eruptions?
    vol$common_month <- vol_df %>%
      group_by(Month) %>%
      summarize(sum_month = length(Month)) %>%
      filter(sum_month == max(sum_month, na.rm = TRUE)) %>%
      pull(Month)

    # What types of volcanos eruptions most frequently?
    vol$volcano_type <- vol_df %>%
      group_by(Type) %>%
      summarize(sum_type = length(Type)) %>%
      filter(sum_type == max(sum_type, na.rm = TRUE)) %>%
      pull(Type)

    # Which year had the most people dead caused by volcano eruptions?
    vol$year_most_dead <- vol_df %>%
      group_by(Year) %>%
      summarize(sum_death = sum(DEATHS, na.rm = TRUE)) %>%
      filter(sum_death == max(sum_death, na.rm = TRUE)) %>%
      pull(Year)

    # Which contry had the most volcano eruptions?
    vol$country_most_eruptions <- vol_df %>%
      group_by(Country) %>%
      summarize(sum_country = length(Country)) %>%
      filter(sum_country == max(sum_country)) %>%
      pull(Country)

    # total death caused by volcano eruptions
    vol$total_death <- vol_df %>%
      group_by(DEATHS) %>%
      summarise(sum_death = sum(DEATHS, na.rm = TRUE)) %>%
      summarise(sum_death = sum(sum_death)) %>%
      pull(sum_death)

    # The name of the volcano which had the most damage in $
    vol$most_damage <- vol_df %>%
      filter(DAMAGE_MILLIONS_DOLLARS ==
             max(DAMAGE_MILLIONS_DOLLARS, na.rm = TRUE)) %>%
      pull(Name)

  return (vol)
}
