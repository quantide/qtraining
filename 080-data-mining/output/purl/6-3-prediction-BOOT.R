## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples

## Datasets from packages
data(Auto, package = "ISLR")

## Other datasets used
# none

################################
## packages needed: boot ISLR ##
################################

## ----ct------------------------------------------------------------------
summary(Auto)

## ----cu------------------------------------------------------------------
boot.fn <- function(data, index) {
	return(coef(lm(mpg ~ horsepower, data = data, subset = index)))
}
boot.fn(Auto, 1:392)

## ----cv------------------------------------------------------------------
set.seed(10)
boot.fn(Auto, sample(1:392, 392, replace = TRUE))

## ----cv1, message=FALSE--------------------------------------------------
require(boot)

## ----cw------------------------------------------------------------------
set.seed(20)
res <- boot(data = Auto, statistic = boot.fn, R = 1000)
print(res)

## ----sds, message=FALSE,echo=FALSE, results='hide'-----------------------
sds <- apply(X = res$t,MARGIN = 2, FUN = sd, na.rm=TRUE)

## ----cx------------------------------------------------------------------
summary(lm(mpg ~ horsepower, data = Auto))$coef

## ----cy------------------------------------------------------------------
boot.fn <- function(data, index) {
	return(coefficients(lm(mpg ~ horsepower + I(horsepower^2), data = data,
	subset = index)))
}
set.seed(10)
res <- boot(data = Auto, statistic = boot.fn, R = 1000)
print(res)
summary(lm(mpg ~ horsepower + I(horsepower^2), data = Auto))$coef

## ----cz------------------------------------------------------------------
set.seed(10)

x <- runif(n = 500, max = 200)
y <- 2 + 3*x +rnorm(500)

dsim <- data.frame(x=x,y=y)
boot.fn <- function(data, index) {
	return(coefficients(lm(y ~ x, data = data,
	subset = index)))
}

res <- boot(data = dsim, statistic = boot.fn, R = 1000)
print(res)
summary(lm(y ~ x, data = dsim))$coef

