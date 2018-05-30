---
title: "Linear and Quadratic Discriminant Analyses (LDA and QDA)"
---





# Linear Discriminant Analysis (LDA)

In LDA, the distribution of the predictors $X$ are modeled separately in each
of the response classes (i.e. given $Y$), and then a rule from probability
theory, known as Bayes' theorem, is used to turn these into estimates for
$Pr(Y = k|X = x)$, called "posterior" probabilities. More specifically, Bayes'
theorem allows to obtain the posterior probabilities by combining "prior"
probabilities with the evidence coming from the data. Every observation is
then assigned to the class with the highest posterior probability.

Alternatively, following the formulation by Fisher, the goal of LDA can also
be stated as finding a linear combination $w$ of the predictors that maximizes
the separation between the centers of the data while at the same time
minimizing the variation within each group of data after projection onto $w$.
Recall that the first principal component is the direction that maximizes
the projected variance of the points. The key difference between PCA and LDA
is that the former deals with unlabeled data and tries to  maximize variance,
whereas the latter deals with labeled data and tries to  maximize the
discrimination between the classes. 

The assumption in LDA is that the predictors' covariance matrices within each class are equal.

In LDA the unknown parameters of the multivariate normal distributions of
each class have to be first estimated. These estimates are then used to find
the decision boundaries based on which observations are assigned to the
different classes. These boundaries are determined by the so called "Fisher's
linear discriminant function".


To perform LDA on Credit Card data, we use the `lda()` function of the `MASS` package. This function
requires to set a formula that specifies the categorical response and the
predictors to use, the data frame containing the data, and a series
of other optional arguments, such as the method to use for estimation and the
prior probabilities for each class (if the prior argument is not specified,
the class proportions for the training set are used):

## Example: Credit Card Default

We will try the LDA on the `Default` dataset:


```r
require(MASS)
```


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
res <- lda(default ~ student + balance, data = Default)
res
```

```
## Call:
## lda(default ~ student + balance, data = Default)
## 
## Prior probabilities of groups:
##     No    Yes 
## 0.9667 0.0333 
## 
## Group means:
##     studentYes   balance
## No   0.2914037  803.9438
## Yes  0.3813814 1747.8217
## 
## Coefficients of linear discriminants:
##                     LD1
## studentYes -0.249059498
## balance     0.002244397
```

The output (an object of class `lda`) shows that non-students with a higher
balance are more likely to default. To classify the observations to either
of the two classes, we use the `predict()` function:


```r
default_hat <- predict(res)$class
```

And now we can assess the goodness of the classification:


```r
table(default_hat, Default$default)
```

```
##            
## default_hat   No  Yes
##         No  9644  252
##         Yes   23   81
```

Elements on the diagonal of the matrix represent individuals whose default
statuses were correctly predicted, while off-diagonal elements represent
individuals that were misclassified. So, the LDA model fit to the 10,000
observations results in an error rate of (23 + 252)/10,000 = 0.0275, i.e. a
2.75%. This sounds like a low error rate, but two caveats must be noted:

1. First, error rates for the observations used in estimation are typically
	  expected to be smaller than if we use the model to predict whether or
	  not a new set of individuals will default. The reason is that we
	  specifically adjust the parameters of our model to do well on the
	  "training" data;

2. Second, since only 3.33% of the individuals in the training sample
	  defaulted, a simple but useless classifier that always predicts that
	  each individual will not default, regardless of his or her credit card
	  balance and student status, will result in an error rate of 3.33%. In
	  other words, the trivial null classifier will achieve an error rate that
	  is only a bit higher than the LDA training set error rate.

However, of the 333 individuals who defaulted, 252 (or 252/333 = 0.757) were
missed by LDA. So, while the overall error rate is low, the error rate among
individuals who defaulted is very high. From the perspective of a credit
card company that is trying to identify high-risk individuals, an error rate
of 75.7% among individuals who default might be unacceptable.
A further way to assess class-specific performance uses the concepts of
sensitivity" and "specificity". The sensitivity is the percentage of true
defaulters that are identified, in the example equal to 81/(252 + 81) =
0.243. The specificity is the percentage of non-defaulters that are correctly
identified, in the example equal to 9,644/(9,644 + 23) = 0.998.

In the `caret` package we find the `confusionMatrix()` function that calculates
automatically the table and other statistics related to the classification
problem:


```r
require(caret)
```


```r
confusionMatrix(data = default_hat, reference = Default$default,
				positive = "Yes")
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction   No  Yes
##        No  9644  252
##        Yes   23   81
##                                           
##                Accuracy : 0.9725          
##                  95% CI : (0.9691, 0.9756)
##     No Information Rate : 0.9667          
##     P-Value [Acc > NIR] : 0.0004973       
##                                           
##                   Kappa : 0.3606          
##  Mcnemar's Test P-Value : < 2.2e-16       
##                                           
##             Sensitivity : 0.2432          
##             Specificity : 0.9976          
##          Pos Pred Value : 0.7788          
##          Neg Pred Value : 0.9745          
##              Prevalence : 0.0333          
##          Detection Rate : 0.0081          
##    Detection Prevalence : 0.0104          
##       Balanced Accuracy : 0.6204          
##                                           
##        'Positive' Class : Yes             
## 
```

To understand why LDA is performing so poorly (especially from the
sensitivity point of view), note that in this example we are particularly
concerned with the misclassification of individuals who actually default,
whereas the misclassification of individuals who will not default is less
problematic. So far, to assign an observation to the default class, we used a
threshold of 50% for the posterior probability of default. One possibility to
improve the sensitivity of this classifier is to lower this threshold. For
instance, we might label any customer with a posterior probability of default
above 20% to the default class. Doing this we would get the following
results:


```r
post <- predict(res)$posterior
threshold <- 0.2
default_hat_20 <- as.factor(ifelse(post[, 2] > threshold, 1, 0))
levels(default_hat_20) <- c("No", "Yes")
prop.table(table(default_hat_20, Default$default), margin = 2)
```

```
##               
## default_hat_20         No        Yes
##            No  0.97569049 0.41441441
##            Yes 0.02430951 0.58558559
```

```r
confusionMatrix(data = default_hat_20, reference = Default$default,
				positive = "Yes")
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction   No  Yes
##        No  9432  138
##        Yes  235  195
##                                           
##                Accuracy : 0.9627          
##                  95% CI : (0.9588, 0.9663)
##     No Information Rate : 0.9667          
##     P-Value [Acc > NIR] : 0.9869          
##                                           
##                   Kappa : 0.4921          
##  Mcnemar's Test P-Value : 6.671e-07       
##                                           
##             Sensitivity : 0.5856          
##             Specificity : 0.9757          
##          Pos Pred Value : 0.4535          
##          Neg Pred Value : 0.9856          
##              Prevalence : 0.0333          
##          Detection Rate : 0.0195          
##    Detection Prevalence : 0.0430          
##       Balanced Accuracy : 0.7806          
##                                           
##        'Positive' Class : Yes             
## 
```

Of the 333 individuals who default, now LDA correctly predicts all but 138,
41.4%). This is a huge improvement! However, this improvement has a price:
now 235 individuals who do not default are incorrectly classified. As a
result, the overall error rate has increased slightly to 3.73%. Probably this
might be considered a small price to pay for a more accurate identification
of individuals who default. The key question now is how to choose which
threshold value is best. Unfortunately there is no immediate answer, because
this decision must be based on domain knowledge, such as detailed information
about the costs associated with default.

A popular tool for assessing the performance of a classifier is the "receiver
operating characteristics" curve (or ROC curve). This is a graph that
simultaneously displays both the sensitivity and specificity for all possible
thresholds. More specifically, the ROC curves reports on the vertical axis
the sensitivity and on the horizontal axis one minus the specificity
corresponding to many different thresholds ranging from zero to 1. ROC curves
are useful for comparing different classifiers. A synthesis of the overall
performance of a classifier is given by the area under the ROC curve (AUC).
An ideal ROC curve will get to the top left corner, so the larger the AUC
the better the classifier. There are many `R` packages that include functions
for producing a ROC curve. One of the easiest to use is the `pROC` package:


```r
require(pROC)
```


```r
roc(response = Default$default, predictor = post[, 2], auc = TRUE, ci = TRUE,
	plot = TRUE, main = "ROC curve")
```

![plot of chunk 02h-roccc](figure/02h-roccc-1.png)

```
## 
## Call:
## roc.default(response = Default$default, predictor = post[, 2],     auc = TRUE, ci = TRUE, plot = TRUE, main = "ROC curve")
## 
## Data: post[, 2] in 9667 controls (Default$default No) < 333 cases (Default$default Yes).
## Area under the curve: 0.9496
## 95% CI: 0.9401-0.959 (DeLong)
```

The AUC for our example is around 0.95, which is pretty close to the maximum
attainable value of 1, so would be considered very good. Note that this
function produces a ROC curve reporting the specificity on the horizontal
axis, which is then reversed. To produce a standard ROC curve with (1 - 
specificity) reported on the horizontal axis, use the argument
`legacy.axes = TRUE`.


```r
roc(response = Default$default, predictor = post[, 2], auc = TRUE, ci = TRUE,
	plot = TRUE, main = "ROC curve", legacy.axes = TRUE)
