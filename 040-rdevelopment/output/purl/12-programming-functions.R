## ----echo=FALSE, message=FALSE-------------------------------------------
if (!("scuba" %in% installed.packages()[,1])){install.packages ("scuba", repos="http://cran.rstudio.com/")}

## ----environments-001----------------------------------------------------
globalenv()
environment()

## ----environments-002----------------------------------------------------
x <- 0
ls.str(globalenv())

## ----environments-003----------------------------------------------------
as.environment("package:stats")

## ----environments-004----------------------------------------------------
environment(mean)

## ----environments-005----------------------------------------------------
f <- function() NULL
environment(f)

## ----environments-006----------------------------------------------------
environmentName(environment(f))

## ----environments-006A---------------------------------------------------
require("scuba", quietly = T)
environmentName(as.environment("package:scuba"))

## ----environments-006B---------------------------------------------------
env <- new.env()
environmentName(env)

## ----environments-007----------------------------------------------------
parent.env(globalenv())

## ----environments-008----------------------------------------------------
tree <- function(env){
  cat("+ ", environmentName(env), "\n")
  if(environmentName(env) != environmentName(emptyenv())){  
    env <- parent.env(env) 
    Recall(env)
  }
invisible(NULL)
}

## ----environments-009----------------------------------------------------
tree(env = globalenv())

## ----environments-010----------------------------------------------------
search()

## ----environments-011----------------------------------------------------
attach(data.frame(NULL))
search()

## ----environments-012----------------------------------------------------
library(MASS)
search()

## ----environments-013----------------------------------------------------
Formaldehyde <- data.frame()

## ----environments-014----------------------------------------------------
get("Formaldehyde", envir = globalenv())

## ----environments-015----------------------------------------------------
get("Formaldehyde", envir = as.environment("package:datasets"))

## ----environments-016----------------------------------------------------
circumference <- function(radius) 2*pi*radius

## ----environments-017----------------------------------------------------
pi <- 0

## ----environments-018----------------------------------------------------
circumference(1)

## ----environments-019----------------------------------------------------
get("pi", envir = as.environment(globalenv()))

## ----environments-020----------------------------------------------------
get("pi", envir = as.environment(baseenv()))

## ----environments-021----------------------------------------------------
circumference <- function(radius) 2*base::pi*radius
circumference(1)

## ----environments-022----------------------------------------------------
conflicts()  

## ----environments-023----------------------------------------------------
env <- new.env()

## ----environments-023A, eval = FALSE-------------------------------------
## rm(env)

## ----environments-024----------------------------------------------------
env$zero <- 0

## ----environments-025----------------------------------------------------
with(env , one <- 1)

## ----environments-026----------------------------------------------------
assign("three", 3, envir  = env)

## ----environments-027----------------------------------------------------
ls(env)
ls.str(env)

## ----environments-028----------------------------------------------------
fill_envir <- function(..., envir = globalenv()){
  this_list <- list(...)
  Map(function(...) assign(..., envir = envir) , names(this_list), this_list)
  invisible(NULL)
}

## ----environments-029----------------------------------------------------
env1 <- new.env() 
fill_envir(one = 1, seven = 7, envir = env1)
ls.str(env1)

## ----environments-030----------------------------------------------------
envir <- function(..., hash = TRUE, parent = parent.frame(), size = 29L){
  envir <- new.env(hash = hash, parent = parent, size = size)
  fill_envir(..., envir = envir)
  return(envir)
}

## ----environments-031----------------------------------------------------
env2 = envir(six = 6, seven = 7)
ls.str(env2)

## ----environments-032----------------------------------------------------
list (0, 1)

## ----environments-033, error=TRUE----------------------------------------
envir(0,1)

## ----environments-034----------------------------------------------------
l <- list (x = 0 , x = 1)
l$x

## ----environments-035----------------------------------------------------
env <- envir(x = 0, x = 1)
ls.str(env)

