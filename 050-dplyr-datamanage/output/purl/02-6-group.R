## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
# load packages and data
require(tidyverse)
require(qdata)
data(bank)

## ----grouped_df_class----------------------------------------------------
# Example data frame
df <- data.frame(x = 1:6, f = rep(1:2, each = 3))

# Grouped data frame
dff <- group_by(df, f)
dff
class(dff)

# Use dff (grouped data frame) as .data argument value in mutate() 
dffn <- mutate(.data = dff, n = n())
dffn
class(dffn)


# Use dff (grouped data frame) as .data argument value in arrange()
dffa <- arrange(.data = dff, desc(x))
dffa
class(dffa)


# Use dff (grouped data frame) as data argument value in summarise()
dfg <- summarise(.data = dff, x_avg = mean(x))
dfg
class(dfg)

## ------------------------------------------------------------------------
by_year <- group_by(bank, year)
summarise(by_year,
          count = n(),
          mean_duration = mean(duration, na.rm = TRUE),
          mean_balance = mean(balance, na.rm = TRUE))

## ------------------------------------------------------------------------
dm <- mtcars %>% 
  group_by(cyl, carb) %>%
  summarise(mpg_mean = mean(mpg))


tapply(dm$mpg_mean, list(dm$cyl, dm$carb), FUN = I)

with(dm, tapply(mpg_mean, list(cyl, carb), FUN = I))

require(xtable)
xtabs(mpg_mean~cyl+carb, data = dm)


## ------------------------------------------------------------------------
summarise(by_year,
          days = n_distinct(date),
          count = n())

## ------------------------------------------------------------------------
daily <- group_by(bank, year, month, day)
groups(daily)

per_day <- summarise(daily, calls = n())
groups(per_day)

per_month <- summarise(per_day, calls = sum(calls))
groups(per_month)

per_year <- summarise(per_month, calls = sum(calls))
groups(per_year)

## ------------------------------------------------------------------------
df <- data.frame(year = rep(c(2014, 2015, 2016), each = 3), 
                 month = rep(1:3, each = 3), 
                 day = rep(20:22, 3), 
                 x = 1:9)

df

df1 <- df %>% group_by(year, month, day) 

groups(df1)

df2 <-  df1 %>% 
  summarise(x_avg = mean(x), n = n())

df2

groups(df2)

summarise(df2, n())

ungroup(df2) %>% summarise(n())


## ------------------------------------------------------------------------
bank_grouped <- bank %>% 
  group_by(marital)       # group by marital status

bank_grouped %>% 
  summarise(mean(balance))   # calculate the group means

## ------------------------------------------------------------------------
# option 1:
summarise(group_by(bank, marital), mean(balance))

# option 2:
bank %>% 
  group_by(marital) %>%       # group by marital status
  summarise(mean(balance))    # calculate the group means

## ------------------------------------------------------------------------
# option 1
filter(
  summarise(
    select(
      group_by(bank, date), age, balance
    ),
    mean_age = mean(age, na.rm = TRUE),
    mean_balance = mean(balance, na.rm = TRUE)
  ),
  mean_age < 40 & mean_balance > 5000
)

# option 2
bank %>%
  group_by(date) %>%
  select(age, balance) %>%
  summarise(
    mean_age = mean(age, na.rm = TRUE),
    mean_balance = mean(balance, na.rm = TRUE)
  ) %>%
  filter(mean_age < 40 & mean_balance > 5000)

