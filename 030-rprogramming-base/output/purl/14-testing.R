## ------------------------------------------------------------------------
install.packages('assertthat')
require(assertthat)

## ---- eval = FALSE-------------------------------------------------------
## x <- 1
## assert_that(is.character(x))

## ---- eval = FALSE-------------------------------------------------------
## x <- 1
## stopifnot(is.character(x))

## ------------------------------------------------------------------------
see_if(is.character(x))

## ------------------------------------------------------------------------
x <- 1
validate_that(is.numeric(x))

## ------------------------------------------------------------------------
expect_equal(10, 10)
expect_equal(10, 10 + 1e-7)

## ------------------------------------------------------------------------
x <- "This is a string"
expect_match(x, "This") 

# Additional arguments:

expect_match(x, "this", ignore.case = TRUE)
expect_match(x, "this is a string", ignore.case = TRUE, all = TRUE)

## ------------------------------------------------------------------------
gg <- ggplot2::ggplot(data = mtcars, aes(mpg,wt))
expect_is(gg, "ggplot")

## ---- eval = FALSE-------------------------------------------------------
## library(stringr)
## context("String length")
## 
## test_that("str_length is number of characters", {
##   expect_equal(str_length("a"), 1)
##   expect_equal(str_length("ab"), 2)
##   expect_equal(str_length("abc"), 3)
## })
## 
## test_that("str_length of factor is length of level", {
##   expect_equal(str_length(factor("a")), 1)
##   expect_equal(str_length(factor("ab")), 2)
##   expect_equal(str_length(factor("abc")), 3)
## })
## 
## test_that("str_length of missing is missing", {
##   expect_equal(str_length(NA), NA_integer_)
##   expect_equal(str_length(c(NA, 1)), c(NA, 1))
##   expect_equal(str_length("NA"), 2)
## })

## ------------------------------------------------------------------------
devtools::use_testthat()

