## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples
if(! "dplyr" %in% installed.packages()) {install.packages("dplyr")}
require(dplyr)
if(! "qdata" %in% installed.packages()) {install.packages("~/gdrive/quantide/int/corsi/corsiR/00-qdata/pkgs/qdata_0.16.tar.gz", repos = NULL, type = "source")}
require(qdata)
data(bank)

## ----grouped_df_class----------------------------------------------------
df <- data.frame(x = 1:6, f = rep(1:2, each = 3))
dff <- group_by(df, f)
dff
class(dff)


dffn <- mutate(dff, n = row_number())
dffn
class(dffn)



dffa <- arrange(dff, desc(x))
dffa
class(dffa)



dfg <- summarise(dff, x_avg = mean(x))

dfg

class(dfg)

## ----group_by_1----------------------------------------------------------
bank <- tbl_df(bank)
by_year <- group_by(bank, year)
summarise(by_year,
          count = n(),
          mean_duration = mean(duration, na.rm = TRUE),
          mean_balance = mean(balance, na.rm = TRUE))

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

