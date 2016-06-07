## ----data, message=FALSE-------------------------------------------------
require(dplyr)
require(tidyr)

## ----bank, message=FALSE-------------------------------------------------
require(qdata)
data(bank)
head(bank)
str(bank)

## ----people, message=FALSE-----------------------------------------------
data(people)
people
str(people)

## ----mtcars, message=FALSE-----------------------------------------------
data(mtcars)
mtcars
str(mtcars)

## ----italia, message=FALSE-----------------------------------------------
data(italia)
italia
str(italia)

## ----tennis, message=FALSE-----------------------------------------------
data(tennis)
usopen
str(usopen)
wimbledon
str(wimbledon)

## ----help, eval=FALSE----------------------------------------------------
## ?bank
## ?people
## ?mtcars
## ?italia
## ?tennis

