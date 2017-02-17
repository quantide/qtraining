## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples
require(dplyr)

## ----bank_tbl_df, message=FALSE------------------------------------------
require(qdata)
data(bank) 

## ----pipe1---------------------------------------------------------------
head(bank)

## ----pipe2---------------------------------------------------------------
bank %>% head()

## ----pipe3---------------------------------------------------------------
bank %>% head(n=10)

