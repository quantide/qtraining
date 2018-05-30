---
title: "Principal Component Analysis (PCA) and Exploratory Factor Analysis (EFA)"
---






# Introduction

When faced with situations involving high-dimensional data, it is natural to
consider the possibility of projecting those data onto a lower-dimensional
subspace without losing important information regarding the original
variables. One way of accomplishing this reduction of dimensionality is
through variable selection, also called "feature selection". Another way is
by creating a reduced set of linear or nonlinear transformations of the input
variables. The creation of such composite variables (or features) by
projection methods is often referred to as "feature extraction".

Principal Component Analysis (PCA) and Factor Analysis (FA) are techniques for reducing the dimensionality of a set of data
whose main aims are exploratory analysis, data visualization and feature
extraction to use in further analyses.


# PCA

Principal component analysis (PCA) is a technique for deriving a reduced set
of orthogonal linear projections of a single collection of correlated
variables, where the projections are ordered by decreasing variances. The
reduced set of orthogonal linear projections (known as the principal
components, PC) is obtained by properly linearly combining the original
variables.

In PCA, "information" is interpreted as the "total variation" of the input
variables, that is, as the sum of variances of the original variables. At the
heart of PCA stands the spectral decomposition (also called the
eigendecomposition) of the (sample) covariance matrix. This returns the
eigenvalues and eigenvectors of the same matrix. The eigenvalues (provided
in decreasing order) represent the amount of total observed variability of
the original variables accounted for by each principal component, while the
eigenvectors represent the corresponding (orthogonal) directions of maximal
variability.

Hopefully the sample variances of the first few sample PCs will be
large, whereas the rest will be small enough for the corresponding set of
sample PCs to be omitted. A variable that does not change much (relative to
other variables) in independent measurements may be treated approximately as
a constant, and so omitting such low-variance sample PCs and putting all
attention on high-variance sample PCs is, therefore, a convenient way of
reducing the dimensionality of the dataset.

Given a set of multivariate data where the variables have completely
different types, then the structure of the principal components derived from
the covariance matrix will depend upon the essentially arbitrary choice of
units of measurement. Additionally, if there are large differences between
the variances of the original variables, then those whose variances are
largest will tend to dominate the early components. Therefore, PCs should
only be extracted from the sample covariance matrix when all original
variables have roughly the same scale. But this is rare and consequently, in
practice, PCs are extracted from the correlation matrix of the variables,
which is equivalent to calculating the PCs from the original variables after
each has been standardized to have unit variance. This is always a sensible
suggestion to try to make the original variables "equally important".

In `R` there are many functions for computing PC. The basic ones available in
base `R` are `princomp()` and `prcomp()`. The former uses the eigendecomposition
for finding the PCs, while the latter uses the singular value decomposition
(SVD). SVD is generally the preferred method for numerical accuracy.
Moreover, `princomp()` uses $n$ (the sample size)  as the divisor for calculating the sample
variances, while `prcomp()` uses the more usual $(n - 1)$.
Of course, when correlation matrices are used to perform PCA, the divisor does not
impact on results at all.

## Example: Life data
Let's consider the `life` dataset (see the section *Introduction and datasets used* for further information). The data contains life expectations in 1960 at birth, 25, 50 and 75 years for men and women in 31 Countries or regions. Before using the data for analysis a data fixing is applied.


```r
# Data fixing:
life[life$country=="Trinidad (62)", "m25"] <- 43
str(life)
```

```
## Classes 'tbl_df', 'tbl' and 'data.frame':	31 obs. of  9 variables:
##  $ country: chr  "Algeria" "Cameroon" "Madagascar" "Mauritius" ...
##  $ m0     : num  63 34 38 59 56 62 50 65 56 69 ...
##  $ m25    : num  51 29 30 42 38 44 39 44 46 47 ...
##  $ m50    : num  30 13 17 20 18 24 20 22 24 24 ...
##  $ m75    : num  13 5 7 6 7 7 7 7 11 8 ...
##  $ w0     : num  67 38 38 64 62 69 55 72 63 75 ...
##  $ w25    : num  54 32 34 46 46 50 43 50 54 53 ...
##  $ w50    : num  34 17 20 25 25 28 23 27 33 29 ...
##  $ w75    : num  15 6 7 8 10 14 8 9 19 10 ...
```

```r
summary(life)
```

```
##    country                m0             m25             m50             m75               w0       
##  Length:31          Min.   :34.00   Min.   :29.00   Min.   :13.00   Min.   : 5.000   Min.   :38.00  
##  Class :character   1st Qu.:57.50   1st Qu.:42.50   1st Qu.:21.50   1st Qu.: 7.000   1st Qu.:62.00  
##  Mode  :character   Median :61.00   Median :44.00   Median :23.00   Median : 8.000   Median :66.00  
##                     Mean   :59.61   Mean   :43.48   Mean   :22.94   Mean   : 8.387   Mean   :64.19  
##                     3rd Qu.:65.00   3rd Qu.:46.00   3rd Qu.:24.00   3rd Qu.: 9.000   3rd Qu.:68.00  
##                     Max.   :69.00   Max.   :51.00   Max.   :30.00   Max.   :14.000   Max.   :75.00  
##       w25             w50             w75       
##  Min.   :32.00   Min.   :17.00   Min.   : 6.00  
##  1st Qu.:46.00   1st Qu.:25.00   1st Qu.: 8.50  
##  Median :49.00   Median :27.00   Median :10.00  
##  Mean   :47.52   Mean   :26.29   Mean   :10.13  
##  3rd Qu.:51.00   3rd Qu.:28.00   3rd Qu.:11.00  
##  Max.   :54.00   Max.   :34.00   Max.   :19.00
```

We use only the last eight variables of data frame because the first one
(country) is a factor and hence cannot be used in a PCA. We will use it for
graphing the results.


```r
require(GGally)
```


```r
lf <- life[, -1]
class(life) <- "data.frame"
ggscatmat(life, columns = 2:9)
```

![plot of chunk 02b-graphlifesummary1](figure/02b-graphlifesummary1-1.png)

As seen from the above scatterplot matrix, some of the original variables are
correlated, therefore it could be useful to pre-process the data
using PCA. To avoid that variation between variables may affect results, each
variable is first standardized. We achieve this by specifying the optional
arguments `cor = TRUE` and `scale = TRUE` in `princomp()` and `prcomp()`
respectively. As we said, this corresponds to perform a PCA on the
correlation matrix of the original variables:


```r
system.time(pca_princomp <- princomp(lf))
```

```
##    user  system elapsed 
##   0.004   0.000   0.016
```

```r
summary(pca_princomp)
```

```
## Importance of components:
##                            Comp.1    Comp.2    Comp.3      Comp.4      Comp.5      Comp.6      Comp.7
## Standard deviation     13.5934012 4.5370290 2.4515180 1.191561472 0.764224458 0.648841377 0.593016147
## Proportion of Variance  0.8620605 0.0960339 0.0280383 0.006623909 0.002724729 0.001964077 0.001640645
## Cumulative Proportion   0.8620605 0.9580944 0.9861327 0.992756588 0.995481317 0.997445394 0.999086039
##                              Comp.8
## Standard deviation     0.4426119310
## Proportion of Variance 0.0009139611
## Cumulative Proportion  1.0000000000
```

```r
system.time(pca_prcomp <- prcomp(lf))
```

```
##    user  system elapsed 
##   0.000   0.000   0.002
```

```r
summary(pca_prcomp)
```

```
## Importance of components:
##                            PC1     PC2     PC3     PC4     PC5     PC6     PC7     PC8
## Standard deviation     13.8181 4.61203 2.49204 1.21126 0.77686 0.65957 0.60282 0.44993
## Proportion of Variance  0.8621 0.09603 0.02804 0.00662 0.00272 0.00196 0.00164 0.00091
## Cumulative Proportion   0.8621 0.95809 0.98613 0.99276 0.99548 0.99745 0.99909 1.00000
```

The two functions return very similar results. `prcomp()` is numerically
more accurate, but somewhat slower for larger dataset. In the rest of the
presentation we'll keep going using `princomp()`.

From the output we can see that the first three PCs account for more than 97%
of the total variability, and have coefficients:


```r
print(summary(pca_princomp, loadings = TRUE)) # (cutoff = .1)
```

```
## Importance of components:
##                            Comp.1    Comp.2    Comp.3      Comp.4      Comp.5      Comp.6      Comp.7
## Standard deviation     13.5934012 4.5370290 2.4515180 1.191561472 0.764224458 0.648841377 0.593016147
## Proportion of Variance  0.8620605 0.0960339 0.0280383 0.006623909 0.002724729 0.001964077 0.001640645
## Cumulative Proportion   0.8620605 0.9580944 0.9861327 0.992756588 0.995481317 0.997445394 0.999086039
##                              Comp.8
## Standard deviation     0.4426119310
## Proportion of Variance 0.0009139611
## Cumulative Proportion  1.0000000000
## 
## Loadings:
##     Comp.1 Comp.2 Comp.3 Comp.4 Comp.5 Comp.6 Comp.7 Comp.8
## m0  -0.562  0.285 -0.287 -0.225 -0.110  0.494 -0.432 -0.166
## m25 -0.312 -0.336 -0.434  0.414         0.301  0.533  0.225
## m50 -0.177 -0.433 -0.470 -0.114 -0.222 -0.627 -0.316       
## m75        -0.334        -0.796  0.364  0.119  0.323       
## w0  -0.623  0.387  0.279               -0.456  0.306  0.273
## w25 -0.343 -0.268  0.302  0.278  0.351               -0.717
## w50 -0.197 -0.367  0.299  0.168  0.379        -0.478  0.572
## w75        -0.388  0.499 -0.143 -0.729  0.195
```

```r
print(summary(pca_princomp, loadings = TRUE), cutoff = .3)
```

