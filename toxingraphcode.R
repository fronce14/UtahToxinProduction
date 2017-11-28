library(tidyverse)
library(forcats)
toxindata <- read_csv("TRI_2016_UT.csv")

levels_to_keep <- c("Metal Mining",
                    "Primary Metals")

rolledup <- toxindata %>% 
  mutate(industry_sector = as_factor(case_when(INDUSTRY_SECTOR %in% levels_to_keep ~ INDUSTRY_SECTOR,
                                               TRUE ~ "Other"))) %>% 
  group_by(industry_sector) %>% 
  summarise(totalpounds = sum(`ON-SITE_RELEASE_TOTAL`, na.rm = TRUE))

ggplot(data = rolledup, aes(x = fct_reorder(industry_sector, totalpounds), y = totalpounds)) +
  geom_col() +
  coord_flip() +
  scale_y_continuous(labels = scales::comma) +
  labs(title = "Pounds of Toxins Released Per Industry in Utah, 2016",
       x = "",
       y = "") +
  theme_minimal() +
  theme(panel.grid = element_blank())
