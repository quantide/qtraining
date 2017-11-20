## ----tidyverse, message=FALSE, eval = FALSE------------------------------
## install.packages("tidyverse")

## ------------------------------------------------------------------------
require(tidyverse)

## ------------------------------------------------------------------------
tidyverse_packages()

## ----tidyverse_update, eval = FALSE--------------------------------------
## tidyverse_update()

## ----bank, message=FALSE-------------------------------------------------
require(qdata)
data(bank)
head(bank)
str(bank)

## ----mtcars, message=FALSE-----------------------------------------------
data(mtcars)
head(mtcars)
str(mtcars)

## ----italia, message=FALSE-----------------------------------------------
data(italia)
head(italia)
str(italia)

## ----tennis, message=FALSE-----------------------------------------------
data(usopen)
head(usopen)
str(usopen)
data(wimbledon)
head(wimbledon)
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

