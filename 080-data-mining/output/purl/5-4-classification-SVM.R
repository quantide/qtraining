## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples

## Datasets from packages
# none

## Other datasets used
# none

###################################
## packages needed: e1071, caret ##
###################################

## ----02i-svmsd-----------------------------------------------------------
set.seed(123)
sim.data <- function(n = 200) {
	if (n < 100) {
		stop("sample size has to be at least 100.")
	}
	n <- ifelse(n %% 4 == 0, n, n - (n %% 4))
	x <- matrix(rnorm(n*2), ncol = 2)
	x[1:(n/2), ] <- x[1:(n/2), ] + 2
	x[(n/2 + 1):(3*n/4), ] <- x[(n/2 + 1):(3*n/4), ] - 2
	y <- c(rep(1, 3*n/4), rep(2, n/4))
	return(data.frame(x1 = x[, 1], x2 = x[, 2], y = as.factor(y)))
}
n <- 200
dat <- sim.data(n)
plot(x2 ~ x1, col = y, data = dat)

## ----message=FALSE-------------------------------------------------------
require(e1071)

## ----02i-plotsvmsd, fig.width=plot_with_legend_fig_width_short-----------
train <- sample(n, 100)
svm.fit <- svm(y ~ ., data = dat[train, ], kernel = "radial", gamma = 1,
			   cost = 1)
plot(svm.fit, dat[train, ],svSymbol = "x", dataSymbol = "o")

## ----02i-plot2svmsd, fig.width=plot_with_legend_fig_width_short----------
svm.fit <- svm(y ~., data = dat[train, ], kernel = "radial", gamma = 1,
			   cost = 1e5)
plot(svm.fit, dat[train, ],svSymbol = "x", dataSymbol = "o")

## ----02i-svmcvsd---------------------------------------------------------
set.seed(123)
tune.out <- tune(svm, y~ ., data = dat[train, ], kernel = "radial",
				 ranges = list(cost = c(0.1, 1, 10, 100, 1000),
				 gamma = c(0.5, 1, 2, 3, 4)))
summary(tune.out)

## ----02i-svmplot3sd, fig.width=plot_with_legend_fig_width_short----------
svm.fit <- svm(y ~., data = dat[train, ], kernel = "radial", gamma = 3,
    	   cost = 10)
plot(svm.fit, dat[train, ],svSymbol = "x", dataSymbol = "o")

## ----require_caret, message=FALSE----------------------------------------
require(caret) # loaded to use confusionMatrix()

## ----02i-svmcmsd---------------------------------------------------------
svm.pred <- predict(tune.out$best.model, newx = dat[-train, ])
confusionMatrix(data = svm.pred, reference = dat[-train, "y"], positive = "1")

