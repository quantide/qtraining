---
title: "Multidimensional Scaling (MDS)"
---






# Introduction

Multidimensional Scaling (MDS) is a set of techniques for projecting points from a highly-dimensional
space onto a smaller space, usually involving just 2 or 3 dimensions, with
the aim of matching the distances between points in the reduced space as
well as possible with those in the original space. The inputs for MDS are
"proximity data", that is the observed similarities or dissimilarities among
all pairs of observations. The proximity matrix is usually displayed as a
lower-triangular array of nonnegative entries, with the understanding that
the diagonal entries are all zeros and that the upper-triangular array is a
mirror image of the given lower-triangle (i.e., the matrix is symmetric).

The general problem of MDS essentially can be stated as follows: given only a
table of proximities between objects (i.e., either observations or
variables), we wish to reconstruct the original map as closely as possible.
A further wrinkle in the problem is that we also do not know the number of
dimensions in which the given entities are located. So, determining the
number of dimensions is another major problem to be solved.

In its basic flavor, MDS is mainly used for visualization purposes for
identifying "clusters" of points, but many variants have been developed to
deal with more specific objectives such as uncovering latent dimensions of
judgment.


# Metric MDS

The `R` function that implements the so-called classical (or metric) MDS is
`cmdscale()`.

## Example: `mds` Fake Data

As a first example, we consider the `mds` fake dataset (see the section *Introduction and datasets used* for further information):


```r
mds
```

```
##    V1 V2 V3 V4 V5
## 1   3  4  4  6  1
## 2   5  1  1  7  3
## 3   6  2  0  2  6
## 4   1  1  1  0  3
## 5   4  7  3  6  2
## 6   2  2  5  1  0
## 7   0  4  1  1  1
## 8   0  6  4  3  5
## 9   7  6  5  1  4
## 10  2  1  4  3  1
```

```r
pairs(x = mds, pch = as.character(as.numeric(rownames(mds))-1))
```

![plot of chunk 02a-loadfk](figure/02a-loadfk-1.png)

or:


```r
require(GGally)
```


```r
ggpairs(data = mds)
```

![plot of chunk 02a-alternative_pairs](figure/02a-alternative_pairs-1.png)

We create the proximity matrix by calculating the corresponding Euclidean
distances via the `dist()` function (other distance measures available through
the `method` argument are `"maximum"`, `"manhattan"`, `"canberra"`, `"binary"` or
`"minkowski"`; see the help page of the `dist()` function for more details).


```r
D <- dist(mds, method = "euclidean")
```

Then we apply classical scaling to this matrix using the `cmdscale()`
function and saving also the corresponding eigenvalues:


```r
X_mds <- cmdscale(D, k = 9, eig = TRUE)
```

```
## Warning in cmdscale(D, k = 9, eig = TRUE): only 7 of the first 9 eigenvalues are > 0
```

Some notes:

1. when dissimilarities are defined as Euclidean inter-point distances,
       this type of classical MDS is equivalent to PCA (see the chapter on PCA and EFA) in that the MDS
       coordinates are identical to the scores of the corresponding principal
       components;
2. if any of the eigenvalues are negative, a suitable constant can be
       added to the dissimilarities, or the negative eigenvalues can be simply
       ignored.

One way of determining the dimensionality of the resulting configuration is
to look at the eigenvalues. The usual strategy is to plot the ordered eigenvalues against dimension and then identify a dimension at which the eigenvalues become "stable" (i.e., do not change perceptively). At that dimension,
we may observe an "elbow" that shows where stability occurs. For easier
graphical interpretation of a classical scaling solution, we hope that the
dimension at we reach stability is small, usually of the order 2 or 3. The
plot of the eigenvalues for our example is obtained as


```r
require(ggplot2)
```


```r
eig <- X_mds$eig
dims <- 1:attr(D, "Size")
eig <- data.frame(Dimensions = dims, Eigenvalue = eig)
ggp <- ggplot(eig, aes(x = Dimensions, y = Eigenvalue)) +
  geom_point() +
  geom_line() +
  scale_x_continuous("Dimensions", breaks = dims) +
  geom_hline(yintercept = 0, linetype = "dashed")
print(ggp)
```

![plot of chunk 02a-screefk](figure/02a-screefk-1.png)

Note that as there are 5 variables in the `mds` data frame, eigenvalues 6 to 7
are essentially zero and only the first five columns of points represent the
Euclidean distances. First, the five-dimensional solution achieves complete
recovery of the observed distances. We can check this by comparing the
original distances with those calculated from the five-dimensional scaling
solution coordinates using the following code:


```r
ggp <- ggplot(data = data.frame(x = as.numeric(D), y = as.numeric(dist(cmdscale(D, k = 5)))),
            mapping = aes(x = x, y = y)) +
  geom_point() +
  geom_abline(intercept = 0, slope = 1) +
  xlab("Original distances") +
  ylab("Fitted distances")
print(ggp)
```

![plot of chunk 02a-coordsfk_alternative_plot](figure/02a-coordsfk_alternative_plot-1.png)

```r
max(abs(dist(mds) - dist(cmdscale(D, k = 5))))
```

```
## [1] 1.065814e-14
```

We can also compute some fitting criteria. The most popular ones are those
introduced by Mardia:


