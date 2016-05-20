## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples

## Datasets from packages
data(Smarket, package = "ISLR")

## Other datasets used
# none

##################################
## packages needed: caret, ISLR ##
##################################

## ----message=FALSE-------------------------------------------------------
require(caret)

## ----02i-loadandknnst----------------------------------------------------
train <- (Smarket$Year < 2005)
train_X <- Smarket[train, c("Lag1", "Lag2")]
test_X <- Smarket[!train, c("Lag1", "Lag2")]
train_Y <- Smarket[train, "Direction"]
test_Y <- Smarket[!train, "Direction"]
set.seed(123)   # the random seed is needed because R will break ties at random
knn_pred_1 <- knn3Train(train_X, test_X, train_Y, k = 1, use.all = FALSE)
confusionMatrix(data = knn_pred_1, reference = test_Y, positive = "Up")

## ----02i-knnk3st---------------------------------------------------------
knn_pred_3 <- knn3Train(train_X, test_X, train_Y, k = 3, use.all = FALSE)
confusionMatrix(data = knn_pred_3, reference = test_Y, positive = "Up")

## ----02i-knnkmultist-----------------------------------------------------
kmax <- 100
test_error <- numeric(kmax)
for (k in 1:kmax) {
  knn_pred <- knn3Train(train_X, test_X, train_Y, k = k, prob = FALSE,
						  use.all = FALSE)
	cm <- confusionMatrix(data = knn_pred, reference = test_Y, positive = "Up")
	test_error[k] <- 1 - cm$overall[1]
}
k_min <- which.min(test_error)
knn_pred_min <- knn3Train(train_X, test_X, train_Y, k = k_min, prob = FALSE,
						 use.all = FALSE)
cm <- confusionMatrix(data = knn_pred_min, reference = test_Y, positive = "Up")
ggp <- ggplot(data.frame(test_error), aes(x = 1:kmax, y = test_error)) +
	geom_line() +
  geom_point() +
  xlab("K (#neighbors)") + ylab("Test error") +
	ggtitle(paste0("KNN best K value = ", k_min,
				   " (min error = ",
				   format((1 - cm$overall[1])*100, digits = 4), "%)"))
print(ggp)

