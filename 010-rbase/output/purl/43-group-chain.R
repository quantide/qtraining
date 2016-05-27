## ----first, message=FALSE------------------------------------------------
require(dplyr)
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

## ----group_by_1----------------------------------------------------------
bank <- tbl_df(bank)
# Split the complete dataset (bank) into years (group the df) 
by_year <- group_by(bank, year)
# Summarise each year applying summarise() verb to the grouped df (by_year)
summarise(by_year,
          count = n(),
          mean_duration = mean(duration, na.rm = TRUE),
          mean_balance = mean(balance, na.rm = TRUE))

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

## ----chain1--------------------------------------------------------------
a1 <- group_by(bank, date)
a2 <- select(a1, age, balance)
a3 <- summarise(a2,
                mean_age = mean(age, na.rm = TRUE),
                mean_balance = mean(balance, na.rm = TRUE)
                )
(a4 <- filter(a3, mean_age < 40 & mean_balance > 5000))

## ----chain2--------------------------------------------------------------
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

## ----chain3--------------------------------------------------------------
bank %>%
  group_by(date) %>%
  select(age, balance) %>%
  summarise(
    mean_age = mean(age, na.rm = TRUE),
    mean_balance = mean(balance, na.rm = TRUE)
  ) %>%
  filter(mean_age < 40 & mean_balance > 5000)

