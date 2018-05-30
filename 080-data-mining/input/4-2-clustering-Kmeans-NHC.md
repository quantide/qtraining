---
title: "Non-Hierarchical Clustering (K-Means) (NHC)"
---






# Introduction

## Non-Hierarchical (Partitioning) Methods

Given a preassigned number $K$ of groups, Non-Hierarchical Clustering (NHC)
methods seek to partition the data into $K$ clusters so that the items within
each cluster are similar to each other, whereas items from different
clusters are quite dissimilar.

A possible approach to do this would be to enumerate all the possible groupings of the
items in $K$ groups and then choose as the best solution the grouping that
optimizes some predefined criterion. Unfortunately, such an
approach would become rapidly infeasible, especially for large datasets,
requiring incredible amounts of computer time and storage. As a result, all
available clustering techniques are iterative and work on only a very
limited amount of enumeration.

Among the many non-hierarchical clustering algorithms developed so far, the
most popular is the K-means one. In its basic implementation, the
K-means algorithm starts either by assigning items to one of $K$ predetermined
clusters and then computing the $K$ cluster centroids, or by pre-specifying
the $K$ cluster centroids. The pre-specified centroids may be randomly selected
items or may be obtained by cutting a dendrogram at an appropriate height.
Then, through an iterative procedure, the algorithm seeks to minimize the
within-group sum of squares (WGSS) over all variables by reassigning items to
clusters. The procedure stops when no further reassignment reduces the value
of WGSS.

The solution will typically not be unique; the algorithm will only find a
local minimum of WGSS. Therefore, it is recommended that the algorithm be
run using different initial random assignments of the items to $K$ clusters
(or by randomly selecting K initial centroids) in order to find the global
minimum of WGSS and, hence, the best clustering solution based upon $K$
clusters.

As an example, we consider the `utilities` dataset (see the section *Introduction and datasets used* for further information):


```r
require(ggplot2)
require(GGally)
```


```r
set.seed(10)
utilities_tmp <- utilities[, 1:8]
ggpairs(utilities_tmp)
```

![plot of chunk 02e-loadandsummaryuc](figure/02e-loadandsummaryuc-1.png)

If we first calculate the variances of the crime rates for the different
types of crimes we find the following:


```r
sapply(utilities_tmp, var)
```

```
##     coverage       return         cost         load         peak        sales      nuclear         fuel 
## 3.404437e-02 5.035758e+00 1.696727e+03 1.990184e+01 9.723485e+00 1.260239e+07 2.819686e+02 3.092451e-01
```

The variances are very different, and using K-means on the raw data would not
be sensible; we must standardize the data in some way, and here we
choose to standardize each variable by its range. After such standardization,
the variances become


```r
rge <- sapply(utilities_tmp, function(x) diff(range(x)))
utilities_s <- sweep(x = utilities_tmp, MARGIN = 2, STATS = rge, FUN = "/")
sapply(utilities_s, var)
```

```
##   coverage     return       cost       load       peak      sales    nuclear       fuel 
## 0.06217015 0.06216985 0.06972088 0.06281353 0.07481906 0.06302205 0.11189051 0.09470796
```

We can now proceed with clustering the data. First we plot the WGSS for one-
to eight-group solutions to see if we can get any indication of the number of
groups. The plot is obtained as follows:


```r
k_max <- 8
wss <- rep(0, k_max)
for (k in 1:k_max) {
	wss[k] <- kmeans(utilities_s, centers = k)$tot.withinss
}
ggp <- ggplot(data = data.frame(x=1:k_max, y=wss), mapping = aes(x=x,y=y)) +
  geom_point() +
  geom_line() +
  xlab("Number of groups") + 
  ylab("Within groups sum of squares")
print(ggp)
```

![plot of chunk 02e-scree1uc](figure/02e-scree1uc-1.png)

