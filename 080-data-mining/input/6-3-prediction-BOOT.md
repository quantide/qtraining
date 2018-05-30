---
title: "Outlines on Bootstrap Techniques"
---






# Introduction

The bootstrap is a widely applicable and extremely powerful tool that can be
used to quantify the uncertainty associated with a given estimator. The power
of the bootstrap lies in the fact that it can be easily applied to a wide
range of statistical methods, including some for which a measure of
variability is otherwise difficult to obtain and is not automatically
provided by statistical software. Suppose for example that one is interested
in making inferences about a ratio of two population means. There is no
simple traditional method for inference in this setting. Bootstrap can be
effectively used in such non-standard situations.

The (nonparametric) bootstrap works no matter what is the distribution of the population.
With respect to this aspect, the bootstrap provides a general nonparametric
approach for performing inferences about the characteristics of a population
of interest.

Suppose a set of $n$ observations is available from which one estimates a
parameter (or set of parameters) $T$, the estimate being denoted as $t$. The 
steps to apply the nonparametric bootstrap are:

1. Generate $B$ new samples (usually few hundreds are enough), called
   bootstrap samples, or resamples, by sampling with replacement from the
   original random sample. Each resample is the same size as the original
   random sample, $n$. Sampling with replacement means that, after one
   randomly draws an observation from the original sample, he/she puts it back
   into the original sample before drawing the next observation. As a result,
   any number can be drawn once, more than once, or not at all.

2. For each resample, calculate the statistic of interest, denoted as $t(b)$,
   with $b = 1, \cdots ,B$; the distribution of these resample statistics is called
   the bootstrap distribution.

3. The bootstrap distribution gives information about the features (shape,
   center, spread, etc.) of the sampling distribution of the statistic of
   interest. In other words, the bootstrap distribution provides an
   approximation to the sampling distribution for the statistic.

Therefore, the basic idea is that the original sample represents the
population from which it was drawn. So, resampling from this sample
represents what one would get if many samples were taken from the
population. The bootstrap distribution of a statistic, based on many
resamples, represents the sampling distribution of the $t$ statistic, based on
many samples.

Performing a bootstrap analysis in `R` requires only two steps. First, we must create a function that computes the statistic of interest. Second, we use the `boot()` function of the `boot` package to perform the bootstrap by repeatedly sampling observations from the dataset with replacement.  
As an illustration we use the `Auto` dataset in the `ISLR` package (see the section *Introduction and datasets used* for further information) to assess the variability of the intercept and slope terms for the linear regression model that uses `horsepower` to predict `mpg`. We will then compare the estimates obtained using the bootstrap with those obtained with the OLS method.


```r
summary(Auto)
```

```
##       mpg          cylinders      displacement     horsepower        weight      acceleration  
##  Min.   : 9.00   Min.   :3.000   Min.   : 68.0   Min.   : 46.0   Min.   :1613   Min.   : 8.00  
##  1st Qu.:17.00   1st Qu.:4.000   1st Qu.:105.0   1st Qu.: 75.0   1st Qu.:2225   1st Qu.:13.78  
##  Median :22.75   Median :4.000   Median :151.0   Median : 93.5   Median :2804   Median :15.50  
##  Mean   :23.45   Mean   :5.472   Mean   :194.4   Mean   :104.5   Mean   :2978   Mean   :15.54  
##  3rd Qu.:29.00   3rd Qu.:8.000   3rd Qu.:275.8   3rd Qu.:126.0   3rd Qu.:3615   3rd Qu.:17.02  
##  Max.   :46.60   Max.   :8.000   Max.   :455.0   Max.   :230.0   Max.   :5140   Max.   :24.80  
##                                                                                                
##       year           origin                      name    
##  Min.   :70.00   Min.   :1.000   amc matador       :  5  
##  1st Qu.:73.00   1st Qu.:1.000   ford pinto        :  5  
##  Median :76.00   Median :1.000   toyota corolla    :  5  
##  Mean   :75.98   Mean   :1.577   amc gremlin       :  4  
##  3rd Qu.:79.00   3rd Qu.:2.000   amc hornet        :  4  
##  Max.   :82.00   Max.   :3.000   chevrolet chevette:  4  
##                                  (Other)           :365
```

We first create a simple function, `boot.fn()`, which takes in the Auto data
set as well as a set of indices for the observations, and returns the
intercept and slope estimates. We then apply this function to compute the
estimates on the entire dataset using the usual linear regression
coefficient estimate formulas:


