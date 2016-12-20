## ----dataframe1----------------------------------------------------------
df <- data.frame(
  name = c("James", "Stevie", "Otis", "Bob", "Levon", "Patti", "Karen"), 
  height = c(180, 170, 175, 190, 168, 160, 165), 
  graduated = c(TRUE, TRUE, FALSE, FALSE, FALSE, TRUE, TRUE),
  gender = factor(c("M", "M", "M", "M", "M", "F", "F")), 
  stringsAsFactors = FALSE)
df

## ----vector--------------------------------------------------------------
# Numeric vector
height <- c(180, 170, 175, 190, 168, 160, 165)
height
# Character vector
name <- c("James", "Stevie", "Otis", "Bob", "Levon", "Patti", "Karen")
name
# Logical vector
graduated <- c(TRUE, TRUE, FALSE, FALSE, FALSE, TRUE, TRUE)
graduated

## ----factor--------------------------------------------------------------
# Factor variable
gender <- factor(c("M", "M", "M", "M", "M", "F", "F"))
gender

## ----dataframe2----------------------------------------------------------
df <- data.frame(name, height, graduated, gender, stringsAsFactors = FALSE)
df

## ----tbl_df, message=FALSE-----------------------------------------------
# Example of data frame
data("mtcars")
class(mtcars)

# If we do not convert it as a tbl_df, all mtcars rows and columns will be printed when calling mtcars 
dim(mtcars)
mtcars

# dplyr version of the same data frame (tbl_df conversion)
require(dplyr)
mtcars_tbl <- tbl_df(mtcars)
class(mtcars_tbl)
mtcars_tbl

## ----matrix--------------------------------------------------------------
matrix(1:8, nrow = 2, ncol = 4)

## ----array---------------------------------------------------------------
z <- array(1:24, dim=c(2,3,4))
z

## ----list----------------------------------------------------------------
my_list <- list(vec = 1:7, mat = matrix(1:12, ncol = 3),
  lis = list(a = 1, b = letters[1:4]))
my_list

