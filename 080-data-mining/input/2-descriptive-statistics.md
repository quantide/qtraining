---
title: "Univariate Descriptions"
---




 

# Introduction

Univariate analysis is the simplest one. Despite the fact that a plethora of tools has been developed for this aim, these are usually not very sophisticated. The tools here presented probably are the most known and used too. Anyway, some introduction to them may be useful.
 

# Numerical Analysis

To illustrate some examples of descriptions, the `wea` data frame will be used first (see the section *Introduction and datasets used* for further information).  

The simplest text-based statistical summary of a dataset is provided by `summary()`. Let's apply it to the `wea` dataset (only columns from 7 to 9: `Sunshine`, `WindGustDir` and `WindGustSpeed`).


```r
summary(wea[,7:9])
```

```
##     Sunshine       WindGustDir  WindGustSpeed  
##  Min.   : 0.000   NW     : 73   Min.   :13.00  
##  1st Qu.: 5.950   NNW    : 44   1st Qu.:31.00  
##  Median : 8.600   E      : 37   Median :39.00  
##  Mean   : 7.909   WNW    : 35   Mean   :39.84  
##  3rd Qu.:10.500   ENE    : 30   3rd Qu.:46.00  
##  Max.   :13.600   (Other):144   Max.   :98.00  
##  NA's   :3        NA's   :  3   NA's   :2
```

A more detailed summary is obtained from `describe()`, provided by the `Hmisc` package. The `Hmisc` package contains many functions useful for data analysis, high-level graphics, utility operations, and many other functionalities.
To illustrate the `describe()` function we first load `Hmisc`:


```r
require(Hmisc)
```

For numeric variables, `describe()` returns two more deciles (10% and 90%) and two
other percentiles (5% and 95%). The output continues with a list of the lowest few and highest few observations of the variable. This extra
information is quite useful in building up our picture of the data.


```r
describe(wea$Sunshine)
```

```
## wea$Sunshine 
##        n  missing distinct     Info     Mean      Gmd      .05      .10      .25      .50      .75      .90 
##      363        3      114        1    7.909    3.875     0.60     2.04     5.95     8.60    10.50    11.80 
##      .95 
##    12.60 
## 
## lowest :  0.0  0.1  0.2  0.3  0.4, highest: 13.1 13.2 13.3 13.5 13.6
```

For categorical variables, `describe()` produces also the frequency count and the corresponding percentage for each level. 


```r
describe(wea$WindDir9am)
```

```
## wea$WindDir9am 
##        n  missing distinct 
##      335       31       16 
##                                                                                                           
## Value          N   NNE    NE   ENE     E   ESE    SE   SSE     S   SSW    SW   WSW     W   WNW    NW   NNW
## Frequency     31     8     4     8    22    29    47    40    27    17     7     5     8    16    30    36
## Proportion 0.093 0.024 0.012 0.024 0.066 0.087 0.140 0.119 0.081 0.051 0.021 0.015 0.024 0.048 0.090 0.107
```

An even more detailed summary of the numeric data is provided by `basicStats()` from `fBasics` (Wuertz et al., 2010).


```r
require(fBasics)
```

Though intended for time series data, it provides useful statistics in general, as we see in the code box below.


```r
basicStats(wea$Sunshine)
```

```
##             X..wea.Sunshine
## nobs             366.000000
## NAs                3.000000
## Minimum            0.000000
## Maximum           13.600000
## 1. Quartile        5.950000
## 3. Quartile       10.500000
## Mean               7.909366
## Median             8.600000
## Sum             2871.100000
## SE Mean            0.182732
## LCL Mean           7.550016
## UCL Mean           8.268716
## Variance          12.120962
## Stdev              3.481517
## Skewness          -0.723454
## Kurtosis          -0.270625
```

Anyway, a frequent issue in data analysis is the presence of `NA`'s in data. There can be many reasons for missing values, including the fact that the data is hard to collect and so not always available.

Knowing why or when the data is missing is important in deciding how to deal with the missing values.
The nature of the missing data can be explored using `md.pattern()` from `mice` package:


```r
require(mice)
```


```r
md.pattern(wea[,7:10])
```

```
##     WindGustSpeed Sunshine WindGustDir WindDir9am   
## 329             1        1           1          1  0
##   3             1        0           1          1  1
##   1             1        1           0          1  1
##  31             1        1           1          0  1
##   2             0        1           0          1  2
##                 2        3           3         31 39
```

`md.pattern()` returns a matrix with `ncol(x)+1` (where `x` is the analyzed data frame) columns, in which each row corresponds to a missing data pattern (`1`=observed, `0`=missing). Rows and columns are sorted in increasing amounts of missing information. The last column shows the "complexity" of missing data pattern (= the number of variables with missing data in that pattern), while the last row contains counts of missing data for each column of data frame, and total.

This function does not strictly perform univariate analysis (as from chapter title), but is useful for investigating any structure of missing observation in the data. In specific case, the missing data pattern could be (nearly) monotone. 

 To perform a so-called *complete-case* analysis using only the data with no missing values, you can use the `complete.cases()` function, which returns a logical vector indicating which cases are complete:


```r
summary(wea[, 7:10])                              # NAs still in the data
```

```
##     Sunshine       WindGustDir  WindGustSpeed     WindDir9am 
##  Min.   : 0.000   NW     : 73   Min.   :13.00   SE     : 47  
##  1st Qu.: 5.950   NNW    : 44   1st Qu.:31.00   SSE    : 40  
##  Median : 8.600   E      : 37   Median :39.00   NNW    : 36  
##  Mean   : 7.909   WNW    : 35   Mean   :39.84   N      : 31  
##  3rd Qu.:10.500   ENE    : 30   3rd Qu.:46.00   NW     : 30  
##  Max.   :13.600   (Other):144   Max.   :98.00   (Other):151  
##  NA's   :3        NA's   :  3   NA's   :2       NA's   : 31
```

```r
summary(wea[complete.cases(wea[,7:10]), 7:10])    # NAs removed
```

```
##     Sunshine       WindGustDir  WindGustSpeed     WindDir9am 
##  Min.   : 0.000   NW     : 65   Min.   :13.00   SE     : 47  
##  1st Qu.: 6.000   NNW    : 35   1st Qu.:31.00   SSE    : 38  
##  Median : 8.700   E      : 34   Median :39.00   NNW    : 36  
##  Mean   : 7.991   WNW    : 32   Mean   :40.37   N      : 30  
##  3rd Qu.:10.700   ENE    : 29   3rd Qu.:46.00   NW     : 30  
##  Max.   :13.600   ESE    : 23   Max.   :98.00   ESE    : 29  
##                   (Other):111                   (Other):119
```

To calculate aggregation measures such as mean, summary, etc., by the levels of a categorical variable you can use the `tapply()` function:


```r
tapply(X = wea$Sunshine, INDEX = wea$WindGustDir, FUN = mean, na.rm = TRUE)
```

```
##         N       NNE        NE       ENE         E       ESE        SE       SSE         S       SSW 
##  9.209524  7.971429  8.981250  7.910000  8.600000  5.978261  5.808333  7.100000  7.759091  6.950000 
##        SW       WSW         W       WNW        NW       NNW 
##  7.500000 11.450000  7.090000  8.088571  8.108333  8.018182
```

```r
tapply(X = wea$Sunshine, INDEX = wea$WindGustDir, FUN = length)
```

```
##   N NNE  NE ENE   E ESE  SE SSE   S SSW  SW WSW   W WNW  NW NNW 
##  21   8  16  30  37  23  12  12  22   5   3   2  20  35  73  44
```

```r
table(wea$WindGustDir, useNA = "ifany")
```

