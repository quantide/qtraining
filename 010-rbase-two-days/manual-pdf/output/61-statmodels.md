


# Models with R


```r
require(qdata)
require(ggplot2)
require(dplyr)
```


\includegraphics[width=2.94in]{images/flow-dtanal} 

Data can be analysed by regression models with R. Regression is an analysis that attempts to determine the strength of the relationship between one dependent variable, $y$, and a series of other changing variables, $x$. 

There are lots of different types of regression models in statistics but R mantains a coherent syntax for the estimation of all of them. Indeed, the common interface to fit a model in R is made of a call to the corresponding function with arguments `formula` and `data`.

The `lm` and `aov` functions are used in R to fit respectively linear regression and analysis of variance model and their syntax is:


```r
linear_model <- lm(formula, data)
anova_model <- aov(formula, data)
```

`formula` argument is a symbolic description of the model to be fitted, which has the form: `response variable ∼ predictor variables`. The variables involved in `formula` should be columns of a dataframe specied in `data` argument.

The resulting object (`linear_model` or `anova_model`) is a list of elements containing information about regression results. This information can be investigated by the following functions:

Expression                    | Description
----------------------------- | -------------
`coef(obj)`                    | regression coefficients
`resid(obj)`                   | residuals
`fitted(obj)`                  | fitted values
`summary(obj)`                 | analysis summary
`predict(obj, newdata = ndat)` | predict for newdata
`deviance(obj)`                | residual sum of squares

Let us see some examples of regression analisys.

\clearpage

### Drug Dosage and Reaction Time

In an experiment to investigate the effect of a depressant drug, the reaction times of ten males rats to a certain stimulus were measured after a specified dose of the drug had been administer to each rat. The results were as follows:


```r
data(drug)
str(drug)
```

```
## Classes 'tbl_df', 'tbl' and 'data.frame':	10 obs. of  3 variables:
##  $ rat : int  1 2 3 4 5 6 7 8 9 10
##  $ dose: num  0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9
##  $ time: num  0.32 0.24 0.4 0.52 0.44 0.56 0.64 0.52 0.6 0.8
```

Basic graphical data exploration may be achieved with: 


```r
pl_1 <- ggplot(data = drug, mapping = aes(x = dose, y=time)) + 
  geom_point() +
  xlab(label = "Dose (mg)") +
  ylab(label = "Reaction Time (secs)")

pl_1
```

![](61-statmodels_files/figure-latex/drugplot-1.pdf)<!-- --> 

A simple model for these data might be a straight line, which can be easy superposed to the data scatterplot by:  



```r
pl_1 + geom_smooth(method="lm", se=FALSE) 
```

![](61-statmodels_files/figure-latex/reg-1.pdf)<!-- --> 

The R command to fit a simple linear model is:


```r
fm <- lm(formula = time ~ dose, data = drug)
```

As we said, `fm` object is a list of elements containing information about regression results.   

Regression results can be investigated by generic function `summary()`, which includes the most important elements for model interpretation.


```r
summary(fm)
```

```
## 
## Call:
## lm(formula = time ~ dose, data = drug)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -0.104 -0.064  0.024  0.056  0.088 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  0.28800    0.04522   6.368 0.000216 ***
## dose         0.48000    0.08471   5.666 0.000472 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.07694 on 8 degrees of freedom
## Multiple R-squared:  0.8005,	Adjusted R-squared:  0.7756 
## F-statistic: 32.11 on 1 and 8 DF,  p-value: 0.0004724
```

Small p-values for t-test on coefficients lead to consider both coefficients as significant. Adjust R-squared equal to 0.78 shows an acceptable portion of total variation explained by the regression model.

Small p-value for F-statistic confirm fitted model significance when compared with null model (model only with intercept).


You can also visualize single elements of `fm` list.  
For example: 


```r
# regression coefficients
coef(fm)
```

```
## (Intercept)        dose 
##       0.288       0.480
```

```r
# residuals
resid(fm)
```

```
##      1      2      3      4      5      6      7      8      9     10 
##  0.032 -0.096  0.016  0.088 -0.040  0.032  0.064 -0.104 -0.072  0.080
```

```r
# fitted values
fitted(fm)
```

```
##     1     2     3     4     5     6     7     8     9    10 
## 0.288 0.336 0.384 0.432 0.480 0.528 0.576 0.624 0.672 0.720
```

Prediction for response variable at specific values of the explanatories variable can be gained using `predict()` function with the following sintax:


```r
newdata <- data.frame(dose = c(0.2, 0.4, 0.6 ))
predict (fm , newdata = newdata)
```

```
##     1     2     3 
## 0.384 0.480 0.576
```

Note how the `newdata` argument within `predict()` requires an object of class `data.frame`, whose column names have to be equal to the explicative variables names of the model.


For a visual inspection of the suite of residuals plots of the model, the sintax is:


```r
par(mfrow = c(2,2))
plot(fm)
```

![](61-statmodels_files/figure-latex/lmplot-1.pdf)<!-- --> 

