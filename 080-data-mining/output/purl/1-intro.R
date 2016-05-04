## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples

## Datasets from packages
# none

## Other datasets used
# none

############################
## packages needed: qdata ##
############################

## ----load datasets, results="hide", message=FALSE------------------------
## Remove all objects in the R environment
rm(list = ls())

## qdata package
require(qdata)

## qdata data frames used in this course
course_qdata_df <- c("banknotes","bimetal1","bostonhousing","druguse","forbes94","german","life","mds",
                     "uscompanies","uscrime","utilities","volcano3d","wea","wwiileaders","wines")

## Load qdata data frames used in this course
data(list = course_qdata_df)

## Load other data frames used in this course
data(skulls, package = "HSAUR2")
data(bread, package = "smacof")
data(Auto, Carseats, Default, Smarket, package = "ISLR")
data(cu.summary, kyphosis, package = "rpart")

## ----auto----------------------------------------------------------------
str(Auto)

## ----banknotes-----------------------------------------------------------
str(banknotes)

## ----bimetal1------------------------------------------------------------
str(bimetal1)

## ----bostonhousing-------------------------------------------------------
str(bostonhousing)

## ----bread---------------------------------------------------------------
str(bread)

## ----Carseats------------------------------------------------------------
str(Carseats)

## ----cu.summary----------------------------------------------------------
str(cu.summary)

## ----Default-------------------------------------------------------------
str(Default)

## ----druguse-------------------------------------------------------------
druguse

## ----faithful------------------------------------------------------------
str(faithful)

## ----forbes94------------------------------------------------------------
str(forbes94)

## ----german--------------------------------------------------------------
str(german)

## ----iris----------------------------------------------------------------
str(iris)

## ----kyphosis------------------------------------------------------------
str(kyphosis)

## ----life----------------------------------------------------------------
str(life)

## ----mds-----------------------------------------------------------------
str(mds)

## ----Smarket-------------------------------------------------------------
str(Smarket)

## ----skulls--------------------------------------------------------------
str(skulls)

## ----uscompanies---------------------------------------------------------
str(uscompanies)

## ----uscrime-------------------------------------------------------------
str(uscrime)

## ----utilities-----------------------------------------------------------
str(utilities)

## ----volcano3d-----------------------------------------------------------
str(volcano3d)

## ----wea-----------------------------------------------------------------
str(wea)

## ----wines---------------------------------------------------------------
str(wines)

## ----wwiileaders---------------------------------------------------------
wwiileaders

