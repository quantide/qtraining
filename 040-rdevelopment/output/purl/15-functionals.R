## ----echo=FALSE, message=FALSE-------------------------------------------
if (!("truncgof" %in% installed.packages()[,1])){install.packages ("truncgof", repos="http://cran.rstudio.com/")}

## ----functionals-000A----------------------------------------------------
l <- list(x = 1:4, y = 4:1)
Reduce(rbind, l)

## ----functionals-000B----------------------------------------------------
Filter(f = function(x) x %% 2 == 0 , x = 1:5)

## ----functionals-000C----------------------------------------------------
fun <- function(f, ...) f(...)

## ----functionals-000D----------------------------------------------------
fun(mean, x = 1:10, trim = .1)

## ----functionals-000E----------------------------------------------------
mean(x = 1:10, trim = .1)

## ----functionals-001-----------------------------------------------------
lapply(list(one = 1, a = "a"), FUN = is.numeric)

## ----functionals-002-----------------------------------------------------
n <- ncol(airquality)
out <- numeric(n)
for (i in 1:n){
 out[i] <- max(airquality[,i], na.rm = TRUE)
}
out

## ----functionals-003-----------------------------------------------------
lapply(X=airquality, FUN = max, na.rm = TRUE)

## ----functionals-004-----------------------------------------------------
mean(1:100, trim = 0.1)
mean(0.1, x = 1:100)

## ----functionals-005-----------------------------------------------------
x <- rnorm(100)
lapply(X = c(0.1, 0.2, 0.5), mean, x = x)

## ----functionals-006-----------------------------------------------------
sapply(X=airquality, FUN = max, na.rm = TRUE)

## ----functionals-007-----------------------------------------------------
sapply(list(), is.numeric)

## ----functionals-008-----------------------------------------------------
vapply(list(), is.numeric, FUN.VALUE = logical(1))
vapply(X=airquality, FUN = max, na.rm = TRUE, FUN.VALUE = numeric(1))

## ----functionals-009-----------------------------------------------------
df_list <- list(cars, airquality, trees) 

## ----functionals-010-----------------------------------------------------
sapply(df_list, ncol)

## ----functionals-011-----------------------------------------------------
df_list <- list(df1 = cars, df2 = NULL, df3 = trees) 

## ----functionals-012-----------------------------------------------------
sapply(df_list, ncol)

## ----functionals-013, error=TRUE-----------------------------------------
vapply(df_list, ncol, FUN.VALUE = numeric(1))

## ----functionals-014-----------------------------------------------------
n <- sample(1:5, 10^6 , rep = T)
vector_list <- lapply(n, sample , x = 0:9)

## ----functionals-015-----------------------------------------------------
system.time(
  sapply(vector_list, length )
)

system.time(
  vapply(vector_list, length, FUN.VALUE = numeric(1))
)

## ----functionals-016-----------------------------------------------------
x = 1:3
vapply(x, function(x) x*x, numeric(1))

## ----functionals-017-----------------------------------------------------
vapply(1:length(x), function(i , x) x[i]*x[i], x=x , FUN.VALUE=numeric(1))

## ----functionals-018-----------------------------------------------------
n = ncol(trees)
out = numeric(n)
trim = c(0.1, 0.2, 0.3)
for ( i in 1:n){
  out[i] = mean(trees[,i], trim[i], na.rm = TRUE)
}
out

## ----functionals-019, tidy=TRUE------------------------------------------
lapply(1:ncol(trees), 
  function(i, x, trim, ...) mean(x[,i], trim[i], na.rm = TRUE), 
  x = trees, trim = c(0.1, 0.2, 0.3))

## ----functionals-020-----------------------------------------------------
ni = 4
nj = 2

nk = ni*nj
k = numeric(nk)
for (j in 1:nj){
  if ( j %% 2 == 0){  
    for ( i in 1:ni){
      if ( i %% 2 == 0 ) next_k = i+j 
      else next_k = i-j
      cat("first ij " , i , j , next_k, "\n")
      k[i+(j-1)*ni] = next_k
    }
  }  
  else {
    for (i in 1:ni){
    next_k <- 99
    cat("second ij " , i , j , next_k, "\n")
    k[i+(j-1)*ni] = next_k
    }
  }
}


## ----functionals-021-----------------------------------------------------
f = function(k , i , j) {
  i <- i[k]
  j <- j[k]
  result <- 99
  if( j %% 2 == 0){
  result <- ifelse(i %% 2 == 0 , i+j , i-j)
  }
  result
}

## ----functionals-022-----------------------------------------------------
grid <- expand.grid(i = 1:ni, j = 1:nj )
with(grid , vapply(1:nrow(grid), f, i=i , j=j, FUN.VALUE = numeric(1)))

## ----functionals-023-----------------------------------------------------
f = function(i , j) {
  ifelse( j %% 2 == 0,
    ifelse(i %% 2 == 0 , i+j , i-j),
  99)        
}

