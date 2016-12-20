
# Data Discovery with R





\includegraphics[width=3.33in]{images/flow-dtman} 

`dplyr` provides also the tools for discovering your data. We are talking about `summarise()` verb, which collapse many values into a summary and about other best practices that allows us to combine together multiple operations. 


```r
require(dplyr)
```

In the following examples, we will refer to `bank` data set. 


```r
require(qdata)
data(bank)
bank
```

```
## # A tibble: 45,211 × 20
##       id   age          job  marital education default balance housing
##    <int> <int>       <fctr>   <fctr>    <fctr>  <fctr>   <int>  <fctr>
## 1      1    58   management  married  tertiary      no    2143     yes
## 2      2    44   technician   single secondary      no      29     yes
## 3      3    33 entrepreneur  married secondary      no       2     yes
## 4      4    47  blue-collar  married   unknown      no    1506     yes
## 5      5    33      unknown   single   unknown      no       1      no
## 6      6    35   management  married  tertiary      no     231     yes
## 7      7    28   management   single  tertiary      no     447     yes
## 8      8    42 entrepreneur divorced  tertiary     yes       2     yes
## 9      9    58      retired  married   primary      no     121     yes
## 10    10    43   technician   single secondary      no     593     yes
## # ... with 45,201 more rows, and 12 more variables: loan <fctr>,
## #   contact <fctr>, day <int>, month <fctr>, year <int>, date <dttm>,
## #   duration <int>, campaign <int>, pdays <int>, previous <int>,
## #   poutcome <fctr>, y <fctr>
```


## Descriptive statistics with `summarise()` and `group_by()`

`summarise()` collapses a data frame to a single row and allows us to compute descriptive statistics.
Let us see some examples:


```r
# Compute the mean of balance of the accounts
summarise(bank, mean_balance = mean(balance, na.rm = TRUE))
```

```
## # A tibble: 1 × 1
##   mean_balance
##          <dbl>
## 1     1362.272
```

```r
# Compute the sum of balance of the accounts
bank %>% summarise(max_balance = sum(balance, na.rm = TRUE))
```

```
## # A tibble: 1 × 1
##   max_balance
##         <int>
## 1    61589682
```

```r
# Compute the minimum and the maximum balance of the accounts
bank %>% summarise(max_balance = max(balance, na.rm = TRUE), min_balance = min(balance, na.rm = TRUE))
```

```
## # A tibble: 1 × 2
##   max_balance min_balance
##         <int>       <int>
## 1      102127       -8019
```

```r
# Compute the summary (number of obs, minimum, first quartile, median, mean, third quartile, 
# maximum and standard deviation) of balance of the accounts  
bank %>% summarise(n_obs = n(),
              min=min(balance, na.rm = TRUE),
              first_q=quantile(balance, prob = 0.25, na.rm = TRUE),
              median=median(balance, na.rm = TRUE),
              mean=mean(balance, na.rm =TRUE),
              third_q=quantile(balance, prob = 0.75, na.rm = TRUE),
              max=max(balance, na.rm = TRUE),
              sd=sd(balance, na.rm =TRUE))
```

```
## # A tibble: 1 × 8
##   n_obs   min first_q median     mean third_q    max       sd
##   <int> <int>   <dbl>  <int>    <dbl>   <dbl>  <int>    <dbl>
## 1 45211 -8019      72    448 1362.272    1428 102127 3044.766
```

Descriptive statistics can be computed also by groups, by using `group_by()`, which is a `dplyr` function that allows us to group observations according to the levels of a variable/s.


```r
# Compute the mean of balance of the accounts by job
bank %>% 
  group_by(job) %>%
  summarise(mean_balance = mean(balance, na.rm = TRUE))
```

```
## # A tibble: 12 × 2
##              job mean_balance
##           <fctr>        <dbl>
## 1         admin.    1135.8389
## 2    blue-collar    1078.8267
## 3   entrepreneur    1521.4701
## 4      housemaid    1392.3952
## 5     management    1763.6168
## 6        retired    1984.2151
## 7  self-employed    1647.9709
## 8       services     997.0881
## 9        student    1388.0608
## 10    technician    1252.6321
## 11    unemployed    1521.7460
## 12       unknown    1772.3576
```

```r
# Compute the summary (number of obs, minimum, first quartile, median, mean, third quantile, 
# maximum and standard deviation) of balance of the accounts by job 
bank %>% 
  group_by(job) %>%
  summarise(n_obs = n(),
            min=min(balance, na.rm = TRUE),
            first_q=quantile(balance, prob = 0.25, na.rm = TRUE),
            median=median(balance, na.rm = TRUE),
            mean=mean(balance, na.rm =TRUE),
            third_q=quantile(balance, prob = 0.75, na.rm = TRUE),
            max=max(balance, na.rm = TRUE),
            sd=sd(balance, na.rm =TRUE))
```

```
## # A tibble: 12 × 9
##              job n_obs   min first_q median      mean third_q    max
##           <fctr> <int> <int>   <dbl>  <dbl>     <dbl>   <dbl>  <int>
## 1         admin.  5171 -1601   63.00  396.0 1135.8389 1203.00  64343
## 2    blue-collar  9732 -8019   55.00  388.0 1078.8267 1203.00  66653
## 3   entrepreneur  1487 -2082   44.50  352.0 1521.4701 1341.00  59649
## 4      housemaid  1240 -1941   57.75  406.0 1392.3952 1382.75  45141
## 5     management  9458 -6847   98.00  572.0 1763.6168 1825.00 102127
## 6        retired  2264 -1598  164.50  787.0 1984.2151 2309.00  81204
## 7  self-employed  1579 -3313  120.00  526.0 1647.9709 1603.50  52587
## 8       services  4154 -2122   35.00  339.5  997.0881 1071.75  57435
## 9        student   938  -679  148.25  502.0 1388.0608 1579.75  24025
## 10    technician  7597 -2827   61.00  421.0 1252.6321 1327.00  45248
## 11    unemployed  1303 -1270   94.00  529.0 1521.7460 1603.50  44134
## 12       unknown   288  -295  170.75  677.0 1772.3576 2165.50  19706
## # ... with 1 more variables: sd <dbl>
```


## Multiple operations

You can also chain together multiple operations to achieve a complex result.
Let us have a look!


```r
# Compute the mean of balance of the accounts and the number of obs by job for people not older than 40 years and 
# sort the result in ascending order  
bank %>%
  filter(age < 40) %>%
  group_by(job) %>%
  summarise(n_obs =n(),
            mean_balance = mean(balance, na.rm = TRUE)) %>%
  arrange(mean_balance)
```

```
## # A tibble: 12 × 3
##              job n_obs mean_balance
##           <fctr> <int>        <dbl>
## 1        retired    25     445.8800
## 2       services  2419     827.6701
## 3         admin.  2924     936.2401
## 4    blue-collar  5064     951.9682
## 5   entrepreneur   647    1153.1453
## 6     technician  4376    1198.5599
## 7      housemaid   363    1346.0992
## 8     unemployed   631    1355.1886
## 9  self-employed   820    1379.8793
## 10       student   924    1385.0801
## 11    management  5101    1548.9508
## 12       unknown    68    1777.5882
```



