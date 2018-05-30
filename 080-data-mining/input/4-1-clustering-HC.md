---
title: "Hierarchical (Agglomerative) Clustering (HC)"
---






# Introduction

The starting point of every Hierarchical Clustering (HC) method is the calculation of the
dissimilarity (i.e., distance) of one item relative to another item. Which
definition of distance (Euclidean, Manhattan, Canberra, etc.) is used is
often application-dependent rather than a matter of subjective choice. Some
distance measures are appropriate only for certain types of data, while some
other have been introduced for clustering variables rather than observations.

A general tool in `R` for calculating dissimilarities is the `dist()` function

`?dist`

The `dist()` function produces and object of type `dist` that need to be
supplied to any function for HC. Another option for getting the
dissimilarities among a set of items is through the `daisy()` function in the
cluster package. This function includes a metric (Gower) that allows to
calculate the distance using a mixture of quantitative and qualitative
variables.

After the dissimilarity matrix has been obtained, one needs to specify how
to calculate the distance between groups of observations during the algorithm
iterations. There are many choice here as well. Among these, we find
the so-called linkage methods:

- **single linkage** ==> the distance between two groups is defined as the
   			   smallest value of the item distances;
- **complete linkage** ==> the distance between two groups is defined as the
						 largest value of the item distances;
- **average linkage** ==> this is a compromise between the previous two 
						approaches, obtained by averaging the corresponding
						distances.

Another popular approach for calculating the distances among groups is the
**Ward method**, which joins groups that obtain the minimum increase of a given
measure of heterogeneity.  
Ward's minimum variance criterion minimizes the total within-cluster variance.  
To implement this method, at each step find the pair of clusters that leads
to minimum increase in total within-cluster variance after merging. This
increase is a weighted squared distance between cluster centers.  
At the initial step, all clusters are singletons (clusters containing a single
point). To apply a recursive algorithm under this objective function, the initial
distance between individual objects must be (proportional to) squared Euclidean
distance.  
Ward's minimum variance method can be defined and implemented recursively by a
Lance–Williams algorithm, where, for disjoint clusters $C_i$, $C_j$, and $C_k$
with sizes $n_i$, $n_j$, and $n_k$ respectively, the distance from the "joined"
cluster $C_i \cup C_j, C_k$ and a third cluster $C_k$ is calculated as:

$d(C_i \cup C_j, C_k) = 
 \frac{n_i+n_k}{n_i+n_j+n_k}\;d(C_i,C_k) +
 \frac{n_j+n_k}{n_i+n_j+n_k}\;d(C_j,C_k) -
 \frac{n_k}{n_i+n_j+n_k}\;d(C_i,C_j)$. 
 
All the above approaches produce potentially different clusters, and which one
should be used in practice depends essentially on a subjective choice.  

As an illustration, consider the dataset `utilities` (see the section 
*Introduction and datasets used* for further information), which is about 22
US utility companies regarding the following variables:

- coverage   ==>   fixed-charge coverage ratio (income/debt)
- return     ==>   rate of return on capital
- cost       ==>   cost per kW capacity in place
- load       ==>   annual load factor
- peak       ==>   peak kWh demand growth from 1974 to 1975
- sales      ==>   sales (kWh use per year)
- nuclear    ==>   percent nuclear
- fuel       ==>   total fuel costs (cents per kWh)
- company    ==>   company full name
- comp_short ==>   company short name


```r
require(GGally)
```


```r
str(utilities)
```

```
## Classes 'tbl_df', 'tbl' and 'data.frame':	22 obs. of  10 variables:
##  $ coverage  : num  1.06 0.89 1.43 1.02 1.49 1.32 1.22 1.1 1.34 1.12 ...
##  $ return    : num  9.2 10.3 15.4 11.2 8.8 13.5 12.2 9.2 13 12.4 ...
##  $ cost      : int  151 202 113 168 192 111 175 245 168 197 ...
##  $ load      : num  54.4 57.9 53 56 51.2 60 67.6 57 60.4 53 ...
##  $ peak      : num  1.6 2.2 3.4 0.3 1 -2.2 2.2 3.3 7.2 2.7 ...
##  $ sales     : int  9077 5088 9212 6423 3300 11127 7642 13082 8406 6455 ...
##  $ nuclear   : num  0 25.3 0 34.3 15.6 22.5 0 0 0 39.2 ...
##  $ fuel      : num  0.628 1.555 1.058 0.7 2.044 ...
##  $ company   : chr  "Arizona Public Service" "Boston Edison Co." "Central Louisiana Electric Co." "Common"..
##  $ comp_short: chr  "Arizona" "Boston" "Central" "Common" ...
```