```r
X_eig <- X_mds$eig
P1 <- cumsum(abs(X_eig))/sum(abs(X_eig))
P2 <- cumsum(X_eig^2)/sum(X_eig^2)

mardia <- data.frame(Dimensions = rep(dims,2), P = c(P1, P2), 
                     Criterion=rep(c("P1", "P2"),each=attr(D, "Size")))
ggp <- ggplot(data = mardia, aes(x = Dimensions, y = P, colour=Criterion)) +
  geom_point() +
  geom_line() +
  scale_x_continuous("Dimensions", breaks = dims) +
  scale_y_continuous("Value", breaks = seq(0, 1, by = .1)) +
  geom_hline(yintercept = .8, linetype = "dashed", color = "darkgray")
print(ggp)
```

![plot of chunk 02a-fittingfk](figure/02a-fittingfk-1.png)

We should look for values above 0.8 to claim a good fit. In our example both
criteria suggest that a 3-dimensional solution seems to fit well. This is
confirmed by the following plot that compares the observed distances with
those returned by the solution with 3 dimensions:


```r
X_final <- X_mds$points[, 1:3]
D_hat <- dist(X_final, method = "euclidean")
D_all <- data.frame(Observed = as.numeric(D), Fitted = as.numeric(D_hat))
ggplot(data = D_all, mapping = aes(x = Observed, y = Fitted)) +
  geom_point() +
  scale_y_continuous(limits = c(0, 10)) + 
  scale_x_continuous(limits = c(0, 10)) +
  geom_abline(linetype = "dashed", color = "gray")
```

![plot of chunk 02a-fittingfinalfk](figure/02a-fittingfinalfk-1.png)

And finally we plot the MDS coordinates for the 3-dimensional solution:


```r
pairs(x = X_final, pch = as.character(as.numeric(rownames(mds))-1))
```

![plot of chunk 02a-plotfinalfk](figure/02a-plotfinalfk-1.png)

or: (this is a 3D plot: try it in your `R`)


```r
require(rgl)
open3d()
with(data.frame(X_final),
     plot3d(x = X1, y = X2, z = X3,
            xlab = "X1", ylab = "X2", zlab = "X3", type = "p")
     )
```

Note that MDS aims at preserving the distances, so the fitted coordinates
may be very different from the original ones. In particular, the Euclidean
distance is invariant under rigid transformations (translations, rotations
and reflections), therefore to practically interpret the coordinates it is
usually better to post-process the solution by applying some transformations.

## Example: Graphical illustration on fake data

To show better the behavor of metric MDS, we prouce a set of fake data:

```r
x <- 1:10
y <- 1:10

comb <- expand.grid(x,y)
names(comb) <-c("x","y")
comb$z= 2 + 3 * comb$x - 2 * comb$y + runif(n = 100,min = -2, max = 2)
```

The data points of variables just created are almost perfectly linear dependent:

```r
open3d()
with(comb,
     plot3d(x = x, y = y, z = z,
            xlab = "x", ylab = "y", zlab = "z", type = "p"
     ))
```

We can then produce an MDS analysis:


```r
D <- dist(x = comb,method = "euclidean")
mds_1 <- cmdscale(d = D,k = 3,eig = TRUE)
mds_1
```