```

![plot of chunk 02h-roclegacycc](figure/02h-roclegacycc-1.png)

```
## 
## Call:
## roc.default(response = Default$default, predictor = post[, 2],     auc = TRUE, ci = TRUE, plot = TRUE, main = "ROC curve", legacy.axes = TRUE)
## 
## Data: post[, 2] in 9667 controls (Default$default No) < 333 cases (Default$default Yes).
## Area under the curve: 0.9496
## 95% CI: 0.9401-0.959 (DeLong)
```

To compare these results with a competing classifier, let's add to the
predictor set also the income of the customers that we excluded in the
previous analysis:


```r
res_new <- lda(default ~ ., data = Default)
res_new
```

```
## Call:
## lda(default ~ ., data = Default)
## 
## Prior probabilities of groups:
##     No    Yes 
## 0.9667 0.0333 
## 
## Group means:
##     studentYes   balance   income
## No   0.2914037  803.9438 33566.17
## Yes  0.3813814 1747.8217 32089.15
## 
## Coefficients of linear discriminants:
##                      LD1
## studentYes -1.746631e-01
## balance     2.243541e-03
## income      3.367310e-06
```

```r
post_new <- predict(res_new)$posterior
# plot the ROC fot original model
roc(response = Default$default, predictor = post[, 2], auc = TRUE, ci = TRUE,
	plot = TRUE, col = "magenta", main = "ROC comparison")
```

```
## 
## Call:
## roc.default(response = Default$default, predictor = post[, 2],     auc = TRUE, ci = TRUE, plot = TRUE, col = "magenta", main = "ROC comparison")
## 
## Data: post[, 2] in 9667 controls (Default$default No) < 333 cases (Default$default Yes).
## Area under the curve: 0.9496
## 95% CI: 0.9401-0.959 (DeLong)
```

```r
# add the ROC fot new model
roc(response = Default$default, predictor = post_new[, 2], auc = TRUE,
	ci = TRUE, plot = TRUE, col = "cyan", add = TRUE)
```

```
## 
## Call:
## roc.default(response = Default$default, predictor = post_new[,     2], auc = TRUE, ci = TRUE, plot = TRUE, col = "cyan", add = TRUE)
## 
## Data: post_new[, 2] in 9667 controls (Default$default No) < 333 cases (Default$default Yes).
## Area under the curve: 0.9495
## 95% CI: 0.9401-0.9589 (DeLong)
```

```r
legend(x = "bottomright", legend = c("w/o income", "w income"),
	   col = c("magenta", "cyan"), lty = rep(1, 2), lwd = rep(2, 2))
```

![plot of chunk 02h-roccomparecc](figure/02h-roccomparecc-1.png)

The two ROC curves and the corresponding AUC are indistinguishable, therefore
it seems that the addition of income doesn't help to better discriminate
the two groups. Other comparisons could be made with further models for
classification like the logistic regression previously estimated, which in this
example would return the same results:


```r
res_logit <- glm(default ~ student + balance, data = Default,
				 family = binomial(link = logit))
post_logit <- predict(res_logit, type = "response")
roc(response = Default$default, predictor = post[, 2], auc = TRUE, ci = TRUE,
	plot = TRUE, col = "magenta", main = "ROC comparison")
```

```
## 
## Call:
## roc.default(response = Default$default, predictor = post[, 2],     auc = TRUE, ci = TRUE, plot = TRUE, col = "magenta", main = "ROC comparison")
## 
## Data: post[, 2] in 9667 controls (Default$default No) < 333 cases (Default$default Yes).
## Area under the curve: 0.9496
## 95% CI: 0.9401-0.959 (DeLong)
```

```r
roc(response = Default$default, predictor = post_logit, auc = TRUE,
	ci = TRUE, plot = TRUE, col = "cyan", add = TRUE)