```
## 
##    N  NNE   NE  ENE    E  ESE   SE  SSE    S  SSW   SW  WSW    W  WNW   NW  NNW <NA> 
##   21    8   16   30   37   23   12   12   22    5    3    2   20   35   73   44    3
```

```r
tapply(X = wea$Sunshine, INDEX = wea$WindGustDir, FUN = summary)
```

```
## $N
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    1.90    8.10    9.70    9.21   11.10   12.70 
## 
## $NNE
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##   0.600   6.650   8.100   7.971  10.500  12.800       1 
## 
## $NE
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   8.575  10.550   8.981  11.475  13.600 
## 
## $ENE
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   6.225   9.300   7.910  10.200  12.600 
## 
## $E
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.0     7.3     9.2     8.6    11.5    13.0 
## 
## $ESE
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   3.750   7.100   5.978   8.400  12.500 
## 
## $SE
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   2.800   7.350   5.808   8.525  11.200 
## 
## $SSE
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.200   2.425   7.850   7.100  10.825  13.300 
## 
## $S
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.900   4.900   8.650   7.759   9.950  12.100 
## 
## $SSW
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##    5.90    5.90    6.70    6.95    7.75    8.50       1 
## 
## $SW
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    6.80    6.85    6.90    7.50    7.85    8.80 
## 
## $WSW
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   11.30   11.38   11.45   11.45   11.53   11.60 
## 
## $W
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   5.875   8.050   7.090   9.125  11.300 
## 
## $WNW
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   6.400   8.400   8.089  10.100  13.500 
## 
## $NW
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##   0.000   6.500   8.550   8.108  10.225  13.100       1 
## 
## $NNW
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   5.500   8.900   8.018  10.525  13.600
```

Notice above that the combination between the `tapply()` and the `length()` functions gives (almost) the same result as the `table()` function, which gives a frequency table.  
With the `aggregate()` function you can get the same results of `tapply()` in a convenient form. Furthermore with `aggregate()` you can get aggregation measures by combinations of levels of more than one categorical variable:


```r
aggregate(x = wea$Pressure9am, by = list(wgd=wea$WindGustDir), FUN = summary)
```

```
##    wgd   x.Min. x.1st Qu. x.Median   x.Mean x.3rd Qu.   x.Max.
## 1    N 1008.500  1019.100 1021.200 1021.476  1024.300 1032.200
## 2  NNE 1013.900  1016.325 1019.450 1021.925  1029.025 1031.400
## 3   NE 1008.700  1017.225 1018.850 1019.900  1023.850 1032.300
## 4  ENE 1006.600  1014.550 1020.750 1019.367  1022.775 1035.700
## 5    E 1010.700  1017.500 1021.600 1021.535  1025.200 1034.300
## 6  ESE 1010.000  1015.400 1021.100 1022.217  1028.350 1033.600
## 7   SE 1017.400  1021.575 1024.200 1023.967  1026.850 1029.500
## 8  SSE 1007.700  1013.300 1018.600 1019.042  1026.000 1028.200
## 9    S 1010.100  1018.275 1020.800 1021.200  1025.700 1029.000
## 10 SSW  999.400  1020.900 1022.800 1019.720  1027.700 1027.800
## 11  SW 1007.600  1011.050 1014.500 1015.933  1020.100 1025.700
## 12 WSW 1013.100  1015.800 1018.500 1018.500  1021.200 1023.900
## 13   W 1002.100  1009.200 1017.300 1015.805  1020.975 1032.900
## 14 WNW 1004.000  1013.600 1019.200 1018.263  1021.950 1030.200
## 15  NW 1003.200  1012.800 1018.000 1017.975  1023.200 1032.100
## 16 NNW  996.500  1017.025 1020.800 1019.732  1024.025 1031.000
```

```r
(res <- aggregate(x = wea$Pressure9am, by = list(wgd=wea$WindGustDir, rt=wea$RainToday), FUN = summary))
```

```
##    wgd  rt   x.Min. x.1st Qu. x.Median   x.Mean x.3rd Qu.   x.Max.
## 1    N  No 1008.500  1019.450 1022.800 1022.016  1024.350 1032.200
## 2  NNE  No 1015.800  1017.350 1020.700 1023.071  1029.450 1031.400
## 3   NE  No 1011.800  1017.850 1020.400 1021.064  1024.150 1032.300
## 4  ENE  No 1006.600  1018.000 1021.100 1021.084  1023.200 1035.700
## 5    E  No 1010.700  1017.600 1022.350 1021.632  1025.350 1034.300
## 6  ESE  No 1012.200  1016.975 1025.650 1023.789  1029.925 1033.600
## 7   SE  No 1017.400  1021.575 1024.200 1023.967  1026.850 1029.500
## 8  SSE  No 1007.700  1011.350 1019.500 1018.513  1026.000 1027.200
## 9    S  No 1018.500  1020.800 1025.700 1023.967  1025.900 1029.000
## 10 SSW  No  999.400  1020.900 1022.800 1019.720  1027.700 1027.800
## 11  SW  No 1007.600  1011.050 1014.500 1015.933  1020.100 1025.700
## 12 WSW  No 1013.100  1015.800 1018.500 1018.500  1021.200 1023.900
## 13   W  No 1002.100  1013.750 1017.600 1017.371  1022.175 1032.900
## 14 WNW  No 1010.500  1014.475 1020.000 1019.570  1022.750 1030.200
## 15  NW  No 1003.200  1014.600 1018.750 1018.809  1023.750 1032.100
## 16 NNW  No 1011.700  1017.800 1022.500 1021.074  1024.150 1031.000
## 17   N Yes 1012.900  1014.625 1016.350 1016.350  1018.075 1019.800
## 18 NNE Yes 1013.900  1013.900 1013.900 1013.900  1013.900 1013.900
## 19  NE Yes 1008.700  1010.225 1011.750 1011.750  1013.275 1014.800
## 20 ENE Yes 1007.600  1009.500 1010.000 1010.780  1012.400 1014.400
## 21   E Yes 1016.800  1018.600 1020.400 1020.433  1022.250 1024.100
## 22 ESE Yes 1010.000  1014.000 1014.600 1016.560  1017.600 1026.600
## 23 SSE Yes 1015.000  1017.475 1018.600 1020.100  1021.225 1028.200
## 24   S Yes 1010.100  1012.950 1015.500 1015.271  1017.300 1020.800
## 25   W Yes 1006.300  1008.000 1009.550 1012.150  1016.500 1021.200
## 26 WNW Yes 1004.000  1006.900 1010.300 1010.420  1013.900 1017.000
## 27  NW Yes 1004.900  1009.500 1016.700 1015.229  1019.200 1027.800
## 28 NNW Yes  996.500  1010.200 1015.800 1014.511  1018.100 1025.700
```

```r
str(res)
```

```
## 'data.frame':	28 obs. of  3 variables:
##  $ wgd: Ord.factor w/ 16 levels "N"<"NNE"<"NE"<..: 1 2 3 4 5 6 7 8 9 10 ...
##  $ rt : Factor w/ 2 levels "No","Yes": 1 1 1 1 1 1 1 1 1 1 ...
##  $ x  : num [1:28, 1:6] 1008 1016 1012 1007 1011 ...
```

```r
(res <- cbind(res[,1:2], res$x))
```

