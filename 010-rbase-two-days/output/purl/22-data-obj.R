## ---- numeric------------------------------------------------------------
# Numeric vector
num <- c(1, 2, 5.3, 6, -2, 4)
num

## ---- character----------------------------------------------------------
# Character vector
char <- c("one", "two", "three")
char

## ---- logical1-----------------------------------------------------------
# Logical vector
logic1 <- num > 3
logic1

## ---- logical2-----------------------------------------------------------
# Logical vector
logic2 <- c(TRUE, FALSE, TRUE)
logic2

## ---- mixed--------------------------------------------------------------
mixed <- c("foo", 1, TRUE)
mixed

## ---- concatenate--------------------------------------------------------
vec1 <- c(11, 12, 13)
vec2 <- c(21, 22, 23)
vec3 <- c(31, 32, 33)
comb <- c(vec1, vec2, vec3)
comb

## ---- sequence1----------------------------------------------------------
go <- 1:20
go
back <- 20:1
back

## ---- sequence2----------------------------------------------------------
seqby <- seq(from = 1, to = 5, by = 0.5)
seqby
seqlength <- seq(from = 1, to = 5, length.out = 13) 
seqlength

## ---- rep----------------------------------------------------------------
rep(x = 1 , times = 10)
rep(x = 1:5, times = 3)
rep(x = 1:5 , each = 3)
rep(c("ALI", "IPERLANDO"), times=4)
rep(x = 1:5 , times = 2 , each = 3)


rep(x = "no",  times = 5)
rep(x = c("a", "b", "c"), times = c(3, 2, 1))
rep(x = c("a", "b", "c"), times = rep(4,3))

mydata <- c("a", "b", "c")
myrep <- rep(4,3)
rep(x = mydata, times = myrep)

## ---- subsetting1--------------------------------------------------------
x <- c(1, 4, 2, 5, 6, 8, 6, 9, 10)
x[3]
x[1:3]
x[c(2,4)]

## ---- subsetting2--------------------------------------------------------
x <- c(1, 4, 2, 5, 6, 8, 6, 9, 10)
x[-2]
x[-c(2, 5, 7)]

## ---- subsetting3--------------------------------------------------------
x <- c(1, 4, 2, 5, 6)
x[c(TRUE, TRUE, FALSE, FALSE, TRUE)]
y <- c(TRUE, TRUE, FALSE, FALSE, TRUE)
x[y]
x[!y]

## ---- subsetting4--------------------------------------------------------
x <- c(1, 4, 2, 5, 6, 8, 6, 9, 10)
y <- x > 5
x[y]

## ---- subsetting5--------------------------------------------------------
x[x > 5]

## ---- subsetting6--------------------------------------------------------
x[x >= 2 & x <= 8]

## ---- subsetting7--------------------------------------------------------
x[x < 2 | x > 8]

## ---- unique-------------------------------------------------------------
x <- c(1, 2, 1, 1, 2, 3, 3, 2, 1, 2, 2, 3)
unique(x)

## ---- matrix-------------------------------------------------------------
matrix(1:8, nrow = 2, ncol = 4)

## ---- byrow--------------------------------------------------------------
matrix(1:8, nrow = 2, ncol = 4, byrow = TRUE)

## ---- dim----------------------------------------------------------------
x <- 1:8
x
dim(x) <- c(2, 4)
x

## ---- bind1--------------------------------------------------------------
cmat <- cbind(1:3, 4:6, 7:9)
cmat
rmat <- rbind(1:3, 4:6, 7:9)
rmat

## ---- bind2--------------------------------------------------------------
cbind(cmat, 10:12)
rbind(cmat, rmat, cmat)

## ---- matrix subsetting--------------------------------------------------
x <- matrix(1:24, nrow = 4, ncol = 6, byrow = TRUE)
x[1:2, ]
x[, c(1, 3, 5)]
x[c(1,3), c(1, 4)]
x[-1, ]
x[1:18]
x[x >= 3 & x < 12]

## ----array---------------------------------------------------------------
z <- array(1:24, dim=c(2,3,4))
z

