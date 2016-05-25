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

## ----functions-writing---------------------------------------------------
myFunction =  function(a, b, c) {...}

## ----functions-writing-example, tidy=FALSE-------------------------------
vat = function(amount, rate = 0.21) {
  taxable = amount / (1 + rate)
  tax = amount - taxable
  return(list(tax = tax, taxable = taxable))
}
vat(121)
vat(104, rate = 0.04)