```
##    wgd  rt   Min.  1st Qu.  Median     Mean  3rd Qu.   Max.
## 1    N  No 1008.5 1019.450 1022.80 1022.016 1024.350 1032.2
## 2  NNE  No 1015.8 1017.350 1020.70 1023.071 1029.450 1031.4
## 3   NE  No 1011.8 1017.850 1020.40 1021.064 1024.150 1032.3
## 4  ENE  No 1006.6 1018.000 1021.10 1021.084 1023.200 1035.7
## 5    E  No 1010.7 1017.600 1022.35 1021.632 1025.350 1034.3
## 6  ESE  No 1012.2 1016.975 1025.65 1023.789 1029.925 1033.6
## 7   SE  No 1017.4 1021.575 1024.20 1023.967 1026.850 1029.5
## 8  SSE  No 1007.7 1011.350 1019.50 1018.513 1026.000 1027.2
## 9    S  No 1018.5 1020.800 1025.70 1023.967 1025.900 1029.0
## 10 SSW  No  999.4 1020.900 1022.80 1019.720 1027.700 1027.8
## 11  SW  No 1007.6 1011.050 1014.50 1015.933 1020.100 1025.7
## 12 WSW  No 1013.1 1015.800 1018.50 1018.500 1021.200 1023.9
## 13   W  No 1002.1 1013.750 1017.60 1017.371 1022.175 1032.9
## 14 WNW  No 1010.5 1014.475 1020.00 1019.570 1022.750 1030.2
## 15  NW  No 1003.2 1014.600 1018.75 1018.809 1023.750 1032.1
## 16 NNW  No 1011.7 1017.800 1022.50 1021.074 1024.150 1031.0
## 17   N Yes 1012.9 1014.625 1016.35 1016.350 1018.075 1019.8
## 18 NNE Yes 1013.9 1013.900 1013.90 1013.900 1013.900 1013.9
## 19  NE Yes 1008.7 1010.225 1011.75 1011.750 1013.275 1014.8
## 20 ENE Yes 1007.6 1009.500 1010.00 1010.780 1012.400 1014.4
## 21   E Yes 1016.8 1018.600 1020.40 1020.433 1022.250 1024.1
## 22 ESE Yes 1010.0 1014.000 1014.60 1016.560 1017.600 1026.6
## 23 SSE Yes 1015.0 1017.475 1018.60 1020.100 1021.225 1028.2
## 24   S Yes 1010.1 1012.950 1015.50 1015.271 1017.300 1020.8
## 25   W Yes 1006.3 1008.000 1009.55 1012.150 1016.500 1021.2
## 26 WNW Yes 1004.0 1006.900 1010.30 1010.420 1013.900 1017.0
## 27  NW Yes 1004.9 1009.500 1016.70 1015.229 1019.200 1027.8
## 28 NNW Yes  996.5 1010.200 1015.80 1014.511 1018.100 1025.7
```

```r
str(res)
```

```
## 'data.frame':	28 obs. of  8 variables:
##  $ wgd    : Ord.factor w/ 16 levels "N"<"NNE"<"NE"<..: 1 2 3 4 5 6 7 8 9 10 ...
##  $ rt     : Factor w/ 2 levels "No","Yes": 1 1 1 1 1 1 1 1 1 1 ...
##  $ Min.   : num  1008 1016 1012 1007 1011 ...
##  $ 1st Qu.: num  1019 1017 1018 1018 1018 ...
##  $ Median : num  1023 1021 1020 1021 1022 ...
##  $ Mean   : num  1022 1023 1021 1021 1022 ...
##  $ 3rd Qu.: num  1024 1029 1024 1023 1025 ...
##  $ Max.   : num  1032 1031 1032 1036 1034 ...
```

```r
(res <- aggregate(x = wea[,c("Pressure9am","Pressure3pm")],
                  by = list(wgd=wea$WindGustDir, rt=wea$RainToday), FUN = summary))
```

```
##    wgd  rt Pressure9am.Min. Pressure9am.1st Qu. Pressure9am.Median Pressure9am.Mean Pressure9am.3rd Qu.
## 1    N  No         1008.500            1019.450           1022.800         1022.016            1024.350
## 2  NNE  No         1015.800            1017.350           1020.700         1023.071            1029.450
## 3   NE  No         1011.800            1017.850           1020.400         1021.064            1024.150
## 4  ENE  No         1006.600            1018.000           1021.100         1021.084            1023.200
## 5    E  No         1010.700            1017.600           1022.350         1021.632            1025.350
## 6  ESE  No         1012.200            1016.975           1025.650         1023.789            1029.925
## 7   SE  No         1017.400            1021.575           1024.200         1023.967            1026.850
## 8  SSE  No         1007.700            1011.350           1019.500         1018.513            1026.000
## 9    S  No         1018.500            1020.800           1025.700         1023.967            1025.900
## 10 SSW  No          999.400            1020.900           1022.800         1019.720            1027.700
## 11  SW  No         1007.600            1011.050           1014.500         1015.933            1020.100
## 12 WSW  No         1013.100            1015.800           1018.500         1018.500            1021.200
## 13   W  No         1002.100            1013.750           1017.600         1017.371            1022.175
## 14 WNW  No         1010.500            1014.475           1020.000         1019.570            1022.750
## 15  NW  No         1003.200            1014.600           1018.750         1018.809            1023.750
## 16 NNW  No         1011.700            1017.800           1022.500         1021.074            1024.150
## 17   N Yes         1012.900            1014.625           1016.350         1016.350            1018.075
## 18 NNE Yes         1013.900            1013.900           1013.900         1013.900            1013.900
## 19  NE Yes         1008.700            1010.225           1011.750         1011.750            1013.275
## 20 ENE Yes         1007.600            1009.500           1010.000         1010.780            1012.400
## 21   E Yes         1016.800            1018.600           1020.400         1020.433            1022.250
## 22 ESE Yes         1010.000            1014.000           1014.600         1016.560            1017.600
## 23 SSE Yes         1015.000            1017.475           1018.600         1020.100            1021.225
## 24   S Yes         1010.100            1012.950           1015.500         1015.271            1017.300
## 25   W Yes         1006.300            1008.000           1009.550         1012.150            1016.500
## 26 WNW Yes         1004.000            1006.900           1010.300         1010.420            1013.900
## 27  NW Yes         1004.900            1009.500           1016.700         1015.229            1019.200
## 28 NNW Yes          996.500            1010.200           1015.800         1014.511            1018.100
##    Pressure9am.Max. Pressure3pm.Min. Pressure3pm.1st Qu. Pressure3pm.Median Pressure3pm.Mean
## 1          1032.200         1006.100            1016.750           1019.100         1018.842
## 2          1031.400         1011.600            1013.450           1019.200         1019.743
## 3          1032.300         1007.400            1013.400           1017.150         1017.500
## 4          1035.700         1003.300            1016.100           1018.600         1018.184
## 5          1034.300         1008.900            1013.800           1018.450         1018.679
## 6          1033.600         1008.700            1015.925           1023.450         1021.067
## 7          1029.500         1017.100            1019.300           1021.950         1021.650
## 8          1027.200         1006.500            1009.125           1015.450         1015.325
## 9          1029.000         1014.800            1019.250           1022.700         1021.740
## 10         1027.800          998.900            1016.000           1019.300         1016.900
## 11         1025.700         1003.000            1007.250           1011.500         1012.100
## 12         1023.900         1009.500            1011.950           1014.400         1014.400
## 13         1032.900          997.500            1009.025           1014.650         1013.443
## 14         1030.200         1006.500            1013.125           1016.950         1016.767
## 15         1032.100          997.700            1010.800           1014.700         1015.386
## 16         1031.000         1010.400            1014.200           1018.000         1017.451
## 17         1019.800         1008.300            1011.000           1013.700         1013.700
## 18         1013.900         1009.500            1009.500           1009.500         1009.500
## 19         1014.800         1006.000            1007.350           1008.700         1008.700
## 20         1014.400         1005.000            1008.400           1009.100         1009.000
## 21         1024.100         1015.000            1017.050           1019.100         1018.267
## 22         1026.600         1007.800            1012.800           1014.900         1015.080
## 23         1028.200         1014.100            1016.350           1017.800         1018.850
## 24         1020.800         1008.400            1010.800           1014.500         1013.800
## 25         1021.200         1002.300            1007.125           1008.250         1009.767
## 26         1017.000         1001.800            1010.300           1012.700         1011.460
## 27         1027.800         1001.500            1007.200           1013.700         1013.588
## 28         1025.700          996.800            1006.500           1013.400         1011.844
##    Pressure3pm.3rd Qu. Pressure3pm.Max.
## 1             1021.950         1026.900
## 2             1026.300         1027.900
## 3             1020.400         1028.900
## 4             1020.000         1031.900
## 5             1022.750         1031.700
## 6             1026.900         1033.200
## 7             1023.500         1027.400
## 8             1022.050         1023.900
## 9             1024.950         1026.300
## 10            1024.800         1025.500
## 11            1016.650         1021.800
## 12            1016.850         1019.300
## 13            1018.900         1028.900
## 14            1020.400         1024.800
## 15            1019.850         1029.600
## 16            1020.650         1028.000
## 17            1016.400         1019.100
## 18            1009.500         1009.500
## 19            1010.050         1011.400
## 20            1011.000         1011.500
## 21            1019.900         1020.700
## 22            1016.800         1023.100
## 23            1020.300         1025.700
## 24            1016.250         1019.600
## 25            1012.450         1019.200
## 26            1014.900         1017.600
## 27            1018.200         1024.300
## 28            1014.100         1022.300
```

