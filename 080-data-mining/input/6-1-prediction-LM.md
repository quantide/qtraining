---
title: "Linear Model Variations (LM)"
---






# Introduction

We now proceed to compare the results from using different alternative
fitting techniques for a linear model. We do this using some simulated data
with many independent variables, the first of which is highly correlated with
some of the others:


```r
# Generate simulate data
set.seed(10)
n <- 1000
p <- 100
X <- data.frame(matrix(runif(n*p), nrow = n, ncol = p))
# Give names to data columns
names(X) <- paste("x", 1:ncol(X), sep = "")
# The first column is really correlated with the columns from 2 to 5.
X$x1 <- X$x2 + 2*X$x3 + 3*X$x4 - 4*X$x5 + rnorm(n, sd = .0001)
# The model for dependent variable
X$y <- 4 + 0.2*X$x1 + .5*X$x2 - .9*X$x3 + X$x4 - 0.5*X$x5 + 0.2*X$x6 + rnorm(n, mean = 0, sd = 1)

dt <- X
rm(X)
```
Since in above data frame only the columns from 1 to 6 and 101 are really correlated, 
a scatterplot matrix of these columns (along with a few of other columns) can be useful to 
show the relations between variables:

```r
require(ggplot2)
require(GGally)

ggpairs(data = dt, columns = c(1:10,101), mapping = aes(alpha = 0.3))
```

![plot of chunk a2](figure/a2-1.png)

And some test on collinearity:

```r
# Collinearity test
X <- as.matrix(dt[,1:10])
require(Matrix)
rankMatrix(X)
```

```
## [1] 10
## attr(,"method")
## [1] "tolNorm2"
## attr(,"useGrad")
## [1] FALSE
## attr(,"tol")
## [1] 2.220446e-13
```

```r
try(solve(t(X)%*%X))
```

```
##                x1            x2            x3            x4            x5           x6           x7
## x1   9.968180e+04 -9.968229e+04 -1.993639e+05 -2.990448e+05  3.987275e+05  0.935470215 -0.118911528
## x2  -9.968229e+04  9.968279e+04  1.993649e+05  2.990463e+05 -3.987294e+05 -0.936978671  0.118078721
## x3  -1.993639e+05  1.993649e+05  3.987284e+05  5.980905e+05 -7.974560e+05 -1.872229008  0.236896550
## x4  -2.990448e+05  2.990463e+05  5.980905e+05  8.971328e+05 -1.196180e+06 -2.807539247  0.355446317
## x5   3.987275e+05 -3.987294e+05 -7.974560e+05 -1.196180e+06  1.594911e+06  3.740329831 -0.477376627
## x6   9.354702e-01 -9.369787e-01 -1.872229e+00 -2.807539e+00  3.740330e+00  0.011075231 -0.001325552
## x7  -1.189115e-01  1.180787e-01  2.368966e-01  3.554463e-01 -4.773766e-01 -0.001325552  0.010275857
## x8  -4.510523e-01  4.503798e-01  9.002870e-01  1.351933e+00 -1.805298e+00 -0.001895663 -0.001575933
## x9  -9.756490e-01  9.746218e-01  1.950252e+00  2.925766e+00 -3.903910e+00 -0.001065308 -0.000953953
## x10  1.202462e+00 -1.203997e+00 -2.406063e+00 -3.608626e+00  4.809310e+00 -0.001121372 -0.001463833
##               x8           x9          x10
## x1  -0.451052346 -0.975648985  1.202462488
## x2   0.450379809  0.974621756 -1.203996720
## x3   0.900286952  1.950252112 -2.406062508
## x4   1.351932662  2.925765710 -3.608625756
## x5  -1.805298142 -3.903909576  4.809309718
## x6  -0.001895663 -0.001065308 -0.001121372
## x7  -0.001575933 -0.000953953 -0.001463833
## x8   0.010999641 -0.000911617 -0.001275055
## x9  -0.000911617  0.010208522 -0.002058651
## x10 -0.001275055 -0.002058651  0.010928909
```
Notice that the $(\underline{X}^T \underline{X})^{-1}$ matrix has very high diagonal values.
This is because of collinearity between predictors. This also will probably produce very
high standard errors and very unstable  parameter estimates (since the variance/covariance
matrix of parameter estimates is equal to $\sigma^2 (\underline{X}^T \underline{X})^{-1}$).

To assess the relative predictive performances of the methods that will study, we split the
dataset into training (75%) and test sets (25%):


```r
# Splits the data into training and test data frames
sel_train <- sample(1:nrow(dt), replace = FALSE, size = n*.75)
dt_train <- dt[sel_train, ]
dt_test <- dt[setdiff(1:n, sel_train), ]
```


## (1) Ordinary Least Squares (OLS)

This usually does not perform well for models with many independent
variables and for models with highly correlated independent variables:


```r
ols_fit <- lm(y ~ ., data = dt_train)
summary(ols_fit)
```

