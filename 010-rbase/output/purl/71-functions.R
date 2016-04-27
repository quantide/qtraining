## ---- argument1----------------------------------------------------------
ls()

## ---- argument2----------------------------------------------------------
foo = 3
rm(foo)

## ---- argument3----------------------------------------------------------
sum(1:10)

## ---- argument4----------------------------------------------------------
sum(c(1, 2, NA), na.rm = T)

## ---- argument5----------------------------------------------------------
rdata = c(rnorm(100), NA)
quantile(x = rdata, probs = c(0.25, 0.50, 0.75), na.rm = T)
quantile(rdata, c(0.25, 0.50, 0.75), T)
quantile(rdata, T, c(0.25, 0.50, 0.75))
quantile(rdata, na.rm = T, probs = c(0.25, 0.50, 0.75))

## ---- help3, eval=F------------------------------------------------------
## help(read.table)

## ---- help4, eval=F------------------------------------------------------
## ?read.table

## ---- operations---------------------------------------------------------
x = 1:10
y = 11:20
z = -4:5
x + y + z
exp(x)
log(z)
abs(z)
sqrt(x)

## ---- sum----------------------------------------------------------------
sum(x)

## ---- round--------------------------------------------------------------
floor(3.14)
floor(3.67)
ceiling(3.14)
ceiling(3.67)
trunc(3.14)
trunc(3.67)
round(3.14, digits = 1)
round(3.19, digits = 1)

## ---- random-------------------------------------------------------------
rnorm(n = 10)
rnorm(n = 20, mean = 3, sd = 5)
rbinom(n = 50, size = 20, prob = 0.8)
rweibull(n = 30, shape = 5, scale = 3)

## ---- density------------------------------------------------------------
dbinom(x = 20, size = 20, prob = 0.8)
dnorm(x = -5:5, mean = 0, sd = 1)

## ---- cdf----------------------------------------------------------------
pnorm(q = 0, mean = 0, sd = 1)
pbinom(q = 20, size = 20, prob = 0.8)

## ---- quantiles----------------------------------------------------------
qnorm(p = 0.5, mean = 0, sd = 1)
qbinom(p = 0.5, size = 20, prob = 0.8)

## ---- stats--------------------------------------------------------------
x = mtcars$mpg
mean(x)
median(x)
sd(x)  
var(x)

## ---- quantile-----------------------------------------------------------
quantile(x, .9) 
quantile(x, c(.3, .84))
quantile(x, c(.25, .50, .75))

## ---- minmax-------------------------------------------------------------
min(x)
max(x)

## ---- summary------------------------------------------------------------
summary(x)

## ---- corcov-------------------------------------------------------------
data = mtcars[, c(1, 3, 4, 5, 6)]
cor(data)
cov(data)

## ----functions-create----------------------------------------------------
f <- function(x, y = 0) {
  z <- x + y
  z
}

## ----functions-002-------------------------------------------------------
formals(f)
body(f)
environment(f)

## ----functions-formals-pairlist------------------------------------------
is.null(pairlist())
is.null(list())

## ----functions-formals-argument------------------------------------------

mean(x = 1:5, trim = 0.1)
mean(1:5, trim = 0.1)
mean(x = 1:5, 0.1)
mean(1:5, 0.1)
mean(trim = 0.1, x = 1:5)

## ----functions-formals-argument2-----------------------------------------
mean(1:5, tr = 0.1)
mean(tr = 0.1, x = 1:5)

## ----functions-formals-arguments3----------------------------------------
mean(c(1, 2, NA))

## ----functions-formals-arguments4----------------------------------------
mean(c(1, 2, NA), na.rm = TRUE)

## ----functions-formals-f-------------------------------------------------
formals(f)

## ----functions-formals-args----------------------------------------------
args(f)

## ----functions-formals-list----------------------------------------------
is.list(formals(mean))

## ----functions-dots------------------------------------------------------
h <- function (x, ...) {0}
formals(h)

## ----functions-dots2-----------------------------------------------------
count_rows <- function(...) {
  list <- list(...)
  lapply(list, nrow)
}

count_rows(airquality, cars)

## ----functions-dots3, fig.height=7, fig.width=7--------------------------
time <-  1:13
depth <-  c(0,9,18,21,21,21,21,18,9,3,3,3,0)

plot_depth <-  function ( time , depth , type = "l", ...){
  plot(time, -depth, type = type, 
       ylab = deparse(substitute(depth)), ...)
}
par(mfrow = c(1, 2))
plot_depth(time, depth, lty = 2)
plot_depth(time, depth, lwd = 4, col = "red")

## ----functions-body-wrong, eval=FALSE------------------------------------
## wrong <- function(x) {x =}

## ----functions-body-right------------------------------------------------
right <- function(x){x+y}

## ----functions-body-right-error, error=TRUE------------------------------
right(x = 2)

## ----functions-environment-userdefined-----------------------------------
f <- function(x){x+1}
environment(f)

## ----functions-environment-package---------------------------------------
environment(mean)

## ----functions-environment-global, error=TRUE----------------------------
f <- function(x){x+1}
x

## ----functions-writing2--------------------------------------------------
myFunction =  function(a, b, c) {...}

## ----functions-writing-example, tidy=FALSE-------------------------------
vat = function(amount, rate = 0.21) {
  taxable = amount / (1 + rate)
  tax = amount - taxable
  return(list(tax = tax, taxable = taxable))
}
vat(121)
vat(104, rate = 0.04)