```
## Importance of components:
##                            Comp.1    Comp.2    Comp.3      Comp.4      Comp.5      Comp.6      Comp.7
## Standard deviation     13.5934012 4.5370290 2.4515180 1.191561472 0.764224458 0.648841377 0.593016147
## Proportion of Variance  0.8620605 0.0960339 0.0280383 0.006623909 0.002724729 0.001964077 0.001640645
## Cumulative Proportion   0.8620605 0.9580944 0.9861327 0.992756588 0.995481317 0.997445394 0.999086039
##                              Comp.8
## Standard deviation     0.4426119310
## Proportion of Variance 0.0009139611
## Cumulative Proportion  1.0000000000
## 
## Loadings:
##     Comp.1 Comp.2 Comp.3 Comp.4 Comp.5 Comp.6 Comp.7 Comp.8
## m0  -0.562                              0.494 -0.432       
## m25 -0.312 -0.336 -0.434  0.414         0.301  0.533       
## m50        -0.433 -0.470               -0.627 -0.316       
## m75        -0.334        -0.796  0.364         0.323       
## w0  -0.623  0.387                      -0.456  0.306       
## w25 -0.343         0.302         0.351               -0.717
## w50        -0.367                0.379        -0.478  0.572
## w75        -0.388  0.499        -0.729
```
The loadings above can help giving a name to principal components.  
The first PC seems (negatively) dominated by the global level of life expectancy.  
The second PC, instead, seems to oppose life expectancy at birth versus life expectancy at
older ages; i.e., bigger values in second PC will be assigned to regions where the difference
between expected life at birth and and expacted life ad elderly ages is bigger.  
The third PC seems to set men against women life expectancy.

A graphical representation of PCA values analysis via the scatterplot of loadings may also help to "name" Pcs.  
Loadings are part of the output produced by `princomp()`.
This graph allows the researcher to find some relations that may appear between 
principal components.

```r
require(ggplot2)
```

```
## Loading required package: ggplot2
```

```r
dl <- pca_princomp$loadings
class(dl) <- "matrix"
dl <- data.frame(dl)
dl$gender <- rep(c("male", "female"), each=4)
dl$age <- rep(as.character((0:3)*25), 2)
ggp <- ggplot(dl, mapping = aes(x=Comp.1, y=Comp.2, colour=gender, shape=age)) + geom_point() + scale_shape_manual(values = rep(0:3,2)) + ggtitle("PC1 Vs PC2 by gender and age")
print(ggp)
```

![plot of chunk 02b-correlationlife](figure/02b-correlationlife-1.png)

```r
ggp <- ggplot(dl, mapping = aes(x=Comp.1, y=Comp.3, colour=gender, shape=age)) + geom_point() + scale_shape_manual(values = rep(0:3,2)) + ggtitle("PC1 Vs PC3 by gender and age")
print(ggp)
```

![plot of chunk 02b-correlationlife](figure/02b-correlationlife-2.png)

```r
ggp <- ggplot(dl, mapping = aes(x=Comp.2, y=Comp.3, colour=gender, shape=age)) + geom_point() + scale_shape_manual(values = rep(0:3,2)) + ggtitle("PC2 Vs PC3 by gender and age")
print(ggp)
```

![plot of chunk 02b-correlationlife](figure/02b-correlationlife-3.png)



Now we will deepen these results by analyzing the so-called __component scores__.

Component scores are the coordinates of original points (rows), once projected on PCs. These are
the new (derived) variables that one could use in other analyses such as a regression.
Component scores are part of the output provided by `princomp()`. Typically one
can represent them graphically to look for features in the data like clusters,
outliers, etc.  
A useful approach for interpreting the estimated PCs is to calculate the
correlations of the most important PCs component scores with each one of the
original variables:


```r
cor(lf, pca_princomp$scores)
```

```
##         Comp.1     Comp.2      Comp.3      Comp.4       Comp.5       Comp.6       Comp.7       Comp.8
## m0  -0.9798753  0.1659175 -0.09029315 -0.03435868 -0.010833525  0.041144972 -0.032913705 -0.009423358
## m25 -0.9077778 -0.3258982 -0.22739054  0.10544636 -0.011758329  0.041757210  0.067592494  0.021300334
## m50 -0.7175522 -0.5871008 -0.34389726 -0.04066645 -0.050642952 -0.121351816 -0.055941848 -0.009586812
## m75 -0.4078898 -0.7593118 -0.03300976 -0.47518338  0.139449498  0.038614254  0.096025917  0.004940247
## w0  -0.9751856  0.2021222  0.07889142 -0.01121110 -0.003964288 -0.034115846  0.020908721  0.013906251
## w25 -0.9506882 -0.2481401  0.15103743  0.06743001  0.054685222 -0.007668405  0.005209272 -0.064675175
## w50 -0.8174017 -0.5067414  0.22319236  0.06099452  0.088174810  0.018831360 -0.086362574  0.077100877
## w75 -0.4793686 -0.6942651  0.48254311 -0.06719398 -0.219750449  0.049935930  0.005522558 -0.004944782
```

```r
ggcorr(cbind(lf, pca_princomp$scores), label = TRUE, cex = 2.5)
```

![plot of chunk 02b-pcsgraphlife](figure/02b-pcsgraphlife-1.png)

The table shows that the 1st PC is strongly and negatively related to all variables:
the mean life expectation within each region drops when the age of subjects grows. That
means that regions with lower value in first PC score should have a longer life expectancy. This 
confirm previous considerations.  
The 2nd PC instead contrasts the life expectancy at birth with the life expectancy at elderly ages,
giving positive values to life expectancy at birth; this might mean that regions with higher 
value in second PC should have a bigger difference in life expectancy at birth and at elderly ages.  
The 3rd PC seems to contrast males with females measures. This should mean that regions with higher
values in 3rd PC should have an higher value of life expectancy for females than for males.

Now, the scatter plot of the first two PCs scores is produced:


```r
pca_sc <- data.frame(pca_princomp$scores, country = life[, 1])
ggplot(pca_sc, aes(x = Comp.1, y = Comp.2, color = country)) + geom_point() + geom_text(mapping = aes(label = country), vjust=1) + theme(legend.position = "none") + ggtitle("Comp.1 Vs Comp.2 scores")
```

![plot of chunk 02b-scoreplotslife](figure/02b-scoreplotslife-1.png)

```r
ggplot(pca_sc, aes(x = Comp.1, y = Comp.3, color = country)) + geom_point() + geom_text(mapping = aes(label = country), vjust=1) + theme(legend.position = "none") + ggtitle("Comp.1 Vs Comp.3 scores")
```

![plot of chunk 02b-scoreplotslife](figure/02b-scoreplotslife-2.png)

```r
ggplot(pca_sc, aes(x = Comp.2, y = Comp.3, color = country)) + geom_point() + geom_text(mapping = aes(label = country), vjust=1) + theme(legend.position = "none") + ggtitle("Comp.2 Vs Comp.3 scores")
```

![plot of chunk 02b-scoreplotslife](figure/02b-scoreplotslife-3.png)

Another graphical representation of the results of a PCA where both the
component scores and the loadings are jointly represented is the biplot,
which can be obtained with the `biplot()` function:


```r
biplot(pca_princomp, choices = c(1,2), cex = c(.7, .7), col = c("gray", "red"))
```

![plot of chunk 02b-biplotlife](figure/02b-biplotlife-1.png)

```r
biplot(pca_princomp, choices = c(1,3), cex = c(.7, .7), col = c("gray", "red"))
```

![plot of chunk 02b-biplotlife](figure/02b-biplotlife-2.png)

```r
biplot(pca_princomp, choices = c(2,3), cex = c(.7, .7), col = c("gray", "red"))
```

![plot of chunk 02b-biplotlife](figure/02b-biplotlife-3.png)

Now, we have seen that the principal components are linear transformations of
original variables. The total number of principal components that can be 
extracted from a dataset is equal to the minimum between the number of rows
and the number of columns of dataset.

How many PCs should we retain? This is probably the main question while
carrying out a PCA. Because the criterion for a good projection in PCA is a
high variance for that projection, we should only retain those principal
components with large variances. The question, therefore, involves the
magnitudes of the eigenvalues of the sample covariance matrix. Different
criteria have been introduced in the literature and we review now the most
popular:

- **explained variance**: retain just enough components to explain some
							 specified large percentage of the total variation
							 of the original variables. Values between 70% and
							 90% are usually suggested.
- **scree plot**: this plot represents the ordered sample eigenvalues
					 against their order number. If the largest few sample
					 eigenvalues dominate in magnitude, with the remaining
					 sample eigenvalues very small, then the scree plot will
					 exhibit an "elbow" in the plot corresponding to the
					 division into "large" and "small" values of the sample 
					 eigenvalues. The order number at which the elbow occurs 
					 can be used as the number of PCs to retain.
- **Kaiser’s rule**: retain only those PCs whose eigenvalues exceed unity.
						This decision guideline is based upon the argument that
						because the total variation of all the R standardized
						variables is equal to `R`, it follows that a PCA should
						account for at least the average variation of a single
						standardized variable. This rule is popular but
						controversial; there is evidence that the cutoff value
						of 1 is too high. A modified rule retains all PCs whose
						eigenvalues of the sample correlation matrix exceed
						0.7. Also, for non standardized data, this rule is perhaps
						not applicable.

For the life example, the explained variance criterion would suggest to
use no more than 2 components. The scree plot, given by


```r
plot(pca_princomp, type = "lines")
```

![plot of chunk 02b-plotprincomplife](figure/02b-plotprincomplife-1.png)

should suggest two, or at most three components (note that the variances reported on the vertical 
axis of this plot correspond to the egienvalues of the correlation matrix of
the original data). The Kaiser's rule suggests 4 components, maybe an high 
value, if the aim is in obtaining a summary of the overall information contained
in the original data.