```
## 
## Call:
## lm(formula = y ~ ., data = dt_train)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -2.8576 -0.6298 -0.0244  0.6235  3.2517 
## 
## Coefficients:
##               Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  4.555e+00  7.072e-01   6.440 2.32e-10 ***
## x1          -8.165e+01  3.969e+02  -0.206 0.837092    
## x2           8.258e+01  3.969e+02   0.208 0.835275    
## x3           1.628e+02  7.939e+02   0.205 0.837583    
## x4           2.464e+02  1.191e+03   0.207 0.836153    
## x5          -3.282e+02  1.588e+03  -0.207 0.836301    
## x6           3.967e-01  1.380e-01   2.875 0.004172 ** 
## x7           1.044e-02  1.341e-01   0.078 0.937969    
## x8          -3.143e-01  1.373e-01  -2.290 0.022353 *  
## x9           4.646e-02  1.383e-01   0.336 0.736938    
## x10         -9.437e-02  1.369e-01  -0.689 0.490882    
## x11         -8.235e-02  1.337e-01  -0.616 0.538054    
## x12         -1.933e-01  1.337e-01  -1.446 0.148711    
## x13          2.338e-01  1.368e-01   1.709 0.087859 .  
## x14         -6.622e-02  1.380e-01  -0.480 0.631555    
## x15          1.972e-01  1.363e-01   1.447 0.148394    
## x16          2.419e-01  1.315e-01   1.840 0.066265 .  
## x17          1.829e-01  1.382e-01   1.323 0.186283    
## x18          1.601e-01  1.360e-01   1.177 0.239623    
## x19         -6.067e-02  1.379e-01  -0.440 0.660048    
## x20          2.443e-02  1.383e-01   0.177 0.859897    
## x21          1.705e-03  1.383e-01   0.012 0.990166    
## x22          1.657e-01  1.344e-01   1.233 0.217951    
## x23         -1.286e-02  1.360e-01  -0.095 0.924688    
## x24         -1.132e-01  1.333e-01  -0.849 0.395967    
## x25          1.537e-01  1.406e-01   1.093 0.274823    
## x26         -2.078e-01  1.327e-01  -1.566 0.117871    
## x27         -6.218e-02  1.419e-01  -0.438 0.661391    
## x28          4.130e-02  1.384e-01   0.298 0.765480    
## x29         -3.009e-01  1.359e-01  -2.214 0.027199 *  
## x30         -2.880e-01  1.387e-01  -2.076 0.038243 *  
## x31          2.455e-02  1.353e-01   0.181 0.856072    
## x32          4.194e-01  1.388e-01   3.021 0.002621 ** 
## x33          1.197e-01  1.357e-01   0.882 0.377900    
## x34          4.035e-02  1.357e-01   0.297 0.766290    
## x35         -1.070e-01  1.321e-01  -0.810 0.418318    
## x36         -1.379e-01  1.316e-01  -1.048 0.295256    
## x37         -7.096e-02  1.316e-01  -0.539 0.589815    
## x38         -1.487e-01  1.346e-01  -1.104 0.269903    
## x39          7.267e-02  1.388e-01   0.524 0.600732    
## x40          1.513e-01  1.368e-01   1.106 0.269295    
## x41          3.144e-02  1.344e-01   0.234 0.815141    
## x42          7.003e-02  1.370e-01   0.511 0.609323    
## x43         -1.030e-01  1.350e-01  -0.763 0.445825    
## x44         -1.362e-01  1.356e-01  -1.004 0.315523    
## x45         -2.136e-01  1.346e-01  -1.587 0.113111    
## x46          4.534e-02  1.330e-01   0.341 0.733293    
## x47          1.091e-01  1.395e-01   0.782 0.434423    
## x48          7.069e-02  1.367e-01   0.517 0.605250    
## x49         -7.660e-02  1.373e-01  -0.558 0.577187    
## x50         -1.247e-01  1.373e-01  -0.908 0.364349    
## x51         -2.063e-01  1.326e-01  -1.556 0.120272    
## x52         -6.246e-02  1.405e-01  -0.445 0.656799    
## x53          1.847e-01  1.320e-01   1.400 0.162046    
## x54         -3.097e-03  1.344e-01  -0.023 0.981622    
## x55          1.373e-01  1.389e-01   0.989 0.323152    
## x56         -1.668e-01  1.378e-01  -1.210 0.226599    
## x57         -6.331e-02  1.380e-01  -0.459 0.646592    
## x58         -6.838e-02  1.360e-01  -0.503 0.615344    
## x59         -4.742e-01  1.377e-01  -3.444 0.000609 ***
## x60         -1.592e-01  1.423e-01  -1.119 0.263572    
## x61         -1.578e-01  1.375e-01  -1.148 0.251454    
## x62          1.481e-01  1.379e-01   1.074 0.283205    
## x63          1.138e-02  1.422e-01   0.080 0.936258    
## x64          3.890e-02  1.329e-01   0.293 0.769872    
## x65          3.264e-02  1.388e-01   0.235 0.814135    
## x66          7.086e-02  1.361e-01   0.521 0.602820    
## x67         -5.794e-02  1.355e-01  -0.428 0.669038    
## x68         -2.564e-01  1.330e-01  -1.927 0.054428 .  
## x69          2.198e-01  1.388e-01   1.583 0.113797    
## x70         -8.131e-02  1.402e-01  -0.580 0.562236    
## x71         -1.286e-01  1.382e-01  -0.930 0.352754    
## x72          2.702e-02  1.407e-01   0.192 0.847843    
## x73         -1.903e-01  1.340e-01  -1.420 0.156039    
## x74          8.408e-03  1.404e-01   0.060 0.952263    
## x75          1.881e-01  1.377e-01   1.366 0.172449    
## x76         -1.438e-01  1.392e-01  -1.033 0.301918    
## x77         -1.929e-02  1.377e-01  -0.140 0.888697    
## x78          1.596e-01  1.346e-01   1.186 0.236130    
## x79         -9.461e-02  1.350e-01  -0.701 0.483712    
## x80         -7.884e-02  1.346e-01  -0.586 0.558251    
## x81         -1.904e-01  1.334e-01  -1.427 0.154122    
## x82          2.509e-01  1.363e-01   1.841 0.066075 .  
## x83          2.124e-01  1.351e-01   1.572 0.116496    
## x84         -1.553e-01  1.343e-01  -1.156 0.247922    
## x85         -7.719e-02  1.393e-01  -0.554 0.579632    
## x86          2.184e-01  1.319e-01   1.656 0.098180 .  
## x87          2.194e-01  1.358e-01   1.615 0.106766    
## x88         -1.067e-01  1.308e-01  -0.816 0.414829    
## x89         -3.362e-02  1.327e-01  -0.253 0.800109    
## x90         -1.452e-01  1.451e-01  -1.000 0.317622    
## x91         -1.070e-02  1.389e-01  -0.077 0.938626    
## x92         -9.042e-03  1.362e-01  -0.066 0.947090    
## x93          1.102e-01  1.370e-01   0.804 0.421482    
## x94          2.375e-01  1.396e-01   1.702 0.089259 .  
## x95         -8.374e-02  1.324e-01  -0.632 0.527374    
## x96          1.280e-02  1.379e-01   0.093 0.926076    
## x97         -5.123e-02  1.345e-01  -0.381 0.703411    
## x98          7.947e-02  1.403e-01   0.567 0.571249    
## x99         -1.248e-01  1.377e-01  -0.906 0.365199    
## x100        -1.429e-02  1.323e-01  -0.108 0.914014    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1.002 on 649 degrees of freedom
## Multiple R-squared:  0.4237,	Adjusted R-squared:  0.3349 
## F-statistic: 4.771 on 100 and 649 DF,  p-value: < 2.2e-16
```
The model finds many non significant parameters; also, as expected, the 
standard errors of parameters are big. Anyway,  $\hat{\sigma}^2 = 1.002$ 
means that the training residuals performs almost well.  
Notice also that the parameter estimates are very far from the true values.

However, to test the predictive performances of model, it must be applied on 
test data, with following results:

```r
res <- dt_test$y - predict(ols_fit, newdata = dt_test)
mse <- setNames(c(summary(res), mean(res^2)), nm = c("Min.","1st Qu.","Median","Mean","3rd Qu.","Max.","MeanSqErr"))
print(mse)
```

```
##        Min.     1st Qu.      Median        Mean     3rd Qu.        Max.   MeanSqErr 
## -2.79136260 -0.62735863  0.10340216  0.04257328  0.77810627  2.81145458  1.11697317
```

```r
ggp <- ggplot(data = data.frame(fit=predict(ols_fit, newdata = dt_test), obs=dt_test$y), mapping = aes(x = obs, y = fit)) +
  geom_point() +
  ggtitle("OLS: Observed Vs. Predicted") +
  xlab("Observed Y's") + ylab("Fitted Y's") + 
  geom_abline(slope = 1,intercept = 0, colour="red")
print(ggp)
```

![plot of chunk c2](figure/c2-1.png)

The resuduals on test data show a greater variability with respect to residuals on train data.

Maybe, by searching a more parsimonious model we could obtain better predictions.

## (2) Forward Stepwise Selection

Forward stepwise selection begins with a model containing no predictors, and
then adds one predictor at a time to the model until all of the "significant" predictors
are in the model. The "Forward stepwise" selection procedure try to minimize an optimality
criterion function (often AIC), and acts as follows:

1. Start from an "initial model" (often the "only mean, no predictors" model) and
  calculates the criterion function
2. Add the predictor that best reduces the criterion function
3. Add another predictor (if exists) that best reduces the criterion function
4. Check if the previously inserted predictors can be removed from model (i.e., check
  if removing some previously inserted variables the criterion function reduces); 
  remove them one by one
5. Are there other predictors that if added to model reduce the criterion function?
  If Yes, then go to step 3.
6. Exit

While computationally advantageous, for example,  with respect to best subset selection, the
Forward Stepwise method does not guarantee to find the best possible model out of all models
containing subsets of the $p$ predictors. For instance, suppose that in a given
dataset with $p = 3$ predictors, the best possible one-variable model contains
$X1$, and the best possible mode is a two-variable one that contains $X2$ and $X3$. Then
forward stepwise selection could fail to select the best possible two-variable
model, because at the second step the model couldn't be able to remove $X1$.


```r
require(MASS)
```


```r
m_init <- lm(y ~ 1, data = dt_train)
upr <- paste("x",1:100, sep="", collapse=" + ")
upr <- as.formula(paste("~",upr))
forw_fit <- stepAIC(m_init, scope = list(upper = upr, lower = ~ 1) , direction = "both", trace = FALSE)
summary(forw_fit)
```

```
## 
## Call:
## lm(formula = y ~ x1 + x3 + x59 + x2 + x6 + x32 + x82 + x29 + 
##     x30 + x4 + x68 + x8 + x45 + x83 + x13 + x94 + x51 + x38 + 
##     x26 + x16 + x40 + x86, data = dt_train)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -2.81775 -0.66472 -0.07128  0.64821  2.76597 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  4.25664    0.30106  14.139  < 2e-16 ***
## x1           0.38963    0.03165  12.309  < 2e-16 ***
## x3          -1.36485    0.13707  -9.957  < 2e-16 ***
## x59         -0.43295    0.12458  -3.475 0.000540 ***
## x2           0.45413    0.13314   3.411 0.000683 ***
## x6           0.41746    0.12770   3.269 0.001130 ** 
## x32          0.36476    0.12736   2.864 0.004304 ** 
## x82          0.27841    0.12636   2.203 0.027881 *  
## x29         -0.27268    0.12554  -2.172 0.030173 *  
## x30         -0.29358    0.12677  -2.316 0.020848 *  
## x4           0.27725    0.15530   1.785 0.074633 .  
## x68         -0.27851    0.12356  -2.254 0.024493 *  
## x8          -0.27003    0.12767  -2.115 0.034763 *  
## x45         -0.22180    0.12494  -1.775 0.076291 .  
## x83          0.20776    0.12362   1.681 0.093261 .  
## x13          0.21798    0.12708   1.715 0.086714 .  
## x94          0.25165    0.13007   1.935 0.053420 .  
## x51         -0.19979    0.12427  -1.608 0.108336    
## x38         -0.18395    0.12632  -1.456 0.145785    
## x26         -0.19114    0.12303  -1.554 0.120707    
## x16          0.20035    0.12395   1.616 0.106453    
## x40          0.20036    0.12665   1.582 0.114074    
## x86          0.17500    0.12319   1.421 0.155877    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.9808 on 727 degrees of freedom
## Multiple R-squared:  0.3815,	Adjusted R-squared:  0.3627 
## F-statistic: 20.38 on 22 and 727 DF,  p-value: < 2.2e-16
```
In this case, the parameter estimates are close enough to the true parameter values.  
Also, too many variables were selected by the procedure (with respect to true model). Maybe, it could depend
from the multicollinearity.

