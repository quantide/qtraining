---
title: "Classification Trees (CTREE)"
---






# Introduction

Decision Tree is one of the commonly used exploratory data analysis and objective segmentation techniques.  
Great advantage with Decision Tree is that its output is relatively easy to understand or interpret.  
Tree-based methods can be used for both regression and classification
problems. These involve stratifying or segmenting the predictors' space into a
number of simple regions. A prediction for a given observation is then
obtained by typically using the mean or the mode of the training
observations in the region to which it belongs.

A simple way to understand decision tree is that it is a hierarchical approach to partition the input data:
at each node (step) one independent variable and one of its values, is used for the partition.  
<!--- If we are working on an objective segmentation problem, our aim is to find conditions which help us finding
a segment which is very similar on target variable value.  
For example, when customer applies for a credit card, the bank or credit card provider accepts or rejects
the application based on predicted risk -probability of default- for the application. 
For building rules for predicting the risk from a credit card application, we can use Decision Tree. The
decision tree can help in finding out the segments which have a low risk (default probability).  --->

A classification tree (CT) is used to predict a qualitative response. In
CTs the prediction for an observation generally corresponds to the most
commonly occurring class of training observations in the region to which it 
belongs. In interpreting the results of a classification tree, we are
typically interested in the class prediction corresponding to a particular
terminal node region, but also in the class proportions among the training
observations that fall into that region.

The building of a tree is usually produced in two phases: _growth_ and _pruning_.

To grow a classification tree, a binary splitting is used.
To split the nodes, the minimum "within-node variability" is searched; the
"variability" is usually measured with two alternative indices:

- the Gini index, which provides a measure of the total uncertainty across the k
  classes; it is often referred to as a measure of node "purity", because a
  small value indicates that a node contains predominantly observations from
  a single class.

- the cross-entropy, which, like the Gini index, takes on a small value if a
  node is pure.

For "pruning" the tree, the
classification error rate is mostly used, if prediction accuracy is the goal.  

To increase predictive accuracy, multiple tress can be combined to yield a
single consensus prediction. Bagging, random forests, and boosting (not shown here) are some
approaches that implement such a strategy. The price to pay for the
increased accuracy is some loss in interpretation.

There are a number of `R` packages with functions for building single
classification trees. One of the most popular is `rpart`. 

We now illustrate this package using some examples.

## Example: Iris Data

In this example we will try to simply introduce the tree-building process.  
The aim of this example is to predict the correct specie of iris flowers given their
length and width measures for petals and sepals.  
Let's start with an "almost non pruned" tree:


```r
require(pROC)
require(caret)
require(rpart)
set.seed(123456)

str(iris)
```

```
## 'data.frame':	150 obs. of  5 variables:
##  $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
##  $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
##  $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
##  $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
##  $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...
```

```r
head(iris)
```

```
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
## 3          4.7         3.2          1.3         0.2  setosa
## 4          4.6         3.1          1.5         0.2  setosa
## 5          5.0         3.6          1.4         0.2  setosa
## 6          5.4         3.9          1.7         0.4  setosa
```

```r
iris_rp <- rpart(Species ~ ., method = "class", data = iris,
								 control = rpart.control(minsplit = 4, cp = 0.000001))
```

We can control the rules and splits using `control` option in `rpart` algorithm.
For example, the minimum number of observations for a node to be considered for a split is given by
using `minsplit`. Minimum observations for a child node to consider a rule for node
split is given by using `minbucket`.  
Now we print the contents of produced tree:


```r
# Print the object
print(iris_rp)
```

```
## n= 150 
## 
## node), split, n, loss, yval, (yprob)
##       * denotes terminal node
## 
##  1) root 150 100 setosa (0.33333333 0.33333333 0.33333333)  
##    2) Petal.Length< 2.45 50   0 setosa (1.00000000 0.00000000 0.00000000) *
##    3) Petal.Length>=2.45 100  50 versicolor (0.00000000 0.50000000 0.50000000)  
##      6) Petal.Width< 1.75 54   5 versicolor (0.00000000 0.90740741 0.09259259)  
##       12) Petal.Length< 4.95 48   1 versicolor (0.00000000 0.97916667 0.02083333)  
##         24) Petal.Width< 1.65 47   0 versicolor (0.00000000 1.00000000 0.00000000) *
##         25) Petal.Width>=1.65 1   0 virginica (0.00000000 0.00000000 1.00000000) *
##       13) Petal.Length>=4.95 6   2 virginica (0.00000000 0.33333333 0.66666667)  
##         26) Petal.Width>=1.55 3   1 versicolor (0.00000000 0.66666667 0.33333333) *
##         27) Petal.Width< 1.55 3   0 virginica (0.00000000 0.00000000 1.00000000) *
##      7) Petal.Width>=1.75 46   1 virginica (0.00000000 0.02173913 0.97826087) *
```
In above output a summary of splitting procedure is shown:

