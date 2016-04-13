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
select(bank, ends_with("tion"), everything() ) # change the order of columns

## ------------------------------------------------------------------------
select(bank, matches(".r")) # match all variables containing "r", but not at the first place

## ------------------------------------------------------------------------
bank2 <- select(bank, x1 = year, x2 = month, x3 = day, x4 = age, x5 = job)

## ------------------------------------------------------------------------
select(bank2, num_range("x", 1:3)) # select x1, x2, x3
select(bank2, num_range("x", c(1,3,5))) # select x1, x3, x5

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

