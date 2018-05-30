---
title: "Support Vector Machines (SVM)"
---






# Introduction

Support Vector Machines (SVM) is an approach for classification developed in the computer science
community, which has recently grown in popularity because they have shown to
perform well in many different contexts. We now briefly present the main
ideas without delving too much into the complicated technical details (for a
more complete presentation see for example Hastie, T., Tibshirani, R., and
Friedman, J., The Elements of Statistical Learning, 2nd edition, Springer,
2009).

The main idea of SVM is to enlarge the feature space using quadratic, cubic
or higher-order polynomial functions of the predictors, interaction terms, or
even more complicated functions of the predictors, to accommodate non-linear
boundaries between the classes. The building blocks of SVM are the "inner
products" of the observations (rather than the observations themselves),
which enter in the classifier after they have been transformed through a
kernel. There are many possible choices of kernels, with the most popular
ones being polynomial and radial kernels.


## An Example with Simulated Data

There are many packages in `R` that implement SVM. We focus here on the `svm()`
function in the `e1071` package. Other options are the `kernlab` package and the
`LiblineaR` package, which is useful for very large linear problems. We now
apply SVM to some simulated data to show the ability of SVM to generate non-
linear boundaries:


```r
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
```

![plot of chunk 02i-svmsd](figure/02i-svmsd-1.png)

We then randomly split the data into training and testing groups and fit the
training data using the `svm()` function using a radial kernel with parameter
gamma set to 1:


```r
require(e1071)
```


```r
train <- sample(n, 100)
svm.fit <- svm(y ~ ., data = dat[train, ], kernel = "radial", gamma = 1,
			   cost = 1)
plot(svm.fit, dat[train, ],svSymbol = "x", dataSymbol = "o")
```

![plot of chunk 02i-plotsvmsd](figure/02i-plotsvmsd-1.png)

The figure shows that there are some training errors in this SVM fit. By
increasing the value of the cost, we can reduce the number of training
errors at the cost of more irregular boundaries:


```r
svm.fit <- svm(y ~., data = dat[train, ], kernel = "radial", gamma = 1,
			   cost = 1e5)
plot(svm.fit, dat[train, ],svSymbol = "x", dataSymbol = "o")
```

![plot of chunk 02i-plot2svmsd](figure/02i-plot2svmsd-1.png)

It is possible to perform cross-validation using the `tune()` function to
select the best choice of gamma and cost for an SVM with a radial kernel:


```r
set.seed(123)
tune.out <- tune(svm, y~ ., data = dat[train, ], kernel = "radial",
				 ranges = list(cost = c(0.1, 1, 10, 100, 1000),
				 gamma = c(0.5, 1, 2, 3, 4)))
summary(tune.out)
```

```
## 
## Parameter tuning of 'svm':
## 
## - sampling method: 10-fold cross validation 
## 
## - best parameters:
##  cost gamma
##    10     3
## 
## - best performance: 0.08 
## 
## - Detailed performance results:
##     cost gamma error dispersion
## 1  1e-01   0.5  0.22 0.10327956
## 2  1e+00   0.5  0.11 0.08755950
## 3  1e+01   0.5  0.09 0.05676462
## 4  1e+02   0.5  0.11 0.08755950
## 5  1e+03   0.5  0.10 0.08164966
## 6  1e-01   1.0  0.22 0.10327956
## 7  1e+00   1.0  0.11 0.08755950
## 8  1e+01   1.0  0.10 0.08164966
## 9  1e+02   1.0  0.09 0.07378648
## 10 1e+03   1.0  0.13 0.08232726
## 11 1e-01   2.0  0.22 0.10327956
## 12 1e+00   2.0  0.12 0.09189366
## 13 1e+01   2.0  0.11 0.07378648
## 14 1e+02   2.0  0.12 0.06324555
## 15 1e+03   2.0  0.16 0.08432740
## 16 1e-01   3.0  0.22 0.10327956
## 17 1e+00   3.0  0.13 0.09486833
## 18 1e+01   3.0  0.08 0.07888106
## 19 1e+02   3.0  0.14 0.06992059
## 20 1e+03   3.0  0.16 0.08432740
## 21 1e-01   4.0  0.22 0.10327956
## 22 1e+00   4.0  0.12 0.09189366
## 23 1e+01   4.0  0.09 0.07378648
## 24 1e+02   4.0  0.13 0.06749486
## 25 1e+03   4.0  0.17 0.11595018
```