```

```
## 
## Call:
## roc.default(response = Default$default, predictor = post_logit,     auc = TRUE, ci = TRUE, plot = TRUE, col = "cyan", add = TRUE)
## 
## Data: post_logit in 9667 controls (Default$default No) < 333 cases (Default$default Yes).
## Area under the curve: 0.9495
## 95% CI: 0.9401-0.959 (DeLong)
```

```r
legend(x = "bottomright", legend = c("LDA", "logit"),
	   col = c("magenta", "cyan"), lty = rep(1, 2), lwd = rep(2, 2))
```

![plot of chunk 02h-roclogitcc](figure/02h-roclogitcc-1.png)

A more appropriate assessment of the predictive ability of these methods
would involve the comparison of the error rate on a separate "test" set. This
can be achieved by specifying the 'subset' argument in the `lda()` function.


# An Extension: Quadratic Discriminant Analysis (QDA)

QDA relaxes one the main assumption of LDA by assuming that each class has its
own covariance matrix. This modification gives rise to decision boundaries
that in QDA are quadratic functions of the predictors. Why would one prefer
LDA or QDA? The answer involves a trade-off between bias and variance of the
predictions. Roughly speaking, LDA tends to produce better results than QDA
if there are relatively few training observations and so reducing variance is
crucial. In contrast, QDA is recommended if the training set is larger, so
that the variance of the classifier is not a major concern.

The function `qda()` in the `MASS` package performs QDA:


```r
res_qda <- qda(default ~ student + balance, data = Default)
post_qda <- predict(res_qda)$posterior
threshold <- 0.2
default.qda <- as.factor(ifelse(post_qda[, 2] > threshold, 1, 0))
levels(default.qda) <- c("No", "Yes")
prop.table(table(default.qda, Default$default), margin = 2)
```

```
##            
## default.qda         No        Yes
##         No  0.96638047 0.35735736
##         Yes 0.03361953 0.64264264
```

```r
confusionMatrix(data = default.qda, reference = Default$default,
				positive = "Yes")
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction   No  Yes
##        No  9342  119
##        Yes  325  214
##                                           
##                Accuracy : 0.9556          
##                  95% CI : (0.9514, 0.9596)
##     No Information Rate : 0.9667          
##     P-Value [Acc > NIR] : 1               
##                                           
##                   Kappa : 0.469           
##  Mcnemar's Test P-Value : <2e-16          
##                                           
##             Sensitivity : 0.6426          
##             Specificity : 0.9664          
##          Pos Pred Value : 0.3970          
##          Neg Pred Value : 0.9874          
##              Prevalence : 0.0333          
##          Detection Rate : 0.0214          
##    Detection Prevalence : 0.0539          
##       Balanced Accuracy : 0.8045          
##                                           
##        'Positive' Class : Yes             
## 
```

```r
roc(response = Default$default, predictor = post[, 2], auc = TRUE, ci = TRUE,
	plot = TRUE, col = "magenta", main = "ROC comparison")
```

```
## 
## Call:
## roc.default(response = Default$default, predictor = post[, 2],     auc = TRUE, ci = TRUE, plot = TRUE, col = "magenta", main = "ROC comparison")
## 
## Data: post[, 2] in 9667 controls (Default$default No) < 333 cases (Default$default Yes).
## Area under the curve: 0.9496
## 95% CI: 0.9401-0.959 (DeLong)
```

```r
roc(response = Default$default, predictor = post_qda[, 2], auc = TRUE,
	ci = TRUE, plot = TRUE, col = "cyan", add = TRUE)
```

```
## 
## Call:
## roc.default(response = Default$default, predictor = post_qda[,     2], auc = TRUE, ci = TRUE, plot = TRUE, col = "cyan", add = TRUE)
## 
## Data: post_qda[, 2] in 9667 controls (Default$default No) < 333 cases (Default$default Yes).
## Area under the curve: 0.9495
## 95% CI: 0.9401-0.9589 (DeLong)
```

```r
legend(x = "bottomright", legend = c("LDA", "QDA"),
	   col = c("magenta", "cyan"), lty = rep(1, 2), lwd = rep(2, 2))
