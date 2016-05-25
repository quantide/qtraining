02-presentation-programming-conditionals.rmd
========================================================
author: 
date: 

Conditionals 
========================================================
Conditionals are made of at least of two components:

* A condition 
* Any valid `R` statement

When the condition is satisfied, i.e. the condition returns `TRUE`, the `R` statement is executed.   

When the condition is not satisfied, i.e. the condition returns `FALSE`, the `R` statement is ignored.   

The `if` statement
========================================================

The `if` statement is the most used conditional. 

Its use is quite simple:


```r
if(condition)  some code 
```

Example: A TRUE condition
========================================================

This `R` statement prints a message as the condition `x > 0` is satisfied. 

```r
x <- 2
if (x > 0) print("x greater than zero")
```

```
[1] "x greater than zero"
```

Example: A FALSE condition
========================================================

This `R` statement does not print the message as the condition `x > 0` is not satisfied. 

```r
x <- -2
if (x > 0) print("x greater than zero")
```

`{}` brackets
========================================================
When the  `R` statement is amde of a single line of code it can be written either 

if ( 2 > 5) cat(0) 
cat(1)




The condition ought be a lenght-one logical vector. Conditions of length greater than one are accepted with a warning, but only the first element is used. If condition is `TRUE` then the code is executed.



```r
x <- -4
if (x > 0) print("x greater than zero")
```

When condition is longer than a one line of code, the code to be executed ought be enclosed in braces (`{...}`). 

```r
x <- 2
if (x > 0) {
  print("x greater than zero")
  return(x)
}
```

```
[1] "x greater than zero"
```

```
[1] 2
```

The `if` statement allows an `else` condition that will be executed when the condition is false.
```
if(condition) code-when-true else code-when-false

As an example:

```r
x = -4
if (x > 0) print("x greater than zero") else print("x is not greater than zero")
```

```
[1] "x is not greater than zero"
```

In this case, it is strongly suggested to always use braces.

```r
x <- -4
if (x > 0) {
  print("x greater than zero")
} else {
  print("x is not greater than zero")
}
```

```
[1] "x is not greater than zero"
```

Of course, the `if` statement can be used to assign values to an object.

```r
x <- -4
if (x > 0) {
  y <- 1
} else {
  y <- -1
}
y
```

```
[1] -1
```

## The `ifelse()` function

As seen above, the `if` statement applies only to a length-one logical vector. If applied to vectors with length greater than one, only the first element is used and a warning message is returned. 


```r
if(x < 5){"LESS"} else {"GREATER"}
```

```
[1] "LESS"
```

The `ifelse()` function allows us to deal with vectors of any length. Its arguments are: a test condition, a return value when the test returns TRUE, a return value when the test returns FALSE.


```r
x = 1:10
ifelse(x < 5, "LESS", "GREATER")
```

```
 [1] "LESS"    "LESS"    "LESS"    "LESS"    "GREATER" "GREATER" "GREATER"
 [8] "GREATER" "GREATER" "GREATER"
```

Moreover, the `ifelse()` function return a vector, so it can be assigned to an object.

```r
x <- -4
y <- ifelse(x > 0, 1, -1)
y
```

```
[1] -1
```

## Select one of a list of alternatives: `switch`

The `switch()` function evaluates an expression and accordingly chooses one of the further arguments. It is usually used inside a function to select from a list of alternatives.

The following code, provide a self-written `centre()` function, that accepts two input arguments: a numeric vector and a centroid function  (mean, median, trimmed mean) to be applied to the numeric vector.

The `switch` read the string with the centroid function (`type`) and applies the accordingly function.


```r
centre <- function(x, type) {
  switch(type,
    mean = mean(x),
    median = median(x),
    trimmed = mean(x, trim = .1)
  )
}
```


```r
x <- rcauchy(10)
centre(x, "mean")
```

```
[1] 0.3433
```

```r
centre(x, "median")
```

```
[1] 0.2169
```

```r
centre(x, "trimmed")
```

```
[1] 0.3204
```













Slide With Code
========================================================


```r
summary(cars)
```

```
     speed           dist    
 Min.   : 4.0   Min.   :  2  
 1st Qu.:12.0   1st Qu.: 26  
 Median :15.0   Median : 36  
 Mean   :15.4   Mean   : 43  
 3rd Qu.:19.0   3rd Qu.: 56  
 Max.   :25.0   Max.   :120  
```

Slide With Plot
========================================================

![plot of chunk unnamed-chunk-2](02-presentation-programming-conditionals.rmd-figure/unnamed-chunk-2.png) 
