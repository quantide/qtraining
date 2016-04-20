## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
require(dplyr)
require(qdata)
data(bank) 
bank <-  tbl_df(bank)

## ----bank----------------------------------------------------------------
select(bank, year, month, day)
select(bank, year:day)
select(bank, -(year:day))

## ------------------------------------------------------------------------
select(bank, ID = id)

## ------------------------------------------------------------------------
select(bank, contains("at"))

## ------------------------------------------------------------------------
select(bank, ends_with("tion"))

## ------------------------------------------------------------------------
select(bank, starts_with("d"))

## ------------------------------------------------------------------------
select(bank, everything())
# change the order of columns
select(bank, ends_with("tion"), everything() ) 

## ------------------------------------------------------------------------
# match all variables containing "r", but not at the first place
select(bank, matches(".r")) 

## ------------------------------------------------------------------------
data(tennis)
wimbledon
select(wimbledon ,num_range("s", c(1:3, 5)))

## ------------------------------------------------------------------------
select(bank, one_of(c("marital","education")))
vars <- c("marital","education")
select(bank, one_of(vars))

## ------------------------------------------------------------------------
select(bank, job:balance)

## ------------------------------------------------------------------------
select(bank, -job)
select(bank, -starts_with("d"))

## ------------------------------------------------------------------------
distinct(select(bank, housing))
distinct(select(bank, housing, loan))

## ------------------------------------------------------------------------
rename(bank, ID = id)