The best choice of parameters involves `cost = 10` and `gamma = 3`. 


```r
svm.fit <- svm(y ~., data = dat[train, ], kernel = "radial", gamma = 3,
    	   cost = 10)
plot(svm.fit, dat[train, ],svSymbol = "x", dataSymbol = "o")
```

![plot of chunk 02i-svmplot3sd](figure/02i-svmplot3sd-1.png)

We can get the test set predictions for this model through the `prediction()` function:


```r
require(caret) # loaded to use confusionMatrix()
```


```r
svm.pred <- predict(tune.out$best.model, newx = dat[-train, ])
confusionMatrix(data = svm.pred, reference = dat[-train, "y"], positive = "1")
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction  1  2
##          1 56 20
##          2 16  8
##                                           
##                Accuracy : 0.64            
##                  95% CI : (0.5379, 0.7336)
##     No Information Rate : 0.72            
##     P-Value [Acc > NIR] : 0.9684          
##                                           
##                   Kappa : 0.0664          
##  Mcnemar's Test P-Value : 0.6171          
##                                           
##             Sensitivity : 0.7778          
##             Specificity : 0.2857          
##          Pos Pred Value : 0.7368          
##          Neg Pred Value : 0.3333          
##              Prevalence : 0.7200          
##          Detection Rate : 0.5600          
##    Detection Prevalence : 0.7600          
##       Balanced Accuracy : 0.5317          
##                                           
##        'Positive' Class : 1               
## 
```

36% of test observations are misclassified by this SVM.

## Some theory about SVM
The following plot shows an example of SVM with two perfect separable classes in $\mathbb{R}^2$.

![](./images/svm-schema.png)

When the classes are perfectly separated (__hard margin__), then SVM searches for the
"line" that maximally separates the data points of the two classes.  
SVM then maximizes the margin $m$.  
Since the distance between the origin and the line $w^Tx = k$ is $\frac{k}{\left \| w \right \|}$, the size of $m$ margin is $m=\frac{2}{\left \| w \right \|}$.

Let $\{ x_1 , \dots , x_n \}$ be our data set and let $y_i \in \{1,-1\}$ be
the class label of $x_i$ (where $x_i$ are points in $\mathbb{R}^p$):

* The decision boundary should classify all points correctly  
  $y_i \left(w^Tx_i + b \right) \ge 1 ,     \forall i \in 1, \dots, n$
  
* Thus the decision boundary can be found by solving the  
  following constrained optimization problem (Lagrange multipliers):  
  $\min \left\{ \|w\| \right \}  \text{ s.t. } y_i \left(w^Tx_i + b \right) \ge 1 \forall i \in 1, \dots, n$

When the classes are not perfectly separated (__soft margin__), then SVM is extendend
by introducing the _hinge loss_ function.:

$max\left\{ 0, 1- y_i \left(w^Tx_i + b \right) \right\}$

This function is zero if $x_i$ lies on the correct side of the margin. For data on the
wrong side of the margin, the function's value is proportional to the distance from the
margin. We then wish to obtain:

$\min \left\{\left[\frac 1 n \sum_{i=1}^n \max\left(0, 1 - y_i(w \cdot x_i - b)\right) \right] + \lambda\| w \|^2 \right\}$

where the parameter $\lambda$ determines the tradeoff between increasing the margin-size
and ensuring that the $x_i$ lie on the correct side of the margin. Thus, for sufficiently
small values of $\lambda$, the soft-margin SVM will behave identically to the hard-margin
SVM if the input data are linearly classifiable, but will still learn a viable
classification rule if not.

<!---
# Exerccises?
--->