A 3-dimensional plot of the first three PCs can be obtained with the
`plot3d()` function in the `rgl` package (the plot can be spinned with the
mouse):


```r
require(rgl)
```


```r
plot3d(pca_princomp$scores[, 1:3], size = 5)
texts3d(pca_princomp$scores[, 1:3], texts = life$country, adj = c(0.5,0))
play3d(spin3d(axis = c(1, 1, 1), rpm = 15), duration = 10)
```

(Note: the above command shows a dynamic 3D graph that cannot be shown here, of course)

## Example: Correlations on Life data

In thi example, the same computations as before are performed, but the data are standardized
before applying PCA. This makes the values of different variables more comparable and with
equal weight during PCA, because the variance of variables is constant.  
The options `cor = TRUE` and `center = TRUE, scale. = TRUE` allow `princomp()` and `prcomp()`
(respectively) to calculate PCAs on standardized variables.


```r
system.time(pca_princomp <- princomp(lf, cor = TRUE))
```

```
##    user  system elapsed 
##   0.004   0.000   0.007
```

```r
summary(pca_princomp)
```

```
## Importance of components:
##                           Comp.1    Comp.2     Comp.3     Comp.4      Comp.5      Comp.6      Comp.7
## Standard deviation     2.4311566 1.1466229 0.69791483 0.42937156 0.244503441 0.158855457 0.113103100
## Proportion of Variance 0.7388153 0.1643430 0.06088564 0.02304499 0.007472742 0.003154382 0.001599039
## Cumulative Proportion  0.7388153 0.9031583 0.96404394 0.98708893 0.994561674 0.997716056 0.999315095
##                              Comp.8
## Standard deviation     0.0740218822
## Proportion of Variance 0.0006849049
## Cumulative Proportion  1.0000000000
```

```r
system.time(pca_prcomp <- prcomp(lf, center = TRUE, scale. = TRUE))
```

```
##    user  system elapsed 
##   0.000   0.000   0.001
```

```r
summary(pca_prcomp)
```

```
## Importance of components:
##                           PC1    PC2     PC3     PC4     PC5     PC6    PC7     PC8
## Standard deviation     2.4312 1.1466 0.69791 0.42937 0.24450 0.15886 0.1131 0.07402
## Proportion of Variance 0.7388 0.1643 0.06089 0.02304 0.00747 0.00315 0.0016 0.00068
## Cumulative Proportion  0.7388 0.9032 0.96404 0.98709 0.99456 0.99772 0.9993 1.00000
```

The two functions return very similar results. In the rest of the
presentation we'll keep going using `princomp()`.

From the output we can see that the first three PCs account for more than 96%
of the total variability, and have coefficients:


```r
print(summary(pca_princomp, loadings = TRUE)) # (cutoff = .1)
```

```
## Importance of components:
##                           Comp.1    Comp.2     Comp.3     Comp.4      Comp.5      Comp.6      Comp.7
## Standard deviation     2.4311566 1.1466229 0.69791483 0.42937156 0.244503441 0.158855457 0.113103100
## Proportion of Variance 0.7388153 0.1643430 0.06088564 0.02304499 0.007472742 0.003154382 0.001599039
## Cumulative Proportion  0.7388153 0.9031583 0.96404394 0.98708893 0.994561674 0.997716056 0.999315095
##                              Comp.8
## Standard deviation     0.0740218822
## Proportion of Variance 0.0006849049
## Cumulative Proportion  1.0000000000
## 
## Loadings:
##     Comp.1 Comp.2 Comp.3 Comp.4 Comp.5 Comp.6 Comp.7 Comp.8
## m0  -0.345  0.456        -0.267  0.246        -0.424  0.596
## m25 -0.392  0.104  0.297  0.335         0.766 -0.108 -0.191
## m50 -0.362 -0.169  0.552  0.399  0.263 -0.542  0.114       
## m75 -0.282 -0.545  0.312 -0.709         0.115              
## w0  -0.339  0.463 -0.172 -0.319  0.170 -0.182  0.118 -0.680
## w25 -0.400  0.120 -0.207        -0.283         0.752  0.366
## w50 -0.392 -0.132 -0.260  0.179 -0.670 -0.247 -0.460       
## w75 -0.298 -0.458 -0.605  0.140  0.551
```

```r
print(summary(pca_princomp, loadings = TRUE), cutoff = .3)
```

```
## Importance of components:
##                           Comp.1    Comp.2     Comp.3     Comp.4      Comp.5      Comp.6      Comp.7
## Standard deviation     2.4311566 1.1466229 0.69791483 0.42937156 0.244503441 0.158855457 0.113103100
## Proportion of Variance 0.7388153 0.1643430 0.06088564 0.02304499 0.007472742 0.003154382 0.001599039
## Cumulative Proportion  0.7388153 0.9031583 0.96404394 0.98708893 0.994561674 0.997716056 0.999315095
##                              Comp.8
## Standard deviation     0.0740218822
## Proportion of Variance 0.0006849049
## Cumulative Proportion  1.0000000000
## 
## Loadings:
##     Comp.1 Comp.2 Comp.3 Comp.4 Comp.5 Comp.6 Comp.7 Comp.8
## m0  -0.345  0.456                             -0.424  0.596
## m25 -0.392                0.335         0.766              
## m50 -0.362         0.552  0.399        -0.542              
## m75        -0.545  0.312 -0.709                            
## w0  -0.339  0.463        -0.319                      -0.680
## w25 -0.400                                     0.752  0.366
## w50 -0.392                      -0.670        -0.460       
## w75        -0.458 -0.605         0.551
```
The loadings above can help giving a name to principal components.  
The first PC seems (negatively) dominated by the global level of life expectancy.  
The second PC, instead, seems to oppose life expectancy at young ages versus life
expectancy at older ages.  
The third PC seems to set men against women life expectancy.

A graphical representation of PCA values analysis via the scatterplot of loadings may
again help to "name" Pcs.  
Loadings are part of the output produced by `princomp()`.

```r
require(ggplot2)
dl <- pca_princomp$loadings
class(dl) <- "matrix"
dl <- data.frame(dl)
dl$gender <- rep(c("male", "female"), each=4)
dl$age <- rep(as.character((0:3)*25), 2)
ggp <- ggplot(dl, mapping = aes(x=Comp.1, y=Comp.2, colour=gender, shape=age)) + geom_point() + scale_shape_manual(values = rep(0:3,2)) + ggtitle("PC1 Vs PC2 by gender and age")
print(ggp)
```

![plot of chunk 02b-correlationlife2](figure/02b-correlationlife2-1.png)

```r
ggp <- ggplot(dl, mapping = aes(x=Comp.1, y=Comp.3, colour=gender, shape=age)) + geom_point() + scale_shape_manual(values = rep(0:3,2)) + ggtitle("PC1 Vs PC3 by gender and age")
print(ggp)
```

![plot of chunk 02b-correlationlife2](figure/02b-correlationlife2-2.png)

```r
ggp <- ggplot(dl, mapping = aes(x=Comp.2, y=Comp.3, colour=gender, shape=age)) + geom_point() + scale_shape_manual(values = rep(0:3,2)) + ggtitle("PC2 Vs PC3 by gender and age")
print(ggp)
```

![plot of chunk 02b-correlationlife2](figure/02b-correlationlife2-3.png)



Now we will deepen these results by analyzing the component scores.

We begin by calculating the correlations of the most important PCs component
scores with all original variables:


```r
cor(lf, pca_princomp$scores)
```

```
##         Comp.1     Comp.2      Comp.3      Comp.4        Comp.5       Comp.6       Comp.7       Comp.8
## m0  -0.8390946  0.5227327  0.03923331 -0.11483293  0.0602238305 -0.008705220 -0.047916929  0.044115946
## m25 -0.9524142  0.1186975  0.20736179  0.14368405  0.0002258456  0.121757701 -0.012235665 -0.014117481
## m50 -0.8791358 -0.1940125  0.38531740  0.17112036  0.0643765383 -0.086097267  0.012859570 -0.002298165
## m75 -0.6847714 -0.6245093  0.21786502 -0.30451359 -0.0231223093  0.018326309  0.002879561 -0.001954258
## w0  -0.8244105  0.5308659 -0.12019789 -0.13714125  0.0414456127 -0.028986718  0.013368252 -0.050366442
## w25 -0.9732376  0.1372837 -0.14479074  0.01446390 -0.0691075198  0.006762882  0.085034852  0.027124636
## w50 -0.9523955 -0.1517311 -0.18142976  0.07681211 -0.1637531747 -0.039234925 -0.051973909 -0.006914984
## w75 -0.7236413 -0.5254190 -0.42223648  0.06000416  0.1347861331  0.012664868 -0.007872979  0.002068105
```

```r
ggcorr(cbind(lf, pca_princomp$scores), label = TRUE, cex = 2.5)
```

![plot of chunk 02b-pcsgraphlife2](figure/02b-pcsgraphlife2-1.png)

The table shows that the 1st PC is strongly and negatively related to all variables:
the mean life expectation within each region drops when the age of subjects grows. That
means that regions with lower value in first PC score should have a longer life expectancy. This 
confirm previous considerations.  
The 2nd PC instead contrasts the life expectancy at younger ages the life expectancy at elderly ages,
giving positive values to life expectancy at birth.  
The 3rd PC seems to contrast males (positive) with females (negative) measures. This means that regions with higher
values in 3rd PC should have an higher value of life expectancy for males than for females.

Now, the scatter plot of the first two PCs scores is produced:


```r
pca_sc <- data.frame(pca_princomp$scores, country = life[, 1])
ggplot(pca_sc, aes(x = Comp.1, y = Comp.2, color = country)) + geom_point() + geom_text(mapping = aes(label = country), vjust=1) + theme(legend.position = "none") + ggtitle("Comp.1 Vs Comp.2 scores")
```