The predictive performaces are:

```r
# Plots Observed Vs. Predicted values
ggp <- ggplot(data = data.frame(fit=predict(forw_fit, newdata = dt_test), obs=dt_test$y), mapping = aes(x = obs, y = fit)) +
  geom_point() +
  ggtitle("Forward Stepwise: Observed Vs. Predicted") +
  xlab("Observed Y's") + ylab("Fitted Y's") + 
  geom_abline(slope = 1,intercept = 0, colour="red")
print(ggp)
```

![plot of chunk g1](figure/g1-1.png)

```r
y_pred_forw <- predict(forw_fit, newdata = dt_test)
res <- dt_test$y - y_pred_forw
mse1 <- setNames(c(summary(res), mean(res^2)), nm = c("Min.","1st Qu.","Median","Mean","3rd Qu.","Max.","MeanSqErr"))
mse <- rbind(mse, mse1)
rownames(mse)[1] <- "OLS"
rownames(mse)[nrow(mse)] <- "Forward"
mse
```

```
##              Min.    1st Qu.     Median       Mean   3rd Qu.     Max. MeanSqErr
## OLS     -2.791363 -0.6273586 0.10340216 0.04257328 0.7781063 2.811455  1.116973
## Forward -2.838173 -0.5920479 0.05753866 0.02205985 0.7915298 2.616119  1.066416
```

In this case the Forward stepwise selection gives almost good results.
The best model selected is a few "redundant" (at least with respect to best subset model),
but it shows good predictive performances.

## (3) Backward Stepwise Selection

Unlike forward stepwise selection, backward stepwise selection begins with
the full least squares model containing all predictors, and then iteratively
removes the least useful predictor, one-at-a-time. Also the "Backward stepwise"
selection procedure try to minimize an optimality criterion function (often
AIC), and acts as follows:

1. Start from an "initial model" (often the "all predictors" model) and
  calculate the criterion function
2. Remove the predictor that best reduces the criterion function
3. Remove another predictor (if exists) that best reduces the criterion function
4. Check if the previously removed predictors can be re-inserted into model (i.e.,
  check if adding some previously removed variables the criterion function reduces); 
  add them one by one
5. Are there other predictors that when removed from model reduce the criterion function?
  If Yes, then go to step 3.
6. Exit

Like forward stepwise selection, backward stepwise selection does not
guarantee to yield the best model containing a subset of the $p$ predictors.
In contrast to forward stepwise, Backward selection requires that the sample
size $n$ is larger than the number of variables $p$ (so that the full model
can be fit).
Anyway, the Backward stepwise procedure usually obtains better results with respect to
the Forward one.


```r
m_init <- lm(y ~ ., data = dt_train)
back_fit <- stepAIC(m_init, scope = list(upper = ~ ., lower = ~ 1) , direction = "both", trace = FALSE)
summary(back_fit)
```

```
## 
## Call:
## lm(formula = y ~ x1 + x2 + x4 + x5 + x6 + x8 + x13 + x15 + x16 + 
##     x22 + x26 + x29 + x30 + x32 + x40 + x45 + x51 + x59 + x68 + 
##     x69 + x75 + x81 + x82 + x83 + x86 + x87 + x94, data = dt_train)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -2.95193 -0.67439 -0.03723  0.63497  2.78239 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  3.72416    0.34234  10.878  < 2e-16 ***
## x1          -0.28925    0.06055  -4.777 2.16e-06 ***
## x2           1.15323    0.14540   7.931 8.26e-15 ***
## x4           2.29936    0.21682  10.605  < 2e-16 ***
## x5          -2.69594    0.27440  -9.825  < 2e-16 ***
## x6           0.39359    0.12794   3.076 0.002175 ** 
## x8          -0.26176    0.12741  -2.054 0.040289 *  
## x13          0.22864    0.12721   1.797 0.072704 .  
## x15          0.18794    0.12723   1.477 0.140071    
## x16          0.20962    0.12403   1.690 0.091439 .  
## x22          0.19068    0.12422   1.535 0.125212    
## x26         -0.17761    0.12301  -1.444 0.149219    
## x29         -0.28446    0.12550  -2.267 0.023707 *  
## x30         -0.27787    0.12661  -2.195 0.028511 *  
## x32          0.38858    0.12768   3.043 0.002425 ** 
## x40          0.19775    0.12652   1.563 0.118505    
## x45         -0.20860    0.12499  -1.669 0.095572 .  
## x51         -0.20463    0.12404  -1.650 0.099444 .  
## x59         -0.43285    0.12513  -3.459 0.000573 ***
## x68         -0.26278    0.12345  -2.129 0.033630 *  
## x69          0.19663    0.12657   1.554 0.120740    
## x75          0.19255    0.12738   1.512 0.131083    
## x81         -0.17202    0.12239  -1.406 0.160287    
## x82          0.27709    0.12636   2.193 0.028643 *  
## x83          0.21754    0.12327   1.765 0.078032 .  
## x86          0.19022    0.12308   1.546 0.122660    
## x87          0.18358    0.12540   1.464 0.143618    
## x94          0.23738    0.12970   1.830 0.067615 .  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.978 on 722 degrees of freedom
## Multiple R-squared:  0.3892,	Adjusted R-squared:  0.3664 
## F-statistic: 17.04 on 27 and 722 DF,  p-value: < 2.2e-16
```
Also in this case, the parameter estimates are almost close to the true parameter values.  
Perhaps too many variables were selected by the procedure. Maybe, it could depend
from the multicollinearity too.

The predictive performaces:

```r
# Plots Observed Vs. Predicted values
ggp <- ggplot(data = data.frame(fit=predict(back_fit, newdata = dt_test), obs=dt_test$y), mapping = aes(x = obs, y = fit)) +
  geom_point() +
  ggtitle("Backward Stepwise: Observed Vs. Predicted") +
  xlab("Observed Y's") + ylab("Fitted Y's") + 
  geom_abline(slope = 1,intercept = 0, colour="red")
print(ggp)
```

![plot of chunk h1](figure/h1-1.png)

```r
y_pred_back <- predict(back_fit, newdata = dt_test)
res <- dt_test$y - y_pred_back
mse1 <- setNames(c(summary(res), mean(res^2)), nm = c("Min.","1st Qu.","Median","Mean","3rd Qu.","Max.","MeanSqErr"))
mse <- rbind(mse, mse1)
rownames(mse)[nrow(mse)] <- "Backward"
mse
```

```
##               Min.    1st Qu.     Median       Mean   3rd Qu.     Max. MeanSqErr
## OLS      -2.791363 -0.6273586 0.10340216 0.04257328 0.7781063 2.811455  1.116973
## Forward  -2.838173 -0.5920479 0.05753866 0.02205985 0.7915298 2.616119  1.066416
## Backward -2.811408 -0.6350795 0.07338870 0.02780858 0.7624021 2.704280  1.082477
```

In this case, Backward Stepwise yields a few worse results than Forward one.


## (4) Best Subset Selection 