With the `by()` function you can get results similar to those obtained by `aggregate()`:


```r
by(data = wea[,c("Sunshine","Pressure9am","Pressure3pm")],
   INDICES = list(wgd=wea$WindGustDir, rt=wea$RainToday), 
   FUN = summary)
```

```
## wgd: N
## rt: No
##     Sunshine       Pressure9am    Pressure3pm  
##  Min.   : 1.900   Min.   :1008   Min.   :1006  
##  1st Qu.: 8.650   1st Qu.:1019   1st Qu.:1017  
##  Median : 9.900   Median :1023   Median :1019  
##  Mean   : 9.374   Mean   :1022   Mean   :1019  
##  3rd Qu.:11.100   3rd Qu.:1024   3rd Qu.:1022  
##  Max.   :12.700   Max.   :1032   Max.   :1027  
## --------------------------------------------------------------------------------- 
## wgd: NNE
## rt: No
##     Sunshine       Pressure9am    Pressure3pm  
##  Min.   : 0.600   Min.   :1016   Min.   :1012  
##  1st Qu.: 6.225   1st Qu.:1017   1st Qu.:1013  
##  Median : 7.800   Median :1021   Median :1019  
##  Mean   : 7.300   Mean   :1023   Mean   :1020  
##  3rd Qu.: 8.775   3rd Qu.:1029   3rd Qu.:1026  
##  Max.   :12.800   Max.   :1031   Max.   :1028  
##  NA's   :1                                     
## --------------------------------------------------------------------------------- 
## wgd: NE
## rt: No
##     Sunshine       Pressure9am    Pressure3pm  
##  Min.   : 0.800   Min.   :1012   Min.   :1007  
##  1st Qu.: 9.200   1st Qu.:1018   1st Qu.:1013  
##  Median :10.750   Median :1020   Median :1017  
##  Mean   : 9.636   Mean   :1021   Mean   :1018  
##  3rd Qu.:11.625   3rd Qu.:1024   3rd Qu.:1020  
##  Max.   :13.600   Max.   :1032   Max.   :1029  
## --------------------------------------------------------------------------------- 
## wgd: ENE
## rt: No
##     Sunshine       Pressure9am    Pressure3pm  
##  Min.   : 0.600   Min.   :1007   Min.   :1003  
##  1st Qu.: 6.800   1st Qu.:1018   1st Qu.:1016  
##  Median : 9.600   Median :1021   Median :1019  
##  Mean   : 8.456   Mean   :1021   Mean   :1018  
##  3rd Qu.:10.200   3rd Qu.:1023   3rd Qu.:1020  
##  Max.   :12.600   Max.   :1036   Max.   :1032  
## --------------------------------------------------------------------------------- 
## wgd: E
## rt: No
##     Sunshine       Pressure9am    Pressure3pm  
##  Min.   : 0.000   Min.   :1011   Min.   :1009  
##  1st Qu.: 7.350   1st Qu.:1018   1st Qu.:1014  
##  Median : 9.250   Median :1022   Median :1018  
##  Mean   : 8.626   Mean   :1022   Mean   :1019  
##  3rd Qu.:11.450   3rd Qu.:1025   3rd Qu.:1023  
##  Max.   :13.000   Max.   :1034   Max.   :1032  
## --------------------------------------------------------------------------------- 
## wgd: ESE
## rt: No
##     Sunshine       Pressure9am    Pressure3pm  
##  Min.   : 0.000   Min.   :1012   Min.   :1009  
##  1st Qu.: 3.950   1st Qu.:1017   1st Qu.:1016  
##  Median : 7.500   Median :1026   Median :1023  
##  Mean   : 6.517   Mean   :1024   Mean   :1021  
##  3rd Qu.: 8.400   3rd Qu.:1030   3rd Qu.:1027  
##  Max.   :12.500   Max.   :1034   Max.   :1033  
## --------------------------------------------------------------------------------- 
## wgd: SE
## rt: No
##     Sunshine       Pressure9am    Pressure3pm  
##  Min.   : 0.000   Min.   :1017   Min.   :1017  
##  1st Qu.: 2.800   1st Qu.:1022   1st Qu.:1019  
##  Median : 7.350   Median :1024   Median :1022  
##  Mean   : 5.808   Mean   :1024   Mean   :1022  
##  3rd Qu.: 8.525   3rd Qu.:1027   3rd Qu.:1024  
##  Max.   :11.200   Max.   :1030   Max.   :1027  
## --------------------------------------------------------------------------------- 
## wgd: SSE
## rt: No
##     Sunshine       Pressure9am    Pressure3pm  
##  Min.   : 0.800   Min.   :1008   Min.   :1006  
##  1st Qu.: 5.575   1st Qu.:1011   1st Qu.:1009  
##  Median : 9.850   Median :1020   Median :1015  
##  Mean   : 8.200   Mean   :1019   Mean   :1015  
##  3rd Qu.:11.225   3rd Qu.:1026   3rd Qu.:1022  
##  Max.   :13.300   Max.   :1027   Max.   :1024  
## --------------------------------------------------------------------------------- 
## wgd: S
## rt: No
##     Sunshine       Pressure9am    Pressure3pm  
##  Min.   : 2.700   Min.   :1018   Min.   :1015  
##  1st Qu.: 5.600   1st Qu.:1021   1st Qu.:1019  
##  Median : 8.200   Median :1026   Median :1023  
##  Mean   : 7.813   Mean   :1024   Mean   :1022  
##  3rd Qu.:10.050   3rd Qu.:1026   3rd Qu.:1025  
##  Max.   :12.100   Max.   :1029   Max.   :1026  
## --------------------------------------------------------------------------------- 
## wgd: SSW
## rt: No
##     Sunshine     Pressure9am      Pressure3pm    
##  Min.   :5.90   Min.   : 999.4   Min.   : 998.9  
##  1st Qu.:5.90   1st Qu.:1020.9   1st Qu.:1016.0  
##  Median :6.70   Median :1022.8   Median :1019.3  
##  Mean   :6.95   Mean   :1019.7   Mean   :1016.9  
##  3rd Qu.:7.75   3rd Qu.:1027.7   3rd Qu.:1024.8  
##  Max.   :8.50   Max.   :1027.8   Max.   :1025.5  
##  NA's   :1                                       
## --------------------------------------------------------------------------------- 
## wgd: SW
## rt: No
##     Sunshine     Pressure9am    Pressure3pm  
##  Min.   :6.80   Min.   :1008   Min.   :1003  
##  1st Qu.:6.85   1st Qu.:1011   1st Qu.:1007  
##  Median :6.90   Median :1014   Median :1012  
##  Mean   :7.50   Mean   :1016   Mean   :1012  
##  3rd Qu.:7.85   3rd Qu.:1020   3rd Qu.:1017  
##  Max.   :8.80   Max.   :1026   Max.   :1022  
## --------------------------------------------------------------------------------- 
## wgd: WSW
## rt: No
##     Sunshine      Pressure9am    Pressure3pm  
##  Min.   :11.30   Min.   :1013   Min.   :1010  
##  1st Qu.:11.38   1st Qu.:1016   1st Qu.:1012  
##  Median :11.45   Median :1018   Median :1014  
##  Mean   :11.45   Mean   :1018   Mean   :1014  
##  3rd Qu.:11.53   3rd Qu.:1021   3rd Qu.:1017  
##  Max.   :11.60   Max.   :1024   Max.   :1019  
## --------------------------------------------------------------------------------- 
## wgd: W
## rt: No
##     Sunshine       Pressure9am    Pressure3pm    
##  Min.   : 0.200   Min.   :1002   Min.   : 997.5  
##  1st Qu.: 6.550   1st Qu.:1014   1st Qu.:1009.0  
##  Median : 8.250   Median :1018   Median :1014.6  
##  Mean   : 7.493   Mean   :1017   Mean   :1013.4  
##  3rd Qu.: 9.275   3rd Qu.:1022   3rd Qu.:1018.9  
##  Max.   :11.300   Max.   :1033   Max.   :1028.9  
## --------------------------------------------------------------------------------- 
## wgd: WNW
## rt: No
##     Sunshine       Pressure9am    Pressure3pm  
##  Min.   : 0.000   Min.   :1010   Min.   :1006  
##  1st Qu.: 6.150   1st Qu.:1014   1st Qu.:1013  
##  Median : 8.050   Median :1020   Median :1017  
##  Mean   : 7.737   Mean   :1020   Mean   :1017  
##  3rd Qu.: 9.950   3rd Qu.:1023   3rd Qu.:1020  
##  Max.   :13.000   Max.   :1030   Max.   :1025  
## --------------------------------------------------------------------------------- 
## wgd: NW
## rt: No
##     Sunshine       Pressure9am    Pressure3pm    
##  Min.   : 1.200   Min.   :1003   Min.   : 997.7  
##  1st Qu.: 7.100   1st Qu.:1015   1st Qu.:1010.8  
##  Median : 8.900   Median :1019   Median :1014.7  
##  Mean   : 8.534   Mean   :1019   Mean   :1015.4  
##  3rd Qu.:10.400   3rd Qu.:1024   3rd Qu.:1019.9  
##  Max.   :13.100   Max.   :1032   Max.   :1029.6  
## --------------------------------------------------------------------------------- 
## wgd: NNW
## rt: No
##     Sunshine       Pressure9am    Pressure3pm  
##  Min.   : 0.500   Min.   :1012   Min.   :1010  
##  1st Qu.: 5.850   1st Qu.:1018   1st Qu.:1014  
##  Median : 9.200   Median :1022   Median :1018  
##  Mean   : 8.394   Mean   :1021   Mean   :1017  
##  3rd Qu.:10.550   3rd Qu.:1024   3rd Qu.:1021  
##  Max.   :13.600   Max.   :1031   Max.   :1028  
## --------------------------------------------------------------------------------- 
## wgd: N
## rt: Yes
##     Sunshine      Pressure9am    Pressure3pm  
##  Min.   :7.200   Min.   :1013   Min.   :1008  
##  1st Qu.:7.425   1st Qu.:1015   1st Qu.:1011  
##  Median :7.650   Median :1016   Median :1014  
##  Mean   :7.650   Mean   :1016   Mean   :1014  
##  3rd Qu.:7.875   3rd Qu.:1018   3rd Qu.:1016  
##  Max.   :8.100   Max.   :1020   Max.   :1019  
## --------------------------------------------------------------------------------- 
## wgd: NNE
## rt: Yes
##     Sunshine   Pressure9am    Pressure3pm  
##  Min.   :12   Min.   :1014   Min.   :1010  
##  1st Qu.:12   1st Qu.:1014   1st Qu.:1010  
##  Median :12   Median :1014   Median :1010  
##  Mean   :12   Mean   :1014   Mean   :1010  
##  3rd Qu.:12   3rd Qu.:1014   3rd Qu.:1010  
##  Max.   :12   Max.   :1014   Max.   :1010  
## --------------------------------------------------------------------------------- 
## wgd: NE
## rt: Yes
##     Sunshine    Pressure9am    Pressure3pm  
##  Min.   :0.0   Min.   :1009   Min.   :1006  
##  1st Qu.:2.2   1st Qu.:1010   1st Qu.:1007  
##  Median :4.4   Median :1012   Median :1009  
##  Mean   :4.4   Mean   :1012   Mean   :1009  
##  3rd Qu.:6.6   3rd Qu.:1013   3rd Qu.:1010  
##  Max.   :8.8   Max.   :1015   Max.   :1011  
## --------------------------------------------------------------------------------- 
## wgd: ENE
## rt: Yes
##     Sunshine      Pressure9am    Pressure3pm  
##  Min.   : 0.00   Min.   :1008   Min.   :1005  
##  1st Qu.: 0.40   1st Qu.:1010   1st Qu.:1008  
##  Median : 5.60   Median :1010   Median :1009  
##  Mean   : 5.18   Mean   :1011   Mean   :1009  
##  3rd Qu.: 9.70   3rd Qu.:1012   3rd Qu.:1011  
##  Max.   :10.20   Max.   :1014   Max.   :1012  
## --------------------------------------------------------------------------------- 
## wgd: E
## rt: Yes
##     Sunshine      Pressure9am    Pressure3pm  
##  Min.   : 5.60   Min.   :1017   Min.   :1015  
##  1st Qu.: 6.65   1st Qu.:1019   1st Qu.:1017  
##  Median : 7.70   Median :1020   Median :1019  
##  Mean   : 8.30   Mean   :1020   Mean   :1018  
##  3rd Qu.: 9.65   3rd Qu.:1022   3rd Qu.:1020  
##  Max.   :11.60   Max.   :1024   Max.   :1021  
## --------------------------------------------------------------------------------- 
## wgd: ESE
## rt: Yes
##     Sunshine      Pressure9am    Pressure3pm  
##  Min.   : 0.30   Min.   :1010   Min.   :1008  
##  1st Qu.: 0.60   1st Qu.:1014   1st Qu.:1013  
##  Median : 3.60   Median :1015   Median :1015  
##  Mean   : 4.04   Mean   :1017   Mean   :1015  
##  3rd Qu.: 5.10   3rd Qu.:1018   3rd Qu.:1017  
##  Max.   :10.60   Max.   :1027   Max.   :1023  
## --------------------------------------------------------------------------------- 
## wgd: SE
## rt: Yes
## NULL
## --------------------------------------------------------------------------------- 
## wgd: SSE
## rt: Yes
##     Sunshine     Pressure9am    Pressure3pm  
##  Min.   : 0.2   Min.   :1015   Min.   :1014  
##  1st Qu.: 2.0   1st Qu.:1017   1st Qu.:1016  
##  Median : 4.4   Median :1019   Median :1018  
##  Mean   : 4.9   Mean   :1020   Mean   :1019  
##  3rd Qu.: 7.3   3rd Qu.:1021   3rd Qu.:1020  
##  Max.   :10.6   Max.   :1028   Max.   :1026  
## --------------------------------------------------------------------------------- 
## wgd: S
## rt: Yes
##     Sunshine       Pressure9am    Pressure3pm  
##  Min.   : 0.900   Min.   :1010   Min.   :1008  
##  1st Qu.: 6.050   1st Qu.:1013   1st Qu.:1011  
##  Median : 9.100   Median :1016   Median :1014  
##  Mean   : 7.643   Mean   :1015   Mean   :1014  
##  3rd Qu.: 9.700   3rd Qu.:1017   3rd Qu.:1016  
##  Max.   :12.000   Max.   :1021   Max.   :1020  
## --------------------------------------------------------------------------------- 
## wgd: SSW
## rt: Yes
## NULL
## --------------------------------------------------------------------------------- 
## wgd: SW
## rt: Yes
## NULL
## --------------------------------------------------------------------------------- 
## wgd: WSW
## rt: Yes
## NULL
## --------------------------------------------------------------------------------- 
## wgd: W
## rt: Yes
##     Sunshine      Pressure9am    Pressure3pm  
##  Min.   :0.000   Min.   :1006   Min.   :1002  
##  1st Qu.:5.675   1st Qu.:1008   1st Qu.:1007  
##  Median :6.800   Median :1010   Median :1008  
##  Mean   :6.150   Mean   :1012   Mean   :1010  
##  3rd Qu.:8.375   3rd Qu.:1016   3rd Qu.:1012  
##  Max.   :9.100   Max.   :1021   Max.   :1019  
## --------------------------------------------------------------------------------- 
## wgd: WNW
## rt: Yes
##     Sunshine     Pressure9am    Pressure3pm  
##  Min.   : 7.5   Min.   :1004   Min.   :1002  
##  1st Qu.: 9.3   1st Qu.:1007   1st Qu.:1010  
##  Median : 9.7   Median :1010   Median :1013  
##  Mean   :10.2   Mean   :1010   Mean   :1011  
##  3rd Qu.:11.0   3rd Qu.:1014   3rd Qu.:1015  
##  Max.   :13.5   Max.   :1017   Max.   :1018  
## --------------------------------------------------------------------------------- 
## wgd: NW
## rt: Yes
##     Sunshine       Pressure9am    Pressure3pm  
##  Min.   : 0.000   Min.   :1005   Min.   :1002  
##  1st Qu.: 4.050   1st Qu.:1010   1st Qu.:1007  
##  Median : 7.800   Median :1017   Median :1014  
##  Mean   : 6.619   Mean   :1015   Mean   :1014  
##  3rd Qu.: 8.350   3rd Qu.:1019   3rd Qu.:1018  
##  Max.   :11.800   Max.   :1028   Max.   :1024  
##  NA's   :1                                     
## --------------------------------------------------------------------------------- 
## wgd: NNW
## rt: Yes
##     Sunshine       Pressure9am      Pressure3pm    
##  Min.   : 0.000   Min.   : 996.5   Min.   : 996.8  
##  1st Qu.: 4.900   1st Qu.:1010.2   1st Qu.:1006.5  
##  Median : 6.000   Median :1015.8   Median :1013.4  
##  Mean   : 6.556   Mean   :1014.5   Mean   :1011.8  
##  3rd Qu.: 8.500   3rd Qu.:1018.1   3rd Qu.:1014.1  
##  Max.   :13.200   Max.   :1025.7   Max.   :1022.3
```

