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

## Example: Boston housing

Perhaps, the most important `R` packages that implement random forests is
`randomForest`.
The next example, based on bosto housing data, will then use
the `randomForest()` function of the `randomForest` package.


Let's look at a summary of example data:

```r
summary(bostonhousing)
```

```
##       crim                zn             indus       chas         nox               rm       
##  Min.   : 0.00632   Min.   :  0.00   Min.   : 0.46   0:471   Min.   :0.3850   Min.   :3.561  
##  1st Qu.: 0.08204   1st Qu.:  0.00   1st Qu.: 5.19   1: 35   1st Qu.:0.4490   1st Qu.:5.886  
##  Median : 0.25651   Median :  0.00   Median : 9.69           Median :0.5380   Median :6.208  
##  Mean   : 3.61352   Mean   : 11.36   Mean   :11.14           Mean   :0.5547   Mean   :6.285  
##  3rd Qu.: 3.67708   3rd Qu.: 12.50   3rd Qu.:18.10           3rd Qu.:0.6240   3rd Qu.:6.623  
##  Max.   :88.97620   Max.   :100.00   Max.   :27.74           Max.   :0.8710   Max.   :8.780  
##       age              dis              rad              tax           ptratio            b         
##  Min.   :  2.90   Min.   : 1.130   Min.   : 1.000   Min.   :187.0   Min.   :12.60   Min.   :  0.32  
##  1st Qu.: 45.02   1st Qu.: 2.100   1st Qu.: 4.000   1st Qu.:279.0   1st Qu.:17.40   1st Qu.:375.38  
##  Median : 77.50   Median : 3.207   Median : 5.000   Median :330.0   Median :19.05   Median :391.44  
##  Mean   : 68.57   Mean   : 3.795   Mean   : 9.549   Mean   :408.2   Mean   :18.46   Mean   :356.67  
##  3rd Qu.: 94.08   3rd Qu.: 5.188   3rd Qu.:24.000   3rd Qu.:666.0   3rd Qu.:20.20   3rd Qu.:396.23  
##  Max.   :100.00   Max.   :12.127   Max.   :24.000   Max.   :711.0   Max.   :22.00   Max.   :396.90  
##      lstat            medv      
##  Min.   : 1.73   Min.   : 5.00  
##  1st Qu.: 6.95   1st Qu.:17.02  
##  Median :11.36   Median :21.20  
##  Mean   :12.65   Mean   :22.53  
##  3rd Qu.:16.95   3rd Qu.:25.00  
##  Max.   :37.97   Max.   :50.00
```


```r
require(dplyr)
require(randomForest)
```


```r
set.seed(100)

bostonhousing$lstat <- log(bostonhousing$lstat)
bostonhousing$rm <- bostonhousing$rm^2
bostonhousing$chas <- factor(bostonhousing$chas, levels = 0:1, labels = c("no", "yes"))
bostonhousing$rad <- factor(bostonhousing$rad, ordered = TRUE)

bostonhousing <- bostonhousing %>%
  select(medv, age, lstat, rm, zn, indus, chas, nox, age, dis, rad, tax, crim, b, ptratio)

train <- sample(nrow(bostonhousing), 400)
bh_train <- bostonhousing[train,]
bh_test <-  bostonhousing[-train,]

(rf_fit <- randomForest(medv ~ ., data = bh_train))
```

```
## 
## Call:
##  randomForest(formula = medv ~ ., data = bh_train) 
##                Type of random forest: regression
##                      Number of trees: 500
## No. of variables tried at each split: 4
## 
##           Mean of squared residuals: 11.20303
##                     % Var explained: 86.8
```

```r
plot(rf_fit)
```

![plot of chunk 06b-RFregr](figure/06b-RFregr-1.png)

<!--- https://stats.stackexchange.com/questions/51629/multiple-curves-when-plotting-a-random-forest --->
In above plot, the back solid line shows the overall error of random forest when the number of trees $B$ grows<!---;
the other lines, however, show the classifcation error for individual classes --->. In this case, about 100 trees 
are sufficient to minimize the global error.

Obviously, we can produce a plot of obsered Vs. predicted values, for training and test sets:

```r
require(dplyr)
data_gr <- bh_train %>%
  mutate(set="train") %>%
  bind_rows(bh_test %>% mutate(set="test"))

data_gr$fit <- predict(rf_fit, data_gr)

require(ggplot2)
```

