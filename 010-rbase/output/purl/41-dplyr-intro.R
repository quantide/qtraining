## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples
require(dplyr)
require(qdata)
data(bank)

## ----eval=FALSE----------------------------------------------------------
## require(dplyr)

## ----tbl_df_bank---------------------------------------------------------
data(bank)
class(bank)
dim(bank)
bank

## ----tbl_df--------------------------------------------------------------
# Example of data frame
df <- data.frame(matrix(data = runif(20000), nrow = 1000, ncol = 20))
names(df) <- letters[1:20]

class(df)
head(df)

# If we do not convert it as a tbl_df, all df rows and columns will be printed when calling df 
dim(df)

# dplyr version of the same data frame (tbl_df conversion)
dfd <- tbl_df(df)
class(dfd)
dfd

