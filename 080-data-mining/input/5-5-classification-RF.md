---
title: "Random Forests"
---






# Introduction

Random Forest is often considered to be a _panacea_ of all data science problems.
On a funny note, when you can’t think of any algorithm (irrespective of situation),
use random forest!

Random Forest is a versatile machine learning method capable of performing both
regression and classification tasks. It also undertakes dimensional reduction methods,
treats missing values, outlier values and other essential steps of data exploration,
and does a fairly good job. For a
more complete presentation see for example Hastie, T., Tibshirani, R., and
Friedman, J., The Elements of Statistical Learning, 2nd edition, Springer,
2009.

Bagging or bootstrap aggregation is a technique for reducing
the variance of an estimated prediction function. Bagging seems to work
especially well for high-variance, low-bias procedures, such as trees. For
regression, we simply fit the same regression tree many times to bootstrap-
sampled versions of the training data, and average the result. For classifi-
cation, a committee of trees each cast a vote for the predicted class.

Random forests (Breiman, 2001) is a substantial modification of bagging
that builds a large collection of de-correlated trees, and then averages them.
On many problems the performance of random forests is high, and they are simple
to train and tune. As a consequence, random forests became popular.

## Example: Credit card default

Perhaps, the most important `R` packages that implement random forests is
`randomForest`.
The next example, based on credit card default data seen above, will then use
the `randomForest()` function of the `randomForest` package.


Let's look at a summary of example data:

```r
summary(Default)
```

```
##  default    student       balance           income     
##  No :9667   No :7056   Min.   :   0.0   Min.   :  772  
##  Yes: 333   Yes:2944   1st Qu.: 481.7   1st Qu.:21340  
##                        Median : 823.6   Median :34553  
##                        Mean   : 835.4   Mean   :33517  
##                        3rd Qu.:1166.3   3rd Qu.:43808  
##                        Max.   :2654.3   Max.   :73554
```


```r
require(randomForest)
```


```r
set.seed(1000)
train <- sample(nrow(Default), 2000)
default_train <- Default[train,]
default_test <-  Default[-train,]

(rf_fit <- randomForest(x= default_train[,c("student","balance", "income")], y = default_train$default, 
                        xtest= default_test[,c("student","balance", "income")], ytest = default_test$default, 
                        cutoff = c(0.8, 0.2)))
```

```
## 
## Call:
##  randomForest(x = default_train[, c("student", "balance", "income")],      y = default_train$default, xtest = default_test[, c("student",          "balance", "income")], ytest = default_test$default,      cutoff = c(0.8, 0.2)) 
##                Type of random forest: classification
##                      Number of trees: 500
## No. of variables tried at each split: 1
## 
##         OOB estimate of  error rate: 3.35%
## Confusion matrix:
##       No Yes class.error
## No  1897  28  0.01454545
## Yes   39  36  0.52000000
##                 Test set error rate: 2.97%
## Confusion matrix:
##       No Yes class.error
## No  7649  93   0.0120124
## Yes  145 113   0.5620155
```

```r
plot(rf_fit)
```

![plot of chunk 02i-plotsvmsd](figure/02i-plotsvmsd-1.png)

<!--- https://stats.stackexchange.com/questions/51629/multiple-curves-when-plotting-a-random-forest --->
In above plot, the back solid line shows the overall OOB (Out Of Bag) error of random forest when the number of trees $B$ grows;
the other lines, however, show the OOB classifcation error for individual classes. In this case, less than 50 trees 
are sufficient to minimize the global error.

<!--- https://www.linkedin.com/pulse/decoding-probabilities-random-forest-sanchit-tiwari --->
Note also the use of the `cutoff` parameter that sets the threshold for which
to declare "defaulter" one customer.  
In this case, we have chosen to set the cutoff values to `c(0.8, 0.2)`, i.e.,
a customer is defined as defaulter if he/she obtain a value of fraction of
trees voted as defaulter greater than `0.2`.  
This corresponds to a weighted voting scheme where one vote for class `default` has 
four times weight than the `non-default` class.  
This result has a greater sensitivity to defaulters than the default (50%, 50%) cutoff.

## Some theory about Random Forests

The essential idea in bagging is to average many noisy but
approximately unbiased models, and hence reduce the variance. Trees are
ideal candidates for bagging, since they can capture complex interaction
structures in the data, and if grown sufficiently deep, have relatively low
bias. Since trees are notoriously noisy, they benefit greatly from the averaging.
Moreover, since each tree generated in bagging is identically distributed
(i.d.), the expectation of an average of $B$ such trees is the same as the 
expectation of any one of them. This means the bias of bagged trees is the
same as that of the individual trees, and the only hope of improvement is
through variance reduction. 
An average of $B$ i.i.d. random variables, each with variance $\sigma^2$ , has variance
$\frac{1}{B} \sigma^2$. If the variables are simply i.d. (identically distributed, but not
necessarily independent) with positive pairwise correlation $\rho$, the variance
of the average is
$$\rho \sigma^2 + \frac{1-\rho}{B} \sigma^2$$
As $B$ increases, the second term disappears, but the first remains, and
hence the size of the correlation of pairs of bagged trees limits the benefits
of averaging. The idea in random forests is to improve
the variance reduction of bagging by reducing the correlation between the
trees, without increasing the variance too much. This is achieved in the
tree-growing process through random selection of the input variables.

Specifically, when growing a tree on a bootstrapped dataset:

 * _Before each split, select $m \le p$ of the input variables at random as candidates for splitting_

Typically values for $m$ are $p$ or even as low as 1.
After $B$ such trees $\left\{T (x; \Theta_b )\right\}_1^B$
are grown, the random forest classification predictor is
$$\hat{C}_{rf}^B(x) = majority vote \left\{ \hat{C}_b(x)\right\}_1^B$$ 
Where $majority vote$ means the most voted classes, and $\Theta_b$ characterizes
the $b$th random forest tree in
terms of split variables, cutpoints at each node, and terminal-node values, and
$\hat{C}_b(x)$ is the class prediction of the $b$th random-forest tree.
Intuitively, reducing $m$ will reduce the correlation between any pair of trees
in the ensemble, and hence will reduce the variance of the average.  

The algorithm of random forest may be then summarized as:

1. For $b = 1 \dots B$:
    (a) Draw a bootstrap sample $Z^*$ of size $N$ from the training data.
    (b) Grow a random-forest tree $T_b$ to the bootstrapped data, by recursively repeating the following steps for each terminal node of the tree, until the minimum node size $n_{min}$ is reached.
        i. Select $m$ variables at random from the $p$ variables.
        ii. Pick the best variable/split-point among the $m$.
        iii. Split the node into two daughter nodes.
2. Output the ensemble of trees $\left\{T_b\right\}_1^B$

<!---
# Exerccises?
--->