![plot of chunk 02b-scoreplotslife2](figure/02b-scoreplotslife2-1.png)

```r
ggplot(pca_sc, aes(x = Comp.1, y = Comp.3, color = country)) + geom_point() + geom_text(mapping = aes(label = country), vjust=1) + theme(legend.position = "none") + ggtitle("Comp.1 Vs Comp.3 scores")
```

![plot of chunk 02b-scoreplotslife2](figure/02b-scoreplotslife2-2.png)

```r
ggplot(pca_sc, aes(x = Comp.2, y = Comp.3, color = country)) + geom_point() + geom_text(mapping = aes(label = country), vjust=1) + theme(legend.position = "none") + ggtitle("Comp.2 Vs Comp.3 scores")
```

![plot of chunk 02b-scoreplotslife2](figure/02b-scoreplotslife2-3.png)

The last graphical representation of the results of the PCA is the biplot,
which can be obtained with the `biplot()` function:


```r
biplot(pca_princomp, choices = c(1,2), cex = c(.7, .7), col = c("gray", "red"))
```

![plot of chunk 02b-biplotlife2](figure/02b-biplotlife2-1.png)

```r
biplot(pca_princomp, choices = c(1,3), cex = c(.7, .7), col = c("gray", "red"))
```

![plot of chunk 02b-biplotlife2](figure/02b-biplotlife2-2.png)

```r
biplot(pca_princomp, choices = c(2,3), cex = c(.7, .7), col = c("gray", "red"))
```

![plot of chunk 02b-biplotlife2](figure/02b-biplotlife2-3.png)

If we want to loook for the "right" number of components to represent our data, we can produce
the scree plot:


```r
plot(pca_princomp, type = "lines")
```

![plot of chunk 02b-plotprincomplife2](figure/02b-plotprincomplife2-1.png)

It would suggest two, or at most three components. The Kaiser's rule suggests 2 components, maybe a low 
value, if the aim is in obtaining a summary of the overall information contained
in the original data.

Finally, the 3-dimensional plot of the first three PCs can be obtained with the
`plot3d()` function in the `rgl` package (the plot can be spinned with the
mouse):


```r
require(rgl)
```


```r
plot3d(pca_princomp$scores[, 1:3], size = 5)
texts3d(pca_princomp$scores[, 1:3], texts = life$country, adj = c(0.5,0))
play3d(spin3d(axis = c(1, 1, 1), rpm = 15), duration = 10)
```

## Example: Banknotes

Let's consider the `banknotes` dataset (see the section *Introduction and datasets used* for further information). This example involves six measures taken on 100 genuine and 100 counterfeit old Swiss 1000-franc banknotes. The six measures are given by the following variables:

- length of the banknote;
- height of the banknote, measured on the left;
- height of the banknote, measured on the right;
- distance of inner frame to the lower border;
- distance of inner frame to the upper border;
- length of the diagonal.

Observations 1–100 are the genuine banknotes and the other 100 observations are the counterfeit banknotes.


```r
str(banknotes)
```

```
## Classes 'tbl_df', 'tbl' and 'data.frame':	200 obs. of  7 variables:
##  $ length  : num  215 215 215 215 215 ...
##  $ left    : num  131 130 130 130 130 ...
##  $ right   : num  131 130 130 130 130 ...
##  $ bottom  : num  9 8.1 8.7 7.5 10.4 9 7.9 7.2 8.2 9.2 ...
##  $ top     : num  9.7 9.5 9.6 10.4 7.7 10.1 9.6 10.7 11 10 ...
##  $ diagonal: num  141 142 142 142 142 ...
##  $ type    : Factor w/ 2 levels "counterfeit",..: 2 2 2 2 2 2 2 2 2 2 ...
```

```r
summary(banknotes)
```

```
##      length           left           right           bottom            top           diagonal    
##  Min.   :213.8   Min.   :129.0   Min.   :129.0   Min.   : 7.200   Min.   : 7.70   Min.   :137.8  
##  1st Qu.:214.6   1st Qu.:129.9   1st Qu.:129.7   1st Qu.: 8.200   1st Qu.:10.10   1st Qu.:139.5  
##  Median :214.9   Median :130.2   Median :130.0   Median : 9.100   Median :10.60   Median :140.4  
##  Mean   :214.9   Mean   :130.1   Mean   :130.0   Mean   : 9.418   Mean   :10.65   Mean   :140.5  
##  3rd Qu.:215.1   3rd Qu.:130.4   3rd Qu.:130.2   3rd Qu.:10.600   3rd Qu.:11.20   3rd Qu.:141.5  
##  Max.   :216.3   Max.   :131.0   Max.   :131.1   Max.   :12.700   Max.   :12.30   Max.   :142.4  
##           type    
##  counterfeit:100  
##  genuine    :100  
##                   
##                   
##                   
## 
```

We use only the first six variables in the data frame because the last one
(type) is a factor and hence cannot be used in a PCA. We will use it for
graphing the results.


```r
require(GGally)
```


```r
bn <- banknotes[, -7]
class(banknotes) <- "data.frame"
ggscatmat(banknotes, columns = 1:6)
```

![plot of chunk 02b-graphsummary1](figure/02b-graphsummary1-1.png)


```r
ggscatmat(banknotes, columns = 1:6, color = "type")
```

![plot of chunk 02b-graphsummary2](figure/02b-graphsummary2-1.png)

As seen from the scatter plot matrix, some of the original variables are
somewhat correlated, therefore it could be useful to pre-process the data
using PCA. Because of wide variations in the different variables, each
variable is first standardized. We achieve this by specifying the optional
arguments `cor = TRUE` and `scale = TRUE` in `princomp()` and `prcomp()`
respectively. As we said, this corresponds to perform a PCA on the
correlation matrix of the original variables:


```r
system.time(pca_princomp <- princomp(bn, cor = TRUE))
```

```
##    user  system elapsed 
##   0.004   0.000   0.002
```

```r
summary(pca_princomp)
```

```
## Importance of components:
##                           Comp.1    Comp.2    Comp.3     Comp.4     Comp.5     Comp.6
## Standard deviation     1.7162629 1.1305237 0.9322192 0.67064796 0.51834053 0.43460313
## Proportion of Variance 0.4909264 0.2130140 0.1448388 0.07496145 0.04477948 0.03147998
## Cumulative Proportion  0.4909264 0.7039403 0.8487791 0.92374054 0.96852002 1.00000000
```

```r
system.time(pca_prcomp <- prcomp(bn, center = TRUE, scale = TRUE))
```

```
##    user  system elapsed 
##   0.000   0.000   0.001
```

```r
summary(pca_prcomp)
```

```
## Importance of components:
##                           PC1    PC2    PC3     PC4     PC5     PC6
## Standard deviation     1.7163 1.1305 0.9322 0.67065 0.51834 0.43460
## Proportion of Variance 0.4909 0.2130 0.1448 0.07496 0.04478 0.03148
## Cumulative Proportion  0.4909 0.7039 0.8488 0.92374 0.96852 1.00000
```

The two functions return the same results. 

From the output we can see that the first three PCs account for more than 84%
of the total variance, and have coefficients:


```r
print(summary(pca_princomp, loadings = TRUE)) # (cutoff = .1)
```

```
## Importance of components:
##                           Comp.1    Comp.2    Comp.3     Comp.4     Comp.5     Comp.6
## Standard deviation     1.7162629 1.1305237 0.9322192 0.67064796 0.51834053 0.43460313
## Proportion of Variance 0.4909264 0.2130140 0.1448388 0.07496145 0.04477948 0.03147998
## Cumulative Proportion  0.4909264 0.7039403 0.8487791 0.92374054 0.96852002 1.00000000
## 
## Loadings:
##          Comp.1 Comp.2 Comp.3 Comp.4 Comp.5 Comp.6
## length           0.815         0.575              
## left      0.468  0.342  0.103 -0.395  0.639  0.298
## right     0.487  0.252  0.123 -0.430 -0.614 -0.349
## bottom    0.407 -0.266  0.584  0.404 -0.215  0.462
## top       0.368        -0.788  0.110 -0.220  0.419
## diagonal -0.493  0.274  0.114 -0.392 -0.340  0.632
```

Now we calculate the correlations of the PCs with each one of the original
variables to interpret the components:


```r
cor(bn, pca_princomp$scores)
```

```
##               Comp.1     Comp.2      Comp.3      Comp.4     Comp.5      Comp.6
## length   -0.01199158  0.9219364 -0.01648225  0.38536590 -0.0304764 -0.01349746
## left      0.80279596  0.3866019  0.09637548 -0.26485400  0.3314768  0.12940207
## right     0.83526859  0.2854104  0.11510550 -0.28856524 -0.3183114 -0.15174296
## bottom    0.69810421 -0.3009779  0.54398559  0.27072283 -0.1116898  0.20094033
## top       0.63139786 -0.1034278 -0.73418921  0.07392333 -0.1139569  0.18208461
## diagonal -0.84690418  0.3096965  0.10615680 -0.26284740 -0.1763188  0.27458160
```

```r
ggcorr(cbind(bn, pca_princomp$scores), label = TRUE, cex = 2.5)
```

![plot of chunk 02b-correlation](figure/02b-correlation-1.png)

The table shows that the 1st PC is strongly related to height measured both
on the left and on the right as well as it is inversely related to the length
of the diagonal. The 2nd PC represents instead the length of the banknote.
The 3rd component is related to the distances of inner frame to the lower and
upper borders, while the remaining PCs do not seem to be strongly related to
any of the original variables.

Now let us draw the scatter plot of the first two PCs:


```r
pca_sc <- data.frame(pca_princomp$scores, type = banknotes[, 7])
ggplot(pca_sc, aes(x = Comp.1, y = Comp.2, color = type)) + geom_point()
```

![plot of chunk 02b-scoreplots](figure/02b-scoreplots-1.png)

