## ----if0, eval = FALSE---------------------------------------------------
## if(condition) code to be executed

## ----if------------------------------------------------------------------
x <- 2
if (x > 0) print("x greater than zero")

## ----iffalse-------------------------------------------------------------
x <- -4
if (x > 0) print("x greater than zero")

## ----ifline--------------------------------------------------------------
x <- 2
if (x > 0) {
  print("x greater than zero")
  return(x)
}

## ----else0, eval=FALSE---------------------------------------------------
## if(condition) code-when-true else code-when-false

## ----ifelse--------------------------------------------------------------
x = -4
if (x > 0) print("x greater than zero") else print("x is not greater than zero")

## ----ifelsebraces--------------------------------------------------------
x <- -4
if (x > 0) {
  print("x greater than zero")
} else {
  print("x is not greater than zero")
}

## ----ifassignement-------------------------------------------------------
x <- -4
if (x > 0) {
  y <- 1
} else {
  y <- -1
}
y

## ----structures-008------------------------------------------------------
if(x < 5){"LESS"} else {"GREATER"}

## ----structures-009------------------------------------------------------
x = 1:10
ifelse(x < 5, "LESS", "GREATER")

## ----ifelsefunction------------------------------------------------------
x <- -4
y <- ifelse(x > 0, 1, -1)
y

## ----switch, tidy=FALSE--------------------------------------------------
centre <- function(x, type) {
  switch(type,
    mean = mean(x),
    median = median(x),
    trimmed = mean(x, trim = .1)
  )
}

## ----centre, echo=2:100--------------------------------------------------
set.seed(355)
x <- rcauchy(10)
centre(x, "mean")
centre(x, "median")
centre(x, "trimmed")

## ----programming-for-01--------------------------------------------------
languages <- c("C", "C++", "R", "Java", "Python")
for(lang in languages) {
  cat("I love ", lang, "\n")

}

## ----programming-for-02--------------------------------------------------
languages <- c("C", "C++", "R", "Java", "Python")
n <- length(languages)
for(i  in 1:n) {
  cat("I love ", languages[i], "\n")

}

## ----programming-for-03, include =FALSE----------------------------------
rm(list = ls())
g = gc()

## ----programming-for-04, cache=TRUE--------------------------------------
k = 100000
n = 10
z = NULL 
system.time({
    for (i in 1:k) {
    x = rnorm(n , 0, 1)
    y = rnorm(n , 0, 1)
    z = c(z , cor(x, y))
  }
  cat ("95th quantile = " , quantile(z , .95), "\n")
})[3]

## ----programming-for-05, cache=TRUE--------------------------------------
k = 100000
n = 10
z = numeric(k)
system.time({
  for ( i in 1:k){
    x = rnorm(n , 0, 1)
    y = rnorm(n , 0, 1)
    z[i] = cor(x, y)
  }
  cat ("95th quantile = " , quantile(z , .95), "\n")
})[3]

## ----structures-006, cache=TRUE------------------------------------------
slow =  function(x, y) {  
  nx = length(x)
  ny = length(y)  
  xy = numeric(nx + ny - 1)  
  
  for(i in 1:nx) {  
         for(j in 1:ny) {  
              ij = i+j-1  
              xy[ij] = xy[ij] + x[i] * y[j]  
          }  
      }  
      xy  
}  


system.time(slow(runif(1000), runif(1000)))[3]

## ----structures-007, cache=TRUE------------------------------------------
fast =  function(x, y) {  
  nx = length(x)
  ny = length(y)  
  xy = numeric(nx + ny - 1)  
  j = 1:ny
  for(i in 1:nx) {  
              ij = i+j-1  
              xy[ij] = xy[ij] + x[i] * y  
      }  
      xy  
}
system.time(fast(runif(1000), runif(1000)))[3]

## ----programming-while, echo=2:100---------------------------------------
set.seed(355)
n <- 0
x <- 0
while(x <= 3) {
  x <- rnorm(1)
  n <- n + 1
}
cat(n, "loops were executed")

