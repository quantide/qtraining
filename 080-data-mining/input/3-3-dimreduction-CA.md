---
title: "Outlines on Correspondence Analysis (CA)"
---






# Introduction

Correspondence Analysis (CA) is a form of multidimensional scaling, which essentially consists in an
approach for constructing a spatial model that displays the associations
among a set of categorical variables. If the set includes only two variables,
the method is usually called simple CA (SCA). SCA is often used to supplement
a standard chi-squared test of independence for two categorical variables
forming a contingency table. If the analysis involves more than two
variables, it is called multiple CA (MCA). Below we briefly present one
example of SCA. A more thorough account of both SCA and MCA ca be found on
any book on multivariate data analysis (see for example Johnson, R. and
Wichern, D., Applied Multivariate Statistical Analysis, 6th edition, Pearson,
2014).

Consider a general two-dimensional contingency table in which there are R
rows and C columns. From this table we can construct tables of column
proportions and row proportions. The key quantity computed in a CA is the
chi-squared distance among columns and among rows of the table. The chi-
square distance can be considered as a weighted Euclidean distance based on
column (row) proportions. It will be zero if two columns (rows) have the
same values for these proportions.

A CA is then obtained by applying classical MDS to each distance matrix in
turn and plotting (usually) the first two coordinates for column categories
and those for row categories on the same diagram. The interpretation of the
resulting diagram may be summarized as follows:

1. The proximity of two rows (columns) indicates a similar profile in these
     rows (columns), where "profile" refers to the conditional frequency
     distribution of a row (column); those two rows (columns) are almost
     proportional. The opposite interpretation applies when the two rows (two
     columns) are far apart.
2. The proximity of a particular row to a particular column indicates that
     this row (column) has a particularly important weight in this column
     (row). In contrast to this, a row that is quite distant from a particular
     column indicates that there are almost no observations in this column for
     this row (and vice versa). In other terms, row points that lie close to
     column points represent a row/column combination that occurs more
     frequently than would be expected if the row and column variables were
     independent. Conversely, row and column points that are distant from one
     another indicate a cell in the table where the count is lower than would
     be expected under independence. These conclusions are particularly true
     when the points are far away from 0.
3. The origin is the average of the row and column factors. Hence, a
     particular point (row or column) projected close to the origin indicates
     an average profile.
4. All the interpretations outlined above must be carried out in view of
     the quality of the graphical representation which is evaluated, as in
     PCA, using the cumulated percentage of variance.

In `R` there are many functions available to carry out a CA, like `corresp()` and
`mca()` in the MASS package for performing SCA and MCA respectively. Here we
focus on the `ca` package, which provides many functions for conducting
different flavors of CA.


## Example: U.S. Crime Rates

We consider the `uscrime` dataset (see the section *Introduction and datasets used* for further information), which provides the number of crimes (per 100,000 residents) in the 50 states of the U.S. classified in 1985 for the following seven categories: _murder_, _rape_, _robbery_, _assault_, _burglary_, _larceny_ and _auto-theft_. Since the data are rates, we first transform these into number of crimes (note that the reported population is in 1,000 people):


```r
states <- uscrime$state
uscrime <- data.frame(uscrime[,-1])
rownames(uscrime) <- states
uscrime.old <- uscrime
uscrime[, 3:9] <- round(uscrime.old[, 3:9]*uscrime.old[, 2]/100)
summary(uscrime)
```

```
##       land           popu1985          murd              rape             robb              assa      
##  Min.   :  1212   Min.   :  509   Min.   :   3.00   Min.   :  35.0   Min.   :   41.0   Min.   :  144  
##  1st Qu.: 37241   1st Qu.: 1236   1st Qu.:  55.25   1st Qu.: 139.2   1st Qu.:  689.8   1st Qu.: 1260  
##  Median : 56214   Median : 3266   Median : 197.50   Median : 497.0   Median : 2128.5   Median : 3925  
##  Mean   : 72374   Mean   : 4762   Mean   : 378.56   Mean   : 896.3   Mean   : 7657.5   Mean   : 7893  
##  3rd Qu.: 83242   3rd Qu.: 5654   3rd Qu.: 486.50   3rd Qu.: 981.8   3rd Qu.: 5881.5   3rd Qu.: 8583  
##  Max.   :591004   Max.   :26365   Max.   :1899.00   Max.   :9254.0   Max.   :78832.0   Max.   :59585  
##       burg             larc             auto             reg            div      
##  Min.   :  1959   Min.   :  5184   Min.   :   623   Min.   :1.00   Min.   :1.00  
##  1st Qu.:  9345   1st Qu.: 23000   1st Qu.:  3780   1st Qu.:2.00   1st Qu.:3.00  
##  Median : 32154   Median : 55204   Median :  9826   Median :3.00   Median :5.00  
##  Mean   : 52014   Mean   :100690   Mean   : 21246   Mean   :2.66   Mean   :5.12  
##  3rd Qu.: 52316   3rd Qu.:110307   3rd Qu.: 22443   3rd Qu.:3.75   3rd Qu.:7.75  
##  Max.   :462178   Max.   :902210   Max.   :181655   Max.   :4.00   Max.   :9.00
```

