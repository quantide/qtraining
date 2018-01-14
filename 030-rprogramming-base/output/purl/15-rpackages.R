## ----versions, eval = F--------------------------------------------------
## R.Version()$version.string
## install.packages("rstudioapi")
## rstudioapi::versionInfo()$version

## ----install_needed_packages, eval = F-----------------------------------
##  install.packages(c("devtools", "roxygen2", "testthat", "knitr"))

## ----devtools_create, eval = F-------------------------------------------
##  devtools::create("package_path/pkgname")

## ----dice_function-------------------------------------------------------
dice <- function(faces = 6, rolls = 1){
  out <- sample(1:faces, rolls, replace = T)
  out
}

## ----DESCRIPTION, eval = F-----------------------------------------------
## Package: game
## Type: Package
## Title: What the Package Does (Title Case)
## Version: 0.1.0
## Author: Who wrote it
## Maintainer: The package maintainer <yourself@somewhere.net>
## Description: More about what it does (maybe more than one line)
##     Use four spaces when indenting paragraphs within the Description.
## License: What license is it under?
## Encoding: UTF-8
## LazyData: true
## RoxygenNote: 6.0.1

## ---- eval = F-----------------------------------------------------------
## Authors@R: c(
##     person("Hadley", "Wickham", email = "hadley@rstudio.com", role = "cre"),
##     person("Winston", "Chang", email = "winston@rstudio.com", role = "aut"))

## ---- eval = F-----------------------------------------------------------
## Imports:
##     dplyr (>= 0.3.0.1),
##     ggplot2

## ---- eval = F-----------------------------------------------------------
## Suggested:
##     qdata,
##     ggmap

## ----DESCRIPTION_edited, eval = F----------------------------------------
## Package: game
## Type: Package
## Title: A toy package with a game tool
## Version: 0.1.0
## Author: Marichiara Fortuna
## Maintainer: Mariachiara Fortuna <mariachiara.fortuna@quantide.com>
## Description: This package contains a basic example that we use to explain how to create
##     a new package. It is a complement of the Professional R Programming course
## License: MIT + file LICENSE
## Encoding: UTF-8
## LazyData: true
## RoxygenNote: 6.0.1

## ---- eval = F-----------------------------------------------------------
## #' Simulate a dice
## #'
## #' @param faces Number of dice faces
## #' @param rolls Number of dice rolls
## #' @return The dice rolls output
## #' @examples
## #' dice()
## #' dice(faces = 10)
## #' dice(faces = 12, rolls = 10)
## dice <- function(faces = 6, rolls = 1){
##   out <- sample(1:faces, rolls, replace = T)
##   out
## }

## ---- eval = F-----------------------------------------------------------
## #' Simulate a dice
## #'

## ---- eval = F-----------------------------------------------------------
## devtools::use_vignette("game-vignette")

## ---- eval = F-----------------------------------------------------------
## ---
## title: "Vignette Title"
## author: "Vignette Author"
## date: "`r Sys.Date()`"
## output: rmarkdown::html_vignette
## vignette: >
##   %\VignetteIndexEntry{Vignette Title}
##   %\VignetteEngine{knitr::rmarkdown}
##   %\VignetteEncoding{UTF-8}
## ---

## ---- eval = F-----------------------------------------------------------
## devtools::use_testthat()

## ---- eval = F-----------------------------------------------------------
## library(testthat)
## 
## context("Dice function output")
## 
## test_that("Dice rolls sets up the number of rolls", {
##   expect_equal(length(dice()), 1)
##   expect_equal(length(dice(rolls = 10)), 10)
##   expect_equal(length(dice(rolls = 30)), 30)
## })
## 

## ---- eval = F-----------------------------------------------------------
## library(testthat)
## 
## context("Dice function output")
## 
## test_that("Dice rolls sets up the number of rolls", {
##   expect_equal(length(dice()), 1)
##   expect_equal(length(dice(rolls = 10)), 60) # <- Error! The expected lenght is 10
##   expect_equal(length(dice(rolls = 30)), 30)
## })
## 

## ---- eval = F-----------------------------------------------------------
## #' Simulate a dice
## #'
## #' @param faces Number of dice faces
## #' @param rolls Number of dice rolls
## #' @return The dice rolls output
## #' @examples
## #' dice()
## #' dice(faces = 10)
## #' dice(faces = 12, rolls = 10)
## #' @export
## dice <- function(faces = 6, rolls = 1){
##   out <- sample(1:faces, rolls, replace = T)
##   out
## }

## ---- eval = F-----------------------------------------------------------
## #' @importFrom ggplot2 ggplot xlab ylab geom_histogram

## ---- eval = F-----------------------------------------------------------
## sample_data <- sample(1000)
## devtools::use_data(sample_data)

## ---- eval = F-----------------------------------------------------------
## #' Prices of 50,000 round cut diamonds.
## #'
## #' A dataset containing the prices and other attributes of almost 54,000
## #' diamonds.
## #'
## #' @format A data frame with 53940 rows and 10 variables:
## #' \describe{
## #'   \item{price}{price, in US dollars}
## #'   \item{carat}{weight of the diamond, in carats}
## #'   ...
## #' }
## #' @source \url{http://www.diamondse.info/}
## "diamonds"

## ---- eval = F-----------------------------------------------------------
## sample_data <- sample(1000)
## devtools::use_data(sample_data, internal = TRUE)

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