```

![plot of chunk 02h-qdacc](figure/02h-qdacc-1.png)

In this example QDA doesn't appear to improve over LDA since both techniques
return exactly the same results.


## Example: Stock Market Data

We consider now `Smarket` (see the section *Introduction and datasets used* for further information), a second dataset consisting of percentage returns for the S&P 500 stock index over 1,250 days, from the beginning of 2001 until the end of 2005. For each date, the percentage returns for each of the five previous trading days (Lag1 through Lag5), the number of shares traded on the previous day (Volume, in billions), the percentage return on the date in question (Today) and whether the market was up or down on this date (Direction) have been recorded:


```r
require(GGally)
```


```r
summary(Smarket)
```

```
##       Year           Lag1                Lag2                Lag3                Lag4          
##  Min.   :2001   Min.   :-4.922000   Min.   :-4.922000   Min.   :-4.922000   Min.   :-4.922000  
##  1st Qu.:2002   1st Qu.:-0.639500   1st Qu.:-0.639500   1st Qu.:-0.640000   1st Qu.:-0.640000  
##  Median :2003   Median : 0.039000   Median : 0.039000   Median : 0.038500   Median : 0.038500  
##  Mean   :2003   Mean   : 0.003834   Mean   : 0.003919   Mean   : 0.001716   Mean   : 0.001636  
##  3rd Qu.:2004   3rd Qu.: 0.596750   3rd Qu.: 0.596750   3rd Qu.: 0.596750   3rd Qu.: 0.596750  
##  Max.   :2005   Max.   : 5.733000   Max.   : 5.733000   Max.   : 5.733000   Max.   : 5.733000  
##       Lag5              Volume           Today           Direction 
##  Min.   :-4.92200   Min.   :0.3561   Min.   :-4.922000   Down:602  
##  1st Qu.:-0.64000   1st Qu.:1.2574   1st Qu.:-0.639500   Up  :648  
##  Median : 0.03850   Median :1.4229   Median : 0.038500             
##  Mean   : 0.00561   Mean   :1.4783   Mean   : 0.003138             
##  3rd Qu.: 0.59700   3rd Qu.:1.6417   3rd Qu.: 0.596750             
##  Max.   : 5.73300   Max.   :3.1525   Max.   : 5.733000
```

```r
ggpairs(Smarket)
```

![plot of chunk 02h-loadsm](figure/02h-loadsm-1.png)

The correlations between the lag variables and today's returns are close to
zero. The only non negligible correlation is between Year and Volume, because
the average number of shares traded daily increased from 2001 to 2005:


```r
ggp <- ggplot(Smarket, aes(x = 1:length(Volume), y = Volume)) + geom_line() +
	xlab("Day")
plot(ggp)
```

![plot of chunk 02h-lineplotsm](figure/02h-lineplotsm-1.png)

We aim to predict the `Direction` values using `Lag1` through `Lag5` and `Volume`.
To this end, we'll compare the results from logistic regression, LDA and QDA.
We start with logistic regression:


```r
glm_fit <- glm(Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume,
               data = Smarket, family = binomial(link = logit))
summary(glm_fit)
```

```
## 
## Call:
## glm(formula = Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + 
##     Volume, family = binomial(link = logit), data = Smarket)
## 
## Deviance Residuals: 
##    Min      1Q  Median      3Q     Max  
## -1.446  -1.203   1.065   1.145   1.326  
## 
## Coefficients:
##              Estimate Std. Error z value Pr(>|z|)
## (Intercept) -0.126000   0.240736  -0.523    0.601
## Lag1        -0.073074   0.050167  -1.457    0.145
## Lag2        -0.042301   0.050086  -0.845    0.398
## Lag3         0.011085   0.049939   0.222    0.824
## Lag4         0.009359   0.049974   0.187    0.851
## Lag5         0.010313   0.049511   0.208    0.835
## Volume       0.135441   0.158360   0.855    0.392
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 1731.2  on 1249  degrees of freedom
## Residual deviance: 1727.6  on 1243  degrees of freedom
## AIC: 1741.6
## 
## Number of Fisher Scoring iterations: 3
```

```r
glm_probs <- predict(glm_fit, type = "response")
glm_pred <- rep("Down", nrow(Smarket))
glm_pred[glm_probs > .5] <- "Up"
confusionMatrix(data = glm_pred, reference = Smarket$Direction,
				positive = "Up")
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction Down  Up
##       Down  145 141
##       Up    457 507
##                                           
##                Accuracy : 0.5216          
##                  95% CI : (0.4935, 0.5496)
##     No Information Rate : 0.5184          
##     P-Value [Acc > NIR] : 0.4216          
##                                           
##                   Kappa : 0.0237          
##  Mcnemar's Test P-Value : <2e-16          
##                                           
##             Sensitivity : 0.7824          
##             Specificity : 0.2409          
##          Pos Pred Value : 0.5259          
##          Neg Pred Value : 0.5070          
##              Prevalence : 0.5184          
##          Detection Rate : 0.4056          
##    Detection Prevalence : 0.7712          
##       Balanced Accuracy : 0.5116          
##                                           
##        'Positive' Class : Up              
## 
```

Therefore we conclude that the error rate on the training data is 52.2%,
slightly better than random guessing. However, as we already remarked, the
training error rate is often overly optimistic, because it tends to
underestimate the test error rate. In order to better assess the accuracy of
the logistic regression model in this setting, we should fit the model using
part of the data, and then examine how well it predicts the held out data.
We therefore decide to use the observations from 2001 through 2004 for
training and those from 2005 for testing:


```r
train <- (Smarket$Year < 2005)
Smarket_2005 <- Smarket[!train, ]
glm_fit <- glm(Direction ~Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume,
			   data = Smarket, family = binomial(link = logit), subset = train)