We now perform CA using the `ca()` function and represent graphically the
solution:


```r
require(ca)
```


```r
uscrime.ca <- ca(as.matrix(uscrime[, 3:9]))
summary(uscrime.ca)
```

```
## 
## Principal inertias (eigenvalues):
## 
##  dim    value      %   cum%   scree plot               
##  1      0.019891  51.3  51.3  *************            
##  2      0.009090  23.5  74.8  ******                   
##  3      0.006032  15.6  90.4  ****                     
##  4      0.003328   8.6  99.0  **                       
##  5      0.000234   0.6  99.6                           
##  6      0.000172   0.4 100.0                           
##         -------- -----                                 
##  Total: 0.038747 100.0                                 
## 
## 
## Rows:
##      name   mass  qlt  inr    k=1 cor ctr    k=2 cor ctr  
## 1  |   ME |    2  759    3 | -188 757   4 |  -10   2   0 |
## 2  |   NH |    2  416    2 | -129 328   2 |  -67  88   1 |
## 3  |   VT |    1  277    3 | -162 254   1 |   49  23   0 |
## 4  |   MA |   23  606  106 |  239 319  66 | -227 287 129 |
## 5  |   RI |    4  592   11 |   75  58   1 | -228 534  25 |
## 6  |   CT |   12  326    9 |    0   0   0 | -101 326  13 |
## 7  |   NY |   89  925  231 |  301 907 409 |   42  18  17 |
## 8  |   NJ |   28  861   24 |  135 551  26 | -101 309  32 |
## 9  |   PA |   27  827   20 |  150 769  30 |  -41  58   5 |
## 10 |   OH |   40  743   13 |   25  48   1 |  -95 695  40 |
## 11 |   IN |   19  918    5 |  -11  13   0 |  -93 906  18 |
## 12 |   IL |   46  289   51 |  110 279  28 |  -21  10   2 |
## 13 |   MI |   52  145   29 |   34  53   3 |   44  91  11 |
## 14 |   WI |   14  879   40 | -275 665  51 | -156 214  36 |
## 15 |   MN |   14  927   11 | -103 339   7 | -135 588  28 |
## 16 |   IA |    8  874   24 | -298 736  34 | -129 138  14 |
## 17 |   MO |   22  810    4 |   77 803   7 |   -7   6   0 |
## 18 |   ND |    1  846    7 | -404 718  10 | -171 128   4 |
## 19 |   SD |    2  926    5 | -329 917   8 |  -33   9   0 |
## 20 |   NE |    4  494    5 | -129 379   4 |  -71 115   2 |
## 21 |   KS |    9  901   13 | -212 865  21 |  -44  36   2 |
## 22 |   DE |    3  247    1 |  -34  92   0 |  -45 156   1 |
## 23 |   MD |   21  407   22 |  118 353  15 |   46  54   5 |
## 24 |   VA |   20  824   10 | -129 824  17 |   -2   0   0 |
## 25 |   WV |    3  956    3 | -156 565   3 |  130 391   5 |
## 26 |   NC |   17  821   68 | -107  76  10 |  336 745 216 |
## 27 |   SC |   11  603   14 |  -70 100   3 |  157 503  29 |
## 28 |   GA |   21  739    8 |  -87 498   8 |   60 240   9 |
## 29 |   FL |   63  910   29 |  -76 334  19 |  100 576  70 |
## 30 |   KY |   10   95    5 |   41  94   1 |    5   1   0 |
## 31 |   TN |   12  537   18 |   85 125   4 |  155 413  32 |
## 32 |   AL |   10  675   23 |  -31  11   0 |  242 664  65 |
## 33 |   MS |    4  779   16 | -156 142   4 |  329 636  43 |
## 34 |   AR |    6  700   15 | -134 186   5 |  223 514  33 |
## 35 |   LA |   16  632   11 |   47  81   2 |  123 551  26 |
## 36 |   OK |   10  852    4 | -118 846   7 |   10   6   0 |
## 37 |   TX |   70  910    9 |  -49 480   9 |   47 430  17 |
## 38 |   MT |    2  910    7 | -285 793  10 | -109 117   3 |
## 39 |   ID |    3  907   12 | -354 883  21 |  -58  24   1 |
## 40 |   WY |    2  919    5 | -326 872   9 |  -75  46   1 |
## 41 |   CO |   18  847    5 |  -83 594   6 |  -54 253   6 |
## 42 |   NM |    6  892    4 | -139 882   6 |   15  10   0 |
## 43 |   AZ |   20  979   14 | -164 955  27 |  -26  24   1 |
## 44 |   UT |    7  908   18 | -269 731  26 | -132 177  14 |
## 45 |   NV |    6  432    1 |  -19  67   0 |  -43 365   1 |
## 46 |   WA |   23  732   24 | -169 686  32 |  -44  46   5 |
## 47 |   OR |   13  875   13 | -181 855  22 |  -28  20   1 |
## 48 |   CA |  175  712   14 |  -38 466  13 |  -28 246  15 |
## 49 |   AK |    2  305    2 |  -61  87   0 |  -97 218   2 |
## 50 |   HI |    6  880    8 | -145 376   6 | -168 504  18 |
## 
## Columns:
##     name   mass  qlt  inr    k=1 cor ctr    k=2 cor ctr  
## 1 | murd |    2  536   16 |    0   0   0 |  408 536  36 |
## 2 | rape |    5  149    8 |  -26  11   0 |   93 138   4 |
## 3 | robb |   40  751  306 |  464 729 435 |   81  22  29 |
## 4 | assa |   41  811  162 |   34   8   2 |  349 804 555 |
## 5 | burg |  273  221   87 |   27  61  10 |   45 161  60 |
## 6 | larc |  528  864  169 | -100 803 264 |  -27  61  44 |
## 7 | auto |  111  840  252 |  227 587 288 | -149 253 272 |
```

