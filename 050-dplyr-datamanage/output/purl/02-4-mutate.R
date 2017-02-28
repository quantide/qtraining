## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
# load packages and data
require(tidyverse)    # alternatively require(dplyr)
require(qdata)
data(bank)

## ------------------------------------------------------------------------
df <- data.frame(x = 1:3, y = 3:1)

df %>% mutate(x1 = x+1)

df %>% mutate(x = x+1)

df %>% mutate(x = x+1, y = x+1)

df %>% mutate(y = x+1, x = x+1)

df %>% mutate(x1 = x+1, y1 = x1+1)

df %>% mutate(xx = x)

## ------------------------------------------------------------------------
bank %>% 
  select (year, age, balance) %>%
  mutate(balance_by_age = balance / age, year_of_birth = year - age)

## ------------------------------------------------------------------------
bank %>% mutate( year_of_birth = year - age, year_of_birth_no_century = year_of_birth - 1900)

## ---- error=TRUE---------------------------------------------------------
bank %>% transform(year_of_birth = year - age, year_of_birth_no_century = year_of_birth - 1900)

## ------------------------------------------------------------------------
transmute(bank, year_of_birth = year - age, year_of_birth_no_century = year_of_birth - 1900)

## ------------------------------------------------------------------------
time <- select(bank, duration)
time %>% mutate(lead_duration = lead(duration), delta_duration = lead_duration - duration)

## ------------------------------------------------------------------------
time %>% mutate(lag_duration = lag(duration), delta_duration = duration - lag_duration)

## ------------------------------------------------------------------------
time %>% mutate(duration_rank = min_rank(duration))

## ------------------------------------------------------------------------
time %>% mutate(duration_rank = dense_rank(duration))

## ------------------------------------------------------------------------
time %>% mutate(duration_rank = percent_rank(duration))

## ------------------------------------------------------------------------
time %>% mutate(duration_rank = row_number(duration))

## ------------------------------------------------------------------------
time %>% mutate(duration_rank = ntile(duration, 10))

## ------------------------------------------------------------------------
time %>% mutate(duration_rank = cume_dist(duration))

## ------------------------------------------------------------------------
time %>% mutate(duration_rank = between(duration, 0, 90))

## ------------------------------------------------------------------------
time %>% mutate(long_duration = cumall(duration > 100))

## ------------------------------------------------------------------------
time %>% mutate(short_duration = cumany(duration < 100))

## ------------------------------------------------------------------------
time %>% mutate(mean_duration = cummean(duration))

