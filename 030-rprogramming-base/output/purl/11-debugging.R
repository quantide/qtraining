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

