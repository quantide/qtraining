# Data Mining with R





\includegraphics[width=3.33in]{images/flow-dtanal} 

Data Mining is the process to discover interesting, previously unknown and potentially useful information from large amounts of data. It is an interdisciplinary field with contributions from many areas, such as statistics, machine learning, information retrieval, pattern recognition and bioinformatics. Data mining is widely used in many domains, such as retail, finance, telecommunication and social media.

R well supports data mining research and projects, providing lots of packages for data minig techniques.

In this chapter we will analize Neural Networks, which is an advanced data mining method.


## Neural Networks

Neural networks tries to artificially simulate the organization and functioning of the human brain structures.
A neural network can be seen as a system capable of giving an answer to a question or provide an output in response to an input. In particular, it takes a set of inputs (explanatory variables), transforms and weights these within a set of hidden units and hidden layers to produce a set of outputs or predictions (that are also transformed).

Usually, neural networks are made up by three layers:

* input layer, that capture of the network input signals
* hidden layer, that transform the inputs into something that the output layer can use 
* output layer, that produces output signals

Next figure is an example of a feed forward neural network consisting of four inputs, a hidden layer that contains three units and an output layer that contains two outputs. The outputs of nodes in one layer are inputs to the next layer. The inputs to each node are combined using a weighted linear combination. The result is then usually modified by a nonlinear function before being output.

\begin{figure}[h]
\includegraphics[width=3.97in]{images/nnet} \caption{Neural Network scheme}(\#fig:g2)
\end{figure}


The R `nnet` package provides `nnet()` function, which fits a single-hidden-layer neural network to data. 


```r
require(nnet)
```

`nnet()` function syntax is very similar to the one used for linear models:


```r
nn_mod <- nnet(formula, data, size)
```

`nnet()` function requires `formula` argument, which is a symbolic description of the model to be fitted, which has the form: `response variable ∼ predictor variables`.
The variables involved in `formula` should be columns of a data frame specified in `data` argument.
Unlike linear model definiton, you have to define `size` argument, which represents the number of units in the hidden layer. 

The resulting object is of `nnet` or `nnet.formula` class and it can be investigated by most of the functions seen for linear model like `summary()`, `predict()`, `coef()` and `resid()`.

### Titanic

Let us see how Neural Network works, considering `titanic` data, included in `qdata` package. `titanic` data contains information about surviving to Titanic wreck along with personal and travel information of the single passengers.


```r
require(qdata)
data(titanic)
head(titanic)
```

```
## # A tibble: 6 × 4
##    Class Gender   Age   Status
##   <fctr> <fctr> <int>   <fctr>
## 1  Coach Female    20 Survived
## 2  Coach Female    21 Survived
## 3  Coach Female    26 Survived
## 4  Coach Female    26     Died
## 5  Coach Female    36 Survived
## 6  Coach Female    41 Survived
```

The aim of study is to find a prediction model to assess the probability of die for each passenger based on its `Age`, `Gender`, and `Class` of accomodation. 

Some tables could help in describing the relations between die probability and explicative variables (`Age`, `Gender`, and `Class`):


```r
require(dplyr)
# frequency table of the counts and percentage of Died and Survived people 
titanic %>% 
  group_by(Status) %>%
  summarise(n = n()) %>%
  mutate(freq = paste(round(n/sum(n)* 100, 2), "%")) 
```

```
## # A tibble: 2 × 3
##     Status     n   freq
##     <fctr> <int>  <chr>
## 1     Died  1490 67.7 %
## 2 Survived   711 32.3 %
```


```r
# frequency table of the counts and percentage of Died and Survived people by Class
titanic %>% 
  group_by(Status, Class) %>%
  summarise(n = n()) %>%
  mutate(freq = paste(round(n/sum(n)* 100, 2), "%"))
```

```
## Source: local data frame [4 x 4]
## Groups: Status [2]
## 
##     Status  Class     n    freq
##     <fctr> <fctr> <int>   <chr>
## 1     Died  Coach  1368 91.81 %
## 2     Died  First   122  8.19 %
## 3 Survived  Coach   508 71.45 %
## 4 Survived  First   203 28.55 %
```


```r
# frequency table of the counts and percentage of Died and Survived people by Gender
titanic %>% 
  group_by(Status, Gender) %>%
  summarise(n= n()) %>%
  mutate(freq = paste(round(n/sum(n)* 100, 2), "%"))
```

```
## Source: local data frame [4 x 4]
## Groups: Status [2]
## 
##     Status Gender     n    freq
##     <fctr> <fctr> <int>   <chr>
## 1     Died Female   126  8.46 %
## 2     Died   Male  1364 91.54 %
## 3 Survived Female   344 48.38 %
## 4 Survived   Male   367 51.62 %
```

The above tables show counts and percentages of died and survived for each combination of Sex and Class factors. Some relations appear, but its interpretation is not really simple.


The following graph shows if some relations exist between Status and Age:


```r
require(ggplot2)
ggplot(data=titanic, mapping=aes(x=Status, y=Age)) +
  geom_boxplot(fill="#74a9cf", colour="#034e7b")+ 
  ggtitle("Box-plot of Age within levels of Status")
```

![](11-data-mining_files/figure-latex/plot_status_age-1.pdf)<!-- --> 

Apparently, a slightly lower age is in survived passengers.

Neural Network method allows us to assess the probability of die for each passenger based on its `Age`, `Gender` and `Class` of accomodation.

Let us divide the data in train and test samples in order to estimate the model on train sample and to test the results on test sample. 


```r
# generate train and test sample 
train <- titanic %>% sample_frac(0.7)
test <- titanic %>% slice(-as.numeric(rownames(train)))
```

Neural Network model estimate on train sample:


```r
nn_mod <- nnet(Status ~ Class + Gender + Age, data = train, size = 3)
```

```
## # weights:  16
## initial  value 997.297049 
## iter  10 value 924.823475
## iter  20 value 792.467557
## iter  30 value 787.742979
## iter  40 value 786.919231
## iter  50 value 785.340304
## iter  60 value 781.830746
## iter  70 value 779.632855
## iter  80 value 778.798058
## iter  90 value 778.208582
## iter 100 value 777.123373
## final  value 777.123373 
## stopped after 100 iterations
```

The predictions on test sample can be gained using `predict()` function:


```r
pr <- predict(object = nn_mod, newdata = test)
head(pr)
```

```
##        [,1]
## 1 0.6471217
## 2 0.6471217
## 3 0.6471217
## 4 0.6471217
## 5 0.6471217
## 6 0.6466071
```

The predictions included the probability of survive in the Titanic wreck according to `Gender`, `Age` and `Class`. We define that probabilities below 0.5 represent `Died` (`TRUE`) and probabilities over 0.5 represent `Survived` (`FALSE`).   


```r
test <- test %>% mutate(pr_mod = pr < .5)
```

Let us see how the performance of the fitted model on the test sample:


```r
test %>% 
  group_by(Status, pr_mod) %>%
  summarise(n = n()) %>%
  mutate(freq = paste(round(n/sum(n)* 100, 2), "%"))
```

```
## Source: local data frame [4 x 4]
## Groups: Status [2]
## 
##     Status pr_mod     n    freq
##     <fctr>  <lgl> <int>   <chr>
## 1     Died  FALSE    81  16.1 %
## 2     Died   TRUE   422  83.9 %
## 3 Survived  FALSE    69 43.95 %
## 4 Survived   TRUE    88 56.05 %
```

We conclude that the model has quite good performance in the prediction of the probability of die in the Titanic wreck according to `Gender`, `Age` and `Class`. 

