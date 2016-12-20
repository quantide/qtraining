
# Statistical models



Before starting the exercises, load the following libraries, supposing they are already installed.


```r
require(dplyr)
require(ggplot2)
require(qdata)
```

## Linear Models

### Exercise 1

The number of impurities (lumps) present in the containers of paint depends on the rate of agitation applied to the container. A researcher wants to determine the relation between the rate of agitation and the number of lumps, so he conducts an experiment. He applies different rates of agitation (`Stirrate`) to 12 containers of paint and he counts the number of impurities (lumps) present in the containers of paint (`Impurity`).  


```r
data(paint)
head(paint)
```

```
## # A tibble: 6 × 2
##   Stirrate Impurity
##      <int>    <dbl>
## 1       20      8.4
## 2       38     16.5
## 3       36     16.4
## 4       40     18.9
## 5       42     18.5
## 6       26     10.4
```

a. Let us compute the main descriptive statistics of `Impurity`. 



b. Let us graphically represent the relation between `Impurity` and `Stirrate` variables (add regression line to the scatterplot).



c. Let us compute a simple linear regression between `Impurity` and `Stirrate`. 



d. Does `Stirrate` influence `Impurity`? How? Let us analyze the model fitted by using `summary()` function.




e. Let us check (final) models residuals.



### Exercise 2

A pressure switch has a membrane whose thickness (in mm) influences the pressure required to trigger the switch itself. The aim is to determine the thickness of the membrane for which the switch "trig" with a pressure equal to 165 ± 15 KPa. 25 switches with different thickness (`DThickness`) of the membrane was analysed, measuring the pressure at which each switch opens (KPa) (`SetPoint`).


```r
data(switcht)
head(switcht)
```

```
## # A tibble: 6 × 2
##   DThickness SetPoint
##        <dbl>    <dbl>
## 1        0.9  223.523
## 2        0.6  157.131
## 3        0.5  149.307
## 4        0.8  200.146
## 5        0.8  199.974
## 6        0.7  166.919
```

a. Let us compute the descriptive statistics of `SetPoint` variable.



b. Let us graphically represent the relation between `DThickness` and `SetPoint`(add regression line to the graph).



c. Let us compute a linear regression between `DThickness` and `SetPoint` and check the residuals of the fitted model. 



d. Does `DThickness` influences `SetPoint`? Let us analyze the model fitted by using `summary()` function.



e. Let us check (final) models residuals.