```
## $points
##                [,1]       [,2]         [,3]
##   [1,]  -3.78582579 -6.2293102  0.323071228
##   [2,]  -2.63882926 -5.6818522 -0.233075864
##   [3,]   2.00978836 -5.1343942  0.159846847
##   [4,]   4.34502381 -4.5869363 -0.074243221
##   [5,]   7.17699255 -4.0394783 -0.173700054
##   [6,]  12.05899925 -3.4920203  0.282479793
##   [7,]  15.12695212 -2.9445624  0.246983454
##   [8,]  16.75625996 -2.3971044 -0.178439301
##   [9,]  20.30919144 -1.8496465 -0.082488367
##  [10,]  22.17830961 -1.3021885 -0.442913584
##  [11,]  -5.31580505 -5.3924770  0.475599930
##  [12,]  -2.93913117 -4.8450190  0.252741223
##  [13,]  -1.30211653 -4.2975611 -0.170592701
##  [14,]   0.96285743 -3.7501031 -0.423726249
##  [15,]   5.97043365 -3.2026451  0.066487618
##  [16,]   8.05046736 -2.6551872 -0.236771630
##  [17,]  12.48169963 -2.1077292  0.097231548
##  [18,]  15.34841050 -1.5602712  0.007191129
##  [19,]  19.71981685 -1.0128133  0.324979252
##  [20,]  19.56953917 -0.4653553 -0.582777494
##  [21,] -10.31024539 -4.5556438 -0.310869422
##  [22,]  -4.42962609 -4.0081858  0.415971653
##  [23,]  -2.10845417 -3.4607279  0.178069847
##  [24,]  -0.20764804 -2.9132699 -0.173766754
##  [25,]   5.29262641 -2.3658119  0.449986693
##  [26,]   5.32911787 -1.8183540 -0.407148656
##  [27,]  10.70875409 -1.2708960  0.183907337
##  [28,]  11.11899863 -0.7234381 -0.571927003
##  [29,]  17.75905057 -0.1759801  0.360748619
##  [30,]  20.00588914  0.3714779  0.102699706
##  [31,]  -9.09033410 -3.7188106  0.586982093
##  [32,]  -8.86580153 -3.1713526 -0.219187108
##  [33,]  -5.23262251 -2.6238947 -0.101486100
##  [34,]  -1.91252380 -2.0764367 -0.068641520
##  [35,]   1.33334297 -1.5289788 -0.055916566
##  [36,]   3.46818463 -0.9815208 -0.344320817
##  [37,]   6.93450973 -0.4340628 -0.271843438
##  [38,]  10.28114996  0.1133951 -0.231805118
##  [39,]  15.71689535  0.6608531  0.374458550
##  [40,]  17.89984831  1.2083111  0.099094255
##  [41,] -12.07669794 -2.8819774  0.344776302
##  [42,] -11.79992891 -2.3345195 -0.447234874
##  [43,]  -8.18713737 -1.7870615 -0.335059629
##  [44,]  -2.92200912 -1.2396035  0.224960434
##  [45,]  -0.03564096 -0.6921456  0.140247871
##  [46,]   2.40073987 -0.1446876 -0.066428027
##  [47,]   7.35374630  0.4027704  0.408995394
##  [48,]   9.24849929  0.9502283  0.055518166
##  [49,]  13.18249826  1.4976863  0.254752591
##  [50,]  15.27082830  2.0451442 -0.046258042
##  [51,] -14.04033926 -2.0451442  0.379766427
##  [52,] -12.88740698 -1.4976863 -0.174771858
##  [53,] -10.03343031 -0.9502283 -0.268263723
##  [54,]  -6.83160871 -0.4027704 -0.267476650
##  [55,]  -3.68369576  0.1446876 -0.281300828
##  [56,]  -0.82585369  0.6921456 -0.373745025
##  [57,]   2.94665932  1.2396035 -0.218279312
##  [58,]   5.90582900  1.7870615 -0.283259953
##  [59,]   9.59692515  2.3345195 -0.149861243
##  [60,]  11.93638027  2.8819774 -0.382807619
##  [61,] -17.88527093 -1.2083111 -0.095143243
##  [62,] -14.45196896 -0.6608531 -0.031616363
##  [63,]  -9.73388415 -0.1133951  0.380134547
##  [64,]  -8.66013416  0.4340628 -0.195865090
##  [65,]  -5.58014790  0.9815208 -0.228099934
##  [66,]  -1.35399714  1.5289788  0.050318515
##  [67,]   3.41919995  2.0764367  0.477006905
##  [68,]   5.19519793  2.6238947  0.091342644
##  [69,]   6.96257918  3.1713526 -0.296657072
##  [70,]  12.64838165  3.7188106  0.377381385
##  [71,] -19.38776754 -0.3714779  0.064834282
##  [72,] -15.71619014  0.1759801  0.192942683
##  [73,] -11.66595226  0.7234381  0.423682187
##  [74,] -11.14694697  1.2708960 -0.302673936
##  [75,]  -6.74286667  1.8183540  0.023970049
##  [76,]  -2.09698970  2.3658119  0.416149939
##  [77,]  -1.50171450  2.9132699 -0.289534194
##  [78,]   2.48247283  3.4607279 -0.076696852
##  [79,]   7.55825860  4.0081858  0.432004346
##  [80,]  10.16566881  4.5556438  0.271683782
##  [81,] -19.61516787  0.4653553  0.570410416
##  [82,] -19.32963949  1.0128133 -0.219226648
##  [83,] -15.12638952  1.5602712  0.052984832
##  [84,] -12.31330992  2.1077292 -0.051591664
##  [85,] -10.33487059  2.6551872 -0.382386774
##  [86,]  -6.51454052  3.2026451 -0.213960857
##  [87,]  -1.73123333  3.7501031  0.215467747
##  [88,]   0.10083888  4.2975611 -0.154998308
##  [89,]   2.70988605  4.8450190 -0.314875194
##  [90,]   7.92675092  5.3924770  0.232063697
##  [91,] -22.70270233  1.3021885  0.300783618
##  [92,] -21.71674252  1.8496465 -0.299010428
##  [93,] -17.91986101  2.3971044 -0.136939945
##  [94,] -15.41858447  2.9445624 -0.326026689
##  [95,]  -9.57681797  3.4920203  0.390283833
##  [96,]  -5.90105631  4.0394783  0.519526324
##  [97,]  -4.85863716  4.5869363 -0.064965138
##  [98,]  -3.48635881  5.1343942 -0.560052463
##  [99,]   3.31133676  5.6818522  0.415350458
## [100,]   5.69666863  6.2293102  0.194838389
## 
## $eig
##   [1]  1.193569e+04  8.250000e+02  8.795205e+00  1.301265e-12  7.568084e-13  7.248820e-13  4.059308e-13
##   [8]  3.722847e-13  3.510998e-13  3.454486e-13  2.729410e-13  2.628643e-13  2.231014e-13  1.994758e-13
##  [15]  1.794196e-13  1.494435e-13  1.344211e-13  1.080541e-13  7.848085e-14  7.262745e-14  5.721879e-14
##  [22]  5.523656e-14  5.496507e-14  4.515499e-14  4.504924e-14  3.958107e-14  3.580342e-14  3.507832e-14
##  [29]  3.211283e-14  2.590526e-14  2.567834e-14  2.527702e-14  2.477519e-14  2.424104e-14  2.278892e-14
##  [36]  2.186685e-14  2.165138e-14  1.629991e-14  1.286909e-14  1.246627e-14  1.047589e-14  7.324301e-15
##  [43]  7.288127e-15  5.219435e-15  4.716585e-15  3.969586e-15  3.152541e-15  2.776255e-15  2.580326e-15
##  [50]  2.438341e-15 -7.733575e-16 -1.667202e-15 -2.557769e-15 -2.757136e-15 -3.054991e-15 -3.856298e-15
##  [57] -3.910191e-15 -5.667547e-15 -6.167489e-15 -7.373495e-15 -1.123636e-14 -1.297283e-14 -1.318041e-14
##  [64] -1.374772e-14 -1.759541e-14 -1.780896e-14 -2.062988e-14 -2.067789e-14 -2.139902e-14 -2.395276e-14
##  [71] -2.686724e-14 -3.074238e-14 -3.314011e-14 -3.754670e-14 -4.342048e-14 -4.355645e-14 -4.372658e-14
##  [78] -4.881088e-14 -5.464360e-14 -6.096731e-14 -6.251031e-14 -6.286251e-14 -6.448362e-14 -6.771265e-14
##  [85] -6.874356e-14 -8.042789e-14 -9.744662e-14 -1.355391e-13 -1.486932e-13 -1.533390e-13 -1.537053e-13
##  [92] -1.712874e-13 -2.096747e-13 -2.128031e-13 -2.228066e-13 -3.024521e-13 -3.567605e-13 -5.626274e-13
##  [99] -6.752664e-13 -8.385967e-13
## 
## $x
## NULL
## 
## $ac
## [1] 0
## 
## $GOF
## [1] 1 1
```