1. At first step, the "root only" tree is evaluated;
2. At the second step, the procedure scans all the variables looking for the partition that maximally reduces the chosen "variabiliy" measure (Gini index or Entropy measure) on the dependent variable; then the predictor ("feature") that minimizes the variability, with its partition, is used as first "branch" (in this case, `Petal.Length` with threshold equal to 2.45), and the data set is splitted in two subsets;
3. At the third step, at each subset the procedure scans again all the variables looking for the partition that minimizes the "variabiliy" measure on the dependent variable, and then retains the predictor ("feature") that maximally reduces the variability, with its partition (`Petal.Width` and 1.75); then the sub-dataset is again splitted;
4. And so on ....

Below a detailed summary of tree is reported:

```r
# Detailed summary
summary(iris_rp)
```

```
## Call:
## rpart(formula = Species ~ ., data = iris, method = "class", control = rpart.control(minsplit = 4, 
##     cp = 1e-06))
##   n= 150 
## 
##        CP nsplit rel error xerror       xstd
## 1 5.0e-01      0      1.00   1.15 0.05180090
## 2 4.4e-01      1      0.50   0.58 0.05964338
## 3 2.0e-02      2      0.06   0.09 0.02908608
## 4 1.0e-02      3      0.04   0.09 0.02908608
## 5 1.0e-06      5      0.02   0.09 0.02908608
## 
## Variable importance
##  Petal.Width Petal.Length Sepal.Length  Sepal.Width 
##           34           32           20           14 
## 
## Node number 1: 150 observations,    complexity param=0.5
##   predicted class=setosa      expected loss=0.6666667  P(node) =1
##     class counts:    50    50    50
##    probabilities: 0.333 0.333 0.333 
##   left son=2 (50 obs) right son=3 (100 obs)
##   Primary splits:
##       Petal.Length < 2.45 to the left,  improve=50.00000, (0 missing)
##       Petal.Width  < 0.8  to the left,  improve=50.00000, (0 missing)
##       Sepal.Length < 5.45 to the left,  improve=34.16405, (0 missing)
##       Sepal.Width  < 3.35 to the right, improve=19.03851, (0 missing)
##   Surrogate splits:
##       Petal.Width  < 0.8  to the left,  agree=1.000, adj=1.00, (0 split)
##       Sepal.Length < 5.45 to the left,  agree=0.920, adj=0.76, (0 split)
##       Sepal.Width  < 3.35 to the right, agree=0.833, adj=0.50, (0 split)
## 
## Node number 2: 50 observations
##   predicted class=setosa      expected loss=0  P(node) =0.3333333
##     class counts:    50     0     0
##    probabilities: 1.000 0.000 0.000 
## 
## Node number 3: 100 observations,    complexity param=0.44
##   predicted class=versicolor  expected loss=0.5  P(node) =0.6666667
##     class counts:     0    50    50
##    probabilities: 0.000 0.500 0.500 
##   left son=6 (54 obs) right son=7 (46 obs)
##   Primary splits:
##       Petal.Width  < 1.75 to the left,  improve=38.969400, (0 missing)
##       Petal.Length < 4.75 to the left,  improve=37.353540, (0 missing)
##       Sepal.Length < 6.15 to the left,  improve=10.686870, (0 missing)
##       Sepal.Width  < 2.45 to the left,  improve= 3.555556, (0 missing)
##   Surrogate splits:
##       Petal.Length < 4.75 to the left,  agree=0.91, adj=0.804, (0 split)
##       Sepal.Length < 6.15 to the left,  agree=0.73, adj=0.413, (0 split)
##       Sepal.Width  < 2.95 to the left,  agree=0.67, adj=0.283, (0 split)
## 
## Node number 6: 54 observations,    complexity param=0.02
##   predicted class=versicolor  expected loss=0.09259259  P(node) =0.36
##     class counts:     0    49     5
##    probabilities: 0.000 0.907 0.093 
##   left son=12 (48 obs) right son=13 (6 obs)
##   Primary splits:
##       Petal.Length < 4.95 to the left,  improve=4.4490740, (0 missing)
##       Sepal.Length < 7.1  to the left,  improve=1.6778480, (0 missing)
##       Petal.Width  < 1.35 to the left,  improve=0.9971510, (0 missing)
##       Sepal.Width  < 2.65 to the right, improve=0.2500139, (0 missing)
## 
## Node number 7: 46 observations
##   predicted class=virginica   expected loss=0.02173913  P(node) =0.3066667
##     class counts:     0     1    45
##    probabilities: 0.000 0.022 0.978 
## 
## Node number 12: 48 observations,    complexity param=0.01
##   predicted class=versicolor  expected loss=0.02083333  P(node) =0.32
##     class counts:     0    47     1
##    probabilities: 0.000 0.979 0.021 
##   left son=24 (47 obs) right son=25 (1 obs)
##   Primary splits:
##       Petal.Width  < 1.65 to the left,  improve=1.95833300, (0 missing)
##       Sepal.Length < 4.95 to the right, improve=0.95833330, (0 missing)
##       Sepal.Width  < 2.55 to the right, improve=0.10119050, (0 missing)
##       Petal.Length < 4.45 to the left,  improve=0.06359649, (0 missing)
## 
## Node number 13: 6 observations,    complexity param=0.01
##   predicted class=virginica   expected loss=0.3333333  P(node) =0.04
##     class counts:     0     2     4
##    probabilities: 0.000 0.333 0.667 
##   left son=26 (3 obs) right son=27 (3 obs)
##   Primary splits:
##       Petal.Width  < 1.55 to the right, improve=1.3333330, (0 missing)
##       Sepal.Width  < 2.65 to the right, improve=0.6666667, (0 missing)
##       Petal.Length < 5.35 to the left,  improve=0.6666667, (0 missing)
##       Sepal.Length < 6.95 to the left,  improve=0.2666667, (0 missing)
##   Surrogate splits:
##       Sepal.Length < 6.5  to the right, agree=0.833, adj=0.667, (0 split)
##       Sepal.Width  < 2.65 to the right, agree=0.833, adj=0.667, (0 split)
## 
## Node number 24: 47 observations
##   predicted class=versicolor  expected loss=0  P(node) =0.3133333
##     class counts:     0    47     0
##    probabilities: 0.000 1.000 0.000 
## 
## Node number 25: 1 observations
##   predicted class=virginica   expected loss=0  P(node) =0.006666667
##     class counts:     0     0     1
##    probabilities: 0.000 0.000 1.000 
## 
## Node number 26: 3 observations
##   predicted class=versicolor  expected loss=0.3333333  P(node) =0.02
##     class counts:     0     2     1
##    probabilities: 0.000 0.667 0.333 
## 
## Node number 27: 3 observations
##   predicted class=virginica   expected loss=0  P(node) =0.02
##     class counts:     0     0     3
##    probabilities: 0.000 0.000 1.000
```
And finally we produce a graph representing the tree:


```r
plot(iris_rp, uniform = TRUE)
text(iris_rp)
```

![plot of chunk iris_4](figure/iris_4-1.png)



To better read the dendrogram there are lot of options:


```r
plot(iris_rp, uniform = TRUE, compress = TRUE, margin = 0.2, branch = 0.3)
text(iris_rp, use.n = TRUE, digits = 3, cex = 0.6)
```

![plot of chunk bp1](figure/bp1-1.png)

If we want to see the labels of a dendrogram object created by `rpart`, we can use `labels()`:


```r
labels(iris_rp)
```

```
##  [1] "root"               "Petal.Length< 2.45" "Petal.Length>=2.45" "Petal.Width< 1.75" 
##  [5] "Petal.Length< 4.95" "Petal.Width< 1.65"  "Petal.Width>=1.65"  "Petal.Length>=4.95"
##  [9] "Petal.Width>=1.55"  "Petal.Width< 1.55"  "Petal.Width>=1.75"
```

To see how the feature (i.e., predictor variables) space has been partitioned in this example, we produce the following graph:


```r
require(ggplot2)
```


```r
ggp <- ggplot(data = iris)
ggp <- ggp + geom_point(aes(x = Petal.Length, y = Petal.Width, colour = Species))
ggp <- ggp + geom_vline(xintercept = 2.45, linetype = 2)
ggp <- ggp + geom_segment(x = 2.45, y = 1.75, xend = max(iris$Petal.Length)*2,yend = 1.75, linetype = 2)
ggp <- ggp + geom_segment(x = 4.95, y = min(iris$Petal.Width)*-2, xend = 4.95,yend = 1.75, linetype = 2)
ggp <- ggp + geom_segment(x = 2.45, y = 1.65, xend = 4.95, yend = 1.65, linetype = 2)
ggp <- ggp + geom_segment(x = 4.95, y = 1.55, xend = max(iris$Petal.Length)*2,yend = 1.55, lty = 2)
ggp <- ggp + ggtitle("Partitions with respect to Petal.Length and Petal.Width" )
ggp
```

![plot of chunk bq](figure/bq-1.png)

An important concept in tree-based methods is that of pruning: it allows
to avoid overfitting. It is important to:

   - ensure that the tree is small enough to avoid putting random
     variation into predictions,
   - ensure that the tree is large enough to avoid putting systematic biases
     into predictions.