```
## Loading required package: ggplot2
```

```
## 
## Attaching package: 'ggplot2'
```

```
## The following object is masked from 'package:randomForest':
## 
##     margin
```

```r
ggp <- ggplot(data = data_gr, mapping = aes(x=fit, y=medv)) +
  geom_point(aes(colour=set), alpha=0.6) +
  geom_abline(slope=1, intercept = 0) +
  geom_smooth(method = "lm", se = FALSE, aes(colour=set), alpha=0.6)
print(ggp)
```

![plot of chunk 05c-plots](figure/05c-plots-1.png)

The above Random Forest model chose Randomly 4 variables to be considered at each split. We could now try all possible 13 predictors which can be found at each split.


```r
set.seed(100)
oob_err <- double(13)
test_err <- double(13)

#mtry is no of Variables randomly chosen at each split
for(mtry in 1:13) 
{
  rf <- randomForest(medv ~ . , data = bh_train, mtry=mtry,ntree=400) 
  oob_err[mtry] <- rf$mse[400] #Error of all Trees fitted
  
  pred <- predict(rf,bh_test) #Predictions on Test Set for each Tree
  test_err[mtry] <- with(bh_test, mean( (medv - pred)^2)) #Mean Squared Test Error
}

# Test Error
test_err
```

```
##  [1] 13.746881  7.659979  6.645199  5.955705  6.078504  6.216903  6.399190  6.657700  6.941230  7.724116
## [11]  7.608894  7.974109  8.210818
```

```r
# Out of Bag Error Estimation
oob_err
```

```
##  [1] 21.11856 14.29039 12.28204 11.48085 10.98090 11.05920 10.83517 10.45569 10.92728 10.90429 11.19955
## [12] 11.12854 11.20330
```

Now we plot both Test Error and Out of Bag Error

```r
ds_gr <- data_frame(type=c(rep("test", length(test_err)), rep("oob", length(oob_err))), mtry = c(1:length(test_err), 1:length(oob_err)), error=c(test_err, oob_err))

ggp <- ggplot(data = ds_gr, mapping = aes(x=mtry,y=error)) +
  geom_line(aes(colour=type)) +
  geom_point(aes(colour=type)) + 
  ggtitle("OOB and Test error Vs. Number of variables in trees (mtry)")
  
print(ggp)
```

![plot of chunk 06d-numberofvarsplot](figure/06d-numberofvarsplot-1.png)

Now what we observe is that the Red line is the Out of Bag Error Estimates and the Blue Line is the Error calculated on Test Set. Both curves are quite smooth and the error estimates are somewhat correlated too. The Test Error tends to be minimized around 4, whereas OOB Error tends to be minimized at around `mtry` = 8.  
On the Extreme Right Hand Side of the above plot, we considered all possible 13 predictors at each Split which is only Bagging.

Now we can try the model with `mtry` = 8.


```r
set.seed(100)
(rf_fit <- randomForest(medv ~ ., data = bh_train, mtry=8))
```

```
## 
## Call:
##  randomForest(formula = medv ~ ., data = bh_train, mtry = 8) 
##                Type of random forest: regression
##                      Number of trees: 500
## No. of variables tried at each split: 8
## 
##           Mean of squared residuals: 11.01078
##                     % Var explained: 87.02
```

```r
plot(rf_fit)
```

![plot of chunk 06e-final-model](figure/06e-final-model-1.png)

```r
data_gr <- bh_train %>%
  mutate(set="train") %>%
  bind_rows(bh_test %>% mutate(set="test"))

data_gr$fit <- predict(rf_fit, data_gr)

require(ggplot2)
ggp <- ggplot(data = data_gr, mapping = aes(x=fit, y=medv)) +
  geom_point(aes(colour=set), alpha=0.6) +
  geom_abline(slope=1, intercept = 0) +
  geom_smooth(method = "lm", se = FALSE, aes(colour=set), alpha=0.6)
print(ggp)
```

![plot of chunk 06e-final-model](figure/06e-final-model-2.png)

No big differences from the previous model are visibile.

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
are grown, the random forest regression predictor is
$$\hat{f}_{rf}^B(x) = \frac{1}{B} \sum_{b=1}^B T_b(x; \Theta_b)$$ 
Where $majority vote$ means the most votes classes, and $\Theta_b$ characterizes
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
