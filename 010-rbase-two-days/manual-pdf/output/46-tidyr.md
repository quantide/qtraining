


# Reshaping data with tidyr


```r
require(dplyr)
require(tidyr)
require(qdata)
require(ggplot2)
```


## Introduction

As a data scientist you collect data from different sources and, very often you will have very little control on the original structure of this data.

Such a variety in data structure implies long time spent at manipulating your data prior any analysis or visualization step.

On the other hand, you may think about a well defined and standard way storing your data so that data are ready to be pushed into any next step. 

This _standard_ format has been defined as __tidy__. 

At the same time, analysis of visualization procedures require to be ready to accept as input _tidy_ data structure. This is not always the case but it is becoming more and more a standard in the `R` community. 

As a simple example let's consider the `people` data frame from package `qdata`:


```r
data(people)
head(people)
```

```
## # A tibble: 6 × 4
##   Gender   Area Weight Height
##   <fctr> <fctr>  <int>  <int>
## 1 Female  Isole     54    168
## 2 Female   Nord     61    171
## 3   Male    Sud     68    170
## 4 Female   Nord     52    164
## 5   Male   Nord     75    181
## 6   Male   Nord     77    178
```

This data frame can be considered as a tidy data frame. 

As a result, plotting `Weight` as a function of `Height` with different colours for `Gender`, using package `ggplot2`, is very straightforward as `ggplot2` is a set of visualization tools ready for tidy data 


```r
ggplot(people, aes(x = Height, y = Weight, colour = Gender)) + geom_point()
```

![](46-tidyr_files/figure-latex/unnamed-chunk-2-1.pdf)<!-- --> 

A similar result, with the standard `R` plotting tools, may require first a data transformation effort:


```r
female <- people[people$Gender == 'Female',]
male <- people[people$Gender == 'Male',]
```

followed by the plotting instruction:


```r
with(people, plot(Height, Weight, type = "n"))
with(female, points(Height, Weight, col = "red"))
with(male, points(Height, Weight, col = "blue"))    
```

![](46-tidyr_files/figure-latex/unnamed-chunk-4-1.pdf)<!-- --> 


As a conclusion, as _Hadley Wickam_ writes: _Tidy datasets and tidy tools work hand in hand to make data analysis easier, allowing you to focus on the interesting domain problem, not on the uninteresting logistics of data._



## Defining Tidy Data

Tidy data is a standard way of mapping the meaning of a dataset to its structure. A dataset is messy or tidy depending on how rows, columns and tables are matched up with observations, variables and types.  

In tidy data:  

* each variable forms a column;
* each observation forms a row;
* each type of observational unit forms a table.

Tidy data makes it easy for an analyst or a computer to extract needed variables because it provides a standard way of structuring a dataset. Tidy data is particularly well suited for vectorized programming languages like `R`, because the layout ensures that values of different variables from the same observation are always paired.


## Tidying Messy Datasets

Real datasets can, and often do, violate the three precepts of tidy data in almost every way imaginable. These are the five most common problems with messy datasets:

1. column headers are values, not variable names;
1. multiple variables are stored in one column;
1. variables are stored in both rows and columns;
1. multiple types of observational units are stored in the same table;
1. a single observational unit is stored in multiple tables.



## Tools

Surprisingly, most messy datasets, including types of messiness not explicitly described above, can be tidied with a small set of tools:

* `gather()` and `spread()` 

![](images/gs.png) 

\clearpage

* `separate()` and `unite()`
 

![](images/us.png) 

\clearpage

### 1. column headers are values, not variable names

![](images/tidy-case1.png)



```r
df <- setNames(data.frame(c("EU", "US"), c(7,5), c(6,2), c(6,5)),
               c("country","0-17" , "18-65", "66+"))

df
```

```
##   country 0-17 18-65 66+
## 1      EU    7     6   6
## 2      US    5     2   5
```

This data frame can be classified as _messy_ because variables: `0-17`, `18-65`, `66+` are values of a variable, say  `age`, not column headers.

The unusual definition of column header by using function `setNames()` is due to the non standard naming convention used in this case. A syntactically valid name consists of letters, numbers and the dot or underline characters and starts with a letter or the dot not followed by a number.

