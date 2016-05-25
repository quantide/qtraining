## ----packages-000A-------------------------------------------------------
env1 <- new.env()
env1$f <- function() NULL

## ----packages-000B-------------------------------------------------------
env2 <- new.env()
env2$f <- env1$f

## ----packages-000C-------------------------------------------------------
mem_add <- function(x) substring(capture.output(.Internal(inspect(x))), 2, 17) 
identical(mem_add(env1$f) , mem_add(env2$f))

## ----packages-000D-------------------------------------------------------
getAnywhere(mean)$where

## ----packages-000L-------------------------------------------------------
length(as.environment(.getNamespace("stats")))
length(as.environment("package:stats"))

## ----packages-000L1------------------------------------------------------
package_imports <- function(pkg){
  v <- packageDescription(pkg, fields = "Imports")
  d <- data.frame( strsplit(v, split = ",")[[1]])
  names(d) <- paste ("imports", pkg, sep = "_")
  d
}

## ----packages-000L2------------------------------------------------------
package_imports(pkg = "ggplot2")

## ----packages-000L3------------------------------------------------------
vapply(getNamespaceImports("ggplot2"), length, FUN.VALUE = numeric(1))

## ----packages-001--------------------------------------------------------
rm(list = ls())
itself = function(x) print(x)
paste2 = function(x, y) print(paste(x, y)) 
set.seed(2012) 
df = data.frame(x = rnorm(100), y = rnorm(100))
ls()

## ----packages-002, eval=FALSE--------------------------------------------
## package.skeleton(name = "simpleExample")

## ----packages-003, eval=FALSE--------------------------------------------
## library(simpleExample)

## ----packages-004--------------------------------------------------------
itself(5)
paste2("Score", 23)

## ----packages-roxygen1---------------------------------------------------
#' Add together two numbers
#'
#' @param x A number
#' @param y A number
#' @return The sum of \code{x} and \code{y}
#' @examples
#' add(1, 1)
#' add(10, 1)

add <- function(x, y) {
  x + y
}

## ----packages-roxygen2---------------------------------------------------
#' Sum of vector elements.
#'
#' \code{sum} returns the sum of all the values present in its arguments.
#'
#' This is a generic function: methods can be defined for it directly
#' or via the \code{\link{Summary}} group generic. For this to work properly,
#' the arguments \code{...} should be unnamed, and dispatch is on the
#' first argument.

sum <- function(..., na.rm = TRUE) {}

## ----packages-roxygen3---------------------------------------------------
#' @title Sum of vector elements.
#'
#' @description
#' \code{sum} returns the sum of all the values present in its arguments.
#'
#' @details
#' This is a generic function: methods can be defined for it directly
#' or via the \code{\link{Summary}} group generic. For this to work properly,
#' the arguments \code{...} should be unnamed, and dispatch is on the
#' first argument.
sum <- function(..., na.rm = TRUE) {}

## ----packages-roxygen4---------------------------------------------------
#' Sum of vector elements.
#'
#' \code{sum} returns the sum of all the values present in its arguments.
#'
#' This is a generic function: methods can be defined for it directly
#' or via the \code{\link{Summary}} group generic. For this to work properly,
#' the arguments \code{...} should be unnamed, and dispatch is on the
#' first argument.
#'
#' @param ... Numeric, complex, or logical vectors.
#' @param na.rm A logical scalar. Should missing values (including NaN)
#'   be removed?
#' @return If all inputs are integer and logical, then the output
#'   will be an integer. If integer overflow
#'   \url{http://en.wikipedia.org/wiki/Integer_overflow} occurs, the output
#'   will be NA with a warning. Otherwise it will be a length-one numeric or
#'   complex vector.
#'
#'   Zero-length vectors have sum 0 by definition. See
#'   \url{http://en.wikipedia.org/wiki/Empty_sum} for more details.
#' @examples
#' sum(1:10)
#' sum(1:5, 6:10)
#' sum(F, F, F, T, T)
#'
#' sum(.Machine$integer.max, 1L)
#' sum(.Machine$integer.max, 1)
#'
#' \dontrun{
#' sum("a")
#' }
sum <- function(..., na.rm = TRUE) {}

## ----packages-000I-------------------------------------------------------
environment( sd) 

## ----packages-000M-------------------------------------------------------
parent.env(as.environment(.getNamespace("stats")))

## ----packages-000N-------------------------------------------------------
parent.env(parent.env(as.environment(.getNamespace("stats"))))
parent.env(parent.env(as.environment(.getNamespace("utils"))))

## ----packages-000O-------------------------------------------------------
parent.env(parent.env(parent.env(as.environment(.getNamespace("stats")))))

## ----packages-000L31, echo = FALSE---------------------------------------
core <- c(".GlobalEnv", "tools:rstudio","package:stats","package:graphics","package:grDevices","package:utils","package:datasets","package:methods","Autoloads","package:base")     
pkg <- search()[!(search() %in% core)]
lapply(pkg, detach, character.only = TRUE, unload = FALSE)

## ----packages-000L32, echo = FALSE---------------------------------------
search()

## ----packages-000L33, echo = FALSE---------------------------------------
require("abc", quietly=TRUE)
search()

## ----packages-000L34, echo = FALSE---------------------------------------
packageDescription("abc", fields = "Depends")
packageDescription("quantreg", fields = "Depends")

## ----packages-000L4, error=TRUE------------------------------------------
library("not_exist")
require("not_exist")

## ----packages-000L5, error=TRUE------------------------------------------
test_library <- library("not_exist")
test_require <-  require("not_exist")
test_library
test_require

## ----packages-000L6------------------------------------------------------
if(!require("ggplot2")) {install.packages("ggplot2"); require("ggplot2")}

## ----packages-000E-------------------------------------------------------
get_from_rdb <- function(symbol, filebase, envir =parent.frame()){
  lazyLoad(filebase = filebase, envir = envir, filter = function(x) x == symbol)
}

## ----packages-000F-------------------------------------------------------
Rlib = .libPaths()[1]
get_from_rdb(symbol =  "venice", filebase = file.path(Rlib, "evd/data/Rdata"))
find("venice")

## ----packages-000G-------------------------------------------------------
head(eval(venice))

## ----packages-000H-------------------------------------------------------
lazyLoad(filebase = file.path(Rlib, "evd/data/Rdata"), envir = parent.frame(), filter = function(x) TRUE)
lazyLoad(filebase = file.path(Rlib, "evd/R/evd"), envir = parent.frame(), filter = function(x) TRUE)

## ----packages-github1, eval=FALSE----------------------------------------
## install.packages("devtools")

## ----packages-github2, eval=FALSE----------------------------------------
## library(devtools)

## ----packages-github3, eval=FALSE----------------------------------------
## install_github("kbroman/broman")

## ----packages-github4, eval=FALSE----------------------------------------
## git remote add origin https://github.com/username/reponame

## ----packages-github5, eval=FALSE----------------------------------------
## git push -u origin master

