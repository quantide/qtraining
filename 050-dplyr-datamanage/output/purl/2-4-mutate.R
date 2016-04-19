## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples
require(dplyr)
require(qdata)
data(bank)

## ------------------------------------------------------------------------
df <- data.frame(x = 1:3, y = 3:1)

df %>% mutate(x1 = x+1)

df %>% mutate(x = x+1)


df %>% mutate(x = x+1, y = x+1)

df %>% mutate(y = x+1, x = x+1)


df %>% mutate(x1 = x+1, y1 = x1+1)

#df %>% mutate(y1 = x1+1, x1 = x+1)
df %>% mutate(y1 = x+1, x1 = x+1)

df %>% mutate(xx = x)


## ------------------------------------------------------------------------
bank <- tbl_df(bank)
bank %>% 
  select (year, age, balance) %>%
  mutate(balance_by_age = balance / age, year_of_birth = year - age)

## ------------------------------------------------------------------------
mutate(bank, year_of_birth = year - age, year_of_birth_no_century = year_of_birth - 1900)

## ---- error=TRUE---------------------------------------------------------
transform(bank, year_of_birth = year - age, year_of_birth_no_century = year_of_birth - 1900)

## ------------------------------------------------------------------------
transmute(bank, year_of_birth = year - age, year_of_birth_no_century = year_of_birth - 1900)

## ------------------------------------------------------------------------
time <- select(bank, duration)
mutate(time, lead_duration = lead(duration) ,delta_duration = lead_duration - duration)

## ------------------------------------------------------------------------
mutate(time, lag_duration = lag(duration) ,delta_duration = duration - lag_duration)

## ------------------------------------------------------------------------
mutate(time, duration_rank = min_rank(duration))

## ------------------------------------------------------------------------
mutate(time, duration_rank = dense_rank(duration))

## ------------------------------------------------------------------------
mutate(time, duration_rank = percent_rank(duration))

## ------------------------------------------------------------------------
mutate(time, duration_rank = row_number(duration))

## ------------------------------------------------------------------------
mutate(time, duration_rank = ntile(duration, 10))

## ------------------------------------------------------------------------
mutate(time, duration_rank = cume_dist(duration))

## ------------------------------------------------------------------------
mutate(time, duration_rank = between(duration, 0, 90))

## ------------------------------------------------------------------------
mutate(time, long_duration = cumall(duration > 100))

## ------------------------------------------------------------------------
mutate(time, short_duration = cumany(duration < 100))

## ------------------------------------------------------------------------
mutate(time, mean_duration = cummean(duration))