The structure of `df` does not make clear:

*  what column headers refer to
*  the meaning of each observational unit

A simple instruction to tidy this data is:


```r
gather(df, key = "age", value = "freq" , 2:4)
```

```
##   country   age freq
## 1      EU  0-17    7
## 2      US  0-17    5
## 3      EU 18-65    6
## 4      US 18-65    2
## 5      EU   66+    6
## 6      US   66+    5
```

where `key` and `value` are the names for the newly created key-value pair and `2:4` are the columns to stack. Again, instead of passing the columns to stack by position it would be better to use column names but, the unusual definition of column names does not allow this.

<!--- AS same example with subx -->


```r
df <- data.frame(country = c("EU", "US"),
                age_0_17 = c(7,5), 
                age_18_65 = c(6,2), 
                age_65 = c(6,5))
                
df <- gather(df, key = "age", value = "freq" , age_0_17, age_18_65, age_65)

subx <- function(x, pattern, replacement , ...) sub(pattern, replacement, x, ...)

df %>% mutate(age = subx(age, "age_", ""))
```

```
##   country   age freq
## 1      EU  0_17    7
## 2      US  0_17    5
## 3      EU 18_65    6
## 4      US 18_65    2
## 5      EU    65    6
## 6      US    65    5
```

\clearpage
              
### 2. multiple variables are stored in one column

![](images/tidy-case2.png)


```r
df <- data.frame(
  country = c("EU", "EU", "EU", "EU", "US", "US", "US", "US"),
  gnd_cls = c("M-C", "M-A", "F-C", "F-A", "M-C", "M-A", "F-C", "F-A"),
  freq = c(7,6,6,0,5,2,5,2))

df
```

```
##   country gnd_cls freq
## 1      EU     M-C    7
## 2      EU     M-A    6
## 3      EU     F-C    6
## 4      EU     F-A    0
## 5      US     M-C    5
## 6      US     M-A    2
## 7      US     F-C    5
## 8      US     F-A    2
```

This data frame can be classified as messy because variable `gnd_cls` stores information about two variables: `gender` and `class`. 

Function `separate()`, whenever you can find a way to do it, separate the content of a column into two columns:


```r
separate(df, col = "gnd_cls", into = c("gender", "class"), sep = "-")
```

```
##   country gender class freq
## 1      EU      M     C    7
## 2      EU      M     A    6
## 3      EU      F     C    6
## 4      EU      F     A    0
## 5      US      M     C    5
## 6      US      M     A    2
## 7      US      F     C    5
## 8      US      F     A    2
```

\clearpage

### 3. variables are stored in both rows and columns;
    
![](images/tidy-case3.png)


```r
df <- data.frame(country = c("EU", "EU", "US", "US"),
                 stat = c("min", "max", "min", "max"),
                 value = c(3, 8 , 2, 9)
                 )
df
```

```
##   country stat value
## 1      EU  min     3
## 2      EU  max     8
## 3      US  min     2
## 4      US  max     9
```

This data frame is _messy_ because observational units of variable `stat` are variables by themselves.

Function `spread()` helps to structure this data in a tidy form:


```r
spread(df, key = stat, value = value)
```

```
##   country max min
## 1      EU   8   3
## 2      US   9   2
```

\clearpage

### 4. multiple types of observational units are stored in the same table
    
![](images/tidy-case4.png)


```r
df <- data.frame(
  country =  c("EU", "EU", "EU", "US", "US", "EU", "EU", "EU", "US", "US"),
  state	= c("UK", "FR", "CH", "WA",	"CA",	"UK",	"FR",	"CH",	"WA",	"CA"),
  km3 = c(244820, 643801, 41290,	184665,	403933,	244820,	643801,	41290, 184665, 403933),
  year = c(2015,	2015,	2015,	2016,	2016,	2015,	2015,	2015,	2016,	2016),
  event	= c(0, 4,	5, 6, 3, 4, 5, 3,	2, 1))

df
```