To prune the tree, `rpart` uses the complexity measure $R(\alpha)$:  
$R(\alpha) = R + \alpha \cdot T$  
where

 - $R$ is the "tree risk" (for classification: the misclassification error;
    for regression: RSS);
 - $\alpha$ is the complexity parameter which is a penalty term that controls
    the size of the tree;
 - $T$ is the number of splits/terminal nodes in tree

When $\alpha$ grows, the tree with minimum $R(\alpha)$ is a smaller subtree of original one.  
When $\alpha$ grows, the sequence of subtrees is nested.  
Thus, each subtree is linked to a value of complexity parameter $\alpha$ for which we can accept the
subtree as the "minimum complexity" one.  

The following code prints a table of optimal pruning based on a complexity parameter:


```r
printcp(iris_rp)
```

```
## 
## Classification tree:
## rpart(formula = Species ~ ., data = iris, method = "class", control = rpart.control(minsplit = 4, 
##     cp = 1e-06))
## 
## Variables actually used in tree construction:
## [1] Petal.Length Petal.Width 
## 
## Root node error: 100/150 = 0.66667
## 
## n= 150 
## 
##        CP nsplit rel error xerror     xstd
## 1 5.0e-01      0      1.00   1.15 0.051801
## 2 4.4e-01      1      0.50   0.58 0.059643
## 3 2.0e-02      2      0.06   0.09 0.029086
## 4 1.0e-02      3      0.04   0.09 0.029086
## 5 1.0e-06      5      0.02   0.09 0.029086
```

In above table:

- `CP` is the $\alpha$ parameter; 
- `nsplit` is the number of splits of best tree found based on `CP`;
- `rel error` is the relative (resubstitution) prediction error of the selected tree with respect to the "root only" tree; the resubstitution error is calculated on the same data where the tree has been trained.
- `xerror` is the cross-validation error, obtained by splitting the data in `xval` subsets, applying the training procedure iteratively on data where one of the subsets is removed, and then predicting on the removed subset; `xerror` is the mean of `xval` obtained cross-validation errors
- `xstd` is the standard deviation of error estimated via cross-validation

The simplest tree with the lowest cross-validated error rate (xerror) is number 3.  
The tree yielding the minimum resubstitution error rate is tree number 5.  
The largest tree will always yield the lowest resubstitution error rate.  

Two are the criterions used to decide the amoount of tree pruning:

- The tree with lowest cross-validation error
- The smallest tree with cross-validation error less than the minimum cross-validation error plus one time its standard deviation.  

A plot of the resubstitution error rate for the tree is obtained by:


```r
ggp <- ggplot(data = data.frame(iris_rp$cptable, Tree.number = 1:nrow(iris_rp$cptable)), mapping = aes(x = Tree.number, y = rel.error))
ggp <- ggp + geom_line()
ggp <- ggp + geom_point()
ggp
```

![plot of chunk bs](figure/bs-1.png)

The plot of the cross-validation error rate is instead obtained with:


```r
plotcp(iris_rp)
```

![plot of chunk bt](figure/bt-1.png)

As already noted, the simplest tree with the lowest `xerror` value is tree number 3.  
Notice that the values in abscissa are different from the ones in CP table: graph cp values are calculate as the geometric mean of adjacent values of CP table.

The following code shows how to extract interactively subtrees from a given tree:


```r
plot(iris_rp, uniform = TRUE)
text(iris_rp)
iris_rp1 <- snip.rpart(iris_rp)
plot(iris_rp1)
text(iris_rp1)
```

This is the code for a quick plot of errors with legends:


```r
plotcp(iris_rp)
with(iris_rp, {
	lines(cptable[, 2] + 1, cptable[ , 3], type = "b", col = "red")
	legend("topright", c("Resub. Error", "CV Error", "min(CV Error) + 1se"),
				 lty = c(1, 1, 2), col = c("red", "black", "black"), bty = "n")
})
```

![plot of chunk bv](figure/bv-1.png)

And here is the custom-pruned tree for `cp=0.094` (near to the first tree with minimum xerror rate):


```r
iris.pruned <- prune(iris_rp, cp=0.094)
plot(iris.pruned, compress = TRUE, margin = 0.2, branch = 0.3)
text(iris.pruned, use.n = TRUE, digits = 3, cex = 0.8)
```

![plot of chunk bw](figure/bw-1.png)

Finally, the partition of the feature space for the pruned tree:


```r
ggp <- ggplot(data = iris)
ggp <- ggp + geom_point(aes(x = Petal.Length, y = Petal.Width, colour = Species))
ggp <- ggp + geom_vline(xintercept = 2.45, linetype = 2)
ggp <- ggp + geom_segment(x = 2.45, y = 1.75, xend = max(iris$Petal.Length)*2,yend = 1.75, linetype = 2)
ggp <- ggp + ggtitle("Partitions with respect to Petal.Length and Petal.Width for the pruned tree")
ggp
```

![plot of chunk bx](figure/bx-1.png)

The predictions for new data from a tree are then obtained, as usual, with the `predict()` method:


```r
iris_pred <- predict(iris.pruned, type = "class")
```

The corresponding confusion matrix is obtained simply as


```r
table(iris_pred, iris$Species)
```

```
##             
## iris_pred    setosa versicolor virginica
##   setosa         50          0         0
##   versicolor      0         49         5
##   virginica       0          1        45
```

Or, using `confusionMatrix()`:

```r
confusionMatrix(data = iris_pred, reference = iris$Species)
```

```
## Confusion Matrix and Statistics
## 
##             Reference
## Prediction   setosa versicolor virginica
##   setosa         50          0         0
##   versicolor      0         49         5
##   virginica       0          1        45
## 
## Overall Statistics
##                                          
##                Accuracy : 0.96           
##                  95% CI : (0.915, 0.9852)
##     No Information Rate : 0.3333         
##     P-Value [Acc > NIR] : < 2.2e-16      
##                                          
##                   Kappa : 0.94           
##  Mcnemar's Test P-Value : NA             
## 
## Statistics by Class:
## 
##                      Class: setosa Class: versicolor Class: virginica
## Sensitivity                 1.0000            0.9800           0.9000
## Specificity                 1.0000            0.9500           0.9900
## Pos Pred Value              1.0000            0.9074           0.9783
## Neg Pred Value              1.0000            0.9896           0.9519
## Prevalence                  0.3333            0.3333           0.3333
## Detection Rate              0.3333            0.3267           0.3000
## Detection Prevalence        0.3333            0.3600           0.3067
## Balanced Accuracy           1.0000            0.9650           0.9450
```

## Example: German Credit Data

Let's consider the `german` dataset, which deals with German credit data (see the section *Introduction and datasets used* for further information).  
In this case we wanto to predict if a customer will default (Bad) or will pay (Good) on the credit card.
So, we have an input data which has both good and bad customers. We want to find out the rules or conditions which separate Good Customers from bad customers. 
The rule(s) should help you find out the segments with significantly higher percentage of good customers.


```r
table(german$Class)
```

```
## 
## Good  Bad 
##  700  300
```

We first split the sample into training and test sets, to allow the test on tree:


```r
set.seed(20)
sel <- sample(1:1000, size = 600, replace = FALSE)
train <- german[sel, ]
test <- german[setdiff(1:1000, sel), ]
table(train$Class)
```

```
## 
## Good  Bad 
##  425  175
```

```r
table(test$Class)
```

```
## 
## Good  Bad 
##  275  125
```

We then begin the analysis building the tree without any other specifications:


```r
set.seed(20)
modelg0 <- rpart(Class ~ ., data = train, cp = 0)
plotcp(modelg0)
```

![plot of chunk cj_1](figure/cj_1-1.png)


```r
plot(modelg0)
text(modelg0)
```

![plot of chunk cj_2](figure/cj_2-1.png)

Now, we try to see te ROC curve for the tree:


```r
probs <- predict(modelg0, newdata = test, type = "prob")[,1] 
roc(response = (test$Class=="Bad"), predictor = probs, auc = TRUE, ci = TRUE,
	plot = TRUE, main = "ROC curve on German Credit", legacy.axes = TRUE)
```

![plot of chunk gc_ROC1](figure/gc_ROC1-1.png)

```
## 
## Call:
## roc.default(response = (test$Class == "Bad"), predictor = probs,     auc = TRUE, ci = TRUE, plot = TRUE, main = "ROC curve on German Credit",     legacy.axes = TRUE)
## 
## Data: probs in 275 controls ((test$Class == "Bad") FALSE) > 125 cases ((test$Class == "Bad") TRUE).
## Area under the curve: 0.7037
## 95% CI: 0.6481-0.7593 (DeLong)
```

We can now check the tree performaces on train data 

```r
train$pred <- predict(modelg0, newdata = train, type = "class") 
table(train$pred, train$Class)
```

```
##       
##        Good Bad
##   Good  392  52
##   Bad    33 123
```