More recent packages (i.e., `dplyr`) allow the researcher to develop by-group analyses in very simple and clear form:

```r
require(dplyr)

(res1 <- wea %>% 
  group_by(WindGustDir, RainToday) %>% 
  summarise(count = n(),
            mean_pressure9am = mean(Pressure9am),
            mean_pressure3pm =mean(Pressure3pm)))
```

```
## # A tibble: 29 x 5
## # Groups:   WindGustDir [?]
##    WindGustDir RainToday count mean_pressure9am mean_pressure3pm
##          <ord>    <fctr> <int>            <dbl>            <dbl>
##  1           N        No    19         1022.016         1018.842
##  2           N       Yes     2         1016.350         1013.700
##  3         NNE        No     7         1023.071         1019.743
##  4         NNE       Yes     1         1013.900         1009.500
##  5          NE        No    14         1021.064         1017.500
##  6          NE       Yes     2         1011.750         1008.700
##  7         ENE        No    25         1021.084         1018.184
##  8         ENE       Yes     5         1010.780         1009.000
##  9           E        No    34         1021.632         1018.679
## 10           E       Yes     3         1020.433         1018.267
## # ... with 19 more rows
```

`table()`, as already seen, returns the absolute frequency table of a categorical variable. If you want the relative frequency table of a categorical table, you can apply the `prop.table()` function to the output of `table()`. With the `margin` option you can choose to calculate row or column relative frequencies:


```r
(tbl <- table(wea$WindGustDir, wea$RainToday))
```

```
##      
##       No Yes
##   N   19   2
##   NNE  7   1
##   NE  14   2
##   ENE 25   5
##   E   34   3
##   ESE 18   5
##   SE  12   0
##   SSE  8   4
##   S   15   7
##   SSW  5   0
##   SW   3   0
##   WSW  2   0
##   W   14   6
##   WNW 30   5
##   NW  56  17
##   NNW 35   9
```

```r
prop.table(tbl)
```

```
##      
##                No         Yes
##   N   0.052341598 0.005509642
##   NNE 0.019283747 0.002754821
##   NE  0.038567493 0.005509642
##   ENE 0.068870523 0.013774105
##   E   0.093663912 0.008264463
##   ESE 0.049586777 0.013774105
##   SE  0.033057851 0.000000000
##   SSE 0.022038567 0.011019284
##   S   0.041322314 0.019283747
##   SSW 0.013774105 0.000000000
##   SW  0.008264463 0.000000000
##   WSW 0.005509642 0.000000000
##   W   0.038567493 0.016528926
##   WNW 0.082644628 0.013774105
##   NW  0.154269972 0.046831956
##   NNW 0.096418733 0.024793388
```

```r
prop.table(tbl, margin = 2)
```

```
##      
##                No         Yes
##   N   0.063973064 0.030303030
##   NNE 0.023569024 0.015151515
##   NE  0.047138047 0.030303030
##   ENE 0.084175084 0.075757576
##   E   0.114478114 0.045454545
##   ESE 0.060606061 0.075757576
##   SE  0.040404040 0.000000000
##   SSE 0.026936027 0.060606061
##   S   0.050505051 0.106060606
##   SSW 0.016835017 0.000000000
##   SW  0.010101010 0.000000000
##   WSW 0.006734007 0.000000000
##   W   0.047138047 0.090909091
##   WNW 0.101010101 0.075757576
##   NW  0.188552189 0.257575758
##   NNW 0.117845118 0.136363636
```

```r
prop.table(tbl, margin = 1)
```

```
##      
##               No        Yes
##   N   0.90476190 0.09523810
##   NNE 0.87500000 0.12500000
##   NE  0.87500000 0.12500000
##   ENE 0.83333333 0.16666667
##   E   0.91891892 0.08108108
##   ESE 0.78260870 0.21739130
##   SE  1.00000000 0.00000000
##   SSE 0.66666667 0.33333333
##   S   0.68181818 0.31818182
##   SSW 1.00000000 0.00000000
##   SW  1.00000000 0.00000000
##   WSW 1.00000000 0.00000000
##   W   0.70000000 0.30000000
##   WNW 0.85714286 0.14285714
##   NW  0.76712329 0.23287671
##   NNW 0.79545455 0.20454545
```


