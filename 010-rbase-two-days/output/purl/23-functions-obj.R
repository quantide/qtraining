## ---- argument1----------------------------------------------------------
ls()

## ---- argument2----------------------------------------------------------
foo <- 3
rm(foo)

## ---- argument3----------------------------------------------------------
sum(1:10)

## ---- help3, eval=F------------------------------------------------------
## help(read.table)

## ---- help4, eval=F------------------------------------------------------
## ?read.table

## ----functions-create----------------------------------------------------
f <- function(x, y = 0) {
  z <- x + y
  z
}

## ----functions-002-------------------------------------------------------
formals(f)
body(f)
environment(f)

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

## ----functions-body-wrong, eval=FALSE------------------------------------
## wrong <- function(x) {x =}

## ----functions-body-right------------------------------------------------
right <- function(x){x+h}

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

## ---- operations---------------------------------------------------------
x <- 1:10
y <- 11:20
z <- -4:5
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
x <- mtcars$mpg
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
data <- mtcars[, c(1, 3, 4, 5, 6)]
cor(data)
cov(data)