The scatter plot shows that the first two PCs (also if this is not the final goal of this analysis)
allow to almost perfectly separate the two groups of banknotes (genuine vs. counterfeit) and this could
also facilitate the classification of banknotes in either one of the two groups.
Now let us try to use the `biplot()` function:


```r
biplot(pca_princomp, cex = c(.7, .7), col = c("gray", "red"))
```

![plot of chunk 02b-biplot](figure/02b-biplot-1.png)

How many PCs should we retain? 
For the banknotes example, the explained variance criterion would suggest to
use 3 components. The scree plot, given by


```r
plot(pca_princomp, type = "lines")
```

![plot of chunk 02b-plotprincomp](figure/02b-plotprincomp-1.png)

does not offer any advice on the number of PCs to retain because there is no
clear elbow in the plot (note that the variances reported on the vertical 
axis of this plot correspond to the egienvalues of the correlation matrix of
the original data). The Kaiser's rule suggests that 3 components provide a
good summary of the overall information contained in the original data.

To plot the scores for components different from the first two, one can still
use the `biplot()` function:


```r
biplot(pca_princomp, cex = c(.7, .7), col = c("gray", "red"), choices = c("Comp.1","Comp.2"))
```

![plot of chunk 02b-biplotprincomp](figure/02b-biplotprincomp-1.png)

A 3-dimensional plot of the first three PCs can be obtained with the
`plot3d()` function:


```r
plot3d(pca_princomp$scores[, 1:3], col = as.integer(banknotes[, 7]) + 2, size = 5)
play3d(spin3d(axis = c(1, 1, 1), rpm = 15), duration = 10)
```

Let us now replay the analysis by using separately genuine and counterfeit banknotes.


```r
unique(banknotes$type)
```

```
## [1] genuine     counterfeit
## Levels: counterfeit genuine
```

```r
# Splits the two datasets
bn_list <- split(x = banknotes,f = banknotes$type)
bn_list <- lapply(X = bn_list, FUN = function(x){x[,-7]})

# Produces the scatterplot matrix for each data frame
lapply(X = bn_list,FUN = function(x){ggscatmat(x, columns = 1:6)})
```

```
## $counterfeit
```

![plot of chunk 02b-banknotes_altro1](figure/02b-banknotes_altro1-1.png)

```
## 
## $genuine
```

![plot of chunk 02b-banknotes_altro1](figure/02b-banknotes_altro1-2.png)



```r
# Produce a list with the two principal components results
pca_princomp <- lapply(X = bn_list, FUN = function(x){princomp(x, cor = TRUE)})
# Produce the summary for either results
lapply(X = pca_princomp, FUN = summary)
```

```
## $counterfeit
## Importance of components:
##                           Comp.1    Comp.2    Comp.3    Comp.4     Comp.5    Comp.6
## Standard deviation     1.3914793 1.3284814 0.9941399 0.8822512 0.56754703 0.4584009
## Proportion of Variance 0.3227025 0.2941438 0.1647190 0.1297279 0.05368494 0.0350219
## Cumulative Proportion  0.3227025 0.6168463 0.7815653 0.9112932 0.96497810 1.0000000
## 
## $genuine
## Importance of components:
##                           Comp.1    Comp.2    Comp.3     Comp.4     Comp.5     Comp.6
## Standard deviation     1.4845355 1.3025778 0.9827302 0.76347839 0.57156088 0.47339788
## Proportion of Variance 0.3673076 0.2827848 0.1609598 0.09714988 0.05444697 0.03735093
## Cumulative Proportion  0.3673076 0.6500924 0.8110522 0.90820210 0.96264907 1.00000000
```

```r
# Show the loadings with cutoff=0.1
invisible(lapply(X = pca_princomp, FUN = function(x){print(summary(x, loadings = TRUE), cutoff = .1)}))
```

```
## Importance of components:
##                           Comp.1    Comp.2    Comp.3    Comp.4     Comp.5    Comp.6
## Standard deviation     1.3914793 1.3284814 0.9941399 0.8822512 0.56754703 0.4584009
## Proportion of Variance 0.3227025 0.2941438 0.1647190 0.1297279 0.05368494 0.0350219
## Cumulative Proportion  0.3227025 0.6168463 0.7815653 0.9112932 0.96497810 1.0000000
## 
## Loadings:
##          Comp.1 Comp.2 Comp.3 Comp.4 Comp.5 Comp.6
## length   -0.434 -0.178         0.848  0.137 -0.190
## left     -0.446 -0.443 -0.310 -0.156 -0.688  0.108
## right    -0.399 -0.479        -0.448  0.615 -0.170
## bottom    0.526 -0.445               -0.164 -0.704
## top      -0.397  0.449  0.460 -0.233 -0.273 -0.548
## diagonal  0.140 -0.378  0.825        -0.168  0.357
## Importance of components:
##                           Comp.1    Comp.2    Comp.3     Comp.4     Comp.5     Comp.6
## Standard deviation     1.4845355 1.3025778 0.9827302 0.76347839 0.57156088 0.47339788
## Proportion of Variance 0.3673076 0.2827848 0.1609598 0.09714988 0.05444697 0.03735093
## Cumulative Proportion  0.3673076 0.6500924 0.8110522 0.90820210 0.96264907 1.00000000
## 
## Loadings:
##          Comp.1 Comp.2 Comp.3 Comp.4 Comp.5 Comp.6
## length   -0.450         0.479  0.742              
## left     -0.585 -0.107        -0.286 -0.700  0.269
## right    -0.572               -0.456  0.676       
## bottom   -0.281  0.616 -0.280        -0.116 -0.669
## top             -0.709  0.170               -0.673
## diagonal  0.206  0.315  0.809 -0.398 -0.165 -0.132
```

```r
# Produce the table of correlations between variables and principal components scores
lapply(X = 1:2, FUN = function(x, bn, pca_princomp){cor(bn[[x]], pca_princomp[[x]]$scores)}, bn_list, pca_princomp)
```

```
## [[1]]
##              Comp.1     Comp.2      Comp.3      Comp.4      Comp.5      Comp.6
## length   -0.6040179 -0.2359174  0.08150875  0.74782493  0.07767695 -0.08709660
## left     -0.6200661 -0.5889159 -0.30830023 -0.13750475 -0.39024330  0.04949458
## right    -0.5551664 -0.6357583  0.05822711 -0.39510269  0.34928037 -0.07815587
## bottom    0.7314361 -0.5915182 -0.02339861  0.04135207 -0.09317513 -0.32275120
## top      -0.5527111  0.5966905  0.45750911 -0.20515772 -0.15495164 -0.25111072
## diagonal  0.1954408 -0.5022568  0.82059065  0.01765530 -0.09538181  0.16359269
## 
## [[2]]
##              Comp.1      Comp.2      Comp.3      Comp.4      Comp.5      Comp.6
## length   -0.6673782  0.09638979  0.47048051  0.56617106  0.03711770  0.04512322
## left     -0.8685205 -0.13980768 -0.04744941 -0.21847248 -0.39984407  0.12754986
## right    -0.8494251 -0.04657390  0.07593872 -0.34808904  0.38626902  0.01309312
## bottom   -0.4174559  0.80274705 -0.27472900  0.03409475 -0.06630537 -0.31669047
## top      -0.1223100 -0.92334531  0.16752622  0.00424619 -0.05456601 -0.31845439
## diagonal  0.3055682  0.41077163  0.79551718 -0.30376457 -0.09408102 -0.06263385
```

```r
# Produce the graph of correlations between variables and principal components scores
lapply(X = 1:2, FUN = function(x, bn, pca_princomp){ggcorr(cbind(bn[[x]], pca_princomp[[x]]$scores), label = TRUE, cex = 2.5)}, bn_list, pca_princomp)
```

```
## [[1]]
```

![plot of chunk 02b-banknotes_altro3](figure/02b-banknotes_altro3-1.png)

```
## 
## [[2]]
```

![plot of chunk 02b-banknotes_altro3](figure/02b-banknotes_altro3-2.png)


```r
lapply(X = pca_princomp, FUN = function(x){plot(x, type = "lines")})
```

![plot of chunk 02b-banknotes_altro4](figure/02b-banknotes_altro4-1.png)![plot of chunk 02b-banknotes_altro4](figure/02b-banknotes_altro4-2.png)

```
## $counterfeit
## NULL
## 
## $genuine
## NULL
```


```r
lapply(X = pca_princomp, FUN = function(x){biplot(x, cex = c(.7, .7), col = c("black", "red"), choices = c("Comp.1","Comp.2"))})
```

![plot of chunk 02b-banknotes_altro5](figure/02b-banknotes_altro5-1.png)![plot of chunk 02b-banknotes_altro5](figure/02b-banknotes_altro5-2.png)

```
## $counterfeit
## NULL
## 
## $genuine
## NULL
```

The two types of banknotes have a different pattern in first two principal components. This difference could help to identify counterfeit banknotes, by using some classification models on scores.

## Example: US Companies

As a second example, we consider the `uscompanies` dataset (see the section *Introduction and datasets used* for further information), which is about some measurements for 79 U.S. companies:

- assets (USD);
- sales (USD);
- market value (USD);
- profits (USD);
- cash flow (USD);
- employees;

together with the name and industry for each company.


```r
summary(uscompanies)
```

