library(tidyverse)
library(readr)
library(here)
here::here()

bank_colors = tibble(bank = c("Chase", "Amex"),
                     color = c("#117ACA","#002663"))

input <- read_csv("Bonus timing.csv") %>% 
  left_join(bank_colors, by = "bank")
  

g.gantt <- input %>%  
  mutate(item = row_number(),
  offer = as_factor(str_wrap(offer, 20))) %>% 
  gather("state", "date", start, end) 



g.gantt %>% ggplot(aes(date, offer)) +
  geom_line(size = 10) +
  labs(x="Offer Date", y=NULL, title="") + 
  theme_minimal() +
  theme(panel.grid.minor=element_blank(),
        text = element_text(size=14)) +
  scale_x_date(date_labels = "%d %b",
               breaks = seq(as.Date("2020-05-01"), as.Date("2021-01-01"), by = "months"))
  
