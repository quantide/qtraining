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