```
##                    company       assets          sales             value            profits      
##  AHRobins              : 1   Min.   :  223   Min.   :  176.0   Min.   :   53.0   Min.   :-771.5  
##  AirProducts           : 1   1st Qu.: 1122   1st Qu.:  815.5   1st Qu.:  512.5   1st Qu.:  39.0  
##  AlliedSignal          : 1   Median : 2788   Median : 1754.0   Median :  944.0   Median :  70.5  
##  AmericanElectricPower : 1   Mean   : 5941   Mean   : 4178.3   Mean   : 3269.8   Mean   : 209.8  
##  AmericanSavingsBankFSB: 1   3rd Qu.: 5802   3rd Qu.: 4563.5   3rd Qu.: 1961.5   3rd Qu.: 188.1  
##  AMR                   : 1   Max.   :52634   Max.   :50056.0   Max.   :95697.0   Max.   :6555.0  
##  (Other)               :73                                                                       
##     cashflow         employees               industry  indshort
##  Min.   :-651.90   Min.   :  0.60   Finance      :17   H:10    
##  1st Qu.:  75.15   1st Qu.:  3.95   Energy       :15   E:15    
##  Median : 133.30   Median : 15.40   Manufacturing:10   F:17    
##  Mean   : 400.93   Mean   : 37.60   Retail       :10   M:10    
##  3rd Qu.: 328.85   3rd Qu.: 48.50   HiTech       : 8   *:17    
##  Max.   :9874.00   Max.   :400.20   Other        : 7   R:10    
##                                     (Other)      :12
```

```r
class(uscompanies) <- "data.frame"
ggscatmat(uscompanies, columns = 2:7)
```

![plot of chunk 02b-loaduc](figure/02b-loaduc-1.png)

The scatter plot matrix shows a considerable correlation among most of the
variables in the dataset.


```r
uscompanies.pca <- princomp(uscompanies[, 2:7], cor = TRUE)
summary(uscompanies.pca, loadings=TRUE)
```

```
## Importance of components:
##                           Comp.1     Comp.2     Comp.3      Comp.4      Comp.5      Comp.6
## Standard deviation     2.2446941 0.71894607 0.59914874 0.222495376 0.170618985 0.082890416
## Proportion of Variance 0.8397752 0.08614724 0.05982987 0.008250699 0.004851806 0.001145137
## Cumulative Proportion  0.8397752 0.92592249 0.98575236 0.994003057 0.998854863 1.000000000
## 
## Loadings:
##           Comp.1 Comp.2 Comp.3 Comp.4 Comp.5 Comp.6
## assets    -0.340  0.849 -0.339 -0.205              
## sales     -0.423  0.170  0.379  0.783         0.186
## value     -0.434 -0.190 -0.192         0.844 -0.149
## profits   -0.420 -0.364 -0.324 -0.156 -0.261  0.703
## cashflow  -0.428 -0.285 -0.267  0.121 -0.452 -0.667
## employees -0.397         0.726 -0.548
```

All the criteria described above suggest to consider 1 or 2 components:


```r
plot(uscompanies.pca, type = "lines")
```

![plot of chunk 02b-plotuc](figure/02b-plotuc-1.png)

The interpretation of the components is possible by calculating the
correlations of the estimated PCs with each one of the original variables:


```r
cor(uscompanies[, 2:7], uscompanies.pca$scores)
```

```
##               Comp.1       Comp.2     Comp.3      Comp.4        Comp.5        Comp.6
## assets    -0.7640054  0.610528047 -0.2032209 -0.04560644 -0.0131284954  0.0004911048
## sales     -0.9501539  0.122311772  0.2272352  0.17428114  0.0009825685  0.0153844264
## value     -0.9730942 -0.136721842 -0.1152070 -0.01576446  0.1439514105 -0.0123172226
## profits   -0.9420049 -0.261476847 -0.1941195 -0.03462414 -0.0444741214  0.0582879297
## cashflow  -0.9604894 -0.205099272 -0.1601623  0.02703225 -0.0771762309 -0.0552762583
## employees -0.8918124 -0.007075869  0.4352444 -0.12195179 -0.0167746411 -0.0054072075
```

The first PC is strongly related to all of the variables, while the second
one is only weakly related with the assets measure.

The plot of the first 2 PC scores reveals an interesting point:


```r
ggp <- ggplot(data = data.frame(uscompanies.pca$scores), mapping = aes(x = Comp.1, y = Comp.2)) +
  xlab("Component 1") + ylab("Component 2") +
  geom_text(label = uscompanies[, 9], size = 4)
print(ggp)
```

![plot of chunk 02b-plotscoresuc](figure/02b-plotscoresuc-1.png)

<!---

or, equivalently:


```r
qplot(x = uscompanies.pca$scores[, 1], y = uscompanies.pca$scores[, 2],
	  xlab = "Component 1", ylab = "Component 2",
	  label = as.character(uscompanies[, 9]), alpha = I(.001)) + geom_text(size = 4)
```

![plot of chunk 02b-plotscoresuc2](figure/02b-plotscoresuc2-1.png)
--->

The two outliers marked as belonging to the hi-tech industry on the left
are IBM and General Electric (GE), which differ from the other companies with
their high market values. As can be seen from the correlations above, market
value has the strongest relation with the first PC, adding to the isolation
of these two companies. The first component, then, is due mostly to IBM and GE.
If IBM and GE were to be excluded from the dataset, a completely different
picture would emerge:


```r
id <- match(c("IBM", "GeneralElectric"), uscompanies[, 1])
uscompanies_new <- uscompanies[-id, ]
uscompanies_new.pca <- princomp(uscompanies_new[, 2:7], cor = TRUE)
summary(uscompanies_new.pca, loadings=TRUE)
```

```
## Importance of components:
##                          Comp.1    Comp.2    Comp.3     Comp.4     Comp.5      Comp.6
## Standard deviation     1.786466 1.2389718 0.8892837 0.54066206 0.38593597 0.203473301
## Proportion of Variance 0.531910 0.2558419 0.1318043 0.04871924 0.02482443 0.006900231
## Cumulative Proportion  0.531910 0.7877518 0.9195561 0.96827534 0.99309977 1.000000000
## 
## Loadings:
##           Comp.1 Comp.2 Comp.3 Comp.4 Comp.5 Comp.6
## assets    -0.263  0.408  0.800        -0.333       
## sales     -0.438  0.407 -0.162  0.509  0.441  0.403
## value     -0.500               -0.801  0.264  0.190
## profits   -0.331 -0.623         0.192 -0.426  0.526
## cashflow  -0.443 -0.450  0.123  0.238  0.335 -0.646
## employees -0.427  0.277 -0.558        -0.575 -0.313
```

```r
plot(uscompanies_new.pca, type = "lines")
```

![plot of chunk 02b-plots2uc](figure/02b-plots2uc-1.png)

```r
cor(uscompanies_new[, 2:7], uscompanies_new.pca$scores)
```

```
##               Comp.1       Comp.2      Comp.3      Comp.4     Comp.5      Comp.6
## assets    -0.4700348  0.504983413  0.71122003  0.03646985 -0.1284184 -0.02009436
## sales     -0.7832050  0.504441483 -0.14367929  0.27537914  0.1701005  0.08195763
## value     -0.8940908  0.003531022  0.03114601 -0.43324402  0.1020753  0.03872158
## profits   -0.5906780 -0.772448025  0.07146335  0.10383555 -0.1645338  0.10706669
## cashflow  -0.7914552 -0.557670006  0.10975063  0.12861897  0.1294571 -0.13136056
## employees -0.7631623  0.343362099 -0.49621126 -0.01125642 -0.2219712 -0.06373629
```

And now the biplot:


```r
biplot(uscompanies_new.pca)
```

![plot of chunk 2b-plots2uc_biplot](figure/2b-plots2uc_biplot-1.png)

Following above criteria, 2 or 3 components should be retained. Moreover, it appears that the first PC
is a (inverse) "size effect", because it is strongly correlated with all 
variables describing the size of the activity of the companies. The second
component oppose "profits-cash flow" with "assets-sales", and is more
difficult to interpret from an economic point of view. The third component
is quite strongly related to assets as opposed to employees.

Anyway, notice that the distribution of companies in scatterplot matrix is very skewed. This
may in general lead to results that are highly influenced by few very high observations (units).
(Remember that the principal components analysis decomposes the Covariance matrix.). For this,
reason, it might be useful to analyze transformed data, such that they distribute "more regularly".

In following lines an "experiment":


```r
uscompanies_sq9 <- sign(uscompanies[,2:7])*abs(uscompanies[,2:7])^(1/9)
uscompanies_sq9 <- cbind(uscompanies[,1], uscompanies_sq9, uscompanies[,8:9])
ggscatmat(uscompanies_sq9, columns = 2:7)
```

![plot of chunk pca_on_transformed_vars](figure/pca_on_transformed_vars-1.png)

```r
uscompanies_sq9.pca <- princomp(uscompanies_sq9[, 2:7], cor = TRUE)
summary(uscompanies_sq9.pca, loadings=TRUE)
```

```
## Importance of components:
##                           Comp.1    Comp.2     Comp.3     Comp.4     Comp.5     Comp.6
## Standard deviation     1.7636737 1.3294470 0.75607642 0.49689411 0.47120897 0.28536392
## Proportion of Variance 0.5184241 0.2945716 0.09527526 0.04115063 0.03700631 0.01357209
## Cumulative Proportion  0.5184241 0.8129957 0.90827096 0.94942159 0.98642791 1.00000000
## 
## Loadings:
##           Comp.1 Comp.2 Comp.3 Comp.4 Comp.5 Comp.6
## assets    -0.401 -0.181  0.871         0.149  0.138
## sales     -0.523 -0.172 -0.216  0.268  0.177 -0.739
## value     -0.513               -0.605 -0.602       
## profits           0.691  0.118  0.568 -0.419       
## cashflow  -0.177  0.665        -0.384  0.615       
## employees -0.511 -0.114 -0.422  0.290  0.173  0.658
```

```r
plot(uscompanies_sq9.pca, type = "lines")
```

![plot of chunk pca_on_transformed_vars](figure/pca_on_transformed_vars-2.png)

```r
cor(uscompanies_sq9[, 2:7], uscompanies_sq9.pca$scores)
```

