## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples
require(dplyr)
require(qdata)
data(bank)

## ------------------------------------------------------------------------
filter(mtcars, disp > 450) 

## ------------------------------------------------------------------------
fun1 <- function(data, x, threshold) {
  filter(data, x > threshold)
}  

## ---- error = TRUE-------------------------------------------------------
fun1(mtcars, x = disp, threshold = 450)

## ------------------------------------------------------------------------
fun2 <- function(data, x, threshold) {
  quoted <- paste(substitute(x), threshold, sep = '>')
  filter_(data, quoted)
}  
fun2(tbl_df(mtcars), x = disp, threshold = 450)

## ----message=FALSE-------------------------------------------------------
require(lazyeval)

## ------------------------------------------------------------------------
fun3 <- function(data, x, threshold) {
  lazy_x <- lazy(x)
  x <- lazy_eval(lazy_x, data)
  data[x > threshold, ]
}  

fun3(mtcars, x = disp, threshold = 450)

## ------------------------------------------------------------------------
fun4_ <- function(data, x, threshold) {
  x <- lazy_eval(x, data)
  data[x > threshold, ]
}  

fun4_(mtcars, x = 'disp', threshold = 450)

fun4 <- function(data, x, threshold) {
  x <- lazy(x)
  fun4_(data = data, x = x, threshold = threshold) 
}

fun4(mtcars, x = disp, threshold = 450)

## ------------------------------------------------------------------------
summarise(bank, mean_balance = mean(balance, na.rm = TRUE))

## ------------------------------------------------------------------------
summarise_(bank, mean_balance = ~mean(balance, na.rm = TRUE))

## ------------------------------------------------------------------------
summarise_(bank, mean_balance = quote(mean(balance, na.rm = TRUE))) 

## ------------------------------------------------------------------------
summarise_(bank, mean_balance = "mean(balance, na.rm = TRUE)")

## ------------------------------------------------------------------------
constant1 <- function(n) ~n
summarise_(bank, constant1(4))

## ----error=TRUE----------------------------------------------------------
constant2 <- function(n) quote(n)
summarise_(bank, constant2(4))

## ------------------------------------------------------------------------
n <- 10
dots <- list(~mean(balance, na.rm = TRUE), ~n)
summarise_(bank, .dots = dots)

## ------------------------------------------------------------------------
summarise_(bank, .dots = setNames(dots, c("mean", "count"))) 

## ------------------------------------------------------------------------
summarise_by_ <- function(data, g , x , fun){
  
  # prepare input
  dots <- setNames(
    list(
      interp(~n()),
      interp( ~fun(x), x = as.name(x))),
    c("n", "fun"))
  
  # compute  
  data <- data %>% 
    group_by_(g) %>%
    summarise_(.dots = dots)
  
  # return
  return(data)      
}

summarise_by_(mtcars, g = "cyl", x = "disp", fun = mean)

## ------------------------------------------------------------------------
x <- 1:10
interp(~mean(x), as.name(x))

## ------------------------------------------------------------------------
summarise_by <- function(data, g, x, fun){
  g <- substitute(g)
  x <- substitute(x)
  summarise_by_ (data, g , x , fun)
}  

summarise_by (mtcars, g = cyl , x = disp , fun = mean)

