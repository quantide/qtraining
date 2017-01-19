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

## ----tbl_df, message=FALSE-----------------------------------------------
# Example of data frame
class(mtcars)

# If we do not convert it as a tbl_df, all mtcars rows and columns will be printed when calling mtcars 
dim(mtcars)
mtcars

# dplyr version of the same data frame (tbl_df conversion)
mtcars_tbl <- tbl_df(mtcars)
class(mtcars_tbl)
mtcars_tbl