## ----environments-036----------------------------------------------------
env <- envir(b = 2, a = 1)
ls.str(env)

## ----environments-037----------------------------------------------------
env0 <- new.env()
parent.env(env0)

## ----environments-038----------------------------------------------------
tree(env0)

## ----environments-039----------------------------------------------------
env1 <- new.env(parent=baseenv())

## ----environments-040----------------------------------------------------
tree(env1)

## ----environments-041----------------------------------------------------
mem_add <- function(x) substring(capture.output(.Internal(inspect(x))), 2, 17) 

## ----environments-042----------------------------------------------------
x <- 0
y <- 0 

## ----environments-043----------------------------------------------------
mem_add(x)
mem_add(y)

## ----environments-044----------------------------------------------------
x <- 0

## ----environments-045----------------------------------------------------
y <- x

## ----environments-046----------------------------------------------------
identical(mem_add(x), mem_add(y))

## ----environments-047----------------------------------------------------
x <- 1:5

## ----environments-048----------------------------------------------------
mem_add(x)

## ----environments-049----------------------------------------------------
x[3] <- 0L

## ----environments-050----------------------------------------------------
mem_add(x)

## ----environments-051----------------------------------------------------
list0 <- list(x = 0)

## ----environments-052----------------------------------------------------
list1 <- list0

## ----environments-053----------------------------------------------------
identical(mem_add(list0), mem_add(list1))

## ----environments-054----------------------------------------------------
list1$x <- 1

## ----environments-055----------------------------------------------------
identical(mem_add(list0), mem_add(list1))

## ----environments-055A---------------------------------------------------
list0 <- list(x = 1:100, y = rpois(100, 100))
list1 <- list0

## ----environments-055B---------------------------------------------------
list1$y[1] <- 0L

## ----environments-055C---------------------------------------------------
lapply(list0, mem_add)
lapply(list1, mem_add)

## ----environments-056----------------------------------------------------
env0 <- new.env()
env0$x <- 0

## ----environments-057----------------------------------------------------
env1 <- env0

## ----environments-058----------------------------------------------------
env0$x
env1$x

## ----environments-059----------------------------------------------------
env1$x <- 1

## ----environments-060----------------------------------------------------
env0$x

## ----environments-061----------------------------------------------------
identical(mem_add(env0), mem_add(env1))

## ----environments-062----------------------------------------------------
options(stringsAsFactors = FALSE)
n = 10^6
df = data.frame(name = paste("p", 1:n, sep = "."), value = 1:n)
head(df,  3)

## ----environments-063, cache=TRUE----------------------------------------
env = new.env(hash = T)

system.time(
  Map(function(...) assign(..., envir = env), x = df$name, value = df$value)
)

## ----environments-064----------------------------------------------------
k = 100
what = paste("p", sample(1:n, k), sep ="." )

## ----environments-065----------------------------------------------------
out <-  numeric(k)
system.time({
for (i in 1:k){
  out[i] <-  df$value[df$name == what[i]]
}})

## ----environments-066----------------------------------------------------
system.time({df$value[is.element(df$name , what)]})

## ----environments-067, cache=TRUE----------------------------------------
system.time({
  unlist(mget(what,  envir =   env))
})

## ----functions-001-------------------------------------------------------
f <- function(x, y = 0) {
  z <- x + y
  z
}

## ----functions-002-------------------------------------------------------
formals(f)
body(f)
environment(f)

## ----functions-003-------------------------------------------------------
is.null(pairlist())
is.null(list())

## ----functions-004-------------------------------------------------------

mean(x = 1:5, trim = 0.1)
mean(1:5, trim = 0.1)
mean(x = 1:5, 0.1)
mean(1:5, 0.1)
mean(trim = 0.1, x = 1:5)

## ----functions-005-------------------------------------------------------
mean(1:5, tr = 0.1)
mean(tr = 0.1, x = 1:5)

## ----functions-006-------------------------------------------------------
mean(c(1, 2, NA))