```
##    country state    km3 year event
## 1       EU    UK 244820 2015     0
## 2       EU    FR 643801 2015     4
## 3       EU    CH  41290 2015     5
## 4       US    WA 184665 2016     6
## 5       US    CA 403933 2016     3
## 6       EU    UK 244820 2015     4
## 7       EU    FR 643801 2015     5
## 8       EU    CH  41290 2015     3
## 9       US    WA 184665 2016     2
## 10      US    CA 403933 2016     1
```

This data frame stores two types of observational units in the same table. Variables `country`, `state` and `km3` refer to the first type of observational unit. The number of events: `event` per year: `year` by `state` refer to a second type of observational unit.

You can tidy this data by splitting the original data frame into two data frame: `df1` and `df2`.

You first define `df1` by selecting the distinct values of the type one columns:


```r
df1 <-  df %>% 
  select(country, state, km3) %>% 
  distinct()
df1 
```

```
##   country state    km3
## 1      EU    UK 244820
## 2      EU    FR 643801
## 3      EU    CH  41290
## 4      US    WA 184665
## 5      US    CA 403933
```

After that you define `df2` as: 


```r
df2 <- df %>%  select(state, year, event)
```

\clearpage

### 5. a single observational unit is stored in multiple tables.
    
![](images/tidy-case5.png)


```r
EU <- data.frame(state = c("UK", "FR", "CH"), km3 = c(244820, 643801, 41290))
US <- data.frame(state = c("WA", "CA"), km3 = c(184664, 403933))

EU
```

```
##   state    km3
## 1    UK 244820
## 2    FR 643801
## 3    CH  41290
```

```r
US
```

```
##   state    km3
## 1    WA 184664
## 2    CA 403933
```

This case often happens when you are loading data from different data sources.

The name of the data frame, in this case, pays a crucial role as it has to be stored into a variable:

Tidying this data requires more than one step:

First save the data frame name into a variable name:


```r
EU <- EU %>% mutate(country = "EU")
US <- US %>% mutate(country = "US")
```

the combine by rows the two data frames


```r
all <- Reduce(rbind , list(EU, US))
all
```

```
##   state    km3 country
## 1    UK 244820      EU
## 2    FR 643801      EU
## 3    CH  41290      EU
## 4    WA 184664      US
## 5    CA 403933      US
```


## Example: Phone Time

In this example about some measurements of how much time people spend on their phones, measured at two locations (work and home), at two times. Each person has been randomly assigned to either treatment or control.


```r
messy <- data.frame(
  id = 1:4,
  trt = rep(c('control', 'treatment'), each = 2),
  work.T1 = c(7, 6, 4, 3),
  home.T1 = c(5, 4, 1, 3),
  work.T2 = c(22, 27, 20, 16),
  home.T2 = c(11, 7, 10, 6)
)
messy
```

```
##   id       trt work.T1 home.T1 work.T2 home.T2
## 1  1   control       7       5      22      11
## 2  2   control       6       4      27       7
## 3  3 treatment       4       1      20      10
## 4  4 treatment       3       3      16       6
```

To tidy this data, before using `gather()` it is necessary to turn columns `work.T1`, `home.T1`, `work.T2` and `home.T2` into a key-value pair of key and time. 


```r
tidier <- gather(messy, key, time, -id, -trt)
tidier
```

```
##    id       trt     key time
## 1   1   control work.T1    7
## 2   2   control work.T1    6
## 3   3 treatment work.T1    4
## 4   4 treatment work.T1    3
## 5   1   control home.T1    5
## 6   2   control home.T1    4
## 7   3 treatment home.T1    1
## 8   4 treatment home.T1    3
## 9   1   control work.T2   22
## 10  2   control work.T2   27
## 11  3 treatment work.T2   20
## 12  4 treatment work.T2   16
## 13  1   control home.T2   11
## 14  2   control home.T2    7
## 15  3 treatment home.T2   10
## 16  4 treatment home.T2    6
```

Next `separate()` splits the key into `location` and `time`, using a regular expression to describe the character that separates them.


```r
tidy <- separate(tidier, col = key, into = c("location", "time"), sep = "\\.")
tidy
```

