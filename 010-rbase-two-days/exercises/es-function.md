---
title: "null"
author: "null"
date: "null"
output:
  pdf_document: default
  html_document:
    self_contained: no
---


 
# Writing R functions
## Exercise 1

Write a function, named `compute_summary`, which computes: sum, subtraction, multiplication and division of two numbers. The function arguments should be the two numbers, named as: `x` and `y`. The function should return all amounts computed. 


```r
compute_summary <- function(x, y){
  sum_op <- x+y
  sub_op <- x-y
  mul_op <- x*y
  div_op <- x/y
  return(list(sum_op=sum_op, sub_op=sub_op, mul_op=mul_op, div_op=div_op))
}

compute_summary(x=4, y=2)
```

```
## $sum_op
## [1] 6
## 
## $sub_op
## [1] 2
## 
## $mul_op
## [1] 8
## 
## $div_op
## [1] 2
```

```r
compute_summary(x=3, y=7)
```

```
## $sum_op
## [1] 10
## 
## $sub_op
## [1] -4
## 
## $mul_op
## [1] 21
## 
## $div_op
## [1] 0.4285714
```

## Exercise 2

Write a function, named `compute_gain`, which computes the income by multiplying the amount produced for sale price and then computes the gain by subtracting the costs to income.  
The function arguments should be: `amount`, `price`, and `costs`; `price` should have a default value equal to 5. The function should return the gain.


```r
compute_gain <- function(amount, costs, price=5){
  income = amount * price
  gain = income - costs
  return(gain)  
}

compute_gain(amount = 40, costs = 50)
```

```
## [1] 150
```

```r
compute_gain(amount = 100,costs = 70,price = 1)
```

```
## [1] 30
```