```r
confusionMatrix(data = train$pred, reference = train$Class, positive = "Bad")
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction Good Bad
##       Good  392  52
##       Bad    33 123
##                                           
##                Accuracy : 0.8583          
##                  95% CI : (0.8278, 0.8852)
##     No Information Rate : 0.7083          
##     P-Value [Acc > NIR] : < 2e-16         
##                                           
##                   Kappa : 0.6458          
##  Mcnemar's Test P-Value : 0.05089         
##                                           
##             Sensitivity : 0.7029          
##             Specificity : 0.9224          
##          Pos Pred Value : 0.7885          
##          Neg Pred Value : 0.8829          
##              Prevalence : 0.2917          
##          Detection Rate : 0.2050          
##    Detection Prevalence : 0.2600          
##       Balanced Accuracy : 0.8126          
##                                           
##        'Positive' Class : Bad             
## 
```

And then to check the tree performaces on test data 

```r
test$pred <- predict(modelg0, newdata = test, type = "class") 
table(test$pred, test$Class)
```

```
##       
##        Good Bad
##   Good  232  65
##   Bad    43  60
```

```r
confusionMatrix(data = test$pred, reference = test$Class, positive = "Bad")
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction Good Bad
##       Good  232  65
##       Bad    43  60
##                                           
##                Accuracy : 0.73            
##                  95% CI : (0.6836, 0.7729)
##     No Information Rate : 0.6875          
##     P-Value [Acc > NIR] : 0.03625         
##                                           
##                   Kappa : 0.34            
##  Mcnemar's Test P-Value : 0.04331         
##                                           
##             Sensitivity : 0.4800          
##             Specificity : 0.8436          
##          Pos Pred Value : 0.5825          
##          Neg Pred Value : 0.7811          
##              Prevalence : 0.3125          
##          Detection Rate : 0.1500          
##    Detection Prevalence : 0.2575          
##       Balanced Accuracy : 0.6618          
##                                           
##        'Positive' Class : Bad             
## 
```

As expected, the performances of tree in test data are poor with respect to train data.
We now try to prune the tree at cp = 0.031 (the cp with minimum xval error in graph), to
see if some overfitting occurred.


```r
modelg0 <- prune(modelg0, cp = 0.031)
plot(modelg0)
text(modelg0)
```

![plot of chunk ck](figure/ck-1.png)

Now we can check the tree using the test sample


```r
test$pred <- predict(modelg0, newdata = test, type = "class") 
table(test$pred, test$Class)
```

```
##       
##        Good Bad
##   Good  255  89
##   Bad    20  36
```

```r
confusionMatrix(data = test$pred, reference = test$Class, positive = "Bad")
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction Good Bad
##       Good  255  89
##       Bad    20  36
##                                          
##                Accuracy : 0.7275         
##                  95% CI : (0.681, 0.7706)
##     No Information Rate : 0.6875         
##     P-Value [Acc > NIR] : 0.04597        
##                                          
##                   Kappa : 0.2534         
##  Mcnemar's Test P-Value : 7.356e-11      
##                                          
##             Sensitivity : 0.2880         
##             Specificity : 0.9273         
##          Pos Pred Value : 0.6429         
##          Neg Pred Value : 0.7413         
##              Prevalence : 0.3125         
##          Detection Rate : 0.0900         
##    Detection Prevalence : 0.1400         
##       Balanced Accuracy : 0.6076         
##                                          
##        'Positive' Class : Bad            
## 
```

By reducing the tree complexity, the performances change. If the global accuracy reduces only a few,
the number of Bad customers actually found by the tree reduces too. Also, the specificity grows
while the sensitivity reduces.

The above results might depend from the fact that the tree gives same "importance" to Bad and Good customers. This is 
not really correct, because the loss for a misclassified Bad customer is greater than the loss due to 
a misclassified Good customer.

To overtake this problem we can build the tree giving different loss values to
the two types of misclassification errors, and then giving more "weight"" to
misclassified `Bad` customers.
We then set a loss matrix, where we assign a loss of 5 for
misclassified Bad customers and a loss of 1 for misclassified Good customers.


```r
# Reset previous predictions
train$pred <- NULL
train$pred <- NULL
# Set Loss matrix
(lmat <- matrix(c(0, 1, 5, 0), byrow = TRUE, nrow = 2))
```

```
##      [,1] [,2]
## [1,]    0    1
## [2,]    5    0
```

```r
# Grows the tree
modelg1 <- rpart(Class ~ ., parms = list(loss = lmat), data = train, cp = 0)
# CP table
printcp(modelg1)
```

