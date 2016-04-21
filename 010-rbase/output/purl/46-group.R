## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples
require(dplyr)
require(qdata)
data(bank)

## ------------------------------------------------------------------------
df <- data.frame(x = 1:6, f = rep(1:2, each = 3))
dff <- df %>% group_by(f)
dff
class(dff)


dffn <- dff %>% mutate(n = row_number())

class(dffn)

dffa <- dff %>% arrange(desc(x))

class(dffa)

dfg <- df %>% 
  group_by(f) %>%
  summarise(x_avg = mean(x))

dfg

class(dfg)

## ------------------------------------------------------------------------
bank <- tbl_df(bank)
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
df <- data.frame(year = rep(c(2010, 2011, 2012), each = 3), 
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


