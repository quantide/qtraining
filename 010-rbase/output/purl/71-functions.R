## ---- argument1----------------------------------------------------------
ls()

## ---- argument2----------------------------------------------------------
foo <- 3
rm(foo)

## ---- argument3----------------------------------------------------------
sum(1:10)

## ---- argument4----------------------------------------------------------
sum(c(1, 2, NA), na.rm = TRUE)

## ---- argument5----------------------------------------------------------
rdata <- c(rnorm(100), NA)
quantile(x = rdata, probs = c(0.25, 0.50, 0.75), na.rm = TRUE)
quantile(rdata, c(0.25, 0.50, 0.75), TRUE)
quantile(rdata, TRUE, c(0.25, 0.50, 0.75))
# When arguments are called explicitely, you can change arguments order 
quantile(rdata, na.rm = TRUE, probs = c(0.25, 0.50, 0.75))

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

## ----functions-writing2--------------------------------------------------
my_function <- function(a, b, c) {
  statements
  return(object)
  }

## ----functions-writing-example1, tidy=FALSE------------------------------
# Function definition
compute_square <- function(x) {
    square <- x * x
    return(square)
}


compute_square(2)
squared_num <- compute_square(24)
squared_num

## ----functions-writing-example2, tidy=FALSE------------------------------
# Function definition
vat <- function(amount, rate = 0.21) {
  taxable = amount / (1 + rate)
  tax = amount - taxable
  return(list(tax = tax, taxable = taxable))
}

vat(121)
vat(104, rate = 0.04)