As the number of groups increases, the sum of squares will necessarily
decrease, but an obvious "elbow" in the plot may be indicative of the most
useful solution for the investigator to look at in detail. In our case there
is only one possible "elbow" in the plot, at four groups, and we now
look at this solution. The group means for this solutions is computed by


```r
km_4 <- kmeans(utilities_s, centers = 4)
km_4$centers * rge
```

```
##     coverage       return        cost         load       peak        sales    nuclear         fuel
## 1   1.207143    15.815238   0.6051465    35.526645  0.1112782    8.1931850  0.0473819     5.516594
## 2  13.013514 14545.028571  10.3104396 48097.558587  2.4248120 5859.4285714  1.2831531 14068.332991
## 3 211.513514    49.456296 223.3333333   154.642322 86.6666667   55.0409636  0.0000000    15.714702
## 4  26.748108     2.304929  20.2189744     5.622003  5.8708772    0.9567733 13.5733865     0.771600
```
We can try using the Calinski-Harabasz index to help us in finding the optimal number of clusters to "combine" with PCA analysis results:

```r
require(clusterSim)
minC <- 2
maxC <- 10
res <- numeric(maxC - minC)
for (nc in minC:maxC) {
	res[nc - minC + 1] <- index.G1(utilities_s, kmeans(utilities_s,centers = nc)$cluster)
}
ggp <- ggplot(data=data.frame(x=2:(length(res)+1), y= res), mapping = aes(x=x,y=y)) + 
  geom_point() + 
  geom_line() +
  xlab("Number of clusters") +
  ylab("Calinski-Harabasz pseudo F-statistic")
print(ggp)
```

![plot of chunk 02d-chfuncut](figure/02d-chfuncut-1.png)

This index gives an almost clear indication on the number of clusters to choose, i.e., 4.

Now, with the aim of explaining or understanding the meaning of the groups, we can apply
the PCA methods to reduce the data dimensionality:

```r
utilities_pca <- princomp(utilities_tmp, cor = TRUE)
summary(utilities_pca, loadings=TRUE)
```

```
## Importance of components:
##                           Comp.1    Comp.2    Comp.3    Comp.4     Comp.5     Comp.6     Comp.7    Comp.8
## Standard deviation     1.4740918 1.3785018 1.1504236 0.9983701 0.80561801 0.75608141 0.46529886 0.4115657
## Proportion of Variance 0.2716183 0.2375334 0.1654343 0.1245929 0.08112755 0.07145739 0.02706288 0.0211733
## Cumulative Proportion  0.2716183 0.5091517 0.6745860 0.7991789 0.88030644 0.95176383 0.97882670 1.0000000
## 
## Loadings:
##          Comp.1 Comp.2 Comp.3 Comp.4 Comp.5 Comp.6 Comp.7 Comp.8
## coverage -0.446 -0.232        -0.555  0.401        -0.206  0.481
## return   -0.571 -0.101        -0.332 -0.336  0.133  0.150 -0.629
## cost      0.349  0.161 -0.467 -0.409  0.269 -0.538  0.118 -0.303
## load      0.289 -0.409  0.143 -0.334 -0.680 -0.299         0.248
## peak      0.355  0.283 -0.281 -0.391 -0.163  0.719         0.122
## sales            0.603  0.332 -0.191 -0.132 -0.150 -0.661 -0.103
## nuclear  -0.168        -0.738  0.333 -0.250        -0.489       
## fuel      0.336 -0.540  0.134         0.293  0.252 -0.489 -0.433
```

```r
plot(utilities_pca, type = "l")
abline(h = 1, lty = 2)
```

![plot of chunk 02ea-explain-pca](figure/02ea-explain-pca-1.png)

If we apply the "proportion of explained variance" criterion, the number of components to retain should be at least 4.  
Anyway, for this example, we will retain the first two components only, and then we analyse the correlation between sores and original variables.


```r
biplot(utilities_pca)
```

![plot of chunk 02e-plotsuc1a](figure/02e-plotsuc1a-1.png)

