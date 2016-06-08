## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
require(dplyr)
require(qdata)
data(bank) 
bank <- tbl_df(bank)

## ----bank----------------------------------------------------------------
# Select columns: year, month and day of bank data frame
select(bank, year, month, day)
# Select columns: year, month and day of bank data frame
select(bank, year:day)
# Select all columns of bank data frame apart from: year, month and day
select(bank, -(year:day))

## ------------------------------------------------------------------------
# Rename id variable as ID
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
select(wimbledon, num_range("s", c(1:3, 5)))

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
# find out unique values of housing variable of bank data frame
distinct(select(bank, housing))
# find out combinations of unique values of housing and loan variables of bank data frame
distinct(select(bank, housing, loan))

## ------------------------------------------------------------------------
# Rename id variable as ID
rename(bank, ID = id)