glm_probs <- predict(glm_fit, Smarket_2005, type = "response")
glm_pred <- rep("Down", nrow(Smarket_2005))
glm_pred[glm_probs > .5] <- "Up"
confusionMatrix(data = glm_pred, reference = Smarket_2005$Direction,
				positive = "Up")
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction Down Up
##       Down   77 97
##       Up     34 44
##                                          
##                Accuracy : 0.4802         
##                  95% CI : (0.417, 0.5437)
##     No Information Rate : 0.5595         
##     P-Value [Acc > NIR] : 0.9952         
##                                          
##                   Kappa : 0.0054         
##  Mcnemar's Test P-Value : 6.062e-08      
##                                          
##             Sensitivity : 0.3121         
##             Specificity : 0.6937         
##          Pos Pred Value : 0.5641         
##          Neg Pred Value : 0.4425         
##              Prevalence : 0.5595         
##          Detection Rate : 0.1746         
##    Detection Prevalence : 0.3095         
##       Balanced Accuracy : 0.5029         
##                                          
##        'Positive' Class : Up             
## 
```

The test error rate is 52%, which is worse than random guessing! This result
is not that surprising, since it is a well known fact that one would not
generally expect to be able to use previous days' returns to predict future
market performance. As an attempt to improve the model, we remove the
predictors with the highest p-values refitting the logistic regression
using just `Lag1` and `Lag2`:


```r
glm_fit <- glm(Direction ~ Lag1 + Lag2, data = Smarket,
			   family = binomial(link = logit), subset = train)
glm_probs <- predict(glm_fit, Smarket_2005, type = "response")
glm_pred <- rep("Down", nrow(Smarket_2005))
glm_pred[glm_probs > .5] <- "Up"
confusionMatrix(data = glm_pred, reference = Smarket_2005$Direction,
				positive = "Up")
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction Down  Up
##       Down   35  35
##       Up     76 106
##                                           
##                Accuracy : 0.5595          
##                  95% CI : (0.4959, 0.6218)
##     No Information Rate : 0.5595          
##     P-Value [Acc > NIR] : 0.5262856       
##                                           
##                   Kappa : 0.0698          
##  Mcnemar's Test P-Value : 0.0001467       
##                                           
##             Sensitivity : 0.7518          
##             Specificity : 0.3153          
##          Pos Pred Value : 0.5824          
##          Neg Pred Value : 0.5000          
##              Prevalence : 0.5595          
##          Detection Rate : 0.4206          
##    Detection Prevalence : 0.7222          
##       Balanced Accuracy : 0.5335          
##                                           
##        'Positive' Class : Up              
## 
```

Now 56% of the daily movements have been correctly predicted.

We now perform LDA using only the observations before 2005:


```r
lda_fit <- lda(Direction ~ Lag1 + Lag2, data = Smarket, subset = train)
lda_probs <- predict(lda_fit, Smarket_2005)$posterior[, 2]
lda_class <- predict(lda_fit, Smarket_2005)$class
confusionMatrix(data = lda_class, reference = Smarket_2005$Direction,
				positive = "Up")
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction Down  Up
##       Down   35  35
##       Up     76 106
##                                           
##                Accuracy : 0.5595          
##                  95% CI : (0.4959, 0.6218)
##     No Information Rate : 0.5595          
##     P-Value [Acc > NIR] : 0.5262856       
##                                           
##                   Kappa : 0.0698          
##  Mcnemar's Test P-Value : 0.0001467       
##                                           
##             Sensitivity : 0.7518          
##             Specificity : 0.3153          
##          Pos Pred Value : 0.5824          
##          Neg Pred Value : 0.5000          
##              Prevalence : 0.5595          
##          Detection Rate : 0.4206          
##    Detection Prevalence : 0.7222          
##       Balanced Accuracy : 0.5335          
##                                           
##        'Positive' Class : Up              
## 
```

LDA provides practically the same result as logistic regression. We now move
to QDA:


```r
qda_fit <- qda(Direction ~ Lag1 + Lag2, data = Smarket, subset = train)
qda_probs <- predict(qda_fit, Smarket_2005)$posterior[, 2]
qda_class <- predict(qda_fit, Smarket_2005)$class
confusionMatrix(data = qda_class, reference = Smarket_2005$Direction,
				positive = "Up")
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction Down  Up
##       Down   30  20
##       Up     81 121
##                                           
##                Accuracy : 0.5992          
##                  95% CI : (0.5358, 0.6602)
##     No Information Rate : 0.5595          
##     P-Value [Acc > NIR] : 0.1138          
##                                           
##                   Kappa : 0.1364          
##  Mcnemar's Test P-Value : 2.369e-09       
##                                           
##             Sensitivity : 0.8582          
##             Specificity : 0.2703          
##          Pos Pred Value : 0.5990          
##          Neg Pred Value : 0.6000          
##              Prevalence : 0.5595          
##          Detection Rate : 0.4802          
##    Detection Prevalence : 0.8016          
##       Balanced Accuracy : 0.5642          
##                                           
##        'Positive' Class : Up              
## 
```

This implies that QDA predictions are accurate almost 60% of the time. This
suggests that QDA may capture the true relationship slightly more accurately
than LDA and logistic regression. This is confirmed by comparing the 
corresponding ROC curves:


```r
roc(response = Smarket_2005$Direction, predictor = glm_probs, auc = TRUE, ci = TRUE, plot = TRUE, col = "magenta", main = "ROC comparison",
	legacy.axes = TRUE)
