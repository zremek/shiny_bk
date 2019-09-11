library(tidyverse)
library(readxl)

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

## todo
# funkcja do czyszczenia danych i dodania zmiennych (realizacja, rocznik, tura)
# ramki do listy
# czyszczenia po elementach listy
# złączenie w jedną ramkę 