## ----functionals-024, tidy = TRUE----------------------------------------
unlist(
  lapply(1:2, 
         function(j, i = ni) vapply(1:4, FUN = f, j, FUN.VALUE = numeric(1))
         )
)


## ----functionals-025-----------------------------------------------------
mapply(mean ,trees, trim = c(0.1 , 0.2, 0.3), 
  MoreArgs = list(na.rm = TRUE),
  SIMPLIFY = FALSE) 

## ----functionals-, eval = FALSE------------------------------------------
## mapply(FUN, ..., MoreArgs=NULL, SIMPLIFY = TRUE)

## ----functionals-026-----------------------------------------------------
Map(function(...) mean(..., na.rm = TRUE), 
  x = trees , trim = c(0.1 , 0.2, 0.3))

## ----functionals-027-----------------------------------------------------
f = function(i , j) {
  result = 99
  if( j %% 2 == 0){
  result <- ifelse(i %% 2 == 0 , i+j , i-j)
  }
  result
}

grid <- expand.grid(i = 1:4, j = 1:2)

## ----functionals-028-----------------------------------------------------
with(grid , mapply(f, i=i , j=j, SIMPLIFY = TRUE))

## ----functionals-029-----------------------------------------------------
unlist(with(grid , Map(f, i=i , j=j)))

## ----functionals-030-----------------------------------------------------
env <- new.env()
env$x = 3 ; env$y = -2
eapply(env, function(x) ifelse(x>0 , 1 , -1))

## ----functionals-rapply, eval=FALSE--------------------------------------
## rapply(object, f, classes = "ANY", deflt = NULL,
##        how = c("unlist", "replace", "list"), ...)

## ----functionals-rapply1-------------------------------------------------
l <- list(list(a = pi, b = list(c = 1:1)), d = "a test")
l
rapply(l, function(x) x, how = "replace")
rapply(l, function(x){paste("rapply of:",x)}, how = "replace")
# class="character" applies the function only to the character
rapply(l, function(x){paste("rapply of:",x)}, how = "replace", class="character")


## ----functionals-rapply2-------------------------------------------------
# class="character" applies the function only to the character and leaves unchanged elements of other classes
rapply(l, nchar, classes = "character", deflt = as.integer(NA), how = "replace")
# class="character" applies the function only to the character and replaces the elements of other classes with NA
rapply(l, nchar, classes = "character", deflt = as.integer(NA), how = "list")
rapply(l, nchar, classes = "character", deflt = as.integer(NA), how = "unlist")


## ----list-of-functions-001-----------------------------------------------
fun_list <- list(m = mean , s = sd)

## ----list-of-functions-002-----------------------------------------------
with (fun_list, m(x = 1:10))

## ----list-of-functions-003-----------------------------------------------
fun_list$m( x = 1:10)

## ----list-of-functions-004-----------------------------------------------
attach(fun_list)
m( x = 1:10)
detach(fun_list)

## ----list-of-functions-005-----------------------------------------------
fun <- function(f, ...){f(...)}

## ----list-of-functions-006-----------------------------------------------
fun(mean, x = 1:10, na.rm = TRUE)

## ----list-of-functions-007-----------------------------------------------
lapply(fun_list, fun, x = 1:10)


## ----list-of-functions-008-----------------------------------------------
lapply(fun_list, do.call, list(x = 1:10, na.rm = T))

## ----list-of-functions-009, tidy=TRUE------------------------------------
require(truncgof, quietly = TRUE)
nor_test <-  list (ad2.test = ad2.test, ad2up.test = ad2up.test,
                   ad.test = ad.test,adup.test = adup.test)

## ----list-of-functions-010-----------------------------------------------
x <- rnorm(100, 10, 1)
m <-  mean(x)
s <- sd(x)
lapply(nor_test, fun, x , distn = "pnorm", list(mean = m, sd = s), sim = 100)

## ----list-of-functions-011, tidy=TRUE------------------------------------
this_summary <- as.data.frame(rbind(
  vapply(trees , mean, FUN.VALUE = numeric(1)),
  vapply(trees , sd, FUN.VALUE = numeric(1)),
  vapply(trees , function(x, ...){diff(range(x))}, FUN.VALUE = numeric(1)))
)

row.names(this_summary) <- c("mean", "sd", "range")
this_summary

## ----list-of-functions-012, tidy=TRUE------------------------------------
my_summary <- function(x, flist){
  f <- function(f,...)f(...)
  g <- function(x, flist){vapply(flist, f , x, FUN.VALUE = numeric(1))}
  df <- as.data.frame(lapply(x, g , flist))
  row.names(df) <- names(flist)
  df
}

my_summary(cars, 
  flist = list(
    mean = mean, 
    stdev = sd, 
    cv =  function(x,...){sd(x,...)/mean(x,...)}
               )
)


## ----list-of-functions-013-----------------------------------------------
fapply <- function(X, FUN, ...){
  lapply(FUN, function(f, ...){f(...)}, X, ...)
}

## ----list-of-functions-014-----------------------------------------------
basic_stat <- list(mean = mean, median = median, sd = sd)
fapply(1:10, basic_stat)