## ----functions-007-------------------------------------------------------
mean(c(1, 2, NA), na.rm = TRUE)

## ----functions-008-------------------------------------------------------
formals(f)

## ----functions-009-------------------------------------------------------
args(f)

## ----functions-010-------------------------------------------------------
is.list(formals(mean))

## ----functions-011-------------------------------------------------------
exists("formals<-")

## ----functions-012-------------------------------------------------------
g <- function(x, y=0) x+y
g(1)
formals(g)
formals(g) <- alist(x=, y=1)
g(1)

## ----functions-013-------------------------------------------------------
formals(mean.default)$na.rm <- TRUE
mean(c(1,2,NA))

## ----functions-014-------------------------------------------------------
exists("mean.default", envir = globalenv())

## ----functions-013A------------------------------------------------------
environment(mean.default)

## ----functions-015-------------------------------------------------------
h <- function (x, ...) {0}
formals(h)

## ----functions-016-------------------------------------------------------
count_rows <- function(...) {
  list <- list(...)
  lapply(list, nrow)
}

count_rows(airquality, cars)

## ----functions-017, fig.height=7, fig.width=7----------------------------
time <-  1:13
depth <-  c(0,9,18,21,21,21,21,18,9,3,3,3,0)

plot_depth <-  function ( time , depth , type = "l", ...){
  plot(time, -depth, type = type, 
       ylab = deparse(substitute(depth)), ...)
}
par(mfrow = c(1, 2))
plot_depth(time, depth, lty = 2)
plot_depth(time, depth, lwd = 4, col = "red")

## ----functions-017A, eval=FALSE------------------------------------------
## wrong <- function(x) {x =}

## ----functions-018-------------------------------------------------------
right <- function(x){x+y}

## ----functions-019, error=TRUE-------------------------------------------
right(x = 2)

## ----functions-020-------------------------------------------------------
f <- function(x) {x+1}
class(body(f))

## ----functions-021-------------------------------------------------------
as.list(body(f))

## ----functions-022-------------------------------------------------------
body(f)[[2]][[1]] <- `-`
f(1)

## ----functions-023-------------------------------------------------------
f <- function(x){x+1}
environment(f)

## ----functions-024-------------------------------------------------------
environment(mean)

## ----functions-023A------------------------------------------------------
f <- function() 0

## ----functions-023B------------------------------------------------------
environment(f)

## ----functions-023C------------------------------------------------------
env <- new.env()
environment(f) <- env
environment(f)

## ----functions-023D------------------------------------------------------
rm(env)

## ----functions-023E------------------------------------------------------
f()

## ----functions-025-------------------------------------------------------
env <- new.env()

with(env,{ 
     y <- 1
     g <- function(x){x+y}
     })


with(env, g(1))

## ----functions-026-------------------------------------------------------
y <- 1
g <- function(x){x+y}
g(2)

## ----functions-027-------------------------------------------------------
rm(y)

## ----functions-028, error=TRUE-------------------------------------------
g(1)

## ----functions-023F------------------------------------------------------
f <- function() x

## ----functions-023G------------------------------------------------------
env <- new.env() 
env$x <- 0
environment(f) <- env

## ----functions-023H------------------------------------------------------
f()

## ----functions-023I------------------------------------------------------
rm(env)

## ----functions-023L------------------------------------------------------
f()

## ----functions-029-------------------------------------------------------
f <-  function(x){
  env <-  environment()
  env
}

env_f <- f(x = 0)
get("x", envir = env_f)

## ----functions-030-------------------------------------------------------
env <- new.env(parent = baseenv()) 
with(env, f <- function(x) {is.function(x)})

## ----functions-031-------------------------------------------------------
with(env, f(c))

## ----functions-032-------------------------------------------------------
with(env, c <- 0) 

## ----functions-033-------------------------------------------------------
with(env, f(x = c))

