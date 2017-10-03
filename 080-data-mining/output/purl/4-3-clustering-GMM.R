## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples

## Datasets from packages
# none

## other datasets used
# faithful

#############################
## packages needed: mclust ##
#############################

## ----message=FALSE-------------------------------------------------------
require(mclust)
require(ggplot2)

## ----02g-plotanalysisff--------------------------------------------------
ggp <- ggplot(data=faithful, mapping = aes(x=eruptions, y= waiting)) +
  geom_point()
print(ggp)

faithfulMclust <- Mclust(faithful)
summary(faithfulMclust)

## ----02g-analysissumwithparsff-------------------------------------------
summary(faithfulMclust, parameters = TRUE)

## ----02g-plotsff, fig.height=8,fig.width=10------------------------------
op <- par(mfrow = c(2, 2))
plot(faithfulMclust, what = "BIC")
plot(faithfulMclust, what = "classification")
plot(faithfulMclust, what = "uncertainty")
plot(faithfulMclust, what = "density")
par(op)

## ----02g-helpff, eval=FALSE----------------------------------------------
## ?mclustModelNames

## ----02g-help2ff, eval=FALSE---------------------------------------------
## help(package = "mclust")

