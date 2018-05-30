---
title: "K-Nearest Neighbors (KNN)"
---






# Introduction

Given a positive integer $K$ and a test observation $x$, the K-Nearest Neighbors (KNN) classifier first
identifies the $K$ points in the training data that are closest to $x$.
It then estimates the probability for every class $j$ of
the response variable as the fraction of points in $K$ whose response values
equal $j$. Then, it classifies the test observation $x$ to the class with the
largest probability. Even if KNN is a very simple approach, it can often
produce surprisingly good results. The key point in applying KNN is the
choice of $K$, the number of closest observations to include in the neighbor of
a given point. When $K$ is small, the method produces very flexible decision
boundaries. As $K$ grows, the method becomes less flexible and produces
decision boundaries that are close to linear. $K$ is usually chosen using an
approach called "cross-validation".

One advantage of KNN is that it is a completely non-parametric approach,
because no assumptions are made about the shape of the decision boundaries.
Therefore, KNN can produce better results than LDA and logistic regression
especially when the decision boundaries are highly non-linear. On the other
hand, KNN is less informative than LDA and logistic regression, because it
doesn't provide an intuition about which predictors are important for
discriminating the response classes, since it doesn't produce a table of
coefficients.


## Example: Stock Market Data

We now apply KNN to `Smarket` (see the section *Introduction and datasets used* for further information), the same stock market data we already presented for LDA.
The package `caret` contains the function `knn3Train()` which directly returns the predictions for the response variable. This function requires the predictor values for both the training and test data, the class labels for the training observations, and a value for $K$. We still use the data from 2005 as the test set and all the remaining observations for training:


```r
require(caret)
```


```r
train <- (Smarket$Year < 2005)
train_X <- Smarket[train, c("Lag1", "Lag2")]
test_X <- Smarket[!train, c("Lag1", "Lag2")]
train_Y <- Smarket[train, "Direction"]
test_Y <- Smarket[!train, "Direction"]
set.seed(123)   # the random seed is needed because R will break ties at random
knn_pred_1 <- knn3Train(train_X, test_X, train_Y, k = 1, use.all = FALSE)
confusionMatrix(data = knn_pred_1, reference = test_Y, positive = "Up")
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction Down Up
##       Down   43 58
##       Up     68 83
##                                           
##                Accuracy : 0.5             
##                  95% CI : (0.4366, 0.5634)
##     No Information Rate : 0.5595          
##     P-Value [Acc > NIR] : 0.9751          
##                                           
##                   Kappa : -0.0242         
##  Mcnemar's Test P-Value : 0.4227          
##                                           
##             Sensitivity : 0.5887          
##             Specificity : 0.3874          
##          Pos Pred Value : 0.5497          
##          Neg Pred Value : 0.4257          
##              Prevalence : 0.5595          
##          Detection Rate : 0.3294          
##    Detection Prevalence : 0.5992          
##       Balanced Accuracy : 0.4880          
##                                           
##        'Positive' Class : Up              
## 
```

Using `k = 1` only 50% of the observations in the test set are correctly
predicted. We now repeat the analysis using `k = 3`:


```r
knn_pred_3 <- knn3Train(train_X, test_X, train_Y, k = 3, use.all = FALSE)
confusionMatrix(data = knn_pred_3, reference = test_Y, positive = "Up")
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction Down Up
##       Down   48 55
##       Up     63 86
##                                           
##                Accuracy : 0.5317          
##                  95% CI : (0.4681, 0.5946)
##     No Information Rate : 0.5595          
##     P-Value [Acc > NIR] : 0.8294          
##                                           
##                   Kappa : 0.0427          
##  Mcnemar's Test P-Value : 0.5193          
##                                           
##             Sensitivity : 0.6099          
##             Specificity : 0.4324          
##          Pos Pred Value : 0.5772          
##          Neg Pred Value : 0.4660          
##              Prevalence : 0.5595          
##          Detection Rate : 0.3413          
##    Detection Prevalence : 0.5913          
##       Balanced Accuracy : 0.5212          
##                                           
##        'Positive' Class : Up              
## 
```

With `k = 3` we get slightly better results (53.6% correctly classified). As an
attempt to improve the results, we look for the optimal value of $K$ by
evaluating the test error rate over different values of $K$ and choosing the
one that minimizes it:


```r
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
```

![plot of chunk 02i-knnkmultist](figure/02i-knnkmultist-1.png)

`k = 72` seems to provide the smallest test error rate (around 46%). To
conclude, it seems that KNN does not provide a better result than LDA and
QDA.

The `caret` package provides many very general functions, such as `train()`, for
fitting a wide range of predictive models using cross-validation or other
resampling methods, but these functions are considerably more complicated to
be used.


<!---
# Exercises with iris or utilities or uscrimes 
--->
