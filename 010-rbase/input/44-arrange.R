## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples
require(dplyr)
require(qdata)
data(bank) 
bank <- tbl_df(bank)

## ------------------------------------------------------------------------
arrange(bank, balance)

## ------------------------------------------------------------------------
arrange(bank, desc(balance))

## ------------------------------------------------------------------------
arrange(bank, age , desc(balance))

## ------------------------------------------------------------------------
arrange(bank, age , desc(balance)) %>% 
  group_by(age) %>%
  filter(row_number() <= 3) %>%
  select(id, age, balance)