```

```
## 
## Call:
## roc.default(response = Smarket_2005$Direction, predictor = glm_probs,     auc = TRUE, ci = TRUE, plot = TRUE, col = "magenta", main = "ROC comparison",     legacy.axes = TRUE)
## 
## Data: glm_probs in 111 controls (Smarket_2005$Direction Down) < 141 cases (Smarket_2005$Direction Up).
## Area under the curve: 0.5584
## 95% CI: 0.4862-0.6307 (DeLong)
```

```r
roc(response = Smarket_2005$Direction, predictor = lda_probs, auc = TRUE,
	ci = TRUE, plot = TRUE, col = "cyan", add = TRUE, legacy.axes = TRUE)
```

```
## 
## Call:
## roc.default(response = Smarket_2005$Direction, predictor = lda_probs,     auc = TRUE, ci = TRUE, plot = TRUE, col = "cyan", add = TRUE,     legacy.axes = TRUE)
## 
## Data: lda_probs in 111 controls (Smarket_2005$Direction Down) < 141 cases (Smarket_2005$Direction Up).
## Area under the curve: 0.5584
## 95% CI: 0.4862-0.6307 (DeLong)
```

```r
roc(response = Smarket_2005$Direction, predictor = qda_probs, auc = TRUE,
	ci = TRUE, plot = TRUE, col = "darkgray", add = TRUE, legacy.axes = TRUE)
```

```
## 
## Call:
## roc.default(response = Smarket_2005$Direction, predictor = qda_probs,     auc = TRUE, ci = TRUE, plot = TRUE, col = "darkgray", add = TRUE,     legacy.axes = TRUE)
## 
## Data: qda_probs in 111 controls (Smarket_2005$Direction Down) < 141 cases (Smarket_2005$Direction Up).
## Area under the curve: 0.562
## 95% CI: 0.4897-0.6343 (DeLong)
```

```r
legend(x = "bottomright", legend = c("Logistic regression", "LDA", "QDA"),
	   col = c("magenta", "cyan", "darkgray"), lty = rep(1, 3),
	   lwd = rep(2, 3))
