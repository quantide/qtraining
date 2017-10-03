## ----message=FALSE-------------------------------------------------------
require(tidyverse)

## ----bank_tbl_df, message=FALSE------------------------------------------
require(qdata)
data(bank) 

## ----pipe1---------------------------------------------------------------
head(bank)

## ----pipe2---------------------------------------------------------------
bank %>% head()

## ----pipe3---------------------------------------------------------------
bank %>% head(n=10)

## ------------------------------------------------------------------------
require(tidyverse)

## ------------------------------------------------------------------------
require(tibble)
require(dplyr)

## ----data frame, message=FALSE-------------------------------------------
# Example of data frame
class(mtcars)

# If we do not convert it as a tbl_df, all mtcars rows and columns will be printed when calling mtcars 
dim(mtcars)
mtcars

## ----tibble, message=FALSE-----------------------------------------------
# tibble version of the same data frame 
mtcars_tbl <- as_tibble(mtcars)
mtcars_tbl

## ----tbl_df, message=FALSE-----------------------------------------------
# tibble version of the data frame mtcars with the function tbl_df()
mtcars_tbl2 <- tbl_df(mtcars)
class(mtcars_tbl)
mtcars_tbl

## ----tibble2, message=FALSE----------------------------------------------
# tibble version of the data frame mtcars with the function tbl_df()
tb <- tibble(
  id = 1:5,
  height = c(1.7, 1.65, 1.6, 1.75, 1.73),
  weight = c(80, 46, 52, 82, 75),
  bmi = weight/ (height) ^2
)
tb

## ----tibble3, message=FALSE----------------------------------------------
# tibble version of the data frame mtcars with the function tbl_df()
tb <- tibble(
  ":)" = "happy",
  "1" = "one",
  "/" = "slash",
  " " = "space"
)
tb