The "Residuals vs Fitted" plot does not show, in this example, any particular pattern. The presence of patterns may suggest that the model is inadequate.
The "Normal Q-Q" plot shows points close to the straight line. If the normal assumption of residuals is not satisfied, points are far from the straight line. The "Normal Q-Q plot" is less reliable on the distribution tails, i.e. points ought be very far from the straight line to suggest that residuals follow a non-normal distribution.
The "Scale location" is similar to the residuals versus fitted values plot, but it uses the square root of the standardized residuals in order to diminish skewness. Like the first plot, there should be no discernable pattern to the plot.
The "Residuals vs Leverage" shows leverage points. Leverage points are those observations, if any, made at extreme or outlying values of the independent variables such that the lack of neighboring observations means that the fitted regression model will pass close to that particular observation. Leverage points fall out the dotted lines.


### Car Seat

Three quality inspectors are studying the reproducibility of a measurement method aiming to test resistance of a specific material used to cover car seats.
As a result, an experiments involving 75 samples of material from the same batch is set up. Three operators: Kevin, Michelle and Rob are assigned to test 25 samples each.

Comparison of operators average measurements and within operators variations are the key points of the analysis.


```r
data(carseat)
str(carseat)
```

```
## Classes 'tbl_df', 'tbl' and 'data.frame':	75 obs. of  2 variables:
##  $ Operator: Factor w/ 3 levels "Kevin","Michelle",..: 2 2 2 2 2 2 2 2 2 2 ...
##  $ Strength: num  11.3 10.6 10.4 10.2 10.4 ...
```

Boxplot of _Strength by Operator_ along with within operators averages can be display by:


```r
require(dplyr)
```


```r
# Data frame of Strength means for each Operator
means_df <- carseat %>% group_by(Operator) %>% summarize(mean=mean(Strength))

pl_2 <- ggplot(data = carseat, mapping = aes(x=Operator, y=Strength)) +
  geom_boxplot(fill = "lightgray", outlier.colour = "blue") +
  geom_point(data=means_df, mapping = aes(x=Operator, y=mean), colour="red", shape=18, size=3) + 
  xlab(label = "Operator") + ylab(label = "Resistance")

pl_2
```

![](61-statmodels_files/figure-latex/carseatplot-1.pdf)<!-- --> 

At first glance, difference between operators is hard to detect as within variation seems to be quite large. 

A simple one way analysis of variance model is computed with: 


```r
fm <- aov(Strength~Operator, data = carseat)
```

Results are shown with the usual `summary()` method.


```r
summary(fm)
```

```
##             Df Sum Sq Mean Sq F value Pr(>F)  
## Operator     2   6.62    3.31   3.851 0.0258 *
## Residuals   72  61.90    0.86                 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

Operators appears to be borderline significant as its F test p-value is 0.0258. That is, not a real difference exists between operators measurements methods.


Finally, normality of residuals can be checked by:

```r
par(mfrow = c(1,2))
plot(fm, which = 1:2)
```

![](61-statmodels_files/figure-latex/residualscarseat-1.pdf)<!-- --> 

Despite a small departure from normality on the rigth side of the residuals distribution, model assumptions seem to confirm.

\clearpage

### Boiling Time

In an attempt to resolve a domestic dispute about which of two pans was the quicker pan for cooking, the following data were obtained:


```r
data(boiling)
str(boiling)
```

```
## Classes 'tbl_df', 'tbl' and 'data.frame':	6 obs. of  3 variables:
##  $ time  : num  4.65 9.75 15.05 4.75 10.15 ...
##  $ pan   : Factor w/ 2 levels "A","B": 1 1 1 2 2 2
##  $ volume: num  1 3 5 1 3 5
```

Various measured volumes (pints) of cold water were put into each pan and heated using the same setting of the cooker. The response variable was the time in minutes until the water boiled.

From a first visual investigation, it's easy to understand that differences in boling time means difference either in intercept or slope between the two lines:


```r
pl_3 <- ggplot(data = boiling, mapping = aes(x=volume, y=time, colour=pan)) + 
  geom_line() + geom_point()

pl_3
```

![](61-statmodels_files/figure-latex/boilingxyplot-1.pdf)<!-- --> 


The natural candidate for this problem is the Gamma distibution as it doesn't assume negative value (boiling time cannot be negative) and it respect the increasing relationship between mean and variance.

A generalized linear model with family Gamma and link identity can be used:


```r
fm_5 <- glm(time ~ pan*volume, data = boiling,
  family = Gamma(link = "identity"))
summary(fm_5) 
```

```
## 
## Call:
## glm(formula = time ~ pan * volume, family = Gamma(link = "identity"), 
##     data = boiling)
## 
## Deviance Residuals: 
##          1           2           3           4           5           6  
##  0.0014711  -0.0062328   0.0047405  -0.0003524   0.0015024  -0.0011512  
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)    
## (Intercept) 2.0592378  0.0394407  52.211 0.000367 ***
## panB        0.0008908  0.0565096   0.016 0.988854    
## volume      2.5839284  0.0194681 132.726 5.68e-05 ***
## panB:volume 0.1076174  0.0279858   3.845 0.061457 .  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for Gamma family taken to be 3.355215e-05)
## 
##     Null deviance: 1.3170e+00  on 5  degrees of freedom
## Residual deviance: 6.7191e-05  on 2  degrees of freedom
## AIC: -15.087
## 
## Number of Fisher Scoring iterations: 3
```

