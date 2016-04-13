## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples
require(dplyr)
require(qdata)
data(bank)

## ------------------------------------------------------------------------
filter(bank, date == "2008-05-05", job == "student")

## ------------------------------------------------------------------------
bank[bank$date == "2008-05-05" & bank$job == "student", ]

## ------------------------------------------------------------------------
filter(bank, age == 18 | age > 90)

## ------------------------------------------------------------------------
filter(bank, age %in% c(18,95))

## ------------------------------------------------------------------------
filter(bank, job %in% c("admin.","technician"))
filter(bank, job == "admin." | job == "technician")

## ------------------------------------------------------------------------
slice(bank, 1:10)
slice(bank, n()) # select last row of the dataset

## ------------------------------------------------------------------------
sample_n(bank, 10)

## ------------------------------------------------------------------------
sample_frac(bank, 0.0001)
sample_frac(bank, 1.5, replace = TRUE)

