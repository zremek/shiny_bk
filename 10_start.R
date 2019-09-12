library(tidyverse)
library(readxl)
library(forcats)

Sys.setenv(LANGUAGE = "en")


# średnia oznacza % osób bez pracy w chwili badania

rg <- "B56:F59" 

re2019_i_ro17_18 <- readxl::read_excel(path = "re2019_i_ro17_18.xlsx", range = rg)
re2019_ii_ro15_16 <- read_excel("re2019_ii_ro15_16.xlsx", range = rg)
re2019_iii_ro13_14 <- read_excel("re2019_iii_ro13_14.xlsx", range = rg)
re2018_i_ro16_17 <- read_excel("re2018_i_ro16_17.xlsx", range = rg)
re2018_ii_ro14_15 <- read_excel("re2018_ii_ro14_15.xlsx", range = rg)
re2018_iii_ro12_15 <- read_excel("re2018_iii_ro12_15.xlsx", range = rg)
re2017_i_ro15_16 <- read_excel("re2017_i_ro15_16.xlsx", range = rg)
re2017_ii_ro13_14 <- read_excel("re2017_ii_ro13_14.xlsx", range = rg)
re2017_iii_ro11_12 <- read_excel("re2017_iii_ro11_12.xlsx", range = rg)

clean <- function(df, grad, surv) {
  df %>% filter(!is.na(...1)) %>% 
    select(-(...2)) %>% 
    mutate(graduation = grad,
           surveyed = surv,
           tour = as.numeric(surv) - as.numeric(substr(x = grad,
                                                       start = 6,
                                                       stop = 9))) %>% 
    rename(mode = "...1")
    
}

i17 <- clean(re2017_i_ro15_16, "2015/2016", "2017")
ii17 <- clean(re2017_ii_ro13_14, "2013/2014", "2017")
iii17 <- clean(re2017_iii_ro11_12, "2011/2012", "2017")
i18 <- clean(re2018_i_ro16_17, "2016/2017", "2018")
ii18 <- clean(re2018_ii_ro14_15, "2014/2015", "2018")
iii18 <- clean(re2018_iii_ro12_15, "2012/2013", "2018")
i19 <- clean(re2019_i_ro17_18, "2017/2018", "2019")
ii19 <- clean(re2019_ii_ro15_16, "2015/2016", "2019")
iii19 <- clean(re2019_iii_ro13_14, "2013/2014", "2019")

df <- bind_rows(i17, ii17, iii17,
                i18, ii18, iii18,
                i19, ii19, iii19)

df <- df %>%
  mutate(tour_descr = forcats::fct_recode(factor(tour), 
                                               `I tura` = "1",
                                               `II tura` = "3",
                                               `III tura` = "5"))

df <- df %>% 
  gather(`Studia I stopnia (licencjackie)`,
         `Studia II stopnia (uzupełniające magisterskie)`,
         `Jednolite studia magisterskie`,
         key = "type",
         value = "not_working_pct") %>% 
  mutate(not_working_pct = as.numeric(not_working_pct))

df$mode <- substr(df$mode, 1, nchar(df$mode)-1)

write_csv(x = df, path = "df.csv")
# df <- read_csv("df.csv")

# df %>% 
#   filter(surveyed == "2017") %>% 
#   ggplot(aes(x = type, y = not_working_pct, fill = mode)) +
#   geom_col(position = "dodge") +
#   facet_grid(. ~ tour_descr) 
# 
# 
# df %>% 
#   ggplot(aes(x = type, y = not_working_pct, fill = mode)) +
#   geom_col(position = "dodge") +
#   facet_grid(surveyed ~ tour_descr) +
#   coord_flip()
