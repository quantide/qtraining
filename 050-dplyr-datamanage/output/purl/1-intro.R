## ----setup, echo=FALSE, results='hide', message=FALSE--------------------
library(knitr)
options(width=80)

## ----require, message=FALSE----------------------------------------------
require(nycflights13)
ls(pos = "package:nycflights13")

## ----flights-------------------------------------------------------------
dim(flights)
head(flights)
str(flights)

## ----airlines------------------------------------------------------------
dim(airlines)
head(airlines)
str(airlines)

## ----airports------------------------------------------------------------
dim(airports)
head(airports)
str(airports)

## ----planes--------------------------------------------------------------
dim(planes)
head(planes)
str(planes)

## ----weather-------------------------------------------------------------
dim(weather)
head(weather)
str(weather)