# Graphical Analysis

Graphical analysis allows us to take a "picture" of data distribution, and then to recognize patterns and/or catch outliers.  

Let us load the `ggplot2` package and consider the `iris` dataset (see the section *Introduction and datasets used* for further information on it):


```r
require(ggplot2)
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


## Time Series Plots
Suppose that data was collected in a time-ordered fashion. Let us add a datetime column to the dataset and plot the time series:


```r
iris$datetime <- seq.POSIXt(from = as.POSIXct("2012-10-10 08:00:00"), by = "1 min", length.out = nrow(iris))
iris$labels <- ifelse(iris$Sepal.Width < 2.8 | iris$Sepal.Width > 3.3, as.character(iris$Sepal.Length), "")

ggp <- ggplot(data = iris, aes(x = datetime, y = Sepal.Length)) +
  geom_point(aes(col = Sepal.Length))+
  geom_line(col = "blue") +
  ggtitle("Time series plot of Sepal.Length") +
  xlab("Date/time") + ylab("Sepal Length") +
  geom_text(aes(label = labels))
print(ggp)
```

![plot of chunk tsplot](figure/tsplot-1.png)

To plot several lines in one graph:


```r
dt <- data.frame(measure = c(iris$Sepal.Length,iris$Sepal.Width),
                 type = c(rep("Sepal Lentgh",150), rep("Sepal Width",150)), datetime=rep(iris$datetime,2))
ggp <- ggplot(data = dt, aes(x = datetime, y = measure, col = type)) +
  geom_line() +
  ggtitle("Time series plot of Sepal.Length and Sepal.Width") +
  xlab("Date/time") + ylab("Measures")
print(ggp)
```

![plot of chunk tssplot](figure/tssplot-1.png)

or (but note the legend):


```r
ggp <- ggplot(data = iris, aes(x = datetime, y = Sepal.Length)) +
  geom_line(colour = "blue") +
  geom_line(aes(y = Sepal.Width), colour = "red") +
  ggtitle("Time series plot of Sepal.Length and Sepal.Width") +
  xlab("Date/time") + ylab("Measures")
print(ggp)
```

![plot of chunk tss2plot](figure/tss2plot-1.png)


## Histograms

### Basic Histograms

These do both the same thing:


```r
(ggp <- ggplot(iris, aes(x = Sepal.Length)) + geom_histogram(binwidth = .3))
```

![plot of chunk histplot](figure/histplot-1.png)

Draw with black outline, white fill:


```r
(ggp <- ggplot(iris, aes(x = Sepal.Length)) +
   geom_histogram(binwidth = .3, colour = "black", fill = "white"))
```

![plot of chunk hist2plot](figure/hist2plot-1.png)

Plot of density curve:


```r
(ggp <- ggplot(iris, aes(x = Sepal.Length)) + geom_density())
```

![plot of chunk densityplot](figure/densityplot-1.png)

Histogram overlaid with kernel density curve:


```r
ggp <- ggplot(iris, aes(x = Sepal.Length)) +
  geom_histogram(aes(y = ..density..),      # Histogram with density instead of count on y-axis
                 binwidth = .3, colour = "black", fill = "white") +
  geom_density(alpha = .2, fill = "#FF6666")  # Overlay with transparent density plot
print(ggp)
```

![plot of chunk densityhistplot](figure/densityhistplot-1.png)

Histogram overlaid with kernel density curve and bars coloured with density values:


```r
ggp <- ggplot(iris, aes(x = Sepal.Length)) +
  geom_histogram(aes(y = ..density.., fill = ..density..), # Histogram with density instead of count on y-axis
                 binwidth = .3, colour = "black") +
  geom_density(alpha = .2, fill = "#FF6666")  # Overlay with transparent density plot
print(ggp)
```

![plot of chunk densityhistplot_colouredbars](figure/densityhistplot_colouredbars-1.png)

Histogram with mean line:


```r
ggp <- ggplot(iris, aes(x = Sepal.Length)) +
  geom_histogram(binwidth = .5, colour = "black", fill = "white") +
  geom_vline(aes(xintercept = mean(Sepal.Length, na.rm = TRUE)),   # Ignore NA values for mean
                        color = "red", linetype = "dashed", size = 1)
print(ggp)
```

![plot of chunk histwithmeanplot](figure/histwithmeanplot-1.png)

Density plots with semi-transparent fill (not really univariate, but an high-impact plot):


```r
(ggp <- ggplot(dt, aes(x = measure, fill = type)) + geom_density(alpha = .3))
```

![plot of chunk densityplots](figure/densityplots-1.png)

```r
(ggp <- ggplot(dt, aes(x = measure, fill = type)) + geom_histogram(alpha = 0.3, position = "identity")) # position="identity" is used to avoid stacked histograms
```

![plot of chunk densityplots](figure/densityplots-2.png)

```r
rm(dt)
```


## Boxplots

Boxplots in ggplot are "mutivariate" by design. If univariate, by design ggplot requires x and y dimensions. x dimension must be put in graph, and the scale value has to be removed:


```r
ggp <- ggplot(iris, aes(x = "", y = Sepal.Length)) +
  geom_boxplot() +
  xlab("Values")
print(ggp)
```

![plot of chunk boxplot](figure/boxplot-1.png)

Horizontal layout:


```r
(ggp <- ggp + coord_flip())  ## What happens if we use coord_flip(), e.g., with histgrams?
```

![plot of chunk horizboxplot](figure/horizboxplot-1.png)

"Standard" boxplot:


```r
nums <- tapply(iris$Sepal.Length, INDEX = iris$Species, FUN = length)
dt <- data.frame(pos = 1:length(nums), Species = names(nums), Count = nums)
ggp <- ggplot(iris, aes(x = Species, y = Sepal.Length)) +
  geom_boxplot() +
  geom_text(data=dt,aes(x = pos,
                        y = tapply(X = iris$Sepal.Length+1, INDEX = iris$Species, FUN = median),
                        label = Count)) +
  ggtitle("Sepal Length Vs Iris Type")
print(ggp)
```

![plot of chunk stdboxplot](figure/stdboxplot-1.png)

```r
ggp <- ggplot(iris, aes(x = "", y = Sepal.Length)) +
  geom_boxplot() + 
  facet_grid(facets = ~Species, as.table = TRUE)
print(ggp)
```

![plot of chunk stdboxplot](figure/stdboxplot-2.png)


## Violin Plots

Violin plots are similar to boxplot, but they show the distribution of variable instead of simple "summaries".
Violin plots in ggplot are "multivariate" by design too.


```r
ggp <- ggplot(iris, aes(x = "", y = Sepal.Length)) +
  geom_violin() +
  xlab("Values")
print(ggp)
```

![plot of chunk violinplot](figure/violinplot-1.png)

Add the points to plot:


```r
ggp <- ggp + geom_jitter()
print(ggp)
```

![plot of chunk addpointstoviolinplot](figure/addpointstoviolinplot-1.png)

"Standard" violin plot:


```r
ggp <- ggplot(iris, aes(x = Species, y = Sepal.Length)) +
  geom_violin() +
  ggtitle("Sepal Length Vs Iris Type")
