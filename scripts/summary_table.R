# Script for table of summary information
library(dplyr)
library(tidyr)

# Out of the eruptions with recorded VEI's, what was the average for each year?
# Also, what number of incidents per year did not have recorded incidents?
get_table_info <- function(volcanos) {
  vol_df <- volcanos %>%
    drop_na(Year) %>%
    group_by(Year) %>%
    summarise(Incidents = n())
  vol_df_two <- volcanos %>%
    drop_na(VEI)
  vol_table <- vol_df_two %>%
    group_by(Year) %>%
    summarize(Incidents = n(), AVG_VEI = sum(VEI) / n())
  vol_table <- left_join(vol_df, vol_table, by = "Year")
  vol_table$AVG_VEI[is.na(vol_table$AVG_VEI)] <- "Not Available"
  vol_table$Incidents.y[is.na(vol_table$Incidents.y)] <- 0
  vol_table <- vol_table %>%
    mutate("Missing incidents" = Incidents.x - Incidents.y)
  names(vol_table)[names(vol_table) == "Incidents.y"] <-
    "Number of Incidents with Recorded VEI"
  names(vol_table)[names(vol_table) == "Incidents.x"] <-
    "Total Number of Incidents"
  names(vol_table)[names(vol_table) == "AVG_VEI"] <-
    "Average VEI"
  return(vol_table)
}
