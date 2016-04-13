## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples
require(dplyr)
require(qdata)
data(bank)

## ----tbl_df_bank---------------------------------------------------------
data(bank)
class(bank)
bank

## ----tbl_df--------------------------------------------------------------
# Example of data frame
df <- setNames(object = data.frame(matrix(data = runif(2000), nrow = 100, ncol = 20)),
               nm = letters[1:20])
class(df)
head(df)
# dplyr version of the same data frame
dfd <- tbl_df(df)
class(dfd)
dfd

