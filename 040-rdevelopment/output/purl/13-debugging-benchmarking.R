## ----echo=FALSE, message=FALSE-------------------------------------------
if (!("rbenchmark" %in% installed.packages()[,1])){install.packages ("rbenchmark", repos="http://cran.rstudio.com/")}
if (!("microbenchmark" %in% installed.packages()[,1])){install.packages ("microbenchmark", repos="http://cran.rstudio.com/")}
if (!("ggplot2" %in% installed.packages()[,1])){install.packages ("ggplot2", repos="http://cran.rstudio.com/")}

## ----profiling-001-------------------------------------------------------
f1 <- function(x, s1 = 1 , s2 = 2){
  n <- length(x)
  y <- NULL
  for ( i in 1:n){
    if (x[i] %% 2 == 0 ) tmp <- x[i]+rnorm(1, 0 , s2)
    else tmp <- x[i]+rnorm(1, 0, s1)
    y <- c(y, tmp)
  }
  sum(y)  
}  
f1(x = 1:5)

## ----profiling-002-------------------------------------------------------
system.time(f1(x = 1:10^5))

## ----profiling-003-------------------------------------------------------

Rprof("f1.Rprof")
f1(x = 1:10^5)
Rprof(NULL)
summaryRprof("f1.Rprof")$by.self

## ----profiling-004-------------------------------------------------------
f2 <- function(x, s1 = 1 , s2 = 2){
  n <- length(x)
  y <- numeric(n)
  for ( i in 1:n){
    if (x[i] %% 2 == 0 ) tmp <- x[i]+rnorm(1, 0 , s2)
    else tmp <- x[i]+rnorm(1, 0, s1)
    y[i] <- tmp
  }
  sum(y)  
}  
f2(x = 1:5)

## ----profiling-005-------------------------------------------------------
Rprof("f2.Rprof")
f2(x = 1:10^5)
Rprof(NULL)
summaryRprof("f2.Rprof")$by.self

## ----profiling-006-------------------------------------------------------
f3 <- function(x, s1 = 1 , s2 = 2){
  f31 <- function(x, s1 , s2){
    ifelse(x %% 2 == 0, x+rnorm(1, 0 , s2) , x+rnorm(1, 0, s1))
  }
sum(vapply(x, f31, FUN.VALUE=numeric(1), s1, s2 ))
}
f3(x = 1:5)

## ----profiling-007, error=TRUE-------------------------------------------
Rprof("f3.Rprof")
f3(x)
Rprof(NULL)
summaryRprof("f3.Rprof")$by.self

## ----profiling-008-------------------------------------------------------
f4 <- function(x, s1 = 1 , s2 = 2){
  n <- length(x)
  s1 <- rnorm(n, 0 , s1)
  s2 <- rnorm(n, 0 , s2)
  sum(ifelse(x %% 2 == 0, x+s1 , x+s2))
}
f4(x = 1:5)

## ----profiling-009, error=TRUE-------------------------------------------
Rprof("f4.Rprof")
f4(x)
Rprof(NULL)
summaryRprof("f4.Rprof")$by.self

## ----profiling-010-------------------------------------------------------
sapply(paste("f", 1:4, ".Rprof", sep = ""), function(x) summaryRprof(x)$sampling.time)

## ----profiling-011-------------------------------------------------------
names(summaryRprof("f2.Rprof"))

## ----profiling-012-------------------------------------------------------
Rprof("f1.Rprof", memory.profiling = TRUE)
f1(x = 1:10^5)
Rprof(NULL)
summaryRprof("f1.Rprof", memory = "both")$by.self

## ----profiling-rbenchmark------------------------------------------------
require(rbenchmark)

## ----profiling-0120------------------------------------------------------
s <- seq(-pi, pi, len = 1000)
f <- function(x) sin(x)/ (1-cos(x))
benchmark(vapply(s,f, FUN.VALUE = numeric(1)), sapply(s,f))

## ----profiling-012A------------------------------------------------------
f_loop <- function(n = 10, k = 1e+05){
  z = numeric(k)
  for (i in 1:k) {
    x = rnorm(n, 0, 1)
    y = rnorm(n, 0, 1)
    z[i] = cor(x, y)
  }
quantile(z, 0.95)
}

## ----profiling-012B------------------------------------------------------
f_rep <- function(n = 10, k = 1e+05){
  z <- replicate(k, cor(rnorm(n), rnorm(n)))
  quantile(z, .95)
}

## ----profiling-012C------------------------------------------------------
f_mat <- function(n = 10, k = 1e+05){
  z <- replicate(k, cor(matrix(rnorm(n*2), nrow = n, ncol = 2))[1,2])
  quantile(z, .95)
}

## ----profiling-012D------------------------------------------------------
benchmark(f_loop(), f_rep(), f_mat(), replications = 10, order = "elapsed")

## ----profiling-013-------------------------------------------------------
x <- 1:100
i <- 66
x[i]
x[[i]]

## ----profiling-014-------------------------------------------------------
benchmark(x[i], x[[i]], replications = 1000)

## ----profiling-015-------------------------------------------------------
library(microbenchmark)
test <- microbenchmark(x[i] , x[[i]], times = 1000)
test

## ----profiling-016-------------------------------------------------------
library(ggplot2)
autoplot(test)

## ----quick---------------------------------------------------------------
quick <- function(df) {
  plot(df$x, df$y, type = "b")
  summary(df)
}

