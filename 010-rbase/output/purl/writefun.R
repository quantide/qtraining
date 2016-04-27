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