```r
boot.fn <- function(data, index) {
	return(coef(lm(mpg ~ horsepower, data = data, subset = index)))
}
boot.fn(Auto, 1:392)
```

```
## (Intercept)  horsepower 
##  39.9358610  -0.1578447
```

The `boot.fn()` function can also be used in order to create bootstrap
estimates for the intercept and slope terms by randomly sampling from among
the observations with replacement:


```r
set.seed(10)
boot.fn(Auto, sample(1:392, 392, replace = TRUE))
```

```
## (Intercept)  horsepower 
##  40.3498976  -0.1622135
```

The resulting estimates are a bootstrap sample estimate of intercept and slope parameters.

Next, we use the `boot()` function of the `boot` package to compute the standard errors of 1,000
bootstrap estimates for the intercept and slope terms:


```r
require(boot)
```


```r
set.seed(20)
res <- boot(data = Auto, statistic = boot.fn, R = 1000)
print(res)
```

```
## 
## ORDINARY NONPARAMETRIC BOOTSTRAP
## 
## 
## Call:
## boot(data = Auto, statistic = boot.fn, R = 1000)
## 
## 
## Bootstrap Statistics :
##       original        bias    std. error
## t1* 39.9358610  0.0294933368  0.83436003
## t2* -0.1578447 -0.0004304856  0.00710765
```


This indicates that the bootstrap estimate for the intercept standard error
is 0.83436, and that the bootstrap estimate for the slope standard error is
0.0071077. The corresponding OLS standard errors are given by 


```r
summary(lm(mpg ~ horsepower, data = Auto))$coef
```

```
##               Estimate  Std. Error   t value      Pr(>|t|)
## (Intercept) 39.9358610 0.717498656  55.65984 1.220362e-187
## horsepower  -0.1578447 0.006445501 -24.48914  7.031989e-81
```

Interestingly, these are somewhat different from the estimates obtained
using the bootstrap. Does this indicate a problem with the bootstrap? In
fact, it suggests the opposite, because the usual inference in a linear
regression model requires certain assumptions (i.e., linearity,
homoscedasticity, normality, etc.) that rarely are satisfied in practice.

As a further example, below we compute the bootstrap standard error
estimates and the standard linear regression estimates that result from
fitting the quadratic model to the same data:


```r
boot.fn <- function(data, index) {
	return(coefficients(lm(mpg ~ horsepower + I(horsepower^2), data = data,
	subset = index)))
}
set.seed(10)
res <- boot(data = Auto, statistic = boot.fn, R = 1000)
print(res)
```

```
## 
## ORDINARY NONPARAMETRIC BOOTSTRAP
## 
## 
## Call:
## boot(data = Auto, statistic = boot.fn, R = 1000)
## 
## 
## Bootstrap Statistics :
##         original        bias     std. error
## t1* 56.900099702  3.063330e-02 2.1068369120
## t2* -0.466189630 -7.198069e-04 0.0334556038
## t3*  0.001230536  3.139720e-06 0.0001206073
```

```r
summary(lm(mpg ~ horsepower + I(horsepower^2), data = Auto))$coef
```

```
##                     Estimate   Std. Error   t value      Pr(>|t|)
## (Intercept)     56.900099702 1.8004268063  31.60367 1.740911e-109
## horsepower      -0.466189630 0.0311246171 -14.97816  2.289429e-40
## I(horsepower^2)  0.001230536 0.0001220759  10.08009  2.196340e-21
```

Finally, to test the bootstrap on data which are correctly specified by design,
we could try the following:


```r
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
```

```
## 
## ORDINARY NONPARAMETRIC BOOTSTRAP
## 
## 
## Call:
## boot(data = dsim, statistic = boot.fn, R = 1000)
## 
## 
## Bootstrap Statistics :
##     original        bias     std. error
## t1* 2.055483  2.388824e-03 0.0921124159
## t2* 2.999537 -3.099819e-06 0.0008115844
```

```r
summary(lm(y ~ x, data = dsim))$coef
```

```
##             Estimate  Std. Error    t value     Pr(>|t|)
## (Intercept) 2.055483 0.094825118   21.67657 7.085419e-74
## x           2.999537 0.000827011 3626.96147 0.000000e+00
```
In this case, where the model is correctly specified "by design", the bootstrap and "standard" results are quite similar.

<!---
# Exercises?
--->
