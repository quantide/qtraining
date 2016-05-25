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

## ----programming-lapply-02-----------------------------------------------
n <- ncol(airquality)
out <- numeric(n)
for (i in 1:n){
 out[i] <- max(airquality[,i], na.rm = TRUE)
}
out

## ----programming-lapply-03-----------------------------------------------
lapply(X=airquality, FUN = max, na.rm = TRUE)

## ----programming-lapply-04-----------------------------------------------
mean(1:100, trim = 0.1)
mean(0.1, x = 1:100)

## ----programming-lapply-05-----------------------------------------------
x <- rnorm(100)
lapply(X = c(0.1, 0.2, 0.5), mean, x = x)

## ----programming-while, echo=2:100---------------------------------------
set.seed(355)
n <- 0
x <- 0
while(x <= 3) {
  x <- rnorm(1)
  n <- n + 1
}
cat(n, "loops were executed")