```
## 
## Classification tree:
## rpart(formula = Class ~ ., data = train, parms = list(loss = lmat), 
##     cp = 0)
## 
## Variables actually used in tree construction:
##  [1] AgeYears            CreditHistory       Duration            EmployedSince       NumberOfCredits    
##  [6] OtherBebtorsGarants OtherInstallPlans   Property            Purpose             SavingsAccountBonds
## [11] StatusAccount       StatusAndSex       
## 
## Root node error: 425/600 = 0.70833
## 
## n= 600 
## 
##           CP nsplit rel error xerror    xstd
## 1  0.1552941      0   1.00000 5.0000 0.13098
## 2  0.1058824      1   0.84471 2.6024 0.13654
## 3  0.0376471      2   0.73882 2.8871 0.13995
## 4  0.0247059      3   0.70118 2.5506 0.13650
## 5  0.0164706      6   0.61882 2.5812 0.13662
## 6  0.0105882      9   0.56471 2.4259 0.13433
## 7  0.0086275     11   0.54353 2.4541 0.13455
## 8  0.0078431     16   0.49176 2.4424 0.13439
## 9  0.0070588     19   0.46824 2.4306 0.13382
## 10 0.0041176     21   0.45412 2.4024 0.13318
## 11 0.0000000     27   0.42353 2.2353 0.12986
```

```r
plotcp(modelg1)
```

![plot of chunk cm_1](figure/cm_1-1.png)


```r
# Tree
plot(modelg1, uniform = FALSE, compress = TRUE, margin = 0.1, branch = 0.1)
text(modelg1, use.n = TRUE, digits = 3, cex = 0.6)
```

![plot of chunk cm_2](figure/cm_2-1.png)

Notice that the minimum xerror tree is the one with CP parameter equal to 0.  
This means that no pruning should be applied to tree without potentially loose in 
predictive power of tree.


