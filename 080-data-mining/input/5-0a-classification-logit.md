---
title: "Recalls on Logistic Regression"
---




Logistic regression is part of GLM models. Its goal is to find a causal relation
between the predictors (the columns of $X$ matrix) and the response $Y$ variable,
where $Y$ can assume only $0/1$ (where $0$ = "absence"; $1$ = "presence") values.

The model used to find this relation states that the dependent variable is Binomially
distibuted with parameters $n$ and $p$, 

$$Y_i \sim Bi(n_i, p_i)$$

and that $p$ is tied to the predictors via a tranformation of a linear function:

$$p_i = \frac{exp\left(a + b x_{i1} + c x_{i2} + \dots \right)}{1 + exp\left(a + b x_{i1} + c x_{i1} + \dots \right)}$$

where $x_{ij}$ values represent the $i$-th value (row) of $j$-th column of $X$ matrix 
(i.e., the $p$ predictors for the $i$-th observation). 

Logistic regression finds the $a, b, c, \dots$ parameters that maximize the probability
of having the observed data. These parameter values will be the estimates of parameters
themselves.

## Example: Credit Card Default

The first example we present is on the `Default` dataset (see the section 
*Introduction and datasets used* for further information), some data about ten thousand
customers with the aim to predict which customers will default on their credit card debt:


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
To perform Logistic Regression on Credit Card data, we use the `glm()` function. This function
requires to set a formula that specifies the categorical response and the
predictors to use, the data frame containing the data, the distribution family, and a series
of other optional arguments:


```r
res_logit <- glm(default ~ student + balance, data = Default,
				 family = binomial(link = logit))
summary(res_logit)
```

```
## 
## Call:
## glm(formula = default ~ student + balance, family = binomial(link = logit), 
##     data = Default)
## 
## Deviance Residuals: 
##     Min       1Q   Median       3Q      Max  
## -2.4578  -0.1422  -0.0559  -0.0203   3.7435  
## 
## Coefficients:
##               Estimate Std. Error z value Pr(>|z|)    
## (Intercept) -1.075e+01  3.692e-01 -29.116  < 2e-16 ***
## studentYes  -7.149e-01  1.475e-01  -4.846 1.26e-06 ***
## balance      5.738e-03  2.318e-04  24.750  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 2920.6  on 9999  degrees of freedom
## Residual deviance: 1571.7  on 9997  degrees of freedom
## AIC: 1577.7
## 
## Number of Fisher Scoring iterations: 8
```

To obtain the probabiity of being a defaulter for a individual customer, the `predict()` function
must be used:

```r
post_logit <- predict(res_logit, type = "response")
head(post_logit)
```

```
##            1            2            3            4            5            6 
## 0.0014090960 0.0011403179 0.0100571943 0.0004469571 0.0019434977 0.0020503778
```

Starting from the probability of default, we can choose the threshold for which to states
that a customer is a probable defaulter.  
For example, if we the set threshold to $0.5$, then the individual customer will be classified
as defaulter if his/her estimated probability of defalut is greater than $0.5$:


```r
default_logit <- ifelse(post_logit>0.5, "Pred: Yes", "Pred: No")
```

To assess the goodness of the classification, a standard tool is to obtain
the so called "confusion matrix", which cross-tabulates the actual and the
predicted classes for each observation:


```r
table(default_logit, Default$default)
```

```
##              
## default_logit   No  Yes
##     Pred: No  9628  228
##     Pred: Yes   39  105
```
