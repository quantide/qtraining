## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples

## Datasets from packages
require(qdata)
data(bostonhousing)
data(cu.summary, package = "rpart")

## Other datasets used
# none

####################################
## packages needed: rpart, party ##
####################################

## ----message=FALSE-------------------------------------------------------
require(rpart)

## ----aa------------------------------------------------------------------
fit <- rpart(Mileage ~ Price + Country + Reliability + Type, method = "anova",
						 data = cu.summary)
printcp(fit) 	# display the results 
plotcp(fit)		# visualize cross-validation results 
summary(fit)	# detailed summary of splits

## ----ab------------------------------------------------------------------
op <- par(mfrow = c(1, 2))
rsq.rpart(fit)
par(op)

## ----ac------------------------------------------------------------------
plot(fit, uniform = TRUE, main = "Regression tree for Mileage")
text(fit, use.n = TRUE, all = TRUE, cex = .8)

## ----ad------------------------------------------------------------------
pfit <- prune(fit, cp = 0.01160389) # from cptable   

## ----ae------------------------------------------------------------------
plot(pfit, uniform = TRUE, main = "Pruned regression tree for Mileage")
text(pfit, use.n = TRUE, all = TRUE, cex = .8)

## ----ag------------------------------------------------------------------
bostonhousing$lstat <- log(bostonhousing$lstat)
bostonhousing$rm <- bostonhousing$rm^2
bostonhousing$chas <- factor(bostonhousing$chas, levels = 0:1, labels = c("no", "yes"))
bostonhousing$rad <- factor(bostonhousing$rad, ordered = TRUE)

## ----message=FALSE-------------------------------------------------------
require(party)

## ----ah------------------------------------------------------------------
ctrl <- mob_control(alpha = 0.05, bonferroni = TRUE, minsplit = 40, objfun = deviance, verbose = TRUE)

## ----ai------------------------------------------------------------------
fmBH <- mob(medv ~ age + lstat + rm | zn + indus + chas + nox + age + dis + rad + tax + crim + b + ptratio,	data = bostonhousing, control = ctrl, model = linearModel)
fmBH
plot(fmBH)
coef(fmBH)
summary(fmBH)

## ----aj------------------------------------------------------------------
mean(residuals(fmBH)^2)
logLik(fmBH)
AIC(fmBH)

