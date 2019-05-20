# Script for table of summary information
library(dplyr)
library(tidyr)

volcanos <- read.csv("data/volcano_1980.csv", stringsAsFactors = FALSE)
# Out of the eruptions with revorded VEI's, what was the average for each year?
# Also, what number of incidents per year did not have recorded incidents?

get_table_info <- function(volcanos) {
vol_df <- drop_na(volcanos, Year) %>%
  group_by(Year) %>%
  summarise(Incidents = n())
vol_df_two <- drop_na(volcanos, VEI)
vol_table <- vol_df_two %>%
  group_by(Year) %>%
  summarize(Incidents = n(), AVG_VEI = sum(VEI) / n())
vol_table <- left_join(vol_df, vol_table, by = "Year")
vol_table$AVG_VEI[is.na(vol_table$AVG_VEI)] = "Not Available"
vol_table$Incidents.y[is.na(vol_table$Incidents.y)] <- 0
vol_table <- vol_table %>%
  mutate("Missing incidents" = Incidents.x - Incidents.y)
vol_table <- rename(vol_table, "Number of Incidents with Recorded VEI" = Incidents.y)
vol_table <- rename(vol_table, "Total Number of Incidents" = Incidents.x)

return(vol_table)
}
