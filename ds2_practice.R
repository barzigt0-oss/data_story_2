

url <- 'https://ourworldindata.org/grapher/government-spending-by-function.csv?v=1&csvType=full&useColumnShortNames=true'
budget <- read_csv(url)
url <- 'https://ourworldindata.org/grapher/fish-species-threatened.csv?v=1&csvType=full&useColumnShortNames=true'
fish <- read_csv(url)

View(fish)

government_expediture_by_function_unit_share_gov_exp_function_environmental_protection_function_subcatergory_total
library(dplyr)

budget_filt <- budget %>%
  select(entity, year, government_expenditure_by_function__unit_share_gov_exp__function_environmental_protection__function_subcategory_total)

budget_filt <- budget_filt %>%
  filter(year %in% c(2018, 2022)) %>%
  left_join(fish, by = c("entity", "year")) %>%
  select(-en_fsh_thrd_no.x) %>%          # drop one copy
  rename(end_fish = en_fsh_thrd_no.y) %>%
  select(entity, year, gov_exp, end_fish)

colnames(budget_filt)
View(budget_filt)
library(ggplot2)
ggplot(budget_filt,
       aes(x = gov_exp,
           y = end_fish,
           group = entity))+
  geom_point()
ggplotly()