## ----functions-034-------------------------------------------------------
remove(c, envir = env)

## ----functions-035-------------------------------------------------------
c <- 0

## ----functions-036-------------------------------------------------------
with(env, f(x = c))

## ----functions-037-------------------------------------------------------
env_of_fun <- function(){
  evaluated_in <- environment()
  defined_in <- parent.env(evaluated_in)
  called_from <- parent.frame(n = 1)

  c(evaluated_in = evaluated_in, 
    defined_in = defined_in, 
    called_from = called_from)
}
env_of_fun()

## ----functions-038-------------------------------------------------------
env <- new.env()
env$env_of_fun <- env_of_fun
rm(env_of_fun)

## ----functions-038A------------------------------------------------------
with(env, env_of_fun())

## ----functions-039-------------------------------------------------------
rm(list = ls())
env <- new.env(parent = baseenv()) 
with(env, f <- function(x) {
  x <- eval(x, envir = parent.frame(n = 1))
  is.function(x)
  })

## ----functions-040-------------------------------------------------------

env$f(c)
c <- 1
env$f(c)
with(env, f(c))

## ----functions-041-------------------------------------------------------
env <- new.env(parent = baseenv()) 
with(env, f <- function(x) eval(x, parent.env(environment())))

## ----functions-042-------------------------------------------------------
with(env, f(x = pi))
pi <- 0
with(env, f(x = pi))

## ----howRworks-034-------------------------------------------------------
clear = function(env = globalenv()) {
  obj = ls(envir = env)
  rm(list = obj, envir = env)
}

## ----howRworks-035-------------------------------------------------------
x <- 1; y <- 2; z <- 3
ls()
clear()
ls()

## ----howRworks-036, error=TRUE-------------------------------------------
a <- 2
clear()

## ----howRworks-037-------------------------------------------------------
clear <-  function (env = globalenv()){
  objects <-  objects(env)
  objects <-  objects[objects != "clear"]
  rm(list = objects, envir = env)
  invisible (NULL)
}

## ----howRworks-038-------------------------------------------------------
a <- b <- c <- 0
clear()
a <- b <- c <- 1
clear()

## ----howRworks-039-------------------------------------------------------
clean <- clear
rm (clear)
a <- b <- c <- 0
clean()

## ----howRworks-040, error=TRUE-------------------------------------------
a <- 3
clean()

## ----howRworks-041-------------------------------------------------------
clear <- function (env = globalenv()){
  fname <- as.character(match.call()[[1]])
  objects <- objects(env)
  objects <- objects[objects != fname]
  rm(list <- objects, envir = env)
  invisible (NULL)
}

## ----howRworks-042, tity = FALSE-----------------------------------------
assign("clean",
  function(env = globalenv()){
    rm(list = ls(envir = env), envir = env)
  },
  envir = attach(NULL, name = "myenv", pos = 2)
)

## ----howRworks-043-------------------------------------------------------
a <- b <- c <- 0
ls()
clean()
ls()

## ----functions-043-------------------------------------------------------
g <-  function (n){
 out <- runif(n)
 cat(head(out))
 invisible(out)
}

x <-  g(10^5)
length(x)

## ----functions-044-------------------------------------------------------
msg <- function(x){
  cat(x, "\n")
  invisible(NULL)
}

## ----functions-045-------------------------------------------------------
msg("test message")

## ----functions-046-------------------------------------------------------
"%+%" = function(x,y){paste(x, y, sep = "")} 
"we " %+% "love " %+% "R !"

## ----functions-047-------------------------------------------------------
methods(`+`)

## ----functions-048-------------------------------------------------------
string <- function(x) {
  s <- as.character(x)
  class(s) <- "string"
  s
}

## ----functions-049-------------------------------------------------------
`+.string` <- function(s1, s2) paste(s1, s2, sep = "")

## ----functions-050-------------------------------------------------------
a <- string("Mickey")
b <- string("Mouse")
a+b