```r
plot(uscrime.ca)
```

![plot of chunk 02c-analysiscr](figure/02c-analysiscr-1.png)

<!---
burglary :  furto in appartamento
larceny :  furto
rape :  violenza
--->

In above table, the term `mass` means, repectively, the row or column marginal 
totals for the total proportions table (multiplied by 1000).
`qlt` means "quality", i.e., the sum of `cor` (squared correlation) values of
individual points in selected components. The quality value should be compared
with sum of squared correlations for all the components. The squared correlations
represent some association between the point and the given component. `inr` 
(inertia) is the proportion of inertia ("Pearson Chi-Square") acconted by the row
(column). `ctr` are contributions of individual rows (columns) to individual components.

It appears that the first axis is robbery versus larceny and that the second
factor contrasts assault and murder to auto-theft. The dominating states for
the first axis are the North-Eastern States (MA and NY) contrasting the
Western States (WY and ID). For the second axis, the differences are seen
between the Northern States (MA and RI) and the Southern States (AL, MS and
AR). The plot also shows in which states the proportion of a particular crime
category is higher or lower than the national average (the origin). Note also
that overall the first two dimensions shown allow to explain around 74.8% of
the total variability (called inertia in CA).

The same output would be obtained using the `corresp()` function in the `MASS`
package:


```r
require(MASS)
```


```r
biplot(corresp(uscrime[, 3:9], nf = 2))
```

![plot of chunk 02c-analysisMASScr](figure/02c-analysisMASScr-1.png)


# Some Theoretical Backgrounds
Let us suppose to have a a sample of $n$ observations with 2 categorical variables, and we produce a two-way $(I \times J)$ contingency table (cross tabulation) from these observations. Let us call $X$ such contingency table. 
Let's define:

- $n_{ij}$ the element at $i$-th row and $j$-th column of $X$ table;
- $n_{i+}$ the total of the $i$-th row in table;
- $n_{+j}$ the total of the $j$-th column in table;
- $n_{++}$, or simply $n$, the grand total of $X$ table ($n_{ij}$ values);
- $p_{ij} = n_{ij}/n$;
- $r_{i}$ or $p_{i+}$ the mass of $i$-th row, i.e., $n_{i+}/n$;
- $c_{j}$ or $p_{+j}$ the mass of $j$-th column, i.e., $n_{+j}/n$;
- $a_{ij}$ the $j$-th element of the profile of row $i$, i.e., $a_{i,j}=n_{ij}/n_{i+}$; the $i$-th row profile vector is denoted by $\underline{a}_i$;
- $b_{ij}$ the $i$-th element of the profile of column $j$, i.e., $b_{i,j}=n_{ij}/n_{+j}$ ; the $j$-th column profile vector is denoted by $\underline{b}_j$;
- $\sqrt{\sum_j{(a_{ij}-a_{i'j})^2}/c_j}$ the $\chi^2$ distance between the $i$-th and $i'$-th row profiles, denoted also as $\left \| \underline{a}_i-\underline{a}_{i'} \right \|_c$;
- $\sqrt{\sum_j{(b_{ij}-b_{ij'})^2}/r_i}$ the $\chi^2$ distance between the $j$-th and $j'$-th column profiles, denoted also as $\left \| \underline{b}_j-\underline{b}_{j'} \right \|_r$
- $\sqrt{\sum_j{(a_{ij}-c_j)^2}/c_j}$ the $\chi^2$ distance between the $i$-th row profile and the average row profile $\underline{c}$ (the vector of column masses), denoted also as $\left \| \underline{a}_i-\underline{c} \right \|_c$;
- $\sqrt{\sum_j{(b_{ij}-r_i)^2}/r_i}$ the $\chi^2$ distance between the $j$-th  and the average column profile $\underline{r}$ (the vector of row masses), denoted also as $\left \| \underline{b}_j-\underline{r} \right \|_r$

Let us define the _Total Inertia_, a function of Pearson Chi-square ($\chi^2$) test statistics, as:

$$
\phi = \dfrac{\chi^2}{n}=\sum_i{r_i \left \| \underline{a}_i-\underline{c} \right \|_c} \\
\phantom{\phi = \dfrac{\chi^2}{n}}=\sum_i{r_i \sum_j{ \left(\dfrac{p_{ij}}{r_i} -c_j\right)^2}} \\
\phantom{\phi = \dfrac{\chi^2}{n}}= \sum_j{c_j \left \| \underline{b}_j-\underline{r} \right \|_r} \\
\phantom{\phi = \dfrac{\chi^2}{n}}=\sum_j{c_j \sum_i{ \left(\dfrac{p_{ij}}{c_j} -r_i\right)^2}} 
$$

Then:

1. The chi-square ($\chi^2$) statistic is an overall measure of the difference between the observed frequencies in a contingency table and the expected frequencies calculated under a hypothesis of homogeneity of the row profiles (or of the column profiles).
2. The (total) inertia of a contingency table is the ($\chi^2$) statistic divided by the total $n$ of the table.
3. Geometrically, the inertia measures how "far" the row profiles (or the column profiles) are from their average profile. The average profile can be considered to represent the hypothesis of homogeneity (i.e., equality) of profiles.
4. Distances between profiles are measured using the chi-square distance ($\chi^2$ - distance). This distance is similar in formulation to the Euclidean distance between points in physical space, except that each squared difference between coordinates is divided by the corresponding element of the average profile.
5. The inertia can be rewritten in a form which can be interpreted as the weighted average of squared $\chi^2$ - distances between the row profiles and their average profile (similarly, between the column profiles and their average).
Now, Let us define:
$$
D_r=diag(\underline{r}) \\
D_c=diag(\underline{c})  \\
P=\dfrac{1}{n} \cdot X = \{p_{ij}\}
$$

Simply stated, the goal of CA is in finding independent linear combinations of $\underline{a}_i$ ($\underline{b}_j$) that maximize the distance between linear combinations themselves. The weights of linear combinations are constrained to have unit length.

To obtain the solution, the following matrix:
$$
S=D_r^{-\frac{1}{2}}\left( P- \underline{r}\underline{c}^T\right)D_c^{-\frac{1}{2}}
$$
must be decomposed by SVD in:
$$ 
S = U D_\alpha V^T; \text{  where  }  U^T U =I \text{  and  }  V^T V = I
$$

$D_\alpha$ is the diagonal matrix of (positive) singular values in descending order, and the quantities 

$$
\Phi=D_r^{-\frac{1}{2}} U; \phantom{ aaa } \Gamma=D_c^{-\frac{1}{2}} V; \phantom{ aaa }  F=D_r^{-\frac{1}{2}} U D_\alpha = \Phi D_\alpha;  \phantom{ aaa }  \Gamma=D_c^{-\frac{1}{2}} V D_\alpha= \Gamma D_\alpha 
$$

are, respectively, the _Standard coordinates of rows_, the _Standard coordinates of columns_, the _Principal coordinates of rows_, and the _Principal coordinates of columns_.

<!---
# Exercises: CA su smoke.RData
--->
