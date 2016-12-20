# Statistical Models with R





\includegraphics[width=3.33in]{images/flow-dtanal} 


Data can be analysed by regression models with R. Regression is an analysis that attempts to determine the strength of the relationship between one dependent variable, $y$, and a series of other changing variables, $x$. 

There are lots of different types of regression models in statistics but R mantains a coherent syntax for the estimation of all of them. Indeed, the common interface to fit a model in R is made of a call to the corresponding function with arguments `formula` and `data`.

The `lm` and `aov` functions are used in R to fit respectively linear regression and analysis of variance model and their syntax is:


```r
linear_model <- lm(formula, data)
anova_model <- aov(formula, data)
```

`formula` argument is a symbolic description of the model to be fitted, which has the form: `response variable ∼ predictor variables`. The variables involved in `formula` should be columns of a dataframe specified in `data` argument.

The resulting object (`linear_model` or `anova_model`) is a list of elements containing information about regression results. This information can be investigated by the following functions:

Expression                    | Description
----------------------------- | -------------
`coef(obj)`                    | regression coefficients
`resid(obj)`                   | residuals
`fitted(obj)`                  | fitted values
`summary(obj)`                 | analysis summary
`predict(obj, newdata = ndat)` | predict for newdata
`deviance(obj)`                | residual sum of squares

Let us see an example of regression analysis.

\clearpage

### Drug Dosage and Reaction Time

In an experiment to investigate the effect of a depressant drug, the reaction times of ten males rats to a certain stimulus were measured after a specified dose of the drug had been administer to each rat. The results were as follows:


```r
require(qdata)
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
require(ggplot2)
pl <- ggplot(data = drug, mapping = aes(x = dose, y=time)) + 
  geom_point() +
  xlab(label = "Dose (mg)") +
  ylab(label = "Reaction Time (secs)")

pl
```

![](10-statistical-models_files/figure-latex/drugplot-1.pdf)<!-- --> 

A simple model for these data might be a straight line, which can be easy superposed to the data scatterplot by:  



```r
pl + geom_smooth(method="lm", se=FALSE) 
```

![](10-statistical-models_files/figure-latex/reg-1.pdf)<!-- --> 

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
predict (fm, newdata = newdata)
```

```
##     1     2     3 
## 0.384 0.480 0.576
```

Note how the `newdata` argument within `predict()` requires an object of class `data.frame`, whose column names have to be equal to the explicative variables names of the model.

\clearpage

For a visual inspection of the suite of residuals plots of the model, the sintax is:


```r
par(mfrow = c(2,2))
plot(fm)
```

![](10-statistical-models_files/figure-latex/lmplot-1.pdf)<!-- --> 

The "Residuals vs Fitted" plot does not show, in this example, any particular pattern. The presence of patterns may suggest that the model is inadequate.
The "Normal Q-Q" plot shows points close to the straight line. If the normal assumption of residuals is not satisfied, points are far from the straight line. The "Normal Q-Q plot" is less reliable on the distribution tails, i.e. points ought be very far from the straight line to suggest that residuals follow a non-normal distribution.
The "Scale location" is similar to the residuals versus fitted values plot, but it uses the square root of the standardized residuals in order to diminish skewness. Like the first plot, there should be no discernable pattern to the plot.
The "Residuals vs Leverage" shows leverage points. Leverage points are those observations, if any, made at extreme or outlying values of the independent variables such that the lack of neighboring observations means that the fitted regression model will pass close to that particular observation. Leverage points fall out the dotted lines.

