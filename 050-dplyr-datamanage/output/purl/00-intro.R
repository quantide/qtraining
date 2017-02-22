## ----tidyverse, message=FALSE, eval = FALSE------------------------------
## install.packages("tidyverse")

## ----tidyverse3----------------------------------------------------------
require(tidyverse)

## ----tidyverse_update, eval = FALSE--------------------------------------
## tidyverse_update()

## ----bank, message=FALSE-------------------------------------------------
require(qdata)
data(bank)
bank
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
data(usopen)
usopen
str(usopen)
data(wimbledon)
wimbledon
str(wimbledon)

## ----help, eval=FALSE----------------------------------------------------
## ?bank
## ?people
## ?mtcars
## ?italia
## ?comuni
## ?province
## ?regioni
## ?ripartizioni
## ?usopen
## ?wimbledon