```
##               Comp.1      Comp.2      Comp.3      Comp.4      Comp.5        Comp.6
## assets    -0.7074821 -0.24086010  0.65817696  0.04209069  0.07024646  0.0394007257
## sales     -0.9228941 -0.22877877 -0.16336832  0.13338807  0.08328232 -0.2109720873
## value     -0.9047090  0.09283965 -0.04536406 -0.30051610 -0.28375089  0.0002282385
## profits   -0.1722917  0.91841229  0.08956263  0.28239364 -0.19756954 -0.0057515751
## cashflow  -0.3124649  0.88424064 -0.00604104 -0.19098704  0.28972427 -0.0056093081
## employees -0.9013674 -0.15196805 -0.31882531  0.14424842  0.08172474  0.1878997968
```

The above results suggest a solution with 2 principal components.
The first component seem to oppose pure profits to all other variables. 
The second component, however, opposes "financial" to "capital" indicators.  
In following graphs, the score plot the biplot are produced.


```r
ggp <- ggplot(data = data.frame(uscompanies_sq9.pca$scores), mapping = aes(x = Comp.1, y = Comp.2)) +
  xlab("Component 1") + ylab("Component 2") +
  geom_text(label = uscompanies[, 9], size = 4)
print(ggp)
```

![plot of chunk pca_on_transformed_vars_2](figure/pca_on_transformed_vars_2-1.png)

```r
biplot(uscompanies_sq9.pca)
```

![plot of chunk pca_on_transformed_vars_2](figure/pca_on_transformed_vars_2-2.png)


# Exploratory Factor Analysis (EFA)

Factor analysis is related to principal components, but the two methods have
different goals. Principal components tries to identify orthogonal linear
combinations of the variables, to be used either for descriptive purposes or
to substitute a smaller number of uncorrelated components for the original
variables. In contrast, factor analysis represents a model for the data, and
as such is more elaborate.  
The factor analysis model hypothesizes that the response variables can be
modeled as linear combinations of a smaller set of unobserved, "latent"
(i.e. unobserved) random variables, called common factors, along with an
error term, also known as the specific factor (for more details about the
model specification see Johnson and Wichern, *Applied Multivariate Statistical Analysis*, 6th edition, Pearson, 2014).  
The coefficients of the linear combinations are called the factor loadings.
The variabilities of the response variables explained by the set of common
factors are called the communalities, while the unexplained variabilities are
called uniqueness or specific variances.


## Example: Drug Usage

The example we consider is based on `druguse` dataset (see the section *Introduction and datasets used* for further information), which is about drug usage rates for a sample of 1,634 students in the seventh to ninth grades in 11 schools in the greater metropolitan area of Los Angeles. Each participant completed a questionnaire about the number of times a particular substance had ever been used. The substances asked about were as follows:

- cigarettes;
- beer;
- wine;
- liquor;
- cocaine;
- tranquillizers;
- drug store medications used to get high;
- heroin and other opiates;
- marijuana;
- hashish;
- inhalants (glue, gasoline, etc.);
- hallucinogenics (LSD, mescaline, etc.);
- amphetamine stimulants.

Responses were recorded on a five-point scale: never tried, only once, a few times, many times, and regularly.  
The correlations between the usage rates of the 13 substances are represented graphically using the `levelplot()` function from the package `lattice` with a somewhat lengthy panel function (the correlation coefficients multiplied by 100 are printed inside the ellipses):


```r
require(lattice)
require(ellipse)
```


```r
panel.corrgram <- function(x, y, z, subscripts, at, level = 0.9, label = FALSE, ...) {
	#require("ellipse", quietly = TRUE)
	x <- as.numeric(x)[subscripts]
	y <- as.numeric(y)[subscripts]
	z <- as.numeric(z)[subscripts]
	zcol <- level.colors(z, at = at, ...)
	for (i in seq(along = z)) {
		ell <- ellipse(z[i], level = level, npoints = 50, scale = c(.2, .2),
					   centre = c(x[i], y[i]))
		panel.polygon(ell, col = zcol[i], border = zcol[i], ...)
	}
	if (label) {
		panel.text(x = x, y = y, lab = 100 * round(z, 2), cex = 0.8,
				   col = ifelse(z < 0, "white", "black"))
	}
}
print(levelplot(druguse, at = do.breaks(c(-1.01, 1.01), 20), 
	  xlab = NULL, ylab = NULL, colorkey = list(space = "top"), 
	  scales = list(x = list(rot = 90)), panel = panel.corrgram, label = TRUE))
```

![plot of chunk 02b-loaddu](figure/02b-loaddu-1.png)

Note that the correlation structure is not very strong. To function
appropriately, factor analysis requires a minimum level of correlation.  
Tests have been developed to ascertain whether there exists sufficiently
high correlation to perform factor analysis:

- **Kaiser–Meyer–Olkin statistic**: measures the proportion of variability
									   within the standardized predictor
									   variables which is shared in common,
									   and therefore might be caused by
									   underlying factors; values of the KMO
									   statistic less than 0.50 indicate that
									   factor analysis may not be appropriate.
- **Bartlett's test**: tests the null hypothesis that the correlation
						  matrix is an identity matrix, that is, that the
						  variables are really uncorrelated. Of course, if Bartlett's test
              "says" that the correlation matrix may be an Identity matrix, 
              then a factor analysis may be unuseful

Both tools are available in the `psych` package:


```r
require(psych)
```


```r
KMO(druguse)
```

```
## Kaiser-Meyer-Olkin factor adequacy
## Call: KMO(r = druguse)
## Overall MSA =  0.87
## MSA for each item = 
##            cigarettes                  beer                  wine                liquor 
##                  0.89                  0.84                  0.83                  0.88 
##               cocaine        tranquillizers drug store medication                heroin 
##                  0.87                  0.87                  0.88                  0.88 
##             marijuana               hashish             inhalants       hallucinogenics 
##                  0.87                  0.88                  0.91                  0.85 
##           amphetamine 
##                  0.86
```

```r
cortest.bartlett(druguse, n = 1634)
```

```
## $chisq
## [1] 6592.802
## 
## $p.value
## [1] 0
## 
## $df
## [1] 78
```

Since both tools provide reasonable results, we proceed with the factor
analysis. The factor analysis model can be estimated in `R` using the function
`factanal()`, which implements a maximum likelihood approach for the estimation
of the factor loadings:


```r
du_fa2 <- factanal(covmat = druguse, n.obs = 1634, factors = 2,
                   rotation = "none")
du_fa2
```

```
## 
## Call:
## factanal(factors = 2, covmat = druguse, n.obs = 1634, rotation = "none")
## 
## Uniquenesses:
##            cigarettes                  beer                  wine                liquor 
##                 0.635                 0.367                 0.447                 0.405 
##               cocaine        tranquillizers drug store medication                heroin 
##                 0.774                 0.552                 0.876                 0.764 
##             marijuana               hashish             inhalants       hallucinogenics 
##                 0.540                 0.577                 0.704                 0.604 
##           amphetamine 
##                 0.430 
## 
## Loadings:
##                       Factor1 Factor2
## cigarettes             0.570  -0.200 
## beer                   0.667  -0.435 
## wine                   0.612  -0.422 
## liquor                 0.708  -0.306 
## cocaine                0.321   0.351 
## tranquillizers         0.514   0.429 
## drug store medication  0.277   0.216 
## heroin                 0.310   0.374 
## marijuana              0.677         
## hashish                0.616   0.207 
## inhalants              0.474   0.266 
## hallucinogenics        0.412   0.476 
## amphetamine            0.604   0.454 
## 
##                Factor1 Factor2
## SS loadings      3.783   1.542
## Proportion Var   0.291   0.119
## Cumulative Var   0.291   0.410
## 
## Test of the hypothesis that 2 factors are sufficient.
## The chi square statistic is 478.08 on 53 degrees of freedom.
## The p-value is 9.79e-70
```

The output of a factor analysis is very similar to that of a PCA and it can
be interpreted in a similar way: choosing two factors, we are able to explain
about 41% of the overall variance of the original variables. However, looking
at the factor loadings (which now provide the correlation with each one of
the original variables) we cannot easily interpret them. Finally, the
uniquenesses signal that most of the variability for many of the original
variables is still unexplained. These conclusions suggest that probably
this first solution is not appropriate.

If multivariate normality hypothesis is acceptable, to determine a reasonable 
number of factors to extract, we may use the likelihood 
ratio test provided by the `factanal()` function for the null hypothesis
that a given number of factors is sufficient:


```r
pval <- sapply(1:6, function(nf)
		factanal(covmat = druguse, factors = nf, n.obs = 1634)$PVAL)
names(pval) <- sapply(1:6, function(nf) paste0("nf = ", nf))
pval
```

```
##       nf = 1       nf = 2       nf = 3       nf = 4       nf = 5       nf = 6 
## 0.000000e+00 9.786000e-70 7.363910e-28 1.794578e-11 3.891743e-06 9.752967e-02
```
These values suggest that the six-factor solution provides an adequate
fit. The results from the six-factor solution are obtained from:


```r
du_fa6 <- factanal(covmat = druguse, n.obs = 1634, factors = 6,
				   rotation = "none")
du_fa6
```