In best subset selection we fit a separate least squares regression for each
possible combination of the $p$ predictors. That is, we fit all models that
contain exactly one predictor, all models that contain exactly two
predictors, and so forth. We then identify the model that is "best"" with respect
to a given optimality criterion (typically, adjusted R-squared, BIC, AIC, or Mallows' Cp).

While best subset selection is a simple and conceptually appealing approach,
it suffers from computational limitations. The number of possible models
that must be considered grows rapidly as the number of potential predictors
increases. With $p$ = 10, there are approximately 1,000 possible models to
consider, therefore it becomes computationally intractable for a number of
variables not too big (around 40). Moreover, best subset selection does not
perform well in situations where $p > n$, that is when the number of predictors
is larger than the number of cases, as well as when some of the predictors
are strongly correlated.

Anyway, the package `leaps` contains the `regsubsets()` function that implements the best
subset approach:


```r
require(leaps)
```


```r
# Performs a best-subset exhaustive (see 'method' parameter) model search
nvmax <- 20
dt_t <- dt_train
dt_train <- dt_train[, c(1:35,101)]
bs_fit <- regsubsets(x = dt_train[, 1:(ncol(dt_train)-1)], y = dt_train[, ncol(dt_train)], method = "exhaustive", nvmax = nvmax, really.big = TRUE) 
l <- summary(bs_fit)

# Plots of the CP index
ggp <- ggplot(data = data.frame(size=1:nvmax, cp=l$cp), mapping = aes(x = size, y = cp)) +
  geom_point() +
  xlab("Model size") + ylab("Mallows' Cp")
print(ggp)
```

![plot of chunk d1](figure/d1-1.png)

Note: Mallows' $Cp =  \frac{RSS_p}{s^2}-(n - 2p)$, where $s^2$ is the residual standard
deviation calculated on most complete model, $p$ is the
number of parameters estimated in model, and $n$ is the sample size.  
We then select best model according to $Cp$:


```r
# Selects the predictors of best model
bestfeat <- l$which[which.min(l$cp), ]
# Adds the dependent variable
bestfeat <- c(bestfeat[-1], TRUE)
```

Finally, we train and test the best model selected


```r
m_bestsubset <- lm(y ~ ., data = dt_train[, bestfeat])
summary(m_bestsubset)
```

```
## 
## Call:
## lm(formula = y ~ ., data = dt_train[, bestfeat])
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -2.9708 -0.6681 -0.0719  0.6759  3.0417 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   3.6521     0.2667  13.695  < 2e-16 ***
## x1            0.8684     0.1295   6.709 3.93e-11 ***
## x3           -2.3348     0.2938  -7.947 7.18e-15 ***
## x4           -1.2063     0.4170  -2.893 0.003930 ** 
## x5            1.9514     0.5377   3.629 0.000304 ***
## x6            0.4127     0.1288   3.204 0.001412 ** 
## x8           -0.1886     0.1286  -1.467 0.142930    
## x13           0.2469     0.1286   1.919 0.055369 .  
## x15           0.1922     0.1284   1.497 0.134815    
## x16           0.2330     0.1251   1.862 0.062970 .  
## x17           0.2203     0.1295   1.701 0.089424 .  
## x18           0.1910     0.1271   1.502 0.133447    
## x22           0.1925     0.1260   1.527 0.127076    
## x26          -0.1977     0.1248  -1.584 0.113653    
## x29          -0.2619     0.1272  -2.059 0.039829 *  
## x30          -0.2368     0.1280  -1.850 0.064708 .  
## x32           0.3609     0.1292   2.794 0.005340 ** 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.9962 on 733 degrees of freedom
## Multiple R-squared:  0.3566,	Adjusted R-squared:  0.3425 
## F-statistic: 25.39 on 16 and 733 DF,  p-value: < 2.2e-16
```

The model on train data seems to select too many variables and almost all the parameters are very far from the true parameter values and show a very high p-value. This can depend
on high multicollinearity.

Let's see the predictive performances:


```r
# Plots Observed Vs. Predicted values
ggp <- ggplot(data = data.frame(fit=predict(m_bestsubset, newdata = dt_test), obs=dt_test$y), mapping = aes(x = obs, y = fit)) +
  geom_point() +
  ggtitle("Best Subset: Observed Vs. Predicted") +
  xlab("Observed Y's") + ylab("Fitted Y's") + 
  geom_abline(slope = 1,intercept = 0, colour="red")
print(ggp)
```

![plot of chunk f2](figure/f2-1.png)

```r
y_pred_bestsubset <- predict(m_bestsubset, dt_test[, bestfeat])
res <- dt_test$y - y_pred_bestsubset
mse1 <- setNames(c(summary(res), mean(res^2)), nm = c("Min.","1st Qu.","Median","Mean","3rd Qu.","Max.","MeanSqErr"))
mse <- rbind(mse, mse1)
rownames(mse)[nrow(mse)] <- "Best subset"
mse
```

```
##                  Min.    1st Qu.     Median       Mean   3rd Qu.     Max. MeanSqErr
## OLS         -2.791363 -0.6273586 0.10340216 0.04257328 0.7781063 2.811455  1.116973
## Forward     -2.838173 -0.5920479 0.05753866 0.02205985 0.7915298 2.616119  1.066416
## Backward    -2.811408 -0.6350795 0.07338870 0.02780858 0.7624021 2.704280  1.082477
## Best subset -3.032828 -0.5512834 0.04319620 0.02972282 0.7617451 3.176085  1.067237
```

```r
dt_train <- dt_t
rm(dt_t)
```

Best subset seems to predict well This may depend on the big number of
predictors selected from above methods, that produces an overfitting on data: the 
above methods predict well the train data, but not the test data, also if
it arises from the same process (by construction).  
Note that this result can change if we use a different criterion to select the
best model (for example, AIC or BIC instead of Mallows' Cp).

## (5) Ridge Regression

When many predictors are available, and when high collinearity exists between
predictors, then the estimates can become unstable and less reliable.

A method to solve this problem, is by fitting a model containing
all $p$ predictors using a technique that "constraints" or "regularizes" the
coefficient estimates, or equivalently, that shrinks the coefficient
estimates towards zero. Shrinking the coefficient estimates has the effect of
significantly reducing the coefficients' variance. The best-known technique
for shrinking the regression coefficients towards zero is ridge regression.

In ridge regression coefficients are estimated by minimizing a slightly
different quantity with respect to least squares. In particular, the
objective function in ridge regression is a penalized version of the sum of
squared deviations used in least squares. The penalty (called a shrinkage
penalty), is small when the coefficients are close to zero, and so it has the
effect of shrinking the estimates towards zero. In the objective function
we find a tuning parameter that regulates the amount of shrinkage.  
In mathematical form, the ridge regression search for the $\hat{\underline{\beta}}=(\beta_0, \beta_1, \dots, \beta_p)^T$ values
that minimize the following modified least squares criterion:

$$\sum_{i=1}^n \left(y_i - \underline{x}_i^T\underline{\beta} \right)^2 + \lambda \sum_{j=1}^p \beta_j^2$$

Where $\lambda$ is the penalization parameter. The selection of a good value for $\lambda$ is critical, and it is
typically carried out by cross-validation.

Ridge regression produces less variable and less correlated coefficient estimates
at the cost of a slight increase in the estimation bias.  
Also ridge regression tends to "push toward zero" the estimated coefficients.  
Notice that ridge regression does not penalize the intercept term.

Ridge regression has been developed to overtake the problem induced by highly
correlated predictors (so called multicollinearity). In fact, the least
squares estimates of standard error of the coefficients can be expressed as
$s^2/((n - 1) \cdot Var(x_j) \cdot 1/(1 - R_j)$, where $s^2$ is the residual variance,
$Var(x_j)$ is the variance of $j$-th predictor, and $R_j$ is the determination
coefficient of the regression of the $j$-th predictor on the remaining
predictors. The factor $1/(1 - R_j)$ is called the variance inflation factor
(VIF).

In our example, the VIF for the first predictor is given by:


```r
1/(1 - summary(lm(x1 ~ ., data = dt_train[,1:100]))$r.squared)
```

```
## [1] 301465937
```

which is very high! The most common threshold used for the VIF is 10.

In R, the `lm.ridge()` function is available inside the MASS package. This function 
performs ridge regression and gives tools to select the best value of $\lambda$:


```r
ridge_fit <- lm.ridge(y ~ ., data = dt_train, lambda = seq(0, 400, by = 0.01))
select(ridge_fit) ## Note: HKB and L-W are alternative estimators of ridge parameter
```

```
## modified HKB estimator is 0.002896856 
## modified L-W estimator is 154.0659 
## smallest value of GCV  at 285.52
```

```r
# Plot of CV Lambda values with its RSS:
ggp <- ggplot(data = as.data.frame(ridge_fit[c("lambda", "GCV")]), mapping = aes(x=lambda, y=GCV)) +
  geom_line() +
  xlab("Lambda (tuning parameter)") + ylab("Generalized Cross-Validation (GCV) values")
print(ggp)
```

![plot of chunk j](figure/j-1.png)

```r
ridge_fit <- lm.ridge(y ~ ., data = dt_train, lambda = ridge_fit$GCV[which(ridge_fit$GCV == min(ridge_fit$GCV))])
```

Since there is no predict method implemented, we need to do it by ourselves:


```r
y_pred_ridge <- as.numeric(cbind(1, as.matrix(dt_test[, 1:(ncol(dt) - 1)])) %*% coef(ridge_fit))
```

And now the predictive performaces:

```r
# Plots Observed Vs. Predicted values
ggp <- ggplot(data = data.frame(fit=y_pred_ridge, obs=dt_test$y), mapping = aes(x = obs, y = fit)) +
  geom_point() +
  ggtitle("Ridge regression: Observed Vs. Predicted") +
  xlab("Observed Y's") + ylab("Fitted Y's") + 
  geom_abline(slope = 1,intercept = 0, colour="red")
print(ggp)
```

![plot of chunk k1](figure/k1-1.png)

The corresponding mse is given by


```r
res <- dt_test$y - y_pred_ridge
mse1 <- setNames(c(summary(res), mean(res^2)), nm = c("Min.","1st Qu.","Median","Mean","3rd Qu.","Max.","MeanSqErr"))
mse <- rbind(mse, mse1)
rownames(mse)[nrow(mse)] <- "Ridge"
mse
```

```
##                  Min.    1st Qu.     Median       Mean   3rd Qu.     Max. MeanSqErr
## OLS         -2.791363 -0.6273586 0.10340216 0.04257328 0.7781063 2.811455  1.116973
## Forward     -2.838173 -0.5920479 0.05753866 0.02205985 0.7915298 2.616119  1.066416
## Backward    -2.811408 -0.6350795 0.07338870 0.02780858 0.7624021 2.704280  1.082477
## Best subset -3.032828 -0.5512834 0.04319620 0.02972282 0.7617451 3.176085  1.067237
## Ridge       -2.789856 -0.6234199 0.10089557 0.04332289 0.7841203 2.801307  1.115676
```

We can see that, at least in this case, ridge regression is not able to produce very
accurate predictions. This is probably due to an overfitting effect, since no variable
selection has been performed. We could try to first select the variables using one of
above methods, and then, if a collinearity between predictors appears, apply ridge 
regression.

Finally, the coefficient estimates, compared with the OLS one:


```r
coef(ridge_fit)
```

```
##                        x1           x2           x3           x4           x5           x6           x7 
##  4.564194526  0.102018875  0.821889038 -0.703435967  1.125598396 -1.199589631  0.398036435  0.009384965 
##           x8           x9          x10          x11          x12          x13          x14          x15 
## -0.314087363  0.045255703 -0.093917236 -0.082007320 -0.194817070  0.235380565 -0.066854299  0.195529969 
##          x16          x17          x18          x19          x20          x21          x22          x23 
##  0.241255331  0.182484388  0.160646236 -0.061378647  0.024289974  0.001423922  0.165669066 -0.012991412 
##          x24          x25          x26          x27          x28          x29          x30          x31 
## -0.113876822  0.153072616 -0.210283576 -0.064018141  0.040038472 -0.301964411 -0.286000645  0.022454135 
##          x32          x33          x34          x35          x36          x37          x38          x39 
##  0.419057484  0.119951659  0.042214292 -0.107067855 -0.138240012 -0.072344146 -0.147842394  0.071486200 
##          x40          x41          x42          x43          x44          x45          x46          x47 
##  0.151057966  0.031629501  0.068840249 -0.103682388 -0.134830400 -0.212844795  0.046043354  0.108289492 
##          x48          x49          x50          x51          x52          x53          x54          x55 
##  0.070729253 -0.075931288 -0.124653924 -0.206119671 -0.062819543  0.184759625 -0.002871102  0.137316968 
##          x56          x57          x58          x59          x60          x61          x62          x63 
## -0.166452793 -0.064447149 -0.070564717 -0.473280444 -0.159299874 -0.158242712  0.147077636  0.012762264 
##          x64          x65          x66          x67          x68          x69          x70          x71 
##  0.039078749  0.033793266  0.071667284 -0.057443629 -0.256358069  0.217840169 -0.081205212 -0.129024299 
##          x72          x73          x74          x75          x76          x77          x78          x79 
##  0.026594426 -0.190418862  0.007786495  0.187119179 -0.143568617 -0.019582912  0.159350093 -0.095477191 
##          x80          x81          x82          x83          x84          x85          x86          x87 
## -0.076828111 -0.190196726  0.248745290  0.210466803 -0.153390767 -0.079571657  0.219172558  0.218767419 
##          x88          x89          x90          x91          x92          x93          x94          x95 
## -0.107066254 -0.033493734 -0.148058377 -0.008499258 -0.008714880  0.111011546  0.237620903 -0.084237296 
##          x96          x97          x98          x99         x100 
##  0.012914949 -0.050960668  0.077797356 -0.124810413 -0.013281946
```

```r
coef(ols_fit)
```

```
##   (Intercept)            x1            x2            x3            x4            x5            x6 
##  4.554598e+00 -8.165067e+01  8.257556e+01  1.628017e+02  2.463825e+02 -3.282097e+02  3.966557e-01 
##            x7            x8            x9           x10           x11           x12           x13 
##  1.043753e-02 -3.142982e-01  4.646501e-02 -9.436869e-02 -8.235240e-02 -1.933035e-01  2.338397e-01 
##           x14           x15           x16           x17           x18           x19           x20 
## -6.621789e-02  1.971669e-01  2.418587e-01  1.828703e-01  1.601200e-01 -6.066572e-02  2.442740e-02 
##           x21           x22           x23           x24           x25           x26           x27 
##  1.705178e-03  1.657073e-01 -1.286298e-02 -1.132467e-01  1.536564e-01 -2.078384e-01 -6.218156e-02 
##           x28           x29           x30           x31           x32           x33           x34 
##  4.129922e-02 -3.009394e-01 -2.880375e-01  2.455323e-02  4.194059e-01  1.197200e-01  4.035049e-02 
##           x35           x36           x37           x38           x39           x40           x41 
## -1.070110e-01 -1.378742e-01 -7.095531e-02 -1.486828e-01  7.267380e-02  1.512610e-01  3.144402e-02 
##           x42           x43           x44           x45           x46           x47           x48 
##  7.002959e-02 -1.029584e-01 -1.361565e-01 -2.135883e-01  4.533494e-02  1.090698e-01  7.068811e-02 
##           x49           x50           x51           x52           x53           x54           x55 
## -7.659557e-02 -1.246505e-01 -2.063320e-01 -6.245864e-02  1.847112e-01 -3.096848e-03  1.373437e-01 
##           x56           x57           x58           x59           x60           x61           x62 
## -1.667900e-01 -6.331507e-02 -6.838094e-02 -4.741700e-01 -1.592034e-01 -1.578461e-01  1.481105e-01 
##           x63           x64           x65           x66           x67           x68           x69 
##  1.137715e-02  3.890117e-02  3.263870e-02  7.085531e-02 -5.794235e-02 -2.563530e-01  2.197900e-01 
##           x70           x71           x72           x73           x74           x75           x76 
## -8.131378e-02 -1.285530e-01  2.701582e-02 -1.903253e-01  8.408269e-03  1.880994e-01 -1.437923e-01 
##           x77           x78           x79           x80           x81           x82           x83 
## -1.928596e-02  1.595883e-01 -9.460945e-02 -7.883728e-02 -1.903944e-01  2.508786e-01  2.124139e-01 
##           x84           x85           x86           x87           x88           x89           x90 
## -1.552876e-01 -7.718571e-02  2.184278e-01  2.194058e-01 -1.066971e-01 -3.361988e-02 -1.451596e-01 
##           x91           x92           x93           x94           x95           x96           x97 
## -1.069872e-02 -9.042297e-03  1.102316e-01  2.375148e-01 -8.373576e-02  1.280358e-02 -5.122576e-02 
##           x98           x99          x100 
##  7.946681e-02 -1.247622e-01 -1.428846e-02
```

As we can see, the estimated coefficients are more similar to the true ones than many
other techniques previusly used.

## (6) Principal Components Regression

We now explore two methods that transform the predictors and then fit a least
squares model using the transformed variables. The first approach is called
principal component regression (PCR), which first constructs the
principal components of the matrix of $X$ variables, and then used these as the
predictors in a least squares linear regression model. In
PCR it is hence assumed that the directions in which $X1$,...,$Xp$ show the most
variation are the directions that are associated with $Y$. While this
assumption is not guaranteed to be true, it often turns out to be a
reasonable enough approximation.

In PCR, the number of principal components, is typically chosen by cross-
validation. The `pls` package contains a function, `pcr()`, that implements the
approach we just described:


```r
require(pls)
```


```r
pcr_fit <- pcr(y ~ ., data = dt_train, validation = "CV")
```

We now select the number of components (by CV)


```r
# Plot of CV components values with its RSS:
ggp <- ggplot(data = data.frame(comps=1:100, t(pcr_fit$validation$PRESS)), mapping = aes(x=comps, y=y)) +
  geom_line() +
  xlab("Number of components") + ylab("Generalized Cross-Validation (GCV) values")
print(ggp)
```

![plot of chunk o](figure/o-1.png)

```r
(ncomp <- which.min(pcr_fit$validation$PRESS))
```

```
## [1] 70
```

Surprisingly, the number of components selected by PCR is equal to 70 (by definition of 
predictors' matrix, there is only a variable correlated with the others, and about 94 non useful
predictors).
We can then calculate the predicted values


```r
y_pred_pcr <- as.vector(predict(pcr_fit, dt_test, ncomp = ncomp))
res <- dt_test$y - y_pred_pcr
mse1 <- setNames(c(summary(res), mean(res^2)), nm = c("Min.","1st Qu.","Median","Mean","3rd Qu.","Max.","MeanSqErr"))
mse <- rbind(mse, mse1)
rownames(mse)[nrow(mse)] <- "PCR"
mse
```

```
##                  Min.    1st Qu.     Median       Mean   3rd Qu.     Max. MeanSqErr
## OLS         -2.791363 -0.6273586 0.10340216 0.04257328 0.7781063 2.811455  1.116973
## Forward     -2.838173 -0.5920479 0.05753866 0.02205985 0.7915298 2.616119  1.066416
## Backward    -2.811408 -0.6350795 0.07338870 0.02780858 0.7624021 2.704280  1.082477
## Best subset -3.032828 -0.5512834 0.04319620 0.02972282 0.7617451 3.176085  1.067237
## Ridge       -2.789856 -0.6234199 0.10089557 0.04332289 0.7841203 2.801307  1.115676
## PCR         -2.972491 -0.5338135 0.12238387 0.04787440 0.7571167 2.753898  1.038035
```


```r
# Plots Observed Vs. Predicted values
ggp <- ggplot(data = data.frame(fit=y_pred_pcr, obs=dt_test$y), mapping = aes(x = obs, y = fit)) +
  geom_point() +
  ggtitle("PCR: Observed Vs. Predicted") +
  xlab("Observed Y's") + ylab("Fitted Y's") + 
  geom_abline(slope = 1,intercept = 0, colour="red")
print(ggp)
```

![plot of chunk q1](figure/q1-1.png)

In this case, the results are better than the ones of OLS and backward and forward stepwise.  
A possibile step ahead  could be to try to reduce the model starting from the matrix of
70 principal components.

## (7) Partial Least Squares (PLS)

As we already pointed out, in PCR there is no guarantee that the directions
that best explain the predictors will also be the best directions to use for
predicting the response. In other words, in finding the components, the
response Y is not used.

Partial least squares (PLS), instead, identifies the components in a
supervised way, that is, it makes use of the response $Y$ in order to identify
new features that not only approximate the old features well, but also that
are related to the response. Roughly speaking, the PLS approach attempts to
find directions that help explain both the response and the predictors. As
with PCR, the number of partial least squares directions used in PLS is a
tuning parameter that is typically chosen by cross-validation. 
Actually, PLS splits the model in two "chunks":  
$X=TP^T + E$  
$Y=UQ^T + F$  
Where $E$ and $F$ are error matrices, $P$ and $Q$ are factor loadings, and $T$
and $U$ are factor scores.  
PLS try to maximize the correlation between $T$ and $U$.  
$Y$ can be multivariate.  
Also, PLS can deal without any problems with data in which the number of cases $n$
is much less than the number $p$ of independent variables (e.g., NIR spectrum analysis)


```r
pls_fit <- as.vector(plsr(y ~ ., data = dt_train, validation = "CV"))
# Plot of CV components values with its RSS:
ggp <- ggplot(data = data.frame(comps=1:100, t(pls_fit$validation$PRESS)), mapping = aes(x=comps, y=y)) +
  geom_line() +
  xlab("Number of components") + ylab("Generalized Cross-Validation (GCV) values")
print(ggp)
```

![plot of chunk r](figure/r-1.png)

```r
(ncomp <- which.min(pls_fit$validation$PRESS))
```

```
## [1] 2
```

```r
y_pred_pls <- predict(pls_fit, dt_test, ncomp = ncomp)
res <- dt_test$y - y_pred_pls
mse1 <- setNames(c(summary(res), mean(res^2)), nm = c("Min.","1st Qu.","Median","Mean","3rd Qu.","Max.","MeanSqErr"))
mse <- rbind(mse, mse1)
rownames(mse)[nrow(mse)] <- "PLS"
mse
```

```
##                  Min.    1st Qu.     Median       Mean   3rd Qu.     Max. MeanSqErr
## OLS         -2.791363 -0.6273586 0.10340216 0.04257328 0.7781063 2.811455  1.116973
## Forward     -2.838173 -0.5920479 0.05753866 0.02205985 0.7915298 2.616119  1.066416
## Backward    -2.811408 -0.6350795 0.07338870 0.02780858 0.7624021 2.704280  1.082477
## Best subset -3.032828 -0.5512834 0.04319620 0.02972282 0.7617451 3.176085  1.067237
## Ridge       -2.789856 -0.6234199 0.10089557 0.04332289 0.7841203 2.801307  1.115676
## PCR         -2.972491 -0.5338135 0.12238387 0.04787440 0.7571167 2.753898  1.038035
## PLS         -2.921726 -0.5868044 0.08408436 0.04195022 0.7468656 2.794285  1.056515
```

PLS reduces even to 2 the number of features (independent variables) in model.
The predictive results are almost good, also if the error is between stepwise and PCR
results.

## (8) Elastic-Net

`glmnet` is a package that fits a generalized linear model via penalized
maximum likelihood. The regularization path is computed at a grid of values
for the regularization parameter. The algorithm is extremely fast, and can
exploit sparsity in the input matrix $X$. It fits linear, logistic and
multinomial, Poisson, and Cox regression models.

The _elastic net_  approach (in linear model) tries to minimize the following
criterion function:
$$\frac{\sum_{i=1}^n \left(y_i - \underline{x}_i^T\underline{\beta} \right)^2}{n} + \lambda \sum_{j=1}^p \left[\alpha | \beta_j| +(1-\alpha) \beta_j^2 \right]$$

Where $\underline{\beta}=(\beta_0, \beta_1, \cdots, \beta_p)^T$, (with $\beta_0$
the intercept), $0 \le \alpha \le1$, and $\lambda$ is the penalty term.  

When $\alpha=1$, then the so-called _LASSO_ (Least Absolute Shrinkage and Selection
Operator) penalty term is used, that is based on $L_1$ norm.  
The use of the $L_1$ penalty causes a subset of the solution coefficients $\beta_j$
to be exactly zero, for a sufficiently large value of the tuning parameter $\lambda$.  

When $\alpha=0$, then the above seen _ridge_ penalty term is used, that is based on $L_2$
norm.  
The ridge penalty, as already seen, tends to shrink the coefficients of correlated
variables toward each other.

Elasticnet is introduced as a compromise between these two techniques, and has a penalty
which is a mix of $L_1$ and $L_2$ norms. In the package, $\lambda$ may be estimated by
cross-validation, while (currently) $\alpha$ is set by the user.


```r
require(glmnet)
```


```r
set.seed(10)
```

We first search for a "good" value for `lambda`:


```r
# Set folding parameter
foldid <- sample(rep(seq(10),length=nrow(dt_train)))
cv <- cv.glmnet(x = as.matrix(dt_train[, 1:100]), y = dt_train$y, alpha = 0.9, foldid=foldid)
plot(cv)
```

![plot of chunk t](figure/t-1.png)

The plot shows that a good `lambda` parameter in model is in between 5 and 20.


```r
glmnet_fit <- glmnet(x = as.matrix(dt_train[, 1:100]), y = dt_train$y, lambda = cv$lambda.min, alpha = 0.9)
coef(glmnet_fit)
```

```
## 101 x 1 sparse Matrix of class "dgCMatrix"
##                      s0
## (Intercept)  4.20782557
## x1           0.32915378
## x2           0.30183033
## x3          -1.07301999
## x4           0.26493327
## x5           .         
## x6           0.14269954
## x7           .         
## x8           .         
## x9           .         
## x10          .         
## x11          .         
## x12          .         
## x13          0.01360800
## x14          .         
## x15          .         
## x16          .         
## x17          .         
## x18          .         
## x19          .         
## x20          .         
## x21          .         
## x22          .         
## x23          .         
## x24          .         
## x25          .         
## x26          .         
## x27          .         
## x28          .         
## x29         -0.05929645
## x30         -0.05483243
## x31          .         
## x32          0.13483265
## x33          .         
## x34          .         
## x35          .         
## x36          .         
## x37          .         
## x38          .         
## x39          .         
## x40          .         
## x41          .         
## x42          .         
## x43          .         
## x44          .         
## x45          .         
## x46          .         
## x47          .         
## x48          .         
## x49          .         
## x50          .         
## x51          .         
## x52          .         
## x53          .         
## x54          .         
## x55          .         
## x56          .         
## x57          .         
## x58          .         
## x59         -0.20563600
## x60          .         
## x61          .         
## x62          .         
## x63          .         
## x64          .         
## x65          .         
## x66          .         
## x67          .         
## x68         -0.01488518
## x69          .         
## x70          .         
## x71          .         
## x72          .         
## x73          .         
## x74          .         
## x75          .         
## x76          .         
## x77          .         
## x78          .         
## x79          .         
## x80          .         
## x81          .         
## x82          0.09564533
## x83          .         
## x84          .         
## x85          .         
## x86          .         
## x87          .         
## x88          .         
## x89          .         
## x90          .         
## x91          .         
## x92          .         
## x93          .         
## x94          .         
## x95          .         
## x96          .         
## x97          .         
## x98          .         
## x99          .         
## x100         .
```

```r
y_pred_glmnet <- as.numeric(predict(glmnet_fit, newx = as.matrix(dt_test[, 1:100])))
res <- dt_test$y - y_pred_glmnet
mse1 <- setNames(c(summary(res), mean(res^2)), nm = c("Min.","1st Qu.","Median","Mean","3rd Qu.","Max.","MeanSqErr"))
mse <- rbind(mse, mse1)
rownames(mse)[nrow(mse)] <- "glmnet"
mse
```

```
##                  Min.    1st Qu.     Median       Mean   3rd Qu.     Max. MeanSqErr
## OLS         -2.791363 -0.6273586 0.10340216 0.04257328 0.7781063 2.811455 1.1169732
## Forward     -2.838173 -0.5920479 0.05753866 0.02205985 0.7915298 2.616119 1.0664161
## Backward    -2.811408 -0.6350795 0.07338870 0.02780858 0.7624021 2.704280 1.0824768
## Best subset -3.032828 -0.5512834 0.04319620 0.02972282 0.7617451 3.176085 1.0672374
## Ridge       -2.789856 -0.6234199 0.10089557 0.04332289 0.7841203 2.801307 1.1156757
## PCR         -2.972491 -0.5338135 0.12238387 0.04787440 0.7571167 2.753898 1.0380354
## PLS         -2.921726 -0.5868044 0.08408436 0.04195022 0.7468656 2.794285 1.0565152
## glmnet      -3.083527 -0.5352761 0.04637397 0.01869590 0.7113028 2.821509 0.9536412
```

`cv$lambda.min` returns the value of lambda for which the minimum value of CV error is obtained.

If we want to see what happens when variyng the lambda parameter, we can use the `plot()` method


```r
glmnet_fit <- glmnet(x = as.matrix(dt_train[, 1:100]), y = dt_train$y, alpha=1) # default alpha (LASSO)
plot(glmnet_fit,xvar="lambda")
```

![plot of chunk v](figure/v-1.png)

```r
glmnet_fit <- glmnet(x = as.matrix(dt_train[, 1:100]), y = dt_train$y, alpha=0.9) # elastic-net
plot(glmnet_fit,xvar="lambda")
```

![plot of chunk v](figure/v-2.png)

```r
glmnet_fit <- glmnet(x = as.matrix(dt_train[, 1:100]), y = dt_train$y, alpha=0) # ridge
plot(glmnet_fit,xvar="lambda")
```

![plot of chunk v](figure/v-3.png)

We now try other combinations of lambda and alpha. Let's try to use the lambda.1se value obtained from CV:


```r
glmnet_fit <- glmnet(x = as.matrix(dt_train[, 1:100]), y = dt_train$y, lambda = cv$lambda.1se, alpha = 0.9)
y_pred_glmnet <- as.numeric(predict(glmnet_fit, newx = as.matrix(dt_test[, 1:100])))
summary((y_pred_glmnet - dt_test$y)^2)
```

```
##      Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
##  0.000191  0.116756  0.437923  0.961089  1.203172 10.830745
```

Here, we serach for the best `lambda` value for with `alpha = 1`:


```r
cv <- cv.glmnet(x = as.matrix(dt_train[, 1:100]), y = dt_train$y, alpha = 1)
plot(cv)
```

![plot of chunk x](figure/x-1.png)

The plot shows that the lambda parameter in model is between 5 and 15.


```r
# Plots the model parameters with alpha=0 (ridge) when varying the L1 norm
glmnet_fit <- glmnet(x = as.matrix(dt_train[, 1:100]), y = dt_train$y, alpha = 0)
plot(glmnet_fit, label = TRUE)
```

![plot of chunk y](figure/y-1.png)

```r
# Compares the models with alpha=1 (LASSO) with lambda.min and lambda.1se
glmnet_fit <- glmnet(x = as.matrix(dt_train[, 1:100]), y = dt_train$y, lambda = cv$lambda.min, alpha = 1)
y_pred_glmnet <- as.numeric(predict(glmnet_fit, newx = as.matrix(dt_test[, 1:100])))
summary((y_pred_glmnet - dt_test$y)^2)
```

```
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
## 0.000001 0.100165 0.404315 0.956141 1.123045 9.263117
```

```r
glmnet_fit <- glmnet(x = as.matrix(dt_train[, 1:100]), y = dt_train$y, lambda = cv$lambda.1se, alpha = 1)
y_pred_glmnet <- as.numeric(predict(glmnet_fit, newx = as.matrix(dt_test[, 1:100])))
summary((y_pred_glmnet - dt_test$y)^2)
```

```
##      Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
##  0.000026  0.116719  0.445032  0.965106  1.212461 11.115585
```

Results for `alpha` = 0.9 and `alpha` = 1 are substantially comparable. Also, using `lambda.min` and `lambda.1se`
seems do not change sensibly the results.
Anyway, it seems that the best solution is the LASSO one.

Now we perform a grid search for the parameters pairs (`lambda`, `alpha`) that produce the best model:

```r
alphas <- (0:101)/101
cv_fits <- lapply(X = alphas,FUN = function(a, dt_train, foldid){
      fit <- cv.glmnet(x = as.matrix(dt_train[, 1:100]), y = dt_train$y, alpha = a, foldid = foldid)
      return(fit)
    },
    dt_train=dt_train, foldid=foldid
  )

mins <- t(sapply(X = cv_fits, FUN = function(x){return(c(lambda=x$lambda.min, cvm=min(x$cvm, na.rm = TRUE) ))}))
wm <- which.min(mins[,"cvm"])
alpha_opt <- alphas[wm]
(opt <- c(alpha=alpha_opt, mins[wm,]))
```

```
##      alpha     lambda        cvm 
## 1.00000000 0.06249825 1.05464583
```

```r
glmnet_fit <- glmnet(x = as.matrix(dt_train[, 1:100]), y = dt_train$y, lambda = opt["lambda"], alpha = opt["alpha"])
coef(glmnet_fit, label = TRUE)
```

```
## 101 x 1 sparse Matrix of class "dgCMatrix"
##                      s0
## (Intercept)  4.21834700
## x1           0.33328712
## x2           0.29913665
## x3          -1.08757071
## x4           0.25404636
## x5           .         
## x6           0.14370274
## x7           .         
## x8           .         
## x9           .         
## x10          .         
## x11          .         
## x12          .         
## x13          0.01317142
## x14          .         
## x15          .         
## x16          .         
## x17          .         
## x18          .         
## x19          .         
## x20          .         
## x21          .         
## x22          .         
## x23          .         
## x24          .         
## x25          .         
## x26          .         
## x27          .         
## x28          .         
## x29         -0.05987263
## x30         -0.05461363
## x31          .         
## x32          0.13526021
## x33          .         
## x34          .         
## x35          .         
## x36          .         
## x37          .         
## x38          .         
## x39          .         
## x40          .         
## x41          .         
## x42          .         
## x43          .         
## x44          .         
## x45          .         
## x46          .         
## x47          .         
## x48          .         
## x49          .         
## x50          .         
## x51          .         
## x52          .         
## x53          .         
## x54          .         
## x55          .         
## x56          .         
## x57          .         
## x58          .         
## x59         -0.20645466
## x60          .         
## x61          .         
## x62          .         
## x63          .         
## x64          .         
## x65          .         
## x66          .         
## x67          .         
## x68         -0.01544489
## x69          .         
## x70          .         
## x71          .         
## x72          .         
## x73          .         
## x74          .         
## x75          .         
## x76          .         
## x77          .         
## x78          .         
## x79          .         
## x80          .         
## x81          .         
## x82          0.09513672
## x83          .         
## x84          .         
## x85          .         
## x86          .         
## x87          .         
## x88          .         
## x89          .         
## x90          .         
## x91          .         
## x92          .         
## x93          .         
## x94          .         
## x95          .         
## x96          .         
## x97          .         
## x98          .         
## x99          .         
## x100         .
```

```r
y_pred_glmnet <- as.numeric(predict(glmnet_fit, newx = as.matrix(dt_test[, 1:100])))

res <- dt_test$y - y_pred_glmnet
mse1 <- setNames(c(summary(res), mean(res^2)), nm = c("Min.","1st Qu.","Median","Mean","3rd Qu.","Max.","MeanSqErr"))
mse <- rbind(mse, mse1)
rownames(mse)[nrow(mse)] <- "best-glmnet"
mse
```

```
##                  Min.    1st Qu.     Median       Mean   3rd Qu.     Max. MeanSqErr
## OLS         -2.791363 -0.6273586 0.10340216 0.04257328 0.7781063 2.811455 1.1169732
## Forward     -2.838173 -0.5920479 0.05753866 0.02205985 0.7915298 2.616119 1.0664161
## Backward    -2.811408 -0.6350795 0.07338870 0.02780858 0.7624021 2.704280 1.0824768
## Best subset -3.032828 -0.5512834 0.04319620 0.02972282 0.7617451 3.176085 1.0672374
## Ridge       -2.789856 -0.6234199 0.10089557 0.04332289 0.7841203 2.801307 1.1156757
## PCR         -2.972491 -0.5338135 0.12238387 0.04787440 0.7571167 2.753898 1.0380354
## PLS         -2.921726 -0.5868044 0.08408436 0.04195022 0.7468656 2.794285 1.0565152
## glmnet      -3.083527 -0.5352761 0.04637397 0.01869590 0.7113028 2.821509 0.9536412
## best-glmnet -3.073836 -0.5376719 0.04885091 0.01830664 0.7063276 2.816687 0.9538477
```

Suprisingly, the best model is not really "best". Maybe, this could be due to rounding effects.
Anyway, the differences between this model and the previous one are really small.

<!---
# Exercises?
--->

## (9) Lasso and Post-Lasso

R package `hdm` contains implementations of recently developed methods for high-dimensional approximately sparse models, mainly relying on forms of Lasso
and Post-Lasso. This package is suitable for the cases where the number of parameters to be estimated ($p$) is large relative to the sample size ($n$) but only a relatively small number $s = o(n)$ of these regressors are important for capturing accurately the main features of the regression function.


```r
require(hdm)
```

The Lasso estimator is a particular case of Elastic-Net, where $a = 1$. It is based on $L_1$ norm, which helps it to avoid overfitting, but it also shrinks the fitted coefficients towards zero, causing a potentially significant bias. In order to remove some of this bias, Post-Lasso is considered, which is an estimator defined as ordinary least squares applied to the data after removing the regressors that were not selected by Lasso.
<!--- 
Let us consider the previous generated sample where we defined $y = 4 + 0.2x_1 + 0.5x_2 - 0.9*x_3 + x_4 - 0.5x_5 + 0.2x_6 + \epsilon$. --->

The function `rlasso()` of `hdm` package implements Lasso and post-Lasso. The prefix "r" signifies that these are theoretically rigorous versions of Lasso and post-Lasso. The default option is post-Lasso, `post=TRUE`. This function returns an object of class `rlasso` for which methods like `predict`, `print`, `summary` are provided, where the option `all` can be set to `FALSE` to limit the print only to the non-zero coefficients.

Let us see how Post-Lasso method performs:


```r
post_lasso_reg <- rlasso(x = dt_train[,1:100], y = dt_train$y, post = TRUE) 
summary(post_lasso_reg, all = FALSE) 
```

```
## 
## Call:
## rlasso.default(x = dt_train[, 1:100], y = dt_train$y, post = TRUE)
## 
## Post-Lasso Estimation:  TRUE 
## 
## Total number of variables: 100
## Number of selected variables: 4 
## 
## Residuals: 
##      Min       1Q   Median       3Q      Max 
## -3.26574 -0.67147 -0.04683  0.67920  3.11264 
## 
##             Estimate
## (Intercept)    4.263
## x1             0.385
## x2             0.446
## x3            -1.422
## x4             0.295
## 
## Residual standard error: 1.015
## Multiple R-squared:  0.3176
## Adjusted R-squared:  0.314
## Joint significance test:
##  the sup score statistic for joint significance test is 23.28 with a p-value of     0
```

The model on train data seems not to select correctly all the variables that actually impact on dependent variable and almost all the parameters are far from the true parameter values. This can depend on high multicollinearity.

Let's see the predictive performances:


```r
y_pred_post_lasso <- c(predict(post_lasso_reg, newdata = dt_test)) 

ggp <- ggplot(data = data.frame(fit=y_pred_post_lasso, obs=dt_test$y), mapping = aes(x = obs, y = fit)) +
  geom_point() +
  ggtitle("Post-Lasso: Observed Vs. Predicted") +
  xlab("Observed Y's") + ylab("Fitted Y's") + 
  geom_abline(slope = 1,intercept = 0, colour="red")
print(ggp)
```

![plot of chunk post-lasso-pred](figure/post-lasso-pred-1.png)



```r
res <- dt_test$y - y_pred_post_lasso
mse1 <- setNames(c(summary(res), mean(res^2)), nm = c("Min.","1st Qu.","Median","Mean","3rd Qu.","Max.","MeanSqErr"))
mse <- rbind(mse, mse1)
rownames(mse)[nrow(mse)] <- "Post-Lasso"
mse
```

```
##                  Min.    1st Qu.     Median       Mean   3rd Qu.     Max. MeanSqErr
## OLS         -2.791363 -0.6273586 0.10340216 0.04257328 0.7781063 2.811455 1.1169732
## Forward     -2.838173 -0.5920479 0.05753866 0.02205985 0.7915298 2.616119 1.0664161
## Backward    -2.811408 -0.6350795 0.07338870 0.02780858 0.7624021 2.704280 1.0824768
## Best subset -3.032828 -0.5512834 0.04319620 0.02972282 0.7617451 3.176085 1.0672374
## Ridge       -2.789856 -0.6234199 0.10089557 0.04332289 0.7841203 2.801307 1.1156757
## PCR         -2.972491 -0.5338135 0.12238387 0.04787440 0.7571167 2.753898 1.0380354
## PLS         -2.921726 -0.5868044 0.08408436 0.04195022 0.7468656 2.794285 1.0565152
## glmnet      -3.083527 -0.5352761 0.04637397 0.01869590 0.7113028 2.821509 0.9536412
## best-glmnet -3.073836 -0.5376719 0.04885091 0.01830664 0.7063276 2.816687 0.9538477
## Post-Lasso  -2.833806 -0.5702318 0.07996222 0.02022122 0.6706851 2.900089 0.9782119
```

The predictive results are good and very close to that of `glmnet`.