print(ggp)
```

![plot of chunk violin2plot](figure/violin2plot-1.png)

Overlay boxplot:


```r
ggp <- ggp + geom_boxplot()
print(ggp)
```

![plot of chunk addboxtoviolinplot](figure/addboxtoviolinplot-1.png)

Add the points to plot:


```r
ggp <- ggp + geom_jitter()
print(ggp)
```

![plot of chunk addpointstoviolin2plot](figure/addpointstoviolin2plot-1.png)

Boxplots are also useful because they provide a simple approach to identify potential outliers.  
To show this feature of the boxplot we use the `forbes94` dataset (see the section *Introduction and datasets used* for further information).


```r
str(forbes94)
```

```
## Classes 'tbl_df', 'tbl' and 'data.frame':	800 obs. of  30 variables:
##  $ TotalComp     : int  600300 1487600 1508180 4069420 1088150 1099010 1652560 7285420 2271460 14899200 ...
##  $ WideIndustry  : Factor w/ 19 levels "Aerospacedefense",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ Company       : Factor w/ 800 levels "20th Century Industr",..: 694 103 526 448 460 319 427 322 701 321..
##  $ CEO           : Factor w/ 796 levels "Dr. Andrew S Grove",..: 777 221 453 530 383 24 128 386 327 347 ...
##  $ CityofBirth   : Factor w/ 402 levels "","Aberdeen",..: 288 35 250 94 18 76 130 281 224 97 ...
##  $ StateofBirth  : Factor w/ 51 levels "","AK","AL","AR",..: 40 15 36 7 22 37 40 21 19 24 ...
##  $ Age           : int  52 62 56 58 56 60 62 58 59 64 ...
##  $ Undergrad     : Factor w/ 262 levels "","Albion C",..: 83 186 106 124 124 67 170 196 190 198 ...
##  $ UGDegree      : Factor w/ 25 levels "","AAS","AB",..: 13 23 13 17 13 3 19 13 13 13 ...
##  $ UGDate        : int  63 54 59 57 60 55 54 57 56 52 ...
##  $ AgeOfUnder    : int  21 22 21 21 22 21 22 21 21 22 ...
##  $ Graduate      : Factor w/ 129 levels "","American Grad S",..: 22 27 39 50 50 61 72 83 86 91 ...
##  $ GradDegree    : Factor w/ 20 levels "AM","EdD","JD",..: 12 8 12 15 12 8 16 20 12 12 ...
##  $ MBA           : int  0 1 0 0 0 1 0 0 0 0 ...
##  $ MasterPhd     : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ G_date        : int  67 58 61 59 62 57 55 60 58 53 ...
##  $ AgeOfGradu    : int  25 26 23 23 24 23 23 24 23 23 ...
##  $ YearsFirm     : int  8 36 19 17 32 10 39 34 4 13 ...
##  $ YearsCEO      : int  3 8 4 6 6 9 5 13 2 1 ...
##  $ Salary        : int  600000 796935 675000 830000 559477 650833 762500 1750000 725000 670000 ...
##  $ Bonus         : int  NA 624000 450000 800000 495100 330000 650000 2200000 950000 1350000 ...
##  $ Other         : int  300 66669 383184 1645320 33569 118175 240064 441046 596461 12879200 ...
##  $ StGains       : int  NA NA NA 794103 NA NA NA 2894380 NA NA ...
##  $ Compfor5Yrs   : int  2560750 7857540 7719720 12625100 4452230 4803290 6614390 31373600 6408090 NA ...
##  $ StockOwned    : num  0.004 0.004 0.576 0.108 3.326 ...
##  $ Sales         : int  2492 25438 5063 9436 14487 1905 13071 60562 9078 3187 ...
##  $ Profits       : num  72.8 1244 96 450.3 396 ...
##  $ ReturnOver5Yrs: int  -9 10 13 17 7 1 11 21 19 24 ...
##  $ Industry      : Factor w/ 71 levels "Aerospacedefense",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ IndustryCode  : num  11 11 11 11 11 11 11 11 11 11 ...
```

```r
ggp <- ggplot(forbes94, aes(x = WideIndustry, y = Salary)) +
  geom_boxplot(outlier.shape = 19, outlier.colour = "red", outlier.size = 2) +
  ggtitle("Salary vs. Industry")
print(ggp)
```

```
## Warning: Removed 11 rows containing non-finite values (stat_boxplot).
```

![plot of chunk loadfandplotfb](figure/loadfandplotfb-1.png)

The boxplots above allow one to compare the salary distributions across the industries. Moreover,
they clearly show that in many industries there are some outliers. These are reported in each
boxplot as isolated observations. Outliers can be dangerous because they can strongly
influence the results of the analysis.


## 3D Plots

If a 3D plot is desired, several options are available.  
Let's consider the `volcano3d` dataset (see the section *Introduction and datasets used* for further information).

### Level Plots


```r
head(volcano3d)
```

```
## # A tibble: 6 x 3
##       x     y     z
##   <int> <int> <dbl>
## 1     1     1   100
## 2     2     1   101
## 3     3     1   102
## 4     4     1   103
## 5     5     1   104
## 6     6     1   105
```

```r
ggp <- ggplot(volcano3d, aes(x = x, y = y, z = z)) +
  stat_contour()
print(ggp)
```

![plot of chunk 3dplot](figure/3dplot-1.png)

With coloured z levels:


```r
ggp <- ggplot(volcano3d, aes(x = x, y = y, z = z)) +
  stat_contour(geom = "polygon", aes(fill = ..level..))
print(ggp)
```

![plot of chunk 3dplot1](figure/3dplot1-1.png)

As tiles:


```r
ggp <- ggplot(volcano3d, aes(x = x, y = y, z = z)) +
  geom_tile(aes(fill = z)) +
  stat_contour()
print(ggp)
```

![plot of chunk 3dplot2](figure/3dplot2-1.png)

3d density plot:


```r
ggp <- ggplot(forbes94, aes(x = Sales, y = Profits)) +
  stat_density2d(aes(fill = ..level..), geom = "polygon")
print(ggp)
```

```
## Warning: Removed 4 rows containing non-finite values (stat_density2d).
```

![plot of chunk 3dplot3](figure/3dplot3-1.png)


### 3D Scatterplots

Try these examples directly in your `R`, since no plots will be shown (these plots are interactive and you can move and turn them by clicking on them with the mouse).


```r
require(rgl)
```


```r
open3d()
with(forbes94,
plot3d(x = StockOwned, y = Sales, z = Profits,
       xlab = "StockOwned", ylab = "Sales", zlab = "Profits", type = "p"#), #col=,  
#        size, lwd, radius,
#        add = FALSE, aspect = !add, ...)
))
```


```r
open3d()
with(forbes94,
     plot3d(x = log(StockOwned), y = log(Sales), z = Profits,
            xlab = "StockOwned", ylab = "Sales", zlab = "Profits", type = "s",
            col = as.numeric(as.factor(WideIndustry))
            #        size, lwd, radius,
            #        add = FALSE, aspect = !add, ...)
     ))
```


```r
open3d()
with(forbes94,
     plot3d(x = log(StockOwned), y = log(Sales), z = Profits,
            xlab = "StockOwned", ylab = "Sales", zlab = "Profits", type = "p",
            col = as.numeric(as.factor(WideIndustry))
            #        size, lwd, radius,
            #        add = FALSE, aspect = !add, ...)
     ))
```


### 3D Surfaces


```r
z <- 2 * volcano        # Exaggerate the relief
x <- 10 * (1:nrow(z))   # 10 meter spacing (S to N)
y <- 10 * (1:ncol(z))   # 10 meter spacing (E to W)
zlim <- range(z)
zlen <- zlim[2] - zlim[1] + 1
colorlut <- terrain.colors(zlen) # height color lookup table
col <- colorlut[ z - zlim[1] + 1 ] # assign colors to heights for each point
open3d()
surface3d(x, y, z, color = col, back = "lines")
```