```r
ggpairs(utilities[, -c(9, 10)])
```

![plot of chunk 02d-loadandsummaryut](figure/02d-loadandsummaryut-1.png)

There are many functions to perform cluster analysis in `R` (for a complete list, see the CRAN
task view at the URL http://cran.r-project.org/web/views/Cluster.html). We
describe here the basic functions available in the `R` base version, in
particular the function hclust(). To avoid any scale effect, we first
standardize the variables:


```r
utilities.std <- scale(utilities[, -c(9, 10)])
d <- dist(utilities.std)
util.SL <- hclust(d, method = "single")
util.CL <- hclust(d, method = "complete")
util.AL <- hclust(d, method = "average")
util.Ward <- hclust(d, method = "ward.D2")
```
As seen, the `hclust()` function requires a dissimilarity matrix as the input.
A standard graphical approach to represent the solution of an agglomerative
HC algorithm is through the dendrogram, which represents the sequence of
successive fusions of the different groups and the distances at which they
are merged. A dendrogram in `R` is available as a plot method for an object of
type "hclust":


```r
op <- par(mfrow = c(2, 2))
plot(util.SL, labels = utilities$comp_short, cex = .7,
		main = "Utilities data (single linkage)", xlab = "Utilities")
plot(util.CL, labels = utilities$comp_short, cex = .7,
		main = "Utilities data (complete linkage)", xlab = "Utilities")
plot(util.AL, labels = utilities$comp_short, cex = .7,
		main = "Utilities data (average linkage)", xlab = "Utilities")
plot(util.Ward, labels = utilities$comp_short, cex = .7,
		main = "Utilities data (Ward)", xlab = "Utilities")
```

![plot of chunk 02d-clusttryplotut](figure/02d-clusttryplotut-1.png)

```r
par(op)
```
The single linkage method has a tendency to create large groups by
successively adding items to already created groups (so-called "chaining").
The other three methods return similar results with more structured clusters.

Once a number of clusters has been chosen (more on this later), the function
`cutree()` can be used to obtain the cluster membership for each item:


```r
util.CL.m <- cutree(util.CL, k = 3)
util.CL.m
```

```
##  [1] 1 1 1 1 1 1 2 3 1 1 3 2 1 1 2 3 2 1 1 1 2 1
```

The cluster membership is useful to perform the profiling of the clusters,
that is to provide a more detailed description of the main features of the
identified clusters:


```r
require(dplyr)
```


```r
utilities <- cbind(utilities, member = util.CL.m)
table(utilities$member)
```

```
## 
##  1  2  3 
## 14  5  3
```

```r
by(data = utilities[, -(9:11)], INDICES = utilities$member, FUN = summary)
```

```
## utilities$member: 1
##     coverage         return           cost            load            peak            sales      
##  Min.   :0.890   Min.   : 8.80   Min.   : 96.0   Min.   :49.80   Min.   :-2.200   Min.   : 3300  
##  1st Qu.:1.062   1st Qu.:10.53   1st Qu.:121.8   1st Qu.:53.17   1st Qu.: 1.100   1st Qu.: 6636  
##  Median :1.135   Median :11.90   Median :159.5   Median :54.35   Median : 2.450   Median : 8742  
##  Mean   :1.171   Mean   :11.71   Mean   :155.2   Mean   :55.31   Mean   : 2.429   Mean   : 8355  
##  3rd Qu.:1.290   3rd Qu.:12.68   3rd Qu.:187.5   3rd Qu.:57.60   3rd Qu.: 3.475   3rd Qu.: 9988  
##  Max.   :1.490   Max.   :15.40   Max.   :202.0   Max.   :60.40   Max.   : 7.200   Max.   :13507  
##     nuclear           fuel       
##  Min.   : 0.00   Min.   :0.5270  
##  1st Qu.: 0.00   1st Qu.:0.6300  
##  Median :19.05   Median :0.7820  
##  Mean   :18.20   Mean   :0.9699  
##  3rd Qu.:32.38   3rd Qu.:1.2078  
##  Max.   :50.20   Max.   :2.0440  
## --------------------------------------------------------------------------------- 
## utilities$member: 2
##     coverage         return           cost            load            peak           sales     
##  Min.   :0.760   Min.   : 6.40   Min.   :136.0   Min.   :61.00   Min.   :-0.10   Min.   :5714  
##  1st Qu.:0.960   1st Qu.: 7.60   1st Qu.:164.0   1st Qu.:61.90   1st Qu.: 2.20   1st Qu.:6154  
##  Median :1.040   Median : 8.60   Median :175.0   Median :62.00   Median : 3.50   Median :6468  
##  Mean   :1.022   Mean   : 9.14   Mean   :171.4   Mean   :62.94   Mean   : 3.66   Mean   :6526  
##  3rd Qu.:1.130   3rd Qu.:10.90   3rd Qu.:178.0   3rd Qu.:62.20   3rd Qu.: 3.70   3rd Qu.:6650  
##  Max.   :1.220   Max.   :12.20   Max.   :204.0   Max.   :67.60   Max.   : 9.00   Max.   :7642  
##     nuclear          fuel      
##  Min.   :0.00   Min.   :1.400  
##  1st Qu.:0.00   1st Qu.:1.652  
##  Median :0.00   Median :1.897  
##  Mean   :1.84   Mean   :1.797  
##  3rd Qu.:0.90   3rd Qu.:1.920  
##  Max.   :8.30   Max.   :2.116  
## --------------------------------------------------------------------------------- 
## utilities$member: 3
##     coverage         return           cost            load            peak           sales      
##  Min.   :0.750   Min.   :7.500   Min.   :173.0   Min.   :51.50   Min.   :3.300   Min.   :13082  
##  1st Qu.:0.925   1st Qu.:8.350   1st Qu.:209.0   1st Qu.:53.75   1st Qu.:4.900   1st Qu.:14536  
##  Median :1.100   Median :9.200   Median :245.0   Median :56.00   Median :6.500   Median :15991  
##  Mean   :1.003   Mean   :8.867   Mean   :223.3   Mean   :54.83   Mean   :6.333   Mean   :15505  
##  3rd Qu.:1.130   3rd Qu.:9.550   3rd Qu.:248.5   3rd Qu.:56.50   3rd Qu.:7.850   3rd Qu.:16716  
##  Max.   :1.160   Max.   :9.900   Max.   :252.0   Max.   :57.00   Max.   :9.200   Max.   :17441  
##     nuclear       fuel       
##  Min.   :0   Min.   :0.3090  
##  1st Qu.:0   1st Qu.:0.4645  
##  Median :0   Median :0.6200  
##  Mean   :0   Mean   :0.5657  
##  3rd Qu.:0   3rd Qu.:0.6940  
##  Max.   :0   Max.   :0.7680
```

```r
util.summ <- group_by(utilities, member) %>%
  summarise(coverage = mean(coverage),
            return	 = mean(return),
            cost     = mean(cost),
            load     = mean(load),
            peak     = mean(peak),
            sales    = mean(sales),
            nuclear  = mean(nuclear),
            fuel     = mean(fuel))
palette(rainbow(8))
to.draw <- apply(util.summ[, -1], 2, function(x) x/max(x))
stars(to.draw, draw.segments = TRUE, scale = FALSE, key.loc = c(4.6, 2.3),
		labels = c("CLUSTER 1", "CLUSTER 2", "CLUSTER 3"),
		main = "Utilities data (cluster profiling)", cex = .75,
		flip.labels = TRUE)
```

![plot of chunk 02d-profilesut](figure/02d-profilesut-1.png)

```r
palette("default")
```

The `cutree()` function can be used to generate more than one vector of cluster
membership at once:


```r
util.CL.g234 <- cutree(util.CL, k = 2:4)
table(clus2 = util.CL.g234[, "2"], clus4 = util.CL.g234[, "4"])
```

```
##      clus4
## clus2 1 2 3 4
##     1 7 7 0 0
##     2 0 0 5 3
```

A further graphical approach to get the cluster memberships is through the
function `rect.hclust()` which adds to the dendrogram rectangles showing the
identified clusters:


```r
plot(util.CL)
rect.hclust(util.CL, k = 5)
```

![plot of chunk 02d-rectclusut](figure/02d-rectclusut-1.png)

It is possible to use the `identify()` function to directly select on the
dendrogram the number of clusters to use. You can use a code like this:


```r
plot(util.CL)
r <- identify(util.CL)
```

Finally, the `clusterSim` package provides many functions to compare the
goodness of different clustering solutions. Among these functions we find:

- index.DB()  ==> Calculates Davies-Bouldin's index
- index.G1()  ==> Calculates Calinski-Harabasz pseudo F-statistic
- index.G2()  ==> Calculates G2 internal cluster quality index
- index.G3()  ==> Calculates G3 internal cluster quality index
- index.Gap() ==> Calculates Tibshirani, Walther and Hastie gap index
- index.H()   ==> Calculates Hartigan index
- index.KL()  ==> Calculates Krzanowski-Lai index
- index.S()   ==> Calculates Rousseeuw's Silhouette internal cluster quality index

For more details see the help pages of these functions. As an example, we consider here the Calinski-Harabasz pseudo F-statistic:


```r
require(clusterSim)
require(ggplot2)
```


```r
minC <- 2
maxC <- 10
res <- numeric(maxC - minC)
for (nc in minC:maxC) {
	res[nc - minC + 1] <- index.G1(utilities.std, cutree(util.Ward, k = nc))
}
ggp <- ggplot(data=data.frame(x=2:(length(res)+1), y= res), mapping = aes(x=x,y=y)) + 
  geom_point() + 
  geom_line() +
  xlab("Number of clusters") +
  ylab("Calinski-Harabasz pseudo F-statistic")
print(ggp)
```

![plot of chunk 02d-chfuncut](figure/02d-chfuncut-1.png)

According to the Calinski-Harabasz pseudo F-statistic, we conclude that the 4
clusters solution seems a good solution.

After a good solution has been identified, we can save the corresponding
cluster membership and use it for graphical purposes:


```r
Cluster <- as.character(cutree(util.CL, k = (minC:maxC)[which.max(res)]))
ggscatmat(data = cbind(utilities[, -(9:11)], Cluster=Cluster), color = "Cluster")
```

![plot of chunk 02d-membsplotut2](figure/02d-membsplotut2-1.png)


```r
utilities$member <-  Cluster
table(utilities$member)
```

```
## 
## 1 2 3 4 
## 7 7 5 3
```

```r
by(utilities[, -(9:11)], utilities$member, summary)
```

```
## utilities$member: 1
##     coverage         return           cost            load            peak            sales      
##  Min.   :1.050   Min.   : 9.20   Min.   : 96.0   Min.   :49.80   Min.   :-2.200   Min.   : 8406  
##  1st Qu.:1.075   1st Qu.:11.85   1st Qu.:107.5   1st Qu.:53.50   1st Qu.:-0.350   1st Qu.: 9144  
##  Median :1.160   Median :12.60   Median :113.0   Median :54.40   Median : 1.600   Median : 9673  
##  Mean   :1.207   Mean   :12.49   Mean   :127.6   Mean   :55.47   Mean   : 1.714   Mean   :10163  
##  3rd Qu.:1.330   3rd Qu.:13.25   3rd Qu.:150.5   3rd Qu.:58.35   3rd Qu.: 3.050   3rd Qu.:10634  
##  Max.   :1.430   Max.   :15.40   Max.   :168.0   Max.   :60.40   Max.   : 7.200   Max.   :13507  
##     nuclear            fuel       
##  Min.   : 0.000   Min.   :0.5880  
##  1st Qu.: 0.000   1st Qu.:0.6320  
##  Median : 0.000   Median :0.8620  
##  Mean   : 3.214   Mean   :0.8744  
##  3rd Qu.: 0.000   3rd Qu.:1.0830  
##  Max.   :22.500   Max.   :1.2410  
## --------------------------------------------------------------------------------- 
## utilities$member: 2
##     coverage         return           cost            load            peak           sales      
##  Min.   :0.890   Min.   : 8.80   Min.   :148.0   Min.   :51.20   Min.   :0.300   Min.   : 3300  
##  1st Qu.:1.045   1st Qu.: 9.80   1st Qu.:171.0   1st Qu.:53.35   1st Qu.:1.600   1st Qu.: 5756  
##  Median :1.120   Median :11.20   Median :192.0   Median :54.30   Median :2.700   Median : 6455  
##  Mean   :1.134   Mean   :10.93   Mean   :182.9   Mean   :55.14   Mean   :3.143   Mean   : 6546  
##  3rd Qu.:1.175   3rd Qu.:12.10   3rd Qu.:198.0   3rd Qu.:56.95   3rd Qu.:4.700   3rd Qu.: 7233  
##  Max.   :1.490   Max.   :12.70   Max.   :202.0   Max.   :59.90   Max.   :6.400   Max.   :10093  
##     nuclear           fuel       
##  Min.   :15.60   Min.   :0.5270  
##  1st Qu.:25.95   1st Qu.:0.6615  
##  Median :34.30   Median :0.7020  
##  Mean   :33.19   Mean   :1.0653  
##  3rd Qu.:40.15   3rd Qu.:1.4305  
##  Max.   :50.20   Max.   :2.0440  
## --------------------------------------------------------------------------------- 
## utilities$member: 3
##     coverage         return           cost            load            peak           sales     
##  Min.   :0.760   Min.   : 6.40   Min.   :136.0   Min.   :61.00   Min.   :-0.10   Min.   :5714  
##  1st Qu.:0.960   1st Qu.: 7.60   1st Qu.:164.0   1st Qu.:61.90   1st Qu.: 2.20   1st Qu.:6154  
##  Median :1.040   Median : 8.60   Median :175.0   Median :62.00   Median : 3.50   Median :6468  
##  Mean   :1.022   Mean   : 9.14   Mean   :171.4   Mean   :62.94   Mean   : 3.66   Mean   :6526  
##  3rd Qu.:1.130   3rd Qu.:10.90   3rd Qu.:178.0   3rd Qu.:62.20   3rd Qu.: 3.70   3rd Qu.:6650  
##  Max.   :1.220   Max.   :12.20   Max.   :204.0   Max.   :67.60   Max.   : 9.00   Max.   :7642  
##     nuclear          fuel      
##  Min.   :0.00   Min.   :1.400  
##  1st Qu.:0.00   1st Qu.:1.652  
##  Median :0.00   Median :1.897  
##  Mean   :1.84   Mean   :1.797  
##  3rd Qu.:0.90   3rd Qu.:1.920  
##  Max.   :8.30   Max.   :2.116  
## --------------------------------------------------------------------------------- 
## utilities$member: 4
##     coverage         return           cost            load            peak           sales      
##  Min.   :0.750   Min.   :7.500   Min.   :173.0   Min.   :51.50   Min.   :3.300   Min.   :13082  
##  1st Qu.:0.925   1st Qu.:8.350   1st Qu.:209.0   1st Qu.:53.75   1st Qu.:4.900   1st Qu.:14536  
##  Median :1.100   Median :9.200   Median :245.0   Median :56.00   Median :6.500   Median :15991  
##  Mean   :1.003   Mean   :8.867   Mean   :223.3   Mean   :54.83   Mean   :6.333   Mean   :15505  
##  3rd Qu.:1.130   3rd Qu.:9.550   3rd Qu.:248.5   3rd Qu.:56.50   3rd Qu.:7.850   3rd Qu.:16716  
##  Max.   :1.160   Max.   :9.900   Max.   :252.0   Max.   :57.00   Max.   :9.200   Max.   :17441  
##     nuclear       fuel       
##  Min.   :0   Min.   :0.3090  
##  1st Qu.:0   1st Qu.:0.4645  
##  Median :0   Median :0.6200  
##  Mean   :0   Mean   :0.5657  
##  3rd Qu.:0   3rd Qu.:0.6940  
##  Max.   :0   Max.   :0.7680
```

```r
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
Exercises with  uscrime or iris
--->

