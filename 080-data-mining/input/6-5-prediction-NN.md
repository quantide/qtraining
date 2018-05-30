---
title: "Neural Networks"
---





## Introduction
Statistical literature on prediction/modeling techniques is growing very quickly. New techniques applied to data-mining and to business intelligence projects appear every day, and new developments allow the researcher to obtain even more precise predictions.  
In this chapter we want to introduce very briefly the basis of Neural Network analysis for classification problems.


## Example: Boston housing data

This example uses the true data from surviving to Titanic wreck.  
The aim of study is to find a prediction model to assess the probability of die for each passenger based on its `Age`, `Gender`, and `Class` of accomodation.

Here we show some summaries on dataset:

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
And here we load the library used for analysis

```r
require(nnet)
```

```
## Loading required package: nnet
```

```r
require(dplyr)
```

```
## Loading required package: dplyr
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

The above tables show counts and percentages of died and survived for each combination of Sex and Class factors. Some relations clearly appear, but their general interpretation is not really simple. One can think that the relation between independent variables and dependent variable is complex and, maybe, non linear.

The following graph shows the relations all `ozone` columns:

```r
require(ggplot2)
```

```
## Loading required package: ggplot2
```

```r
require(GGally)
```

```
## Loading required package: GGally
```

```
## 
## Attaching package: 'GGally'
```

```
## The following object is masked from 'package:dplyr':
## 
##     nasa
```

```r
ggpairs(bostonhousing)
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

![Relationship between variables](figure/06c-descrgraphs-1.png)
Several relations appear, and particularly, `O3` (dependent) variable seems to relate with more of other (independent) variables.

Now we can try a model to predict the `O3` variable based on all other variables.  
The R `nnet` library gives a `nnet()` function to fit a single-hidden-layer neural network to data. `nnet()` produces in output an object of class `nnet.formula` and `nnet`.

The syntax used to build a `nnet` object is very similar to the one used for (generalized) linear models:

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

set.seed(100)

nn0 <- nnet(medv ~ ., data = bh_train, size = 14)
```

```
## # weights:  309
## initial  value 228914.988489 
## final  value 221875.370000 
## converged
```
The `size` parameter of above `nnet()` call specifies the number of units (neurons) in hidden layer. 

Obviously, we can produce a plot of obsered Vs. predicted values, for training and test sets:

```r
require(dplyr)
data_gr <- bh_train %>%
  mutate(set="train") %>%
  bind_rows(bh_test %>% mutate(set="test"))

data_gr$fit <- predict(nn0, data_gr)

require(ggplot2)
ggp <- ggplot(data = data_gr, mapping = aes(x=fit, y=medv)) +
  geom_point(aes(colour=set), alpha=0.6) +
  geom_abline(slope=1, intercept = 0) +
  geom_smooth(method = "lm", se = FALSE, aes(colour=set), alpha=0.6)
print(ggp)
```

![plot of chunk 06e-plots](figure/06e-plots-1.png)

## Some theory about Neural networks
Neural networks can be considered a type of nonlinear regression that takes a set of 
inputs (explanatory variables), transforms and weights these within a set of hidden units
and hidden layers to produce a set of outputs or predictions (that are also transformed).

Next figure is an example of a feed forward neural network consisting of four inputs, a
hidden layer that contains three units and an output layer that contains two outputs.

![Example of simple feed-forward Neural Network](./images/nnet.png)

The outputs of nodes in one layer are inputs to the next layer. The inputs to each node are combined using a weighted linear combination. The result is then usually modified by a nonlinear function before being output. For example, the inputs into hidden neuron $j$ in above figure are combined to give

$z_j=b_j+\sum_{i=1}^4 w_{i,j} x_i$.

In the hidden layer, this is then modified using a nonlinear function such as a sigmoid,

$\phi(z)=\dfrac{1}{1+e^{-z}}$,

to give the input for the next layer. This allows the formula to reduce the effect of extreme input values, thus making the network more robust to outliers.

The parameters $b_1$,$b_2$,$b_3$ and $w_{1,1}, \cdots ,w_{4,3}$ are "learned" from the data. 

The weights usually take random values to begin with, and are then updated using the observed data. Consequently, there is an element of randomness in the predictions produced by a neural network. Therefore, the network is usually trained several times using different random starting points, and the results are averaged.

The number of hidden layers, and the number of nodes in each hidden layer, must be specified in advance. 