## ---- list---------------------------------------------------------------
x <- 1:5
y <- c(-0.0921, 0.4543, -0.1473, -0.0235, -0.3923)
out <- lsfit(x, y)
out

## ---- list create--------------------------------------------------------
my_list <- list(vec = 1:7, mat = matrix(1:12, ncol = 3),
  lis = list(a = 1, b = letters[1:4]))
my_list

## ---- list subsetting1---------------------------------------------------
my_list[1:2]
my_list[-3]
ml1 <- my_list[1]
ml1

## ---- list subsetting2---------------------------------------------------
ml2 <- my_list[[1]]
ml2
my_list[[2]]
my_list[[3]]

## ---- list subsetting3---------------------------------------------------
my_list$vec
my_list$mat
my_list$lis

## ---- list subsetting4---------------------------------------------------
my_list[[1]][1:3]
my_list$mat[3:4, c(1, 3)]
my_list$lis[1]
my_list$lis[[1]]
my_list$lis$a

## ---- factors------------------------------------------------------------
grade <- c(3, 4, 2, 2, 4, 1, 1, 4, 2, 2)
factor(grade)  
gender <- c(rep("male", 3), rep("female", 4))
gender <- factor(gender, levels=c("male", "female", "trans"))
gender

## ---- factor labels------------------------------------------------------
size <- factor(c(2, 3, 1, 1, 1, 2, 3, 3), levels = c(1, 2, 3),
  labels = c("small", "medium", "large"))
levels(size)
levels(size) <- c("S", "M", "L")
size

## ---- ordered factor-----------------------------------------------------
mark <- sample(c("D", "C", "B", "A"), 12, replace = T)
mark1 <- factor(mark)
mark2 <- factor(mark, levels = c("D", "C", "B", "A"), order = T)
mark1
mark2

## ---- as.numeric as.character--------------------------------------------
as.numeric(size)
as.character(size)

## ---- levels-------------------------------------------------------------
size <- factor(c(2, 3, 1, 1, 1, 2, 3, 3), levels = c(1, 2, 3),
  labels = c("small", "medium", "large"))
size
size[1:5]
size[-4]
levels(size)
size[size == "medium" | size == "large"]

## ---- data frame1--------------------------------------------------------
name <- c("James", "Stevie", "Otis", "Bob", "Levon", "Patti", "Karen")
height <- c(180, 170, 175, 190, 168, 160, 165)
gender <- factor(c("M", "M", "M", "M", "M", "F", "F"))
df <- data.frame(name, height, gender, stringsAsFactors = FALSE)
df

## ---- data frame2--------------------------------------------------------
df <- data.frame(
  height = c(180, 170, 175, 190, 168, 160, 165),
  name = c("James", "Stevie", "Otis", "Bob", "Levon", "Patti", "Karen"),
  gender = factor(c("M", "M", "M", "M", "M", "F", "F")),
  stringsAsFactors = FALSE
)
df

## ---- dfsubsetting1------------------------------------------------------
df[c(1, 3, 7), ]

## ---- dfsubsetting2------------------------------------------------------
df[, c(1, 2)]

## ---- dfsubsetting3------------------------------------------------------
df$height
is.vector(df$height)

## ---- dfsubsetting4------------------------------------------------------
data.frame(height = df$height)
data.frame(height = df$height, name = df$name)

## ---- dim2---------------------------------------------------------------
dim(df)
nrow(df)
ncol(df)

## ---- str----------------------------------------------------------------
df
str(df)

## ---- head---------------------------------------------------------------
nrow(iris)
head(iris)

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

## ---- na-----------------------------------------------------------------
x <- c(4, 1, "a")
y <- as.integer(x)
y

## ---- is.na--------------------------------------------------------------
is.na(y)

## ---- nan----------------------------------------------------------------
log(-1)
sqrt(-4)
x <- log(c(-1, 1, 2))
x
is.nan(x)

## ---- null---------------------------------------------------------------
x <- c()
x
is.null(x)


## ---- inf----------------------------------------------------------------
log(0)

