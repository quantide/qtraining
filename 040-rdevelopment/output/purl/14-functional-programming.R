## ----echo=FALSE, message=FALSE-------------------------------------------
if (!("pracma" %in% installed.packages()[,1])){install.packages ("pracma", repos="http://cran.rstudio.com/")}
if (!("truncdist" %in% installed.packages()[,1])){install.packages ("truncdist", repos="http://cran.rstudio.com/")}

## ----closures-000, echo=FALSE--------------------------------------------
rm(list = ls())

## ----closures-00A--------------------------------------------------------
lapply(0, identity)

## ----closures-00B--------------------------------------------------------
(function(x) sd(x)/mean(x))(x = 1:5)

## ----closures-00C--------------------------------------------------------
f <- function(){
  function(x) sd(x)/mean(x)
}

## ----closures-00D--------------------------------------------------------
function_list <- list(mean , sd)

## ----closures-001--------------------------------------------------------
f <- function(x) 0
environment(f)

## ----closures-002--------------------------------------------------------
environment(mean)

## ----closures-002A-------------------------------------------------------
environment(sum)

## ----closures-003--------------------------------------------------------
y <- 1 
f <- function(x){x+y}
f(1)

## ----closures-005--------------------------------------------------------
g <- function(){
  y <- 1
  function(x) {x+y}
}
f1 <- g()
f1(3)

## ----closures-006--------------------------------------------------------
g <- function (y) {
    function(x) x+y
}
f1 <- g(1)
f1(3)

## ----closures-007--------------------------------------------------------
g_tmp <- function(y){
  print(environment())
  function(x) {x+y}
}

## ----closures-008--------------------------------------------------------
f1 <- g_tmp(1)

## ----closures-009--------------------------------------------------------
environment(f1)

## ----closures-010--------------------------------------------------------
get("y" , env = environment(f1))

## ----closures-011--------------------------------------------------------
f2 <- g(1)
environment(f1)
environment(f2)

## ----closures-012--------------------------------------------------------
add <- function(x, i){
  x+i
}

## ----closures-013--------------------------------------------------------
f <- function(i){
  function(x) {x+i}
}

## ----closures-014--------------------------------------------------------
f1 <-  f(1)
f1(3)
f2 <- f(2)
f2(4)

## ----closures-015--------------------------------------------------------
new_estimate <-  function(dist){
  estimate <-  function(x, theta){   
    neglik <-  function(theta = theta , x = x, log = T){
      args <-  c(list(x), as.list(theta), as.list(log))
      neglik <-  -sum(do.call(dist,  args))
      neglik
    }
    optim(par = theta, fn = neglik , x = x)$par
  }
estimate
}

## ----closures-016--------------------------------------------------------
llnorm <- new_estimate("dlnorm")
x <- rlnorm(100, 7 , 1)
llnorm(x, theta = c(mean(log(x)), sd(log(x))))


## ----closures-017--------------------------------------------------------
lweibull <- new_estimate("dweibull")
w <- rweibull(100, 2 , 1)
lweibull(w, theta = c(mean(w), sd(w)))

## ----closures-018--------------------------------------------------------
g <- function(i , x, n , f, ...) f(x[(i-n+1):i], ...)
g(i = 5 , x = 1:10,n = 3  , f= mean) 
g(i = 5 , x = 1:10,n = 3  , f= sd) 


## ----closures-019--------------------------------------------------------
moving <- function(f){
  g <- function(i , x, n , f, ...) f(x[(i-n+1):i], ...)
  h <- function(x, n, ...) {
    N <- length(x)
    vapply(n:N, g, x , n , f, FUN.VALUE = numeric(1), ...)
  }
return(h)  
}

## ----closures-020--------------------------------------------------------
moving_average <- moving(mean)  
moving_average(x = rpois(10, 10), n = 3)

## ----closures-021--------------------------------------------------------
moving_average(x = rpois(10, 10), n = 3, trim = .5)

## ----closures-022--------------------------------------------------------
moving(sd)(rpois(10, 10), n = 5)

## ----closures-023,  fig.width=7, fig.height=4, fig.cap="Plot of moving average and median"----

x <- 1:100
y <- seq(along = x, from = 0 , to = 1)+rnorm(length(x), 0 , .1)
plot(x, y)
lines(x[10:length(x)], moving(mean)(y, 10), col = "red", lwd = 2)
lines(x[10:length(x)], moving(median)(y, 10), col = "green", lwd = 2)

## ----closures-024--------------------------------------------------------
x <- c(7,10,13)
dlnorm(x , meanlog = 2, sdlog = 1)

## ----closures-025--------------------------------------------------------
require(truncdist)
dtrunc(x, spec = "lnorm", a = 5)

## ----closures-025A, eval = FALSE-----------------------------------------
## tdlnorm(x, meanlog = 2, sdlog = 1, L = 5)

## ----closures-025B, eval = FALSE-----------------------------------------
## tdlnorm(x, meanlog = 2, sdlog = 1)

## ----closures-026--------------------------------------------------------
tdlnorm <-  function (x, meanlog = 0, sdlog = 1,  L = 0,  H = Inf) 
 {
  
  density <-  
     stats::dlnorm(x, meanlog=meanlog, sdlog=sdlog)/
        (
        stats::plnorm(H, meanlog=meanlog, sdlog=sdlog)-  
        stats::plnorm(L, meanlog=meanlog, sdlog=sdlog)  
          )
              
   return(density)
 }

