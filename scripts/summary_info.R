# Script for calculating summary information
library(dplyr)
vol_df <- read.csv("data/volcano_1980.csv", stringsAsFactors = FALSE)

# What was the name of the volcano with the highest elevation?
volcano_with_highest_elevation <- vol_df %>%
  filter(Elevation == max(Elevation, na.rm = TRUE)) %>%
  pull(Name)

# Number of eruptions between 1980 to 2018
num_eruption <- nrow(vol_df) - 1

# Which month had the most eruptions?
common_month <- vol_df %>%
  group_by(Month)


get_summary_info <- function(vol_df) {
  vol_df <- list(
    num_eruption,
    volcano_with_highest_elevation
    
  )
  return (vol_df)
} 