And thus the plot of eigenvalues and the plot of totally reproduced distances:

```r
eig <- mds_1$eig
dims <- 1:attr(D, "Size")
eig <- data.frame(Dimensions = dims, Eigenvalue = eig)
ggp <- ggplot(eig, aes(x = Dimensions, y = Eigenvalue)) +
  geom_point() +
  geom_line() +
  scale_x_continuous("Dimensions", breaks = 1:attr(D, "Size")) +
  geom_hline(yintercept = 0, linetype = "dashed")
print(ggp)
```

![plot of chunk 02a-fakedataanalysis2](figure/02a-fakedataanalysis2-1.png)

```r
ggp <- ggplot(data = data.frame(x = as.numeric(D), y = as.numeric(dist(cmdscale(D, k = 3)))),
              mapping = aes(x = x, y = y)) +
  geom_point() +
  geom_abline(intercept = 0, slope = 1) +
  xlab("Original distances") +
  ylab("Fitted distances")
print(ggp)
```

![plot of chunk 02a-fakedataanalysis2](figure/02a-fakedataanalysis2-2.png)

```r
max(abs(D - dist(cmdscale(D, k = 3))))
```

```
## [1] 7.194245e-14
```

As expected, from the first graph we see that the first two components explain almost all the distances between points in dataset.  

The following graph can be obviously edited only at screen, and show how a 2D MDS surface is projected on the datapoints cloud.

```r
my_surface <- function(f, n=10, ...) { 
  ranges <- rgl:::.getRanges()
  x <- seq(ranges$xlim[1], ranges$xlim[2], length=n)
  y <- seq(ranges$ylim[1], ranges$ylim[2], length=n)
  z <- outer(x,y,f)
  surface3d(x, y, z, ...)
}

f <- function(x, y){
  return(2 + 3 * x - 2*y)
}

open3d()
with(comb,
     plot3d(x = x, y = y, z = z,
            xlab = "x", ylab = "y", zlab = "z", type = "p", col="red")
     )
my_surface(f, alpha=.7 )
```
![](images/plot3d_mds_1.png)

If we want to analyze the 2D solution, we have simpy to set to 0 (or to exclude) the third component in mds solution.  
This is the projection of 2D points on the linear surface:

```r
# 2-dims reproduced solution
comb_3 <- setNames(data.frame(mds_1$points), c("x","y","z"))
comb_3$z <- 0
```

```r
open3d()
with(comb_3,
     plot3d(x = x, y = y, z = z,
            xlab = "x", ylab = "y", zlab = "z", type = "p", col="red")
     )
```
![](images/plot3d_mds_2.png)

As we can see, the points are projected into the mainfold built on the first two components.
The graph below shows the observed vs. reproduced distances plot:

```r
ggp <- ggplot(data = data.frame(x = as.numeric(D), y = as.numeric(dist(cmdscale(D, k = 2)))),
              mapping = aes(x = x, y = y)) +
  geom_point() +
  geom_abline(intercept = 0, slope = 1) +
  xlab("Original distances") +
  ylab("Fitted distances")
print(ggp)
```

![plot of chunk 02a-fakedataanalysis5](figure/02a-fakedataanalysis5-1.png)

```r
max(abs(D - dist(cmdscale(D, k = 2))))
```

```
## [1] 0.5029524
```

## Example: Egyptian Skulls

As a further (somehow complex) example, let's consider the `skulls` data, which is about four measurements on male Egyptian skulls from five epochs (see the section *Introduction and datasets used* for further information). The measurements are:

- mb --> maximum breadth of the skull,
- bh --> height of the skull,
- bl --> length of the skull,
- nh --> nasal height of the skull.

The question is whether the measurements change over time. Non-constant
measurements of the skulls over time would indicate interbreeding with
immigrant populations.


```r
# Summarize the data
by(data = skulls[, -1], INDICES = skulls$epoch, FUN = summary)
```

```
## skulls$epoch: c4000BC
##        mb              bh              bl               nh       
##  Min.   :119.0   Min.   :121.0   Min.   : 89.00   Min.   :44.00  
##  1st Qu.:128.0   1st Qu.:131.2   1st Qu.: 95.00   1st Qu.:49.00  
##  Median :131.0   Median :134.0   Median :100.00   Median :50.00  
##  Mean   :131.4   Mean   :133.6   Mean   : 99.17   Mean   :50.53  
##  3rd Qu.:134.8   3rd Qu.:136.0   3rd Qu.:102.75   3rd Qu.:53.00  
##  Max.   :141.0   Max.   :143.0   Max.   :114.00   Max.   :56.00  
## --------------------------------------------------------------------------------- 
## skulls$epoch: c3300BC
##        mb              bh              bl               nh       
##  Min.   :123.0   Min.   :124.0   Min.   : 90.00   Min.   :45.00  
##  1st Qu.:130.0   1st Qu.:129.2   1st Qu.: 97.00   1st Qu.:48.00  
##  Median :132.0   Median :133.0   Median : 98.50   Median :50.50  
##  Mean   :132.4   Mean   :132.7   Mean   : 99.07   Mean   :50.23  
##  3rd Qu.:134.8   3rd Qu.:136.0   3rd Qu.:101.75   3rd Qu.:52.75  
##  Max.   :148.0   Max.   :145.0   Max.   :107.00   Max.   :56.00  
## --------------------------------------------------------------------------------- 
## skulls$epoch: c1850BC
##        mb              bh              bl               nh       
##  Min.   :126.0   Min.   :123.0   Min.   : 87.00   Min.   :45.00  
##  1st Qu.:132.2   1st Qu.:131.0   1st Qu.: 92.25   1st Qu.:48.25  
##  Median :136.0   Median :133.5   Median : 96.00   Median :50.00  
##  Mean   :134.5   Mean   :133.8   Mean   : 96.03   Mean   :50.57  
##  3rd Qu.:137.0   3rd Qu.:137.0   3rd Qu.: 99.75   3rd Qu.:52.75  
##  Max.   :140.0   Max.   :145.0   Max.   :106.00   Max.   :60.00  
## --------------------------------------------------------------------------------- 
## skulls$epoch: c200BC
##        mb              bh              bl               nh       
##  Min.   :129.0   Min.   :120.0   Min.   : 86.00   Min.   :46.00  
##  1st Qu.:132.2   1st Qu.:130.0   1st Qu.: 91.25   1st Qu.:50.25  
##  Median :135.0   Median :132.0   Median : 94.50   Median :52.00  
##  Mean   :135.5   Mean   :132.3   Mean   : 94.53   Mean   :51.97  
##  3rd Qu.:138.8   3rd Qu.:135.8   3rd Qu.: 97.75   3rd Qu.:53.75  
##  Max.   :144.0   Max.   :142.0   Max.   :107.00   Max.   :60.00  
## --------------------------------------------------------------------------------- 
## skulls$epoch: cAD150
##        mb              bh              bl              nh       
##  Min.   :126.0   Min.   :120.0   Min.   : 81.0   Min.   :44.00  
##  1st Qu.:132.2   1st Qu.:126.0   1st Qu.: 91.0   1st Qu.:48.25  
##  Median :137.0   Median :130.0   Median : 94.0   Median :52.00  
##  Mean   :136.2   Mean   :130.3   Mean   : 93.5   Mean   :51.37  
##  3rd Qu.:139.0   3rd Qu.:135.0   3rd Qu.: 97.0   3rd Qu.:54.00  
##  Max.   :147.0   Max.   :138.0   Max.   :103.0   Max.   :58.00
```

```r
ggscatmat(data = skulls, columns = 2:5, color = "epoch")
```

![plot of chunk 02a-loades](figure/02a-loades-1.png)

We calculate the distances between each pair of epochs using the
`mahalanobis()` function and apply classical scaling to the resulting
distance matrix.


```r
skulls_var <- tapply(X = 1:nrow(skulls), INDEX = skulls$epoch,
                     FUN = function(i) var(skulls[i, -1]))

S <- 0
for (v in skulls_var) {
  S <- S + 29 * v
}
S <- S / 145  # estimate of the common covariance matrix in the different epochs

skulls_cen <- tapply(X = 1:nrow(skulls), INDEX = skulls$epoch,
                     FUN = function(i) apply(skulls[i, -1], 2, mean))
skulls_cen <- matrix(data = unlist(skulls_cen),
                     nrow = length(skulls_cen), byrow = TRUE)
skulls_mah <- as.dist(m = apply(X = skulls_cen, MARGIN = 1,
                                FUN = function(cen) mahalanobis(skulls_cen, cen, S)))
skulls_mah   # Mahalanobis distance between each pair of epochs
```