## ----closures-027--------------------------------------------------------
tdlnorm(x, 1, 2, L= 5, H = 20)
dtrunc(x, spec = "lnorm", a = 5, b = 20, meanlog = 1, sdlog = 2)

## ----closures-028--------------------------------------------------------
dtruncate <-
  function (dist, pkg = stats){ 
    
    dist <- deparse(substitute(dist))
    envir <- as.environment(paste("package", as.character(substitute(pkg)), sep = ":"))
    
    ddist=paste("d", dist, sep = "") 
    pdist=paste("p", dist, sep = "")
        
    #gets density function                    
    ddist <-  get(ddist, mode = "function", envir = envir)
    #gets argument of density function
    dargs <- formals(ddist)
   
    #gets probability function                    
    pdist <- get(pdist, mode = "function", envir = envir)
    #gets argument of probability function
    pargs <- formals(pdist)
        
    #Output function starts here
    density <- function () 
    {
      #check L U 
      if (L > U) stop("U must be greater than or equal to L")
      
      #gets density arguments
      call <- as.list(match.call())[-1]
      
      #all unique arguments belonging to density and ddist 
      dargs <- c(dargs[!is.element(names(dargs), names(call))], call[is.element(names(call), names(dargs))])
      
      #all unique arguments belonging to probability and pdist 
      pargs <- c(pargs[!is.element(names(pargs), names(call))], call[is.element(names(call), names(pargs))])
      
      #select x only where defined by L and U
      dargs$x <- x[x > L & x <= U]
      
      #define arguments for pdist in L and U
      pUargs <-  pLargs <- pargs 
      pUargs$q <- U
      pLargs$q <- L
      
      #initialize output
      density <- numeric(length(x))
      
      #standard method for computing density values for truncated distributions
      density[x > L & x <= U] <-  do.call("ddist", as.list(dargs)) / (do.call("pdist", as.list(pUargs)) - do.call("pdist", as.list(pLargs)))
      
      #returns density values for truncated distributions
      return(density)
      
    }
    
    #add to density function formals L and U with values as passed with dtruncate
    formals(density) <-  c(formals(ddist), eval(substitute(alist(L=-Inf, U=Inf))))
    #return density function
    return(density)
  }

## ----closures-029--------------------------------------------------------
tdlnorm <- dtruncate(dist = lnorm)

## ----closures-030--------------------------------------------------------
p <- ppoints(1000)
x <- qlnorm(p, meanlog = 1, sdlog = 1)
d <- tdlnorm(x, meanlog = 1, sdlog = 1)
dt <- tdlnorm(x, meanlog = 1, sdlog = 1, L= 5, U = 10)
plot(x, dt, type = "n", xlab = "Quantile", ylab = "Density")
points(x, dt, type = "s", col = "red", lwd = 2)
points(x, d, type = "s", col = "darkblue", lwd = 2)
title("Truncated and not-truncated log-normal")
grid()

## ----closures-031--------------------------------------------------------
dtrunc(x = 5:8, spec = "lnorm", a = 5, b = 10, meanlog = 1, sdlog = 1)
tdlnorm(x = 5:8, meanlog = 1, sdlog = 1, L = 5, U = 10)

## ----closures-032--------------------------------------------------------
dweibull <-  dtruncate(dist = weibull)
dgpd <- dtruncate(gpd, pkg = evd)

## ----closures-033--------------------------------------------------------
g <- function(){
 i <- 0
 f <- function(){
    i <<- i+1
    cat("this function has been called ", i, " times", "\n")
    date()  
}}

f <- g()
#first call
f()
#second call
f() 
#third call
f()

## ----closures-033A, eval = FALSE-----------------------------------------
## assign("i", i+1, envir = parent.env(environment())):

## ----closures-034--------------------------------------------------------
library(pracma)
primes(n = 9)

## ----closures-035--------------------------------------------------------
makefprime = function () {
  .env = new.env()
  f = function(n) {
    symbol = paste("p", n, sep = ".")
    if (exists(symbol, envir = .env)){
      prime = get(symbol, envir = .env)
    } 
    else {prime = primes(n = n)
      assign(symbol , prime, envir = .env)
    }
    prime
   }  
f
}

## ----closures-036--------------------------------------------------------
fprimes = makefprime()
fprimes(10)

## ----closures-037--------------------------------------------------------
system.time({p1 = fprimes(n = 10^7)})

## ----closures-038--------------------------------------------------------
system.time({p2 = fprimes(n = 10^7)})

## ----closures-043--------------------------------------------------------
new_plot = function(){
  xx = NULL
  yy = NULL
  function(x, y, ...) {
  xx <<- c(xx, x)
  yy <<- c(yy, y)
  plot(xx, yy, ...)
}}

this_plot <- new_plot()

## ----closures-044, fig.width=7, fig.height=4, fig.cap="first call"-------
this_plot (1:4, c(2, 3, 1, 5), type = "b")

## ----closures-045, fig.width=7, fig.height=4, fig.cap="second call"------
this_plot(5, 3, type = "b")

## ----closures-046, fig.width=7, fig.height=4, fig.cap="third call"-------
this_plot(6, 3, type = "b", col = "red")