```
##    id       trt location time time
## 1   1   control     work   T1    7
## 2   2   control     work   T1    6
## 3   3 treatment     work   T1    4
## 4   4 treatment     work   T1    3
## 5   1   control     home   T1    5
## 6   2   control     home   T1    4
## 7   3 treatment     home   T1    1
## 8   4 treatment     home   T1    3
## 9   1   control     work   T2   22
## 10  2   control     work   T2   27
## 11  3 treatment     work   T2   20
## 12  4 treatment     work   T2   16
## 13  1   control     home   T2   11
## 14  2   control     home   T2    7
## 15  3 treatment     home   T2   10
## 16  4 treatment     home   T2    6
```


## Example: Stock Market data

Supposing you have the following packages, load them into `R`:


```r
require(quantmod)
require(lubridate)
```

Then, download these data from Google Finance:


```r
invisible(Sys.setlocale("LC_MESSAGES", "C"))
invisible(Sys.setlocale("LC_TIME", "C"))
getSymbols.google(Symbols = "IBM",
                  env = globalenv(),
                  return.class = 'data.frame',
                  from = "2015-01-01",
                  to = Sys.Date())
```

```
## [1] "IBM"
```

```r
head(IBM)
```

```
##            IBM.Open IBM.High IBM.Low IBM.Close IBM.Volume
## 2015-01-02   161.31   163.31  161.00    162.06    5525466
## 2015-01-05   161.27   161.27  159.19    159.51    4880389
## 2015-01-06   159.67   159.96  155.17    156.07    6146712
## 2015-01-07   157.20   157.20  154.03    155.05    4701839
## 2015-01-08   156.24   159.04  155.55    158.42    4241113
## 2015-01-09   158.42   160.34  157.25    159.11    4488347
```

In the following code chunks you will find also some `dplyr` functions. To better understand them, see the next chapters of the course, in particular the `dplyr` parts about `mutate()` and `summarise()`.  

Manipulate data from wide to long:


```r
df  <- IBM  %>% 
  transmute(time = ymd(row.names(.)), open = IBM.Open, high = IBM.High, low = IBM.Low, 
            close = IBM.Close) %>%
  gather(key = hloc, value = price, -time) %>%
  mutate(hloc = factor(hloc)) %>%
  tbl_df()
head(df)
```

```
## # A tibble: 6 × 3
##         time   hloc  price
##       <date> <fctr>  <dbl>
## 1 2015-01-02   open 161.31
## 2 2015-01-05   open 161.27
## 3 2015-01-06   open 159.67
## 4 2015-01-07   open 157.20
## 5 2015-01-08   open 156.24
## 6 2015-01-09   open 158.42
```

Plot data with ggplot:


```r
ggplot(data = df, aes(x = time, y = price, colour = hloc)) + geom_line() 
```

![](46-tidyr_files/figure-latex/unnamed-chunk-24-1.pdf)<!-- --> 

Compute returns:


```r
df <- df %>% group_by(hloc) %>% mutate(returns = (price - lag(price))/lag(price))
head(df)
```

```
## Source: local data frame [6 x 4]
## Groups: hloc [1]
## 
##         time   hloc  price       returns
##       <date> <fctr>  <dbl>         <dbl>
## 1 2015-01-02   open 161.31            NA
## 2 2015-01-05   open 161.27 -0.0002479697
## 3 2015-01-06   open 159.67 -0.0099212501
## 4 2015-01-07   open 157.20 -0.0154694056
## 5 2015-01-08   open 156.24 -0.0061068702
## 6 2015-01-09   open 158.42  0.0139528930
```

And summarise them:


```r
df %>%
  group_by(hloc) %>%
  summarise(n = n(), avg = mean(returns, na.rm = TRUE), sd = sd(returns, na.rm = TRUE))
```

```
## # A tibble: 4 × 4
##     hloc     n          avg         sd
##   <fctr> <int>        <dbl>      <dbl>
## 1  close   509 0.0001504396 0.01291350
## 2   high   509 0.0001410029 0.01133475
## 3    low   509 0.0001568441 0.01240202
## 4   open   509 0.0001752224 0.01244935
```