```
## 
## Call:
## factanal(factors = 6, covmat = druguse, n.obs = 1634, rotation = "none")
## 
## Uniquenesses:
##            cigarettes                  beer                  wine                liquor 
##                 0.563                 0.368                 0.374                 0.412 
##               cocaine        tranquillizers drug store medication                heroin 
##                 0.681                 0.522                 0.785                 0.669 
##             marijuana               hashish             inhalants       hallucinogenics 
##                 0.318                 0.005                 0.541                 0.620 
##           amphetamine 
##                 0.005 
## 
## Loadings:
##                       Factor1 Factor2 Factor3 Factor4 Factor5 Factor6
## cigarettes             0.325   0.523                  -0.225         
## beer                   0.306   0.708           0.130   0.126         
## wine                   0.253   0.711                   0.220         
## liquor                 0.391   0.647                                 
## cocaine                0.341           0.424                   0.140 
## tranquillizers         0.546           0.325  -0.148           0.223 
## drug store medication  0.235           0.343                  -0.168 
## heroin                 0.316           0.448                   0.129 
## marijuana              0.544   0.441           0.156  -0.406         
## hashish                0.840                   0.538                 
## inhalants              0.412   0.166   0.425                  -0.274 
## hallucinogenics        0.518           0.275  -0.126   0.106         
## amphetamine            0.869                  -0.489                 
## 
##                Factor1 Factor2 Factor3 Factor4 Factor5 Factor6
## SS loadings      3.180   1.937   0.873   0.643   0.309   0.196
## Proportion Var   0.245   0.149   0.067   0.049   0.024   0.015
## Cumulative Var   0.245   0.394   0.461   0.510   0.534   0.549
## 
## Test of the hypothesis that 6 factors are sufficient.
## The chi square statistic is 22.41 on 15 degrees of freedom.
## The p-value is 0.0975
```

To better interpret the estimated factors, we can apply a rotation to the
factor loadings. A very popular rotation is the varimax rotation, which aims
to produce factors that have high correlations with one small set of
variables and little or no correlation with other sets. We can apply a
rotation directly in the `factanal()` function by providing the name of the
rotation method in the 'rotation' argument:


```r
du_fa6_rot <- factanal(covmat = druguse, n.obs = 1634, factors = 6,
					   rotation = "varimax")
du_fa6_rot
```

```
## 
## Call:
## factanal(factors = 6, covmat = druguse, n.obs = 1634, rotation = "varimax")
## 
## Uniquenesses:
##            cigarettes                  beer                  wine                liquor 
##                 0.563                 0.368                 0.374                 0.412 
##               cocaine        tranquillizers drug store medication                heroin 
##                 0.681                 0.522                 0.785                 0.669 
##             marijuana               hashish             inhalants       hallucinogenics 
##                 0.318                 0.005                 0.541                 0.620 
##           amphetamine 
##                 0.005 
## 
## Loadings:
##                       Factor1 Factor2 Factor3 Factor4 Factor5 Factor6
## cigarettes             0.494                           0.407   0.110 
## beer                   0.776                           0.112         
## wine                   0.786                                         
## liquor                 0.720   0.121   0.103   0.115   0.160         
## cocaine                        0.519           0.132           0.158 
## tranquillizers         0.130   0.564   0.321   0.105   0.143         
## drug store medication          0.255                           0.372 
## heroin                         0.532   0.101                   0.190 
## marijuana              0.429   0.158   0.152   0.259   0.609   0.110 
## hashish                0.244   0.276   0.186   0.881   0.194   0.100 
## inhalants              0.166   0.308   0.150           0.140   0.537 
## hallucinogenics                0.387   0.335   0.186           0.288 
## amphetamine            0.151   0.336   0.886   0.145   0.137   0.187 
## 
##                Factor1 Factor2 Factor3 Factor4 Factor5 Factor6
## SS loadings      2.301   1.415   1.116   0.964   0.676   0.666
## Proportion Var   0.177   0.109   0.086   0.074   0.052   0.051
## Cumulative Var   0.177   0.286   0.372   0.446   0.498   0.549
## 
## Test of the hypothesis that 6 factors are sufficient.
## The chi square statistic is 22.41 on 15 degrees of freedom.
## The p-value is 0.0975
```

Substances that load highly on the first factor are cigarettes, beer, wine,
liquor, and marijuana and we might label it "social/soft drug use". Cocaine,
tranquillizers, and heroin load highly on the second factor - the obvious
label for the factor is "hard drug use". Factor three is essentially simply
amphetamine use, and factor four hashish use. The remaining factors load
mainly on a single variable.

As for PCA, we can ask for the factor scores in EFA adding the argument
'scores', which can only be produced if a data matrix is supplied and used.
The scores are the accessible through the scores element in the returned
list.

# Some Theoretical Backgrounds

## PCA

The aim of Principal Components Analysis is to find the linear combinations of analyzed variables that report highest variability, given the data.

Let us suppose that the data contains numerical values for $p$ variables on $n$ cases. Let name $X$ the $(n \times p)$ data matrix.  
Let us suppose then that each row of $X$, denoted by  $\underline{x}$ , is a random realization from the same multivariate random distribution, with variance/covariance matrix denoted by $\Sigma$.  
Now, we want to find the linear combination 
$$
z= \underline{a}^T\underline{x}
$$
Such that $Var(z)$ is maximum. Since this problem has no unique solution, we will constraint the problem within unit norm vector ($\underline{a}^T\underline{a}=1$).

However, it may be shown that $Var(z)= \underline{a}^T \Sigma \underline{a}$, and then that the above problem can be expressed as a constraint maximization problem:
$$
\max_{\begin{matrix}
\underline{a}\\
s.t.:\underline{a}^T\underline{a}=1
\end{matrix} } \left\{\underline{a}^T \Sigma \underline{a}\right\}
\\ 
$$

This optimum problem can be solved by using Lagrange multipliers, and the solution is given by the $\underline{a}$('s) vector(s) such that 
$$
(\Sigma - \lambda \underline{I}) \underline{a}=\underline{0}
$$

i.e., the solution of the problem is given by the (orthonormal) eigenvectors of $\Sigma$.  

The number of non-null eigenvalues $\lambda$ is equal to $g = rank(X) \le p$, and they sum up to the sum of diagonal elements of $\Sigma$, i.e., the variances of $\underline{x}$. At each eigenvalue correspond an eigenvector $\underline{a}$ that is a solution of above equation.  
As a result of these calculations we obtain a factorization of $\Sigma$ as:
$$
\Sigma = \Gamma \Lambda \Gamma^T
$$

Where $\Gamma$ is the $(p \times g)$ matrix resulting combining side by side the eigenvectors $\underline{a}$, and $\Lambda$ is the $(g \times g)$ diagonal matrix containing the $g$ eigenvaules ($\lambda$) in descending order of magnitude.

The $\underline{a}$ vectors are called loadings, while the $\underline{z}$ are named scores. Consequently, if there are $p$ non null eigenvalues, then there are also $p$ distinct $\underline{z}$'s, one for each solution, and then we may think to a $\underline{z}$ vector:
$\underline{z}=\Gamma^T \underline{x}$.

The variance/covariance matrix of $\underline{z}$ is then:
$$
Var\{\underline{z}\}=\Gamma^T Var\{\underline{x}\}\Gamma=\Gamma^T \Gamma \Lambda \Gamma^T \Gamma=\Lambda
$$

Of course, $\Sigma$ is usually unknown. In that cases, we can use $S$, the sample estimate of $\Sigma$ in place of $\Sigma$ itself. 

Anyway, given the above results, and given a data matrix $X$, we can obtain a sample score matrix $Z$ as:
$$
Z = X \Gamma
$$
Where $\Gamma$ is the matrix of eigenvectors obtained from $S$.

The sample variance/covariance matrix of $Z$, of course, is $\Lambda$, where $\Lambda$ is the diagonal matrix obtained by factorizing $S$ as above.


## EFA

EFA is very similar to PCA in terms of goals and of methods used to obtain the results.  
However, notice that in this paragraph the notations and smybols are disjointed from the notations and symbols used for describing PCA. 

EFA hypothesizes that the individual data vector, $\underline{x}$, comes from a multivariate distribution with mean $\underline{\mu}$ and variance/covariance matrix $\Sigma$, and that the following model holds:
$$
\underline{x} = \Gamma \underline{f} + \underline{\varepsilon} + \underline{\mu}
$$
where $\Gamma$ is a $(p \times g)$ matrix of constants (_factor loadings_), and $\underline{f}$  and $\underline{\varepsilon}$ are, respectively, the $(g \times 1)$ and $(p \times 1)$ random vectors of _common_ and _specific_ factors, for which:
$$
E\{\underline{f}\}=\underline{0}; Var\{\underline{f}\}=\underline{I}
$$
$$
E\{\underline{\varepsilon}\}=\underline{0}; Var\{\underline{\varepsilon}\}=\Lambda=diag(\lambda_1,\cdots,\lambda_g)
$$
and
$$
Cov\{\underline{f},\underline{\varepsilon}\}=\underline{0}
$$
Thus, all the factors are uncorrelated with one anoter and further the factors $\underline{f}$ are each standardized to have variance 1.  
It is sometimes convenient to suppose that $\underline{f}$ and $\underline{\varepsilon}$ (ad hence $\underline{x}$) are multinormally distributed.

The validity of $g$-factor model can be expressed in terms of a simple condition on $\Sigma$:
$$
\Sigma=\Gamma \Gamma^T + \Lambda
$$

The converse also holds. If $\Sigma$ can be decomposed into the form above, then the $g$-factor model holds for $\underline{x}$.


### Non-Uniqueness of Factor Loadings

Since the above results, one may argue that there is no unique solution on EFA model. In fact, if $\Phi$ is a rotation matrix (i.e., a matrix such that $\Phi \Phi^T=\underline{I}$), then $\underline{x}$ may be written as:
$$
\underline{x} = (\Gamma\Phi) (\Phi^T \underline{f}) + \underline{\varepsilon} + \underline{\mu}
$$
Since the random vector $\Phi^T \underline{f}$ satisfies the above conditions about the factors and the following holds for $\Sigma$:
$$
\Sigma=(\Gamma\Phi)(\Gamma\Phi)^T + \Lambda = \Gamma\Gamma^T + \Lambda 
$$
Then the $g$-factor model is valid with new factors $(\Phi^T \underline{f})$ and new factor loadings $(\Gamma\Phi)$.

This allows the researcher to find some rotational strategy on loadings to make the factor solutions more easily interpretable.

<!---
# Exercises with life or iris data
--->