```

![plot of chunk 02h-rocqdasm](figure/02h-rocqdasm-1.png)


# Some Theoretical Backgrounds

Two are the main approaches to Discriminant Analysis:

1. The first was from Fisher, who developed the Linear Discriminant Functions without formulating any distributional assumptions on data (excluding constant variance/covariance matrix within groups)
2. The second one, instead, assumes that the distribution of data is a multivariate normal, and basically applies LR methods to perform discriminations


## Linear Discriminant Functions

Let us suppose, for sake of simplicity, that two groups of observations are to be discriminated based on their measurements on two dimensions. 
We have then $g=2$ groups of observations; for each group we have $n$ observations on $p=2$ (continuous) dimensions.  
A possible representation of data points in a bidimensional Cartesian space could be the following:


```r
require(ggplot2)
```

![plot of chunk 02h-thplot1](figure/02h-thplot1-1.png)

We must find the linear transformation of data points such that the two groups on this new dimension are "maximally separated".  
This is solved by finding the solution of:
$$
\begin{matrix}
\max\\ 
\underline{a}
\end{matrix}\left\{\frac{\left [ \underline{a}^T \left(\underline{\overline{x}}_1-\underline{\overline{x}}_2 \right) \right ]}{\underline{a}^T S \underline{a}}\right\}
$$
Where $S$ is the pooled variance/covariance matrix of two subgroups

The solution of above problem is:

$$
\underline{a} = S^{-1}  \left(\underline{\overline{x}}_1-\underline{\overline{x}}_2 \right) 
$$
and
$$
z=\underline{a}^T \underline{x} =  \left(\underline{\overline{x}}_1-\underline{\overline{x}}_2 \right)^T S^{-1} \underline{x}
$$

Where $\underline{x}$ is a generic vector of observed data. $\underline{a}^T \underline{x}$ is the so-called _Fisher Linear Discriminant Function_.

![plot of chunk 02h-plotzetas](figure/02h-plotzetas-1.png)

The thershold between groups is given by the mean of mean scores of the two groups, then the criterion to assign an observation to first group is:
$$
\left(\underline{\overline{x}}_1-\underline{\overline{x}}_2 \right)^T S^{-1} \underline{x} - \left(\underline{\overline{x}}_1-\underline{\overline{x}}_2 \right)^T S^{-1} \left(\frac{\underline{\overline{x}}_1+\underline{\overline{x}}_2}{2} \right) >0
$$


The above method may be applied also when $g >2$. In this case, the problem becomes more complex, and requires the maximization, with respect to the $\underline{a}$, of the function:
$$
R = \frac{\underline{a}^T B \underline{a}}{\underline{a}^T W \underline{a}}
$$
Under some constraints on $\underline{a}$ and $\underline{a}^T \underline{x}$ values.  
In above formula, $B$ is an estimate of the "between" groups variance/covariance matrix, and $W$ is an estimated of "within" groups variance/covariance matrix.  
In this case, $max\{p,g-1\}$ orthogonal Linear Discriminant Functions shall be obtained.


## Probability Models

An alternative approach to discrimination is via probability models.  
Let $\pi_i (i=1, \cdots, g)$ denote the prior probabilities of the groups, and $p(\underline{x}|i)$ the densities of distributions of the observations for each group. Then the posterior distribution of belonging to $i$-th group after observing $\underline{x}$ is
$$
p(i|\underline{x}) = \frac{\pi_i p(\underline{x} | i)}{p(\underline{x})} \propto \pi_i p(\underline{x} | i)
$$
and it is fairly simple to show that the allocation rule which makes the smallest
expected number of errors chooses the class with maximal $p(i | \underline{x})$; this is known
as the _Bayes rule_.

Now suppose the distribution for group $i$ is multivariate normal with mean $\mu_i$
and covariance $\Sigma_i$ . Then the Bayes rule minimizes
$$
Q_i = −2 \log(p(\underline{x} | i)) − 2 \log(\pi_i)
= (\underline{x} − \mu_i )^T\Sigma_i^{−1} (\underline{x} − \mu_i ) + \log(|\Sigma_i |) − 2 \log( \pi_i)
$$

The first addendum of last term of above formula is the squared Mahalanobis distance to the group centre. The rule to assign observation to group $i$ that minimizes the above formula gives the _Quadratic Discriminant Function_.

If we suppose that the groups have a common covariance matrix $\Sigma$. Differences in the $Q_i$ are then linear functions of $\underline{x}$, and we can maximize $−Q_i /2$ or
$$ 
L_i = \underline{x} \Sigma^{−1} \mu^T_i − \mu_i Σ^{−1} \mu^T_i /2 + \log(\pi_i)
$$
If we substitute $\mu_i$ and $\Sigma$ with sample estimates (sample mean $\overline{\underline{x}}$ and sample within groups variance/covariance matrix $S$), then
the above formula gives results that, for $\pi_i=1/g$, are equivalent to the the ones of Linear Discriminant Functions.

<!---
Exercises with iris or utilities or uscrimes 
--->
