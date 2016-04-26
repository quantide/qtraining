## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples
require(dplyr)
require(qdata)
data(bank)

## ------------------------------------------------------------------------
a1 <- group_by(bank, date)
a2 <- select(a1, age, balance)
a3 <- summarise(a2,
                mean_age = mean(age, na.rm = TRUE),
                mean_balance = mean(balance, na.rm = TRUE)
                )
(a4 <- filter(a3, mean_age < 40 & mean_balance > 5000))

## ------------------------------------------------------------------------
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

## ------------------------------------------------------------------------
bank %>%
  group_by(date) %>%
  select(age, balance) %>%
  summarise(
    mean_age = mean(age, na.rm = TRUE),
    mean_balance = mean(balance, na.rm = TRUE)
  ) %>%
  filter(mean_age < 40 & mean_balance > 5000)