## ----functions-051-------------------------------------------------------
rm(list = ls())
f = function(x, y){
  x+1
}

## ----functions-052-------------------------------------------------------
f(x = 0, y = z)

## ----functions-053, eval=TRUE--------------------------------------------
h <-  function(a , b){
  cat ("a is:", a, "\n")
  cat ("b is:", b, "\n")
  invisible(NULL)
}

## ----functions-054, error=TRUE-------------------------------------------
h(a = "we love R")

## ----functions-055, error=TRUE-------------------------------------------
g <-function(x, y){
  call <- match.call()
  args <- match(c("x", "y"), names(call))
  if(any(is.na(args))) stop("All args must be provided!")
  pi
}

g(y = 1)


## ----functions-056-------------------------------------------------------
rescale = function(x, location = min(x), scale = max(y)){
  y <- x-location
  y/scale
}
rescale(1:4)

## ----functions-056A------------------------------------------------------
delayedAssign("promise" , {x+y})
x <- 0
y <- 1
eval(promise)

## ----functions-057, eval=FALSE-------------------------------------------
## mean(x = 1:100, trim = 0.2)

## ----functions-058, eval=FALSE-------------------------------------------
## do.call("mean", list(x = 1:100, trim = 0.2))
## do.call(mean, list(x = 1:100, trim = 0.2))

## ----functions-059-------------------------------------------------------
mle = function(theta, x){
  ml = function(theta, x) {
    ml = dnorm(x = x, mean = theta[1], sd = theta[2])
    ml = -sum(log(ml))
    }
    optim(theta, ml, x = x)$par
}
mle(theta = c(0, 1), x = rnorm(100, 5, 2))

## ----functions-060-------------------------------------------------------
mle = function(theta, x){
  ml = function(theta, x) {
    ml = do.call(dnorm, list(x, theta[1], theta[2]))
    ml = -sum(log(ml))
  }
  optim(theta, ml, x = x)$par
}

mle(theta = c(0, 1), x = rnorm(100, 5, 2))

## ----functions-061-------------------------------------------------------
mle = function(theta, x, dist){
  dist = paste("d", dist , sep = "")
  ml = function(dist , theta, x) {
    ml = do.call(dist, list(x, theta[1], theta[2]))
    -sum(log(ml))
  }  
  optim(theta,  ml, dist = dist  , x = x)$par
}
mle(dist = "norm" , theta = c(0, 1), x = rnorm(10, 5, 2))

## ----functions-062-------------------------------------------------------
mle(dist = "lnorm" , theta = c(0,1), x = rlnorm(100, 3, 1))
mle(dist = "weibull" , theta = c(1,1), x = rweibull(100, 3, 1))

## ----functions-063-------------------------------------------------------
f = function(a, b){
  call = match.call()
  call}
  
my_call = f(2, 3)  
my_call
class(my_call)  

## ----functions-064-------------------------------------------------------
my_call_list <- as.list(my_call)
my_call_list

## ----functions-065-------------------------------------------------------
my_call$a <- 0
eval(my_call)

## ----functions-066-------------------------------------------------------
anyway = function(a , b){
  call <-  match.call()
  if (is.numeric(a) & is.numeric(b)) {call[[1]] <- as.name("sum")} 
    else {
      call[[1]] <- as.name("paste" )
      call$sep <- "+"
    }
eval(call)
}

anyway(3, 6)
anyway("c", 2)

## ----functions-067-------------------------------------------------------
write.csv <-  function(...) write.table(sep = ",", dec = ".", ...)
siris <- head(iris, 3)
write.csv(siris)

## ----functions-068, error=TRUE-------------------------------------------
write.csv(siris, sep = ";")

## ----functions-069-------------------------------------------------------
write.csv = function(...){
  call = match.call()
  call[[1]] = as.name("write.table")
  call$sep = ","
  call$dec = "."
  eval(call)
}

write.csv(siris, sep = ";")

