## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples

## Datasets from packages
require(qdata)
data(uscrime)

## Other datasets used
# none

###############################
## packages needed: ca, MASS ##
###############################

## ----02c-loadcr----------------------------------------------------------
states <- uscrime$state
uscrime <- data.frame(uscrime[,-1])
rownames(uscrime) <- states
uscrime.old <- uscrime
uscrime[, 3:9] <- round(uscrime.old[, 3:9]*uscrime.old[, 2]/100)
summary(uscrime)

## ----message=FALSE-------------------------------------------------------
require(ca)

## ----02c-analysiscr------------------------------------------------------
uscrime.ca <- ca(as.matrix(uscrime[, 3:9]))
summary(uscrime.ca)
plot(uscrime.ca)

## ----message=FALSE-------------------------------------------------------
require(MASS)

## ----02c-analysisMASScr, fig.width=plot_with_legend_fig_width_short------
biplot(corresp(uscrime[, 3:9], nf = 2))