```r
ggcorr(cbind(utilities_s, utilities_pca$scores), label = TRUE, cex = 2.5)
```

![plot of chunk 02e-plotsuc1a](figure/02e-plotsuc1a-2.png)

The first principal component seems to oppose technical measures (`fuel`, `load`, `cost`) with financial ones (`coverage` and `return`), while the second principal component seems to oppose sales (`sales`) and costs (`fuel`) .  

Let us try to plot the grouping information on the plot of scores of 
a simple 2-dimensions PCA analysis


```r
Cluster <- as.character(km_4$cluster)
utilities_scores <- cbind(data.frame(utilities_pca$scores[, c("Comp.1", "Comp.2")]), company=utilities$comp_short, Cluster=Cluster)
ggp <- ggplot(data= utilities_scores, mapping = aes(x = Comp.1, y=Comp.2, label=company, colour=Cluster)) +
  geom_point() +
  xlab("1st PCA dimension") +
  ylab("2nd PCA dimension") +
  geom_text(hjust=0.5, vjust=-0.5, size=3)
print(ggp)
```

![plot of chunk 02e-plotsuc2](figure/02e-plotsuc2-1.png)

This graph shows how the 4 groups are related with the first 2 components of PCA. It shows that the groups 2 and 3 are clearly separated.  
The other two groups are somehow confused; maybe, they could be better separated by using a third PC.

Without using 3D graphs, the next graph can help to find some differences between the remaining two groups:

```r
pairs(utilities_tmp, col = Cluster, pch = Cluster, cex = .75)
```

![plot of chunk 02e-plotsuc3](figure/02e-plotsuc3-1.png)

<!---


```r
# Cluster <- as.character(km_4$cluster)
# ggp <- ggplot(data=data.frame(x = uscrime_scores[, 1], y = uscrime_scores[, 2], Cluster=Cluster, state=uscrime$state), mapping = aes(x=x,y=y, colour=Cluster))+
#   geom_point() +
#   xlab("1st PCA dimension") +
#   ylab("2nd PCA dimension") +
#   geom_text(mapping = aes(label=state), hjust = 0.5, vjust = -0.5, size = 3)
# print(ggp)
```


```r
# pairs(utilities_tmp, col = Cluster, pch = Cluster, cex = .75)
```

The previous plots together with the next ones suggest that the two groups
solution seems to be more interpretable. Anyway, we can also cross ths information
with the geographic areas:


```r
# uscrime$reg <- as.factor(uscrime$reg)
# levels(uscrime$reg) <- c("Northeast", "Midwest", "South", "West")
# 
# plot(table(uscrime$reg, km_2$cluster), main = "Clusters vs. US States region",
# 			xlab = "Region of US", ylab = "2 groups solution")
# 
# plot(table(uscrime$reg, km_4$cluster), main = "Clusters vs. US States region",
# 			xlab = "Region of US", ylab = "4 groups solution")
```
--->

The next grph will help to "identify" groups as for hierarchical clustering:


```r
utilities$member <-  Cluster
util.summ <- summarise(group_by(utilities, member),
                       coverage = mean(coverage),
                       return   = mean(return),
                       cost     = mean(cost),
                       load     = mean(load),
                       peak     = mean(peak),
                       sales    = mean(sales),
                       nuclear  = mean(nuclear),
                       fuel     = mean(fuel))
palette(rainbow(8))
to.draw <- apply(util.summ[, -1], 2, function(x) x/max(x))
stars(to.draw, draw.segments = TRUE, scale = FALSE, key.loc = c(4.6,2.0), nrow=3, ncol=2,
      labels = c("CLUSTER 1", "CLUSTER 2","CLUSTER 3", "CLUSTER 4"),
      main = "Utilities data (cluster profiling)", cex = .75, ylim=c(0,8),
      flip.labels = TRUE)
```

![plot of chunk 02d-membsplotut3](figure/02d-membsplotut3-1.png)

```r
palette("default")
```

<!---
# Exercises with iris o utilities 
--->