```r
require(rpart.plot) # provides alternative ways to plot the tree
rpart.plot(modelg1)
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2-1.png)

```r
print(modelg1)
```

```
## n= 600 
## 
## node), split, n, loss, yval, (yprob)
##       * denotes terminal node
## 
##    1) root 600 425 Bad (0.70833333 0.29166667)  
##      2) StatusAccount=ge.200,noCA 264 165 Good (0.87500000 0.12500000)  
##        4) Purpose=car (new),car (used),others,furniture/equipment,radio/television,domestic appliances,education,retraining 237 105 Good (0.91139241 0.08860759)  
##          8) Duration< 16.5 112  20 Good (0.96428571 0.03571429)  
##           16) Duration>=10.5 64   0 Good (1.00000000 0.00000000) *
##           17) Duration< 10.5 48  20 Good (0.91666667 0.08333333)  
##             34) Purpose=car (new),car (used),domestic appliances,education,retraining 24   0 Good (1.00000000 0.00000000) *
##             35) Purpose=furniture/equipment,radio/television 24  20 Good (0.83333333 0.16666667)  
##               70) CreditHistory=delay in paying in past,critical account/credit in other 10   0 Good (1.00000000 0.00000000) *
##               71) CreditHistory=no credits,credits this bank paid back till now 14  10 Bad (0.71428571 0.28571429) *
##          9) Duration>=16.5 125  85 Good (0.86400000 0.13600000)  
##           18) Purpose=car (used),others,radio/television,retraining 86  35 Good (0.91860465 0.08139535)  
##             36) Property=noRE but building savings agreem/insurance,unknown/no property 25   0 Good (1.00000000 0.00000000) *
##             37) Property=real estate,noREorBuild but car or oth not in Savings 61  35 Good (0.88524590 0.11475410)  
##               74) EmployedSince=ge.4y.lt7y 14   0 Good (1.00000000 0.00000000) *
##               75) EmployedSince=unemployed,lt.1y,ge.1y.lt.4y,ge.7y 47  35 Good (0.85106383 0.14893617)  
##                150) OtherInstallPlans=none 40  20 Good (0.90000000 0.10000000)  
##                  300) CreditHistory=critical account/credit in other 14   0 Good (1.00000000 0.00000000) *
##                  301) CreditHistory=credits this bank paid back till now,delay in paying in past 26  20 Good (0.84615385 0.15384615)  
##                    602) NumberOfCredits< 1.5 19   5 Good (0.94736842 0.05263158) *
##                    603) NumberOfCredits>=1.5 7   4 Bad (0.57142857 0.42857143) *
##                151) OtherInstallPlans=bank,stores 7   4 Bad (0.57142857 0.42857143) *
##           19) Purpose=car (new),furniture/equipment,education 39  29 Bad (0.74358974 0.25641026)  
##             38) SavingsAccountBonds=ge.100.lt.500,ge.500.lt.1000,ge.1000 14   0 Good (1.00000000 0.00000000) *
##             39) SavingsAccountBonds=lt.100,unkown.no 25  15 Bad (0.60000000 0.40000000) *
##        5) Purpose=repairs,business 27  15 Bad (0.55555556 0.44444444)  
##         10) EmployedSince=ge.4y.lt7y,ge.7y 9   5 Good (0.88888889 0.11111111) *
##         11) EmployedSince=unemployed,lt.1y,ge.1y.lt.4y 18   7 Bad (0.38888889 0.61111111) *
##      3) StatusAccount=lt.0,ge.0.lt200 336 194 Bad (0.57738095 0.42261905)  
##        6) Duration< 8.5 28  10 Good (0.92857143 0.07142857)  
##         12) StatusAndSex=maleDivorced,maleSingle,maleMarriedWidowed 19   0 Good (1.00000000 0.00000000) *
##         13) StatusAndSex=femaleDivorcedOrMarried 9   7 Bad (0.77777778 0.22222222) *
##        7) Duration>=8.5 308 168 Bad (0.54545455 0.45454545)  
##         14) SavingsAccountBonds=ge.500.lt.1000,ge.1000,unkown.no 72  54 Bad (0.75000000 0.25000000)  
##           28) StatusAccount=ge.0.lt200 44  25 Good (0.88636364 0.11363636)  
##             56) Property=real estate,noREorBuild but car or oth not in Savings 29   5 Good (0.96551724 0.03448276) *
##             57) Property=noRE but building savings agreem/insurance,unknown/no property 15  11 Bad (0.73333333 0.26666667) *
##           29) StatusAccount=lt.0 28  15 Bad (0.53571429 0.46428571) *
##         15) SavingsAccountBonds=lt.100,ge.100.lt.500 236 114 Bad (0.48305085 0.51694915)  
##           30) Property=real estate,noRE but building savings agreem/insurance 119  70 Bad (0.58823529 0.41176471)  
##             60) Duration< 11.5 15   5 Good (0.93333333 0.06666667) *
##             61) Duration>=11.5 104  56 Bad (0.53846154 0.46153846)  
##              122) Purpose=car (used),business 12  10 Good (0.83333333 0.16666667) *
##              123) Purpose=car (new),others,furniture/equipment,radio/television,domestic appliances,repairs,education,retraining 92  46 Bad (0.50000000 0.50000000)  
##                246) CreditHistory=credits this bank paid back till now,delay in paying in past,critical account/credit in other 83  46 Bad (0.55421687 0.44578313)  
##                  492) Purpose=others,furniture/equipment,repairs 22  17 Bad (0.77272727 0.22727273)  
##                    984) OtherBebtorsGarants=co-applicant,guarantor 7   0 Good (1.00000000 0.00000000) *
##                    985) OtherBebtorsGarants=none 15  10 Bad (0.66666667 0.33333333) *
##                  493) Purpose=car (new),radio/television,domestic appliances,education,retraining 61  29 Bad (0.47540984 0.52459016)  
##                    986) StatusAccount=ge.0.lt200 21  14 Bad (0.66666667 0.33333333)  
##                     1972) AgeYears>=25.5 12   5 Good (0.91666667 0.08333333) *
##                     1973) AgeYears< 25.5 9   3 Bad (0.33333333 0.66666667) *
##                    987) StatusAccount=lt.0 40  15 Bad (0.37500000 0.62500000) *
##                247) CreditHistory=no credits,all credits this bank paid 9   0 Bad (0.00000000 1.00000000) *
##           31) Property=noREorBuild but car or oth not in Savings,unknown/no property 117  44 Bad (0.37606838 0.62393162) *
```

Now then we check the tree using the test sample:


```r
test$pred <- predict(modelg1, newdata = test, type = "class") 
table(test$pred, test$Class)
```

```
##       
##        Good Bad
##   Good  152  30
##   Bad   123  95
```

```r
confusionMatrix(data = test$pred, reference = test$Class, positive = "Bad")
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction Good Bad
##       Good  152  30
##       Bad   123  95
##                                           
##                Accuracy : 0.6175          
##                  95% CI : (0.5679, 0.6654)
##     No Information Rate : 0.6875          
##     P-Value [Acc > NIR] : 0.9988          
##                                           
##                   Kappa : 0.26            
##  Mcnemar's Test P-Value : 1.024e-13       
##                                           
##             Sensitivity : 0.7600          
##             Specificity : 0.5527          
##          Pos Pred Value : 0.4358          
##          Neg Pred Value : 0.8352          
##              Prevalence : 0.3125          
##          Detection Rate : 0.2375          
##    Detection Prevalence : 0.5450          
##       Balanced Accuracy : 0.6564          
##                                           
##        'Positive' Class : Bad             
## 
```

The global accuracy of tree is reduced again, but the sensitivity has sensibly grown,
at the cost of a reduction of specificity.

Globally, this last tree model "recognizes" much more Bad customers, with respect to
the tree that does not use the loss matrix.

<!---
# Exercises with kyphosis, utilities, uscrimes or Smarket
--->
