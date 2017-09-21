## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples

## Datasets from packages 
data(Default, package = "ISLR")

## Other datasets used
# none

###########################################################
## packages needed: randomForest, caret, ISLR (for data) ##
###########################################################

## ----05a-summary---------------------------------------------------------
summary(Default)

## ----message=FALSE-------------------------------------------------------
require(randomForest)

## ----02i-plotsvmsd, fig.width=plot_with_legend_fig_width_short-----------
set.seed(1000)
train <- sample(nrow(Default), 2000)
default_train <- Default[train,]
default_test <-  Default[-train,]

(rf_fit <- randomForest(x= default_train[,c("student","balance", "income")], y = default_train$default, 
                        xtest= default_test[,c("student","balance", "income")], ytest = default_test$default, 
                        cutoff = c(0.8, 0.2)))
plot(rf_fit)