## ----quick1, fig.height=4, fig.width=8-----------------------------------
df1 <- data.frame(x = 1:100 , y = rnorm(100))
quick(df1)

## ----quick2, fig.height=4, fig.width=8-----------------------------------
df2 <- data.frame(x = sample(letters[1:3], 100, rep= T ), y = rnorm(100))
quick(df2)

## ----quick3, fig.keep = "none"-------------------------------------------
options(stringsAsFactors = FALSE)
df <- data.frame(x = sample(letters[1:3], 100, rep= T ), y = rnorm(100))
try(quick(df))

## ----quick4, , fig.keep = "none", error = TRUE---------------------------
quick <- function(df){
 cat (str(df), "\n")
 plot(df$x, df$y, type = "b")
 summary(df)
}
quick(df)

## ----rmean---------------------------------------------------------------
rmean <- function(n, min, max){
 x <- numeric(n)
 for (i in 1:n){
   s <-  sample(min:max,1)
   x[i] <- log(s)
   if(!is.finite(x[i])) {cat ("Loop" , i, ": s = " , s , "\n")}
 }
 mean(x)
}

rmean(n = 10, min = -1, max = 4)

## ----xf------------------------------------------------------------------
xf <- factor(c("a", "b", "c"))
class(xf)
print(xf)
print.default(xf)
cat(xf) 

## ----italy---------------------------------------------------------------
myCountry <- "Italy"
print(paste("I live in", myCountry))
cat("I live in", myCountry)

## ----debug-009-----------------------------------------------------------
xc <- 'test\\test'
print(xc)
cat(xc)

## ----half----------------------------------------------------------------
half <- function(x) {return(x/2)}
try(half("text"))

## ----stop, error = TRUE--------------------------------------------------
half <- function(x){
  if(!is.numeric(x)) {stop("x must be numeric")}
  return(x/2)
}
half("text")

## ----warning-------------------------------------------------------------
repText <- function(times, text = NA) {
  if(is.na(text)) {
    warning("text not provided. 'test' is used.")
    text  <- "test"
  }
  rep(text, times)
}
repText(times = 3)

## ----doit----------------------------------------------------------------
doit <- function(x) {
  x <- sample(x, replace=TRUE)
  if(length(unique(x)) == length(x)) {
    mean(x)
  } else {
    stop("too few unique points")
  }
  cat("end of function", "\n")
  invisible(NULL)
}

## ----doitExecute, error = TRUE-------------------------------------------
x <- 1:10
thisError  <- doit(x)
thisTry <- try(doit(x))
thisError
thisTry

## ----mix, error = TRUE---------------------------------------------------
mix <- function (x) {
 rn <- rnorm(1)
 ru <- runif(1)
 browser()
 return(x +rn+ru)
}

## ----mix-out, eval = FALSE-----------------------------------------------
## mix(0)
## Called from: mix(0)
## Browse[1]> rn
## [1] 0.9315371
## Browse[1]> ru
## [1] 0.4610282
## Browse[1]> c
## [1] 1.392565

## ----debug-018-----------------------------------------------------------
msg <- function (x) {
  if (x > 0 ) cat ("Hello")
  else cat("goodbye")
  invisible(NULL)
}

msg(1)
msg(-1)

## ----debug-019, error= TRUE----------------------------------------------
msg(log(-1))

## ----debug-020-----------------------------------------------------------
traceback()

## ----debug-020A, eval= FALSE---------------------------------------------
## debugonce(msg)

## ----debug-021, error = TRUE---------------------------------------------
if(NA) {cat ("this is strange")}

## ----isdebugged----------------------------------------------------------
debug(msg)
isdebugged(msg)
undebug(msg)
isdebugged(msg)

## ----fgh-----------------------------------------------------------------
f <-  function(x) {
  r <-  x - g(x)
  r
}

g <- function(y) {
  r <- y * h(y)
  r
}

h <- function(z) {
  r <- log(z)
  if (r < 10)
      r^2
  else r^3
}

## ----fneg, error = TRUE--------------------------------------------------
f(-1)

## ----trb, eval = FALSE---------------------------------------------------
## traceback()

## ----dbgonce-h, eval = FALSE---------------------------------------------
## debugonce(h)
## f(-1)

## ----dbgonce-f, eval = FALSE---------------------------------------------
## debugonce(f)

## ----options1------------------------------------------------------------
options("error")

## ----debug-026-----------------------------------------------------------
options(error = recover)

## ----debug-026A, eval= FALSE---------------------------------------------
## f(-1)

## ----debug-027, error = TRUE---------------------------------------------
options(error = quote(dump.frames("fdump", to.file=TRUE)))
f(-1)

## ----debug-027A, eval = FALSE--------------------------------------------
## load("fdump.rda")
## debugger(fdump)

## ----debug-027B, eval = FALSE--------------------------------------------
## options(error = Quote(
##  if (interactive()) recover()
##  else dump.frames()
## ))

## ----f4------------------------------------------------------------------
f = function(lambda, n = 10){
  x = numeric(n)
  for ( i in 1:n) {
    r = rpois(1 , lambda)
    l = sum(rexp(r, 1/r))
    x[i] = log(r*l)
  }
mean(x)
}

## ----f101----------------------------------------------------------------
f(10)
f(.1)

## ----trace---------------------------------------------------------------
trace("f", exit = quote(browser()), print=F)
f(1)

## ----body2---------------------------------------------------------------
trace("f", exit = quote(browser()) , print=F)
body(f)