## ----functions-070-------------------------------------------------------
one_c <- function(x){
  while (x > 2){
    x <- x/2
}
x
}
one_c(10)

## ----functions-071-------------------------------------------------------
one_r <- function(x){
  if (x > 2 ){
   x <- x/2
   x <- Recall(x)
  }
x  
}
one_r(10)

## ----functions-072-------------------------------------------------------
quick_sort_r  <- function(x) {
  
  if(length(x) > 1) {
    base <- x[1]
    l <- Recall(x[x < base])
    m <- x[x == base]
    h <- Recall(x[x > base])
    
    c(l, m, h)
  }
  else x
}

## ----functions-073-------------------------------------------------------
quick_sort_r(sample(1:10))

## ----functions-074-------------------------------------------------------
quick_sort_c <- function(x , max_lev = 1000) {
  n <- length(x)
  i <- 1
  beg <- end <- max_lev
  beg[1] <- 1 
  end[1] <- n+1
  
  while (i>=1) {
    L <- beg[i]
    R <- end[i]-1
    if (L<R) {
      piv <- x[L] 
      if (i == max_lev) 
        stop("Error: max_lev reached");
      
      while (L<R) {
        while (x[R]>=piv && L<R){ 
          R <- R-1
        }
        if (L < R){
          x[L] <-  x[R]
          L <- L+1
        }
        while (x[L]<=piv && L<R){
          L <- L+1
        }
        if (L<R) {
          x[R] <- x[L]
          R <- R-1
        }
      }
      x[L] <- piv
      beg[i+1] <- L+1
      end[i+1] <- end[i]
      end[i] <- L
      i <- i+1
    }
    else {
      i <- i-1 
    }
  }
  return( x) 
}

## ----functions-075-------------------------------------------------------
quick_sort_c(sample(1:10))

## ----functions-076-------------------------------------------------------
x <- sample(1:10^5)
system.time(quick_sort_r(sample(x)))
system.time(quick_sort_c(sample(x)))

## ----functions-076A------------------------------------------------------
df1 <- data.frame(id = 1:6, x1 = 1:6)
df2 <- data.frame(id = 2:4, x2 = 2:4)
df3 <- data.frame(id = 3:5, x1 = 3:5)

## ----functions-076B------------------------------------------------------
df12 <- merge(df1, df2, by = "id", all.x = T)
df123 <- merge(df12, df3, by = "id", all.x = T)
df123

## ----functions-076C------------------------------------------------------
left_join <- function(df_list, by, all.x = T){
  df_merged <- merge(df_list[[1]], df_list[[2]], by = by, all.x = all.x)
  df_list <- df_list[-1]
  df_list[[1]] <- df_merged
  if (length(df_list) > 1){
    df_merged <- Recall(df_list, by = by, all.x = all.x)
  }  
  df_merged
}

## ----functions-076D------------------------------------------------------
left_join(list(df1, df2, df3), by = "id")

## ----functions-077-------------------------------------------------------
df <-  data.frame(x = 1:3, y = 3:1)

## ----functions-077A------------------------------------------------------
names(df)

## ----functions-078-------------------------------------------------------
names(df) <-  c("xx", "yy")
names(df)

## ----functions-079-------------------------------------------------------
get("names<-")

## ----functions-080-------------------------------------------------------
trim <-  function(x, p){
  x[x <= quantile(x, p)]
}

trim(1:10, p = .25)

## ----functions-081-------------------------------------------------------
"trim<-" <-  function (x, p, value){
  x[x <= quantile(x, p)] <-  value
  x
}

## ----functions-082-------------------------------------------------------
y <- 1:10
trim(x = y, p = .25) <-  0
y

## ----functions-083-------------------------------------------------------
df <- data.frame(x = 0, y = 1)
names(df) <- c("a", "b")

## ----functions-084, error=TRUE-------------------------------------------
names(data.frame(x = 0, y = 1)) <- c("a", "b")

