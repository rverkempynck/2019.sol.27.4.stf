
rm(list=ls())

library(tidyverse)

load("output.RData")
load("data.RData")

assyear <- 2019

yearclass <- c((assyear-1):(assyear-42))

y <- data.frame(yearclass = yearclass,
                year1 = yearclass + 1,
                year2 = yearclass + 2) %>% 
  arrange(yearclass)

age1 <- as.data.frame(stock.n(ass.stock)[1,]) %>%
  filter(year %in% y$year1) %>% 
  select(year1 = "year", age1 = "data")
  
age2 <- as.data.frame(stock.n(ass.stock)[2,]) %>%
  filter(year %in% y$year2) %>%
  select(year2 = "year", age2 = "data")

dfs0 <- as.data.frame(index(indices[[3]][1,])) %>% 
  filter(year %in% yearclass) %>%
  select(yearclass = "year", dfs0 = "data")

sns0 <- as.data.frame(index(indices[[2]][1,])) %>% 
  filter(year %in% yearclass) %>%
  select(yearclass = "year", sns0 = "data")

sns1 <- as.data.frame(index(indices[[2]][2,])) %>% 
  filter(year %in% y$year1) %>%
  select(year1 = "year", sns1 = "data")

bts1 <- as.data.frame(index(ass.indices[[1]][1,])) %>% 
  filter(year %in% y$year1) %>%
  select(year1 = "year", bts1 = "data")

altin1 <- full_join(y, age1, by = "year1") %>% 
  full_join(., dfs0, by = "yearclass") %>% 
  full_join(., sns0, by = "yearclass") %>%
  full_join(., sns1, by = "year1") %>%
  full_join(., bts1, by = "year1") %>%
  mutate(age1 = ifelse( yearclass > (assyear - 5), "NA", age1)) %>% 
  select(yearclass, age1, dfs0, sns0, sns1, bts1)

write_tsv(altin1, "altin_1.txt")

altin2 <- full_join(y, age2, by = "year2") %>% 
  full_join(., dfs0, by = "yearclass") %>% 
  full_join(., sns0, by = "yearclass") %>%
  full_join(., sns1, by = "year1") %>%
  full_join(., bts1, by = "year1") %>%
  mutate(age2 = ifelse( yearclass > (assyear - 5), "NA", age2)) %>% 
  select(yearclass, age2, dfs0, sns0, sns1, bts1)

write_tsv(altin2, "altin_2.txt")

## now write altin1 and altin2, manually remove headers and add rct3 stuff tot the files