```
##            1          2          3          4
## 2 0.09103424                                 
## 3 0.90307383 0.72893770                      
## 4 1.88112615 1.59401352 0.44311301           
## 5 2.69681662 2.17568935 0.91087158 0.21928508
```

We then use the first two coordinate values to provide a map of the data
showing the relationships between epochs.


```r
eig <- cmdscale(skulls_mah, k = attr(skulls_mah, "Size") - 1, eig = TRUE)$eig
```

```
## Warning in cmdscale(skulls_mah, k = attr(skulls_mah, "Size") - 1, eig = TRUE): only 2 of the first 4
## eigenvalues are > 0
```

```r
eig <- data.frame(Dimensions = 1:attr(skulls_mah, "Size"), Eigenvalue = eig)
ggp <- ggplot(data = eig, mapping = aes(x = Dimensions, y = Eigenvalue)) +
  geom_point() +
  geom_line() +
  geom_hline(yintercept = 0, linetype = "dashed")
print(ggp)
```

![plot of chunk 02a-screees](figure/02a-screees-1.png)

```r
skulls_mds <- cmdscale(skulls_mah)
```

The plot of the MDS coordinates shows that the scaling solution is 
essentially unidimensional, with this single dimension providing a time
ordering of the five epochs:


```r
ds <- data.frame(V1=skulls_mds[,1],V2= skulls_mds[,2], label = levels(skulls[, 1]))
ggp <- ggplot(data = ds, mapping = aes(x=V1, y = V2, label=label)) + 
  geom_point() +
  geom_text(hjust = 0.5, vjust = -0.5) +
  xlab("1st dimension") + ylab("2nd dimension") +
  coord_fixed(ratio = 1, xlim = c(-2, 2), ylim = c(-2, 2)) 
print(ggp)
```

![plot of chunk 02a-plotmdses](figure/02a-plotmdses-1.png)

```r
rm(ds)
```


# Non-Metric MDS

In some situations, such as psychology and market research, proximity
matrices arise from asking human subjects to make judgments about the
similarity or dissimilarity of objects. Most typically, such judgments
provide only an ordering of the objects. Such type of data led to the
development of MDS methods that use only the rank order of the proximities
to produce a spatial representation of them. One of these methods, called
the non-metric MDS, uses monotonic regression to find quantities known as
"disparities", and then the required coordinates in the spatial
representation of the observed dissimilarities are found by minimizing a
criterion introduced by Kruskal, called Stress. Loosely speaking, the Stress
represents the extent to which the rank order of the fitted distances
disagrees with the rank order of the observed dissimilarities.

For each value of the number of dimensions, $m$, in the spatial configuration,
the configuration that has the smallest Stress is called the best-fitting
configuration in $m$ dimensions, $S_m$, and a rule of thumb for judging the fit
is:

- $S_m \ge 20\%$ ==> poor,
- $S_m = 10\%$ ==> fair,
- $S_m \le 5\%$ ==> good.

## Example: Political Ideology

As an example of non-metric MDS, let's consider the `wwiileaders` dataset. We get a spatial representation of the judgments of the dissimilarities in ideology of a number of world leaders and politicians prominent at the time of the Second World War. The subjects made judgments on a nine-point scale, with the extreme points of the scale, 1 and 9, being described as indicating "very similar" and "very dissimilar", respectively (see the section *Introduction and datasets used* for further information).

One function that implements non-metric MDS is `isoMDS()` in the `MASS` package.


```r
require(MASS)
```


```r
WWII_mds <- isoMDS(wwiileaders)
```

```
## initial  value 20.504211 
## iter   5 value 15.216103
## iter   5 value 15.207237
## iter   5 value 15.207237
## final  value 15.207237 
## converged
```

```r
WWII_mds$stress
```

```
## [1] 15.20724
```

Using the default value for the number of dimensions (`k` = 2), we get a Stress
value equal to 15.21, which corresponds to a relatively poor fit:

By representing graphically the 2-dimensional solution, we see that the three
fascists group together as do the three British prime ministers. Stalin and
Mao Tse-Tung are more isolated compared with the other leaders. Eisenhower
seems more related to the British government than to his own President
Truman. Interestingly, de Gaulle is placed in the center of the MDS solution:


```r
ds <- data.frame(V1=WWII_mds$points[, 1],V2= WWII_mds$points[, 2], label = attr(wwiileaders, "Labels"))
ggp <- ggplot(data = ds, mapping = aes(x=V1, y = V2, label=label)) + 
  geom_point() +
  geom_text(hjust = 0.5, vjust = -0.5) +
  xlab("1st dimension") + ylab("2nd dimension") +
  coord_fixed(ratio = 1, xlim = c(-6, 6), ylim = c(-6, 6)) 
print(ggp)
```

![plot of chunk 02a-plotpi](figure/02a-plotpi-1.png)

```r
rm(ds)
```

The quality of an MDS can be assessed informally by plotting the original
dissimilarities and the distances obtained from an MDS in a scatterplot, a so-called Shepard diagram. In an ideal situation, the points fall on the
bisecting line. In our case, some deviations are observable:


```r
WWII_shep <- as.data.frame(Shepard(wwiileaders, WWII_mds$points))
ggp <- ggplot(WWII_shep, aes(x = WWII_shep[, 1], y = WWII_shep[, 2])) +
  geom_point(size = 1) + 
  geom_step(aes(y = WWII_shep[, 3])) +
  xlab("Observed") + ylab("Fitted") +
  ggtitle("Shepard diagram") 
print(ggp)
```

![plot of chunk 02a-shepardpi](figure/02a-shepardpi-1.png)

To improve the model, we compute the Stress value for different MDS
solutions:


```r
ndim <- 1:7
stress_mds <- sapply(ndim, function(i) isoMDS(wwiileaders, k = i,
                     trace = FALSE)$stress/100)
WWII_stress <- data.frame(Dimensions = ndim, Stress = stress_mds)
ggp <- ggplot(WWII_stress, aes(x = Dimensions, y = Stress)) +
  geom_point() +
  geom_line() +
  scale_y_continuous(limits = c(0, max(stress_mds)),
		                    breaks = seq(0, max(stress_mds), by = .05)) +
  scale_x_continuous(limits = c(0, max(ndim)), breaks = ndim)
print(ggp)
```

![plot of chunk 02a-shepartrydpi](figure/02a-shepartrydpi-1.png)

Therefore, a fairly good solution could use 3 dimensions:


```r
WWII_final <- as.data.frame(isoMDS(wwiileaders, k = 3)$points)
```

```
## initial  value 14.418825 
## iter   5 value 10.271773
## iter  10 value 9.992507
## final  value 9.976593 
## converged
```

```r
panel.txt <- function(x, y, ...) {
  points(x, y, ...)
  text(x, y, labels = rownames(WWII_final), pos = 1, cex = .8, offset = .5)
}
pairs(x = WWII_final, panel = panel.txt, xlim = c(-5, 5), ylim = c(-5, 5))
```

![plot of chunk 02a-finaldpi](figure/02a-finaldpi-1.png)

The code to represent the 3D graph for the 3 dimensions follows:


```r
WWII_final$Leader <- row.names(WWII_final)
open3d()
with(WWII_final,
     plot3d(x = V1, y = V2, z = V3,
            xlab = "1st dimension", ylab = "2nd dimension", zlab = "3rd dimension", type = "p",
            col = "blue")
     )
with(WWII_final,
     text3d(x = V1, y = V2, z = V3,texts = Leader)
     )
```

# Other MDS Algorithms

## Sammon Mapping

Another popular approach, especially used in machine learning for pattern
recognition purposes, is the Sammon nonlinear mapping. It is considered a
nonlinear approach as the mapping cannot be represented as a linear
combination of the original variables, as done for example by principal
component analysis (PCA). This is achieved in Sammon mapping by weighting the
squared differences between fitted and observed distances through the inverse
of the observed distances. As a result, Sammon mapping preserves the small
observed distances, giving them a greater degree of importance in the fitting
procedure than for larger distances.

Sammon nonlinear mapping can be used for both metric and non-metric data. The
`sammon()` function available in the `MASS` package implements only the
non-metric variant of the Sammon algorithm. 
 
<!--- 
As an example, we re-analyze the
data on the world leaders judgments:
** RIMUOVERE **

```r
WWII_sammon <- sammon(wwiileaders)
```

```
## Initial stress        : 0.08020
## stress after  10 iters: 0.04174, magic = 0.500
## stress after  20 iters: 0.04150, magic = 0.500
## stress after  30 iters: 0.04150, magic = 0.500
```

```r
WWII_sammon$stress
```

```
## [1] 0.04149857
```

```r
qplot(x = WWII_sammon$points[, 1], y = WWII_sammon$points[, 2], geom = "point",
      xlab = "1st dimension", ylab = "2nd dimension",
      label = attr(wwiileaders, "Labels")) +
  coord_fixed(ratio = 1, xlim = c(-6, 6), ylim = c(-6, 6)) +
  geom_text(hjust = 0.5, vjust = -0.5)
```

![plot of chunk 02a-sammonpi](figure/02a-sammonpi-1.png)
  
The results are practically identical to those obtained with `isoMDS()` (just
note that the stress values for the two algorithms cannot be compared since
they are defined slightly differently). However, the plot of the stress now
shows that a 2-dimensional solution is fairly good:


```r
ndim <- 1:7
stress.sammon <- sapply(ndim, function(i) sammon(wwiileaders, k = i,
                                                 trace = FALSE)$stress)
WWII_stress_sammon <- data.frame(Dimensions = ndim, Stress = stress.sammon)
p <- ggplot(WWII_stress_sammon, aes(x = Dimensions, y = Stress))
p <- p + geom_point() + geom_line() +
  scale_y_continuous(limits = c(0, max(stress.sammon)),
                     breaks = seq(0, max(stress.sammon), by = .05)) +
  scale_x_continuous(limits = c(0, max(ndim)), breaks = ndim)
p
```

![plot of chunk 02a-sammonstresspi](figure/02a-sammonstresspi-1.png)
--->

## The `smacof` Package

Many other variants of MDS are available in the `smacof` package available on
CRAN (see de Leeuw, J. and Mair, P. (2009), Multidimensional Scaling Using
Majorization: SMACOF in `R`, Journal of Statistical Software, 31, 3, 1-30). The
package provides the following MDS methods:

- `smacofSym()`: simple MDS on a symmetric dissimilarity matrix,
- `smacofIndDiff()`: MDS for individual differences scaling (3-way MDS),
- `smacofRect()`: unfolding models,
- `smacofConstraint()`: confirmatory MDS,
- `smacofSphere.primal()` and `smacofSphere.dual()`: spherical MDS.


# Some Theoretical Backgrounds

An MDS algorithm aims to place each object in $K$-dimensional space such that the between-object distances are preserved as well as possible.

The data to be analyzed is a collection of $N$ objects, on a $P$-dimensional space (an $X_{N \times P}$ matrix), on which a _distance_ (or _dissimilarity_) _function_ is defined:

$\delta_{i,j}$= distance between object $i$ and object $j$.

These distances (or dissimilarities) are the entries of the _dissimilarity matrix_:

$$
\Delta=\begin{bmatrix}
 \delta_{1,1}& \delta_{1,2} & \cdots & \delta_{1,N} \\ 
 \delta_{2,1}& \delta_{2,2} & \cdots & \delta_{2,N} \\ 
 \cdots & \cdots & \cdots & \cdots \\ 
 \delta_{N,1}& \delta_{N,2} & \cdots & \delta_{N,N}
\end{bmatrix}
$$

The goal of MDS is, given $\Delta$, to find $N$ vectors $\underline{x}_1,\ldots,\underline{x}_N \in \mathbb{R}^K$, where $K<P$, and usually $K=2$ or $K=3$, such that

$\|\underline{x}_i - \underline{x}_j\| \approx \delta_{i,j}$ for all $i,j\in {1,\dots,N}$,
where $\|\cdot\|$ is a vector norm. In classical MDS, this norm is the Euclidean distance, but, in a broader sense, it may be a metric or arbitrary distance or similarity function.

In other words, MDS attempts to find an embedding from the $N$ objects into $\mathbb{R}^K$ such that distances are preserved. If the dimension $K$ is chosen to be 2 or 3, we may plot the vectors $x_i$ to obtain a visualization of the similarities between the $N$ objects. Note that the vectors $x_i$ are generally not unique: with the Euclidean distance, they may be arbitrarily translated, rotated, and reflected, since these transformations do not change the pairwise distances $\|\underline{x}_i - \underline{x}_j\|$.

There are various approaches to determining the vectors $x_i$. Usually, MDS is formulated as an optimization problem, where $(\underline{x}_1,\ldots,\underline{x}_N)$ is found as a minimizer of some cost function, for example:

$\min_{\underline{x}_1,\ldots,\underline{x}_N} \sum_{i<j} ( \|\underline{x}_i - \underline{x}_j\| - \delta_{i,j} )^2. \,$ 

A solution may then be found by numerical optimization techniques. 


## Metric MDS

For some particularly chosen cost and distance functions (e.g., when using metric MDS with Euclidean distances), the squared distance matrix may be calculated as:
$$
 \Delta = D(X) = diag(X X^T) \underline{1}^T + \underline{1} diag(XX^T)^T − 2XX^T
$$

and if we apply a centering on $X$ data via $L \cdot D$, where $L=(I − \underline{1} \underline{1}^T )$, it may be shown that:
$$
D(X)=D(LX)
$$
In other words, the distances are invariant to translation. Also, given a $\Delta$ distance matrix deriving from a data matrix $X$, it may be shown that:
$$
- L \Delta L = 2 L  X X^T L
$$

In this case, minimizers can be stated analytically in terms of matrix eigendecomposition of: 
$$
-1/2 \cdot L \Delta L = \Gamma \Lambda \Gamma^T
$$
where $\Gamma$ is a $(P \times K)$ orthonormal matrix, and $\Lambda$ is a $(K \times K)$ diagonal matrix of first $K$ biggest eigenvalues in decreasing order.

The data points (rows) of $(N \times K)$ $Z$ matrix:
$$
Z = \Gamma \Lambda^{1/2}
$$
represent a projection of rows of $LX$ into a lower dimensional subpace that preserves a big part of distances, and then is a solution of above optimization problem.


## Non-Metric MDS
In contrast to metric MDS, non-metric MDS (`isoMDS`) finds both a non-parametric monotonic relationship between the dissimilarities in the item-item matrix and the Euclidean distances between items, and the location of each item in the low-dimensional space. 

MDS is not so much an exact procedure as rather a way to "rearrange" objects in an efficient manner, via an iterative algorithm, so as to arrive at a configuration that best approximates the observed distances. 

It actually moves objects around in the $R^K$, where $K<P$, and checks how well the distances between objects can be reproduced by the new configuration. In more technical terms, it uses a function minimization algorithm that evaluates different configurations with the goal of minimizing "lack of fit".

The measure of lack of fit is called _Stress_.  
The stress value used in `isoMDS()` for a configuration is defined by:

$$
Stress = \dfrac{\sum_{i,j}{\left(d_{i,j} - \delta_{i,j} \right)^2}}{\sum_{i,j} d_{i,j}^2}
$$

In above formula, $d_{i,j}$ stands for the reproduced distances, given the respective number of dimensions, and $\delta_{i,j}$ stands for the observed distances. However, the input distances are allowed a monotonic transformation.


<!---
# Exercises with life, bread or iris data
--->
