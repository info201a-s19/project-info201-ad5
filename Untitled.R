library("dplyr")

volcano_data_set <- read.csv("scripts/data/volcano_1980.csv", stringsAsFactors = FALSE)
volcano_data_set <- volcano_data_set[-1, ]

top_five_country_greaest_damage <- 
  volcano_data_set  %>%
    select(Country, VEI, TOTAL_DAMAGE_MILLIONS_DOLLARS) %>%
    replace(is.na(.), 0) %>%
    group_by(Country) %>%
    summarize(total_damage = sum(TOTAL_DAMAGE_MILLIONS_DOLLARS)) %>%
    top_n(5, total_damage) %>%
    arrange(-total_damage)
    

