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
require("tibble", quietly = T)
environmentName(as.environment("package:tibble"))

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

