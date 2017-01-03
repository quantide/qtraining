


# Introduction to dplyr


\includegraphics[width=2.94in]{images/flow-dtman} 


This chapter provides an overview of data management with `R` through the `dplyr`, `tidyr` and `lubridate` packages.

The `dplyr` package for `R` is very powerful for data management since:

* it simplifies how you can think about common data manipulation tasks;
* it provides simple "verbs", functions that correspond to the most common data manipulation tasks;
* it uses efficient data storage backends, so you spend less time waiting for the computer.


```r
require(dplyr)
```

`tidyr` is a modern `R` package which provides a standard way to organise data values within a dataset. 


```r
require(tidyr)
```

`lubridate` is an R packages that deals with dates and times in an intuitive and coherent way.


```r
require(lubridate)
```

In the following chapters, we will explore the innovations introduced by `dplyr`, `tidyr` and `lubridate` to make our lifes easier when dealing with dataframes manipulation tasks.     
In particular:

* pipe operator (`%>%`) 
* `tbl_df` data frame class
* `dplyr` verbs for data manipulation 
* `dplyr` verbs for combining data
* `dplyr` with backend databases
* reshaping data with `tidyr`
* managing dates with `lubridate`

In the following two paragraphs we will explore two important `dplyr` innovations: pipe operator (`%>%`) and `tbl_df` data frame class

<!--
aggiungere qualcosa a questa frase: dire magari che sono le innovazioni base
-->


## Pipe operator  

`dplyr` pipe operator (`%>%`) allows us to pipe the output from one function to the input of another function. The idea of piping is to read the functions from left to right. It is particularly useful with nested functions (reading from the inside to the outside) or with multiple operations.

![<small>Source: www.datacamp.com</small>](./images/pipe.png)

Pipes can work with nearly any functions (`dplyr` and not-`dplyr` functions), let us see an example.

Let us consider `bank` data set, included in `qdata` package, which contains information about a direct marketing campaigns of a Portuguese banking institution based on phone calls. 


```r
require(qdata)
```

```
## Loading required package: qdata
```

```r
data(bank) 
```

Suppose we want to visualize the first rows of `bank` dataframe, by using `head()` function.   

Usually we write:


```r
head(bank)
```

```
## # A tibble: 6 × 20
##      id   age          job marital education default balance housing   loan contact   day  month  year
##   <int> <int>       <fctr>  <fctr>    <fctr>  <fctr>   <int>  <fctr> <fctr>  <fctr> <int> <fctr> <int>
## 1     1    58   management married  tertiary      no    2143     yes     no unknown     5    may  2008
## 2     2    44   technician  single secondary      no      29     yes     no unknown     5    may  2008
## 3     3    33 entrepreneur married secondary      no       2     yes    yes unknown     5    may  2008
## 4     4    47  blue-collar married   unknown      no    1506     yes     no unknown     5    may  2008
## 5     5    33      unknown  single   unknown      no       1      no     no unknown     5    may  2008
## 6     6    35   management married  tertiary      no     231     yes     no unknown     5    may  2008
## # ... with 7 more variables: date <dttm>, duration <int>, campaign <int>, pdays <int>, previous <int>,
## #   poutcome <fctr>, y <fctr>
```

By using `%>%`, the code becomes:


```r
bank %>% head()
```

```
## # A tibble: 6 × 20
##      id   age          job marital education default balance housing   loan contact   day  month  year
##   <int> <int>       <fctr>  <fctr>    <fctr>  <fctr>   <int>  <fctr> <fctr>  <fctr> <int> <fctr> <int>
## 1     1    58   management married  tertiary      no    2143     yes     no unknown     5    may  2008
## 2     2    44   technician  single secondary      no      29     yes     no unknown     5    may  2008
## 3     3    33 entrepreneur married secondary      no       2     yes    yes unknown     5    may  2008
## 4     4    47  blue-collar married   unknown      no    1506     yes     no unknown     5    may  2008
## 5     5    33      unknown  single   unknown      no       1      no     no unknown     5    may  2008
## 6     6    35   management married  tertiary      no     231     yes     no unknown     5    may  2008
## # ... with 7 more variables: date <dttm>, duration <int>, campaign <int>, pdays <int>, previous <int>,
## #   poutcome <fctr>, y <fctr>
```

Pipe takes the argument on the left (`bank`) and passes it to the function on the right (`head()`). So you don't need to write the first argument of the function. 

Other arguments of the function must be added to the function itself, as usually done. By default `head()` prints the first 6 rows of the dataframe. Suppose we want to print 10 rows, by setting `n` argument to 10:


```r
bank %>% head(n=10)
```

```
## # A tibble: 10 × 20
##       id   age          job  marital education default balance housing   loan contact   day  month  year
##    <int> <int>       <fctr>   <fctr>    <fctr>  <fctr>   <int>  <fctr> <fctr>  <fctr> <int> <fctr> <int>
## 1      1    58   management  married  tertiary      no    2143     yes     no unknown     5    may  2008
## 2      2    44   technician   single secondary      no      29     yes     no unknown     5    may  2008
## 3      3    33 entrepreneur  married secondary      no       2     yes    yes unknown     5    may  2008
## 4      4    47  blue-collar  married   unknown      no    1506     yes     no unknown     5    may  2008
## 5      5    33      unknown   single   unknown      no       1      no     no unknown     5    may  2008
## 6      6    35   management  married  tertiary      no     231     yes     no unknown     5    may  2008
## 7      7    28   management   single  tertiary      no     447     yes    yes unknown     5    may  2008
## 8      8    42 entrepreneur divorced  tertiary     yes       2     yes     no unknown     5    may  2008
## 9      9    58      retired  married   primary      no     121     yes     no unknown     5    may  2008
## 10    10    43   technician   single secondary      no     593     yes     no unknown     5    may  2008
## # ... with 7 more variables: date <dttm>, duration <int>, campaign <int>, pdays <int>, previous <int>,
## #   poutcome <fctr>, y <fctr>
```


### `tbl_df`: the `dplyr` Data Frame Class

Sometimes data frames have large dimensions. `dplyr` package provide `tbl_df`, which is a wrapper around a data frame that will not accidentally print a lot of data to the screen; indeed tbl objects only print a few rows and all the columns that fit on one screen, describing the rest of it as text.

When the class of data object is not tbl, `tbl_df()` function should be used.  
Let us consider `mtcars`, a dataset included in `datasets` package (automatically loaded at the start of an R session): 


```r
# Example of data frame
class(mtcars)
```

```
## [1] "data.frame"
```

```r
# If we do not convert it as a tbl_df, all mtcars rows and columns will be printed when calling mtcars 
dim(mtcars)
```

```
## [1] 32 11
```

```r
mtcars
```

```
##                      mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4           21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag       21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710          22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive      21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout   18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
## Valiant             18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
## Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
## Merc 240D           24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
## Merc 230            22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
## Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
## Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
## Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
## Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
## Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
## Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
## Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
## Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
## Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
## Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
## Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
## Toyota Corona       21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
## Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
## AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
## Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
## Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
## Fiat X1-9           27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
## Porsche 914-2       26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
## Lotus Europa        30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
## Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
## Ferrari Dino        19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
## Maserati Bora       15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
## Volvo 142E          21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
```

```r
# dplyr version of the same data frame (tbl_df conversion)
mtcars_tbl <- tbl_df(mtcars)
class(mtcars_tbl)
```

```
## [1] "tbl_df"     "tbl"        "data.frame"
```

```r
mtcars_tbl
```

```
## # A tibble: 32 × 11
##      mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
## *  <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
## 1   21.0     6 160.0   110  3.90 2.620 16.46     0     1     4     4
## 2   21.0     6 160.0   110  3.90 2.875 17.02     0     1     4     4
## 3   22.8     4 108.0    93  3.85 2.320 18.61     1     1     4     1
## 4   21.4     6 258.0   110  3.08 3.215 19.44     1     0     3     1
## 5   18.7     8 360.0   175  3.15 3.440 17.02     0     0     3     2
## 6   18.1     6 225.0   105  2.76 3.460 20.22     1     0     3     1
## 7   14.3     8 360.0   245  3.21 3.570 15.84     0     0     3     4
## 8   24.4     4 146.7    62  3.69 3.190 20.00     1     0     4     2
## 9   22.8     4 140.8    95  3.92 3.150 22.90     1     0     4     2
## 10  19.2     6 167.6   123  3.92 3.440 18.30     1     0     4     4
## # ... with 22 more rows
```

<!--
cambiare mtcars -> rivedere perchè non va
-->

## Verb Functions


```r
require(dplyr)
require(qdata)
```

`dplyr` aims to provide a function for each basic verb of data manipulating.

All these functions are very similar:

* the first argument is a data frame;
* the subsequent arguments describe what to do with it, and you can refer to columns in the data frame directly without using $. Note that the column names must be unquoted;
* the result is a new data frame.

Together these properties make it easy to chain together multiple simple steps to achieve a complex result.

These five functions provide the basis of a language of data manipulation. At the most basic level, you can only alter a tidy data frame in five useful ways: 

1. select variables of interest: `select()`;
2. filter records of interest: `filter()`;
3. reorder the rows: `arrange()`;
4. add new variables that are functions of existing variables: `mutate()`;
5. collapse many values to a summary: `summarise()`. 


In the following examples we will refer to `bank` data set which contains information about a direct marketing campaigns of a Portuguese banking institution based on phone calls. 


```r
data(bank) 
```

### `select()`

Often you work with large datasets with many columns where only a few are actually of interest to you. 

`select()` allows you to rapidly zoom in on a useful subset of columns.  


![](images/sel.png) 

The first argument is the name of the data frame, and the second and subsequent are the name of column/s of that data frame you want to select:


```r
# Select columns: year, month and day of bank data frame
select(bank, year, month, day)
```

```
## # A tibble: 45,211 × 3
##     year  month   day
##    <int> <fctr> <int>
## 1   2008    may     5
## 2   2008    may     5
## 3   2008    may     5
## 4   2008    may     5
## 5   2008    may     5
## 6   2008    may     5
## 7   2008    may     5
## 8   2008    may     5
## 9   2008    may     5
## 10  2008    may     5
## # ... with 45,201 more rows
```

```r
# Select columns: year, month and day of bank data frame
bank %>% select(year:day)
```

```
## # A tibble: 45,211 × 3
##     year  month   day
##    <int> <fctr> <int>
## 1   2008    may     5
## 2   2008    may     5
## 3   2008    may     5
## 4   2008    may     5
## 5   2008    may     5
## 6   2008    may     5
## 7   2008    may     5
## 8   2008    may     5
## 9   2008    may     5
## 10  2008    may     5
## # ... with 45,201 more rows
```

```r
# Select all columns of bank data frame apart from: year, month and day
bank %>% select(-(year:day))
```

```
## # A tibble: 45,211 × 17
##       id   age          job  marital education default balance housing   loan contact       date duration
##    <int> <int>       <fctr>   <fctr>    <fctr>  <fctr>   <int>  <fctr> <fctr>  <fctr>     <dttm>    <int>
## 1      1    58   management  married  tertiary      no    2143     yes     no unknown 2008-05-05      261
## 2      2    44   technician   single secondary      no      29     yes     no unknown 2008-05-05      151
## 3      3    33 entrepreneur  married secondary      no       2     yes    yes unknown 2008-05-05       76
## 4      4    47  blue-collar  married   unknown      no    1506     yes     no unknown 2008-05-05       92
## 5      5    33      unknown   single   unknown      no       1      no     no unknown 2008-05-05      198
## 6      6    35   management  married  tertiary      no     231     yes     no unknown 2008-05-05      139
## 7      7    28   management   single  tertiary      no     447     yes    yes unknown 2008-05-05      217
## 8      8    42 entrepreneur divorced  tertiary     yes       2     yes     no unknown 2008-05-05      380
## 9      9    58      retired  married   primary      no     121     yes     no unknown 2008-05-05       50
## 10    10    43   technician   single secondary      no     593     yes     no unknown 2008-05-05       55
## # ... with 45,201 more rows, and 5 more variables: campaign <int>, pdays <int>, previous <int>,
## #   poutcome <fctr>, y <fctr>
```


You can rename variables with `select()` by using named arguments:


```r
# Rename id variable as ID
bank %>% select(ID = id)
```

```
## # A tibble: 45,211 × 1
##       ID
##    <int>
## 1      1
## 2      2
## 3      3
## 4      4
## 5      5
## 6      6
## 7      7
## 8      8
## 9      9
## 10    10
## # ... with 45,201 more rows
```

\clearpage

### `filter()`

`filter()` allows you to select a subset of the rows of a data frame.

![](images/fil.png) 

The first argument is the name of the data frame, and the second and subsequent are filtering expressions evaluated in the context of that data frame.

For example, you can select all calls made to students whit balance above 20,000:



```r
filter(bank, job == "student", balance > 20000)
```

```
## # A tibble: 3 × 20
##      id   age     job marital education default balance housing   loan  contact   day  month  year
##   <int> <int>  <fctr>  <fctr>    <fctr>  <fctr>   <int>  <fctr> <fctr>   <fctr> <int> <fctr> <int>
## 1 31125    24 student  single secondary      no   23878      no     no cellular    18    feb  2009
## 2 39536    24 student  single secondary      no   23878      no     no cellular    26    may  2009
## 3 41923    27 student  single  tertiary      no   24025      no     no cellular    21    oct  2009
## # ... with 7 more variables: date <dttm>, duration <int>, campaign <int>, pdays <int>, previous <int>,
## #   poutcome <fctr>, y <fctr>
```


`filter()` allows you to give it any number of filtering conditions which are joined together with `&` and/or the other operators.  


```r
# Select all calls made to student of 18 years 
bank %>% filter(age == 18 & job == "student")
```

```
## # A tibble: 12 × 20
##       id   age     job marital education default balance housing   loan   contact   day  month  year
##    <int> <int>  <fctr>  <fctr>    <fctr>  <fctr>   <int>  <fctr> <fctr>    <fctr> <int> <fctr> <int>
## 1  40737    18 student  single   primary      no    1944      no     no telephone    10    aug  2009
## 2  40745    18 student  single   unknown      no     108      no     no  cellular    10    aug  2009
## 3  40888    18 student  single   primary      no     608      no     no  cellular    12    aug  2009
## 4  41223    18 student  single   unknown      no      35      no     no telephone    21    aug  2009
## 5  41253    18 student  single secondary      no       5      no     no  cellular    24    aug  2009
## 6  41274    18 student  single   unknown      no       3      no     no  cellular    25    aug  2009
## 7  41488    18 student  single   unknown      no     108      no     no  cellular     8    sep  2009
## 8  42147    18 student  single secondary      no     156      no     no  cellular     4    nov  2009
## 9  42275    18 student  single   primary      no     608      no     no  cellular    13    nov  2009
## 10 42955    18 student  single   unknown      no     108      no     no  cellular     9    feb  2010
## 11 43638    18 student  single   unknown      no     348      no     no  cellular     5    may  2010
## 12 44645    18 student  single   unknown      no     438      no     no  cellular     1    sep  2010
## # ... with 7 more variables: date <dttm>, duration <int>, campaign <int>, pdays <int>, previous <int>,
## #   poutcome <fctr>, y <fctr>
```


```r
# Select all calls made to people of 18 or 95 years
bank %>% filter(age == 18 | age == 95)
```

```
## # A tibble: 14 × 20
##       id   age     job  marital education default balance housing   loan   contact   day  month  year
##    <int> <int>  <fctr>   <fctr>    <fctr>  <fctr>   <int>  <fctr> <fctr>    <fctr> <int> <fctr> <int>
## 1  33700    95 retired divorced   primary      no    2282      no     no telephone    21    apr  2009
## 2  40737    18 student   single   primary      no    1944      no     no telephone    10    aug  2009
## 3  40745    18 student   single   unknown      no     108      no     no  cellular    10    aug  2009
## 4  40888    18 student   single   primary      no     608      no     no  cellular    12    aug  2009
## 5  41223    18 student   single   unknown      no      35      no     no telephone    21    aug  2009
## 6  41253    18 student   single secondary      no       5      no     no  cellular    24    aug  2009
## 7  41274    18 student   single   unknown      no       3      no     no  cellular    25    aug  2009
## 8  41488    18 student   single   unknown      no     108      no     no  cellular     8    sep  2009
## 9  41664    95 retired  married secondary      no       0      no     no telephone     1    oct  2009
## 10 42147    18 student   single secondary      no     156      no     no  cellular     4    nov  2009
## 11 42275    18 student   single   primary      no     608      no     no  cellular    13    nov  2009
## 12 42955    18 student   single   unknown      no     108      no     no  cellular     9    feb  2010
## 13 43638    18 student   single   unknown      no     348      no     no  cellular     5    may  2010
## 14 44645    18 student   single   unknown      no     438      no     no  cellular     1    sep  2010
## # ... with 7 more variables: date <dttm>, duration <int>, campaign <int>, pdays <int>, previous <int>,
## #   poutcome <fctr>, y <fctr>
```

`filter()` can be used also with `%in%` to establish conditions under which filter: 


```r
# Select all calls made to people of 18 or 95 years
bank %>% filter(age %in% c(18,95))
```

```
## # A tibble: 14 × 20
##       id   age     job  marital education default balance housing   loan   contact   day  month  year
##    <int> <int>  <fctr>   <fctr>    <fctr>  <fctr>   <int>  <fctr> <fctr>    <fctr> <int> <fctr> <int>
## 1  33700    95 retired divorced   primary      no    2282      no     no telephone    21    apr  2009
## 2  40737    18 student   single   primary      no    1944      no     no telephone    10    aug  2009
## 3  40745    18 student   single   unknown      no     108      no     no  cellular    10    aug  2009
## 4  40888    18 student   single   primary      no     608      no     no  cellular    12    aug  2009
## 5  41223    18 student   single   unknown      no      35      no     no telephone    21    aug  2009
## 6  41253    18 student   single secondary      no       5      no     no  cellular    24    aug  2009
## 7  41274    18 student   single   unknown      no       3      no     no  cellular    25    aug  2009
## 8  41488    18 student   single   unknown      no     108      no     no  cellular     8    sep  2009
## 9  41664    95 retired  married secondary      no       0      no     no telephone     1    oct  2009
## 10 42147    18 student   single secondary      no     156      no     no  cellular     4    nov  2009
## 11 42275    18 student   single   primary      no     608      no     no  cellular    13    nov  2009
## 12 42955    18 student   single   unknown      no     108      no     no  cellular     9    feb  2010
## 13 43638    18 student   single   unknown      no     348      no     no  cellular     5    may  2010
## 14 44645    18 student   single   unknown      no     438      no     no  cellular     1    sep  2010
## # ... with 7 more variables: date <dttm>, duration <int>, campaign <int>, pdays <int>, previous <int>,
## #   poutcome <fctr>, y <fctr>
```

An other example is:


```r
# Select all calls made to people whose job is admin. or technician 
bank %>% filter(job %in% c("admin.","technician"))
```

```
## # A tibble: 12,768 × 20
##       id   age        job  marital education default balance housing   loan contact   day  month  year
##    <int> <int>     <fctr>   <fctr>    <fctr>  <fctr>   <int>  <fctr> <fctr>  <fctr> <int> <fctr> <int>
## 1      2    44 technician   single secondary      no      29     yes     no unknown     5    may  2008
## 2     10    43 technician   single secondary      no     593     yes     no unknown     5    may  2008
## 3     11    41     admin. divorced secondary      no     270     yes     no unknown     5    may  2008
## 4     12    29     admin.   single secondary      no     390     yes     no unknown     5    may  2008
## 5     13    53 technician  married secondary      no       6     yes     no unknown     5    may  2008
## 6     14    58 technician  married   unknown      no      71     yes     no unknown     5    may  2008
## 7     17    45     admin.   single   unknown      no      13     yes     no unknown     5    may  2008
## 8     26    44     admin.  married secondary      no    -372     yes     no unknown     5    may  2008
## 9     30    36 technician   single secondary      no     265     yes    yes unknown     5    may  2008
## 10    31    57 technician  married secondary      no     839      no    yes unknown     5    may  2008
## # ... with 12,758 more rows, and 7 more variables: date <dttm>, duration <int>, campaign <int>,
## #   pdays <int>, previous <int>, poutcome <fctr>, y <fctr>
```

```r
# Select all calls made to people whose job is admin. or technician 
bank %>% filter(job == "admin." | job == "technician")
```

```
## # A tibble: 12,768 × 20
##       id   age        job  marital education default balance housing   loan contact   day  month  year
##    <int> <int>     <fctr>   <fctr>    <fctr>  <fctr>   <int>  <fctr> <fctr>  <fctr> <int> <fctr> <int>
## 1      2    44 technician   single secondary      no      29     yes     no unknown     5    may  2008
## 2     10    43 technician   single secondary      no     593     yes     no unknown     5    may  2008
## 3     11    41     admin. divorced secondary      no     270     yes     no unknown     5    may  2008
## 4     12    29     admin.   single secondary      no     390     yes     no unknown     5    may  2008
## 5     13    53 technician  married secondary      no       6     yes     no unknown     5    may  2008
## 6     14    58 technician  married   unknown      no      71     yes     no unknown     5    may  2008
## 7     17    45     admin.   single   unknown      no      13     yes     no unknown     5    may  2008
## 8     26    44     admin.  married secondary      no    -372     yes     no unknown     5    may  2008
## 9     30    36 technician   single secondary      no     265     yes    yes unknown     5    may  2008
## 10    31    57 technician  married secondary      no     839      no    yes unknown     5    may  2008
## # ... with 12,758 more rows, and 7 more variables: date <dttm>, duration <int>, campaign <int>,
## #   pdays <int>, previous <int>, poutcome <fctr>, y <fctr>
```

\clearpage

### `arrange()`

Function `arrange()` reorders a data frame by one or more variables. If you provide more than one column name, each additional column will be used to break ties in the values of preceding columns:

![](images/arr.png)

The first argument is the name of the data frame, and the second and subsequent are the name of columns of that data frame you want to order by.  
You may want to order the `bank` data frame by the balance of the account in ascending order:


```r
arrange(bank, balance)
```

```
## # A tibble: 45,211 × 20
##       id   age           job  marital education default balance housing   loan  contact   day  month  year
##    <int> <int>        <fctr>   <fctr>    <fctr>  <fctr>   <int>  <fctr> <fctr>   <fctr> <int> <fctr> <int>
## 1  12910    26   blue-collar   single secondary     yes   -8019      no    yes cellular     7    jul  2008
## 2  15683    49    management  married  tertiary     yes   -6847      no    yes cellular    21    jul  2008
## 3  38737    60    management divorced  tertiary      no   -4057     yes     no cellular    18    may  2009
## 4   7414    43    management  married  tertiary     yes   -3372     yes     no  unknown    29    may  2008
## 5   1897    57 self-employed  married  tertiary     yes   -3313     yes    yes  unknown     9    may  2008
## 6  32714    39 self-employed  married  tertiary      no   -3058     yes    yes cellular    17    apr  2009
## 7  18574    40    technician  married  tertiary     yes   -2827     yes    yes cellular    31    jul  2008
## 8  31510    52    management  married  tertiary      no   -2712     yes    yes cellular     2    apr  2009
## 9  25120    49   blue-collar   single   primary     yes   -2604     yes     no cellular    18    nov  2008
## 10 14435    51    management divorced  tertiary      no   -2282     yes    yes cellular    14    jul  2008
## # ... with 45,201 more rows, and 7 more variables: date <dttm>, duration <int>, campaign <int>,
## #   pdays <int>, previous <int>, poutcome <fctr>, y <fctr>
```

or in descending order by using function `desc()` within `arrange()`: 


```r
bank %>% arrange(desc(balance))
```

```
## # A tibble: 45,211 × 20
##       id   age          job  marital education default balance housing   loan   contact   day  month  year
##    <int> <int>       <fctr>   <fctr>    <fctr>  <fctr>   <int>  <fctr> <fctr>    <fctr> <int> <fctr> <int>
## 1  39990    51   management   single  tertiary      no  102127      no     no  cellular     3    jun  2009
## 2  26228    59   management  married  tertiary      no   98417      no     no telephone    20    nov  2008
## 3  42559    84      retired  married secondary      no   81204      no     no telephone    28    dec  2009
## 4  43394    84      retired  married secondary      no   81204      no     no telephone     1    apr  2010
## 5  41694    60      retired  married   primary      no   71188      no     no  cellular     6    oct  2009
## 6  19786    56   management divorced  tertiary      no   66721      no     no  cellular     8    aug  2008
## 7  21193    52  blue-collar  married   primary      no   66653      no     no  cellular    14    aug  2008
## 8  19421    59       admin.  married   unknown      no   64343      no     no  cellular     6    aug  2008
## 9  41375    32 entrepreneur   single  tertiary      no   59649      no     no  cellular     1    sep  2009
## 10 12927    56  blue-collar  married secondary      no   58932      no     no telephone     7    jul  2008
## # ... with 45,201 more rows, and 7 more variables: date <dttm>, duration <int>, campaign <int>,
## #   pdays <int>, previous <int>, poutcome <fctr>, y <fctr>
```

You can order a data frame by one or more than one variables.

Ordering data frame bank by `age` first and descending `balance` afterward requires:



```r
bank %>% arrange(age, desc(balance))
```

```
## # A tibble: 45,211 × 20
##       id   age     job marital education default balance housing   loan   contact   day  month  year
##    <int> <int>  <fctr>  <fctr>    <fctr>  <fctr>   <int>  <fctr> <fctr>    <fctr> <int> <fctr> <int>
## 1  40737    18 student  single   primary      no    1944      no     no telephone    10    aug  2009
## 2  40888    18 student  single   primary      no     608      no     no  cellular    12    aug  2009
## 3  42275    18 student  single   primary      no     608      no     no  cellular    13    nov  2009
## 4  44645    18 student  single   unknown      no     438      no     no  cellular     1    sep  2010
## 5  43638    18 student  single   unknown      no     348      no     no  cellular     5    may  2010
## 6  42147    18 student  single secondary      no     156      no     no  cellular     4    nov  2009
## 7  40745    18 student  single   unknown      no     108      no     no  cellular    10    aug  2009
## 8  41488    18 student  single   unknown      no     108      no     no  cellular     8    sep  2009
## 9  42955    18 student  single   unknown      no     108      no     no  cellular     9    feb  2010
## 10 41223    18 student  single   unknown      no      35      no     no telephone    21    aug  2009
## # ... with 45,201 more rows, and 7 more variables: date <dttm>, duration <int>, campaign <int>,
## #   pdays <int>, previous <int>, poutcome <fctr>, y <fctr>
```

\clearpage

### `mutate()`

As well as selecting from the set of existing columns, it’s often useful to add new columns that are functions of existing columns. This is the job of `mutate()`:

![](images/mut.png) 


The first argument is the name of the data frame, and the second and subsequent are expressions for creating new columns to add to that data frame or for modifying the existing ones: 



```r
df <- data.frame(x = 1:3, y = 3:1)

mutate(df, x1 = x+1)
```

```
##   x y x1
## 1 1 3  2
## 2 2 2  3
## 3 3 1  4
```

```r
mutate(df, x = x+1)
```

```
##   x y
## 1 2 3
## 2 3 2
## 3 4 1
```

```r
mutate(df, x = x+1, y = x+1)
```

```
##   x y
## 1 2 3
## 2 3 4
## 3 4 5
```

```r
mutate(df, x1 = x+1, y1 = x1+1)
```

```
##   x y x1 y1
## 1 1 3  2  3
## 2 2 2  3  4
## 3 3 1  4  5
```

```r
mutate(df, y1 = x+1, x1 = x+1)
```

```
##   x y y1 x1
## 1 1 3  2  2
## 2 2 2  3  3
## 3 3 1  4  4
```

```r
mutate(df, xx = x)
```

```
##   x y xx
## 1 1 3  1
## 2 2 2  2
## 3 3 1  3
```



```r
# generate a variable indicating the total number of times each person has been contacted 
# during this campaign and during the previous ones 
mutate(bank, contacts_n = campaign + previous)
```

```
## # A tibble: 45,211 × 21
##       id   age          job  marital education default balance housing   loan contact   day  month  year
##    <int> <int>       <fctr>   <fctr>    <fctr>  <fctr>   <int>  <fctr> <fctr>  <fctr> <int> <fctr> <int>
## 1      1    58   management  married  tertiary      no    2143     yes     no unknown     5    may  2008
## 2      2    44   technician   single secondary      no      29     yes     no unknown     5    may  2008
## 3      3    33 entrepreneur  married secondary      no       2     yes    yes unknown     5    may  2008
## 4      4    47  blue-collar  married   unknown      no    1506     yes     no unknown     5    may  2008
## 5      5    33      unknown   single   unknown      no       1      no     no unknown     5    may  2008
## 6      6    35   management  married  tertiary      no     231     yes     no unknown     5    may  2008
## 7      7    28   management   single  tertiary      no     447     yes    yes unknown     5    may  2008
## 8      8    42 entrepreneur divorced  tertiary     yes       2     yes     no unknown     5    may  2008
## 9      9    58      retired  married   primary      no     121     yes     no unknown     5    may  2008
## 10    10    43   technician   single secondary      no     593     yes     no unknown     5    may  2008
## # ... with 45,201 more rows, and 8 more variables: date <dttm>, duration <int>, campaign <int>,
## #   pdays <int>, previous <int>, poutcome <fctr>, y <fctr>, contacts_n <int>
```

`mutate()` allows you to refer to columns that you just created:


```r
# generate two variable: one indicating the year of birth and one the year of birth without century 
bank %>% mutate(year_of_birth = year - age, year_of_birth_no_century = year_of_birth - 1900)
```

```
## # A tibble: 45,211 × 22
##       id   age          job  marital education default balance housing   loan contact   day  month  year
##    <int> <int>       <fctr>   <fctr>    <fctr>  <fctr>   <int>  <fctr> <fctr>  <fctr> <int> <fctr> <int>
## 1      1    58   management  married  tertiary      no    2143     yes     no unknown     5    may  2008
## 2      2    44   technician   single secondary      no      29     yes     no unknown     5    may  2008
## 3      3    33 entrepreneur  married secondary      no       2     yes    yes unknown     5    may  2008
## 4      4    47  blue-collar  married   unknown      no    1506     yes     no unknown     5    may  2008
## 5      5    33      unknown   single   unknown      no       1      no     no unknown     5    may  2008
## 6      6    35   management  married  tertiary      no     231     yes     no unknown     5    may  2008
## 7      7    28   management   single  tertiary      no     447     yes    yes unknown     5    may  2008
## 8      8    42 entrepreneur divorced  tertiary     yes       2     yes     no unknown     5    may  2008
## 9      9    58      retired  married   primary      no     121     yes     no unknown     5    may  2008
## 10    10    43   technician   single secondary      no     593     yes     no unknown     5    may  2008
## # ... with 45,201 more rows, and 9 more variables: date <dttm>, duration <int>, campaign <int>,
## #   pdays <int>, previous <int>, poutcome <fctr>, y <fctr>, year_of_birth <int>,
## #   year_of_birth_no_century <dbl>
```

\clearpage

### `summarise()`

The last verb is `summarise()`, which collapses a data frame to a single row.

The first argument is the name of the data frame, and the second and subsequent are summarising expressions.


```r
# Compute the mean of balance variable of bank data frame
bank %>% summarise(mean_balance = mean(balance, na.rm = TRUE))
```

```
## # A tibble: 1 × 1
##   mean_balance
##          <dbl>
## 1     1362.272
```

```r
# Compute the minimum and the maximum value of balance of bank data frame
bank %>% summarise(max_balance = max(balance, na.rm = TRUE), min_balance = min(balance, na.rm = TRUE))
```

```
## # A tibble: 1 × 2
##   max_balance min_balance
##         <int>       <int>
## 1      102127       -8019
```

\clearpage

## Group Data and Chain Verbs


```r
require(dplyr)
require(qdata)
data(bank)
```


### `group_by()`

The verb functions are useful, but they become really powerful when you combine them with the idea of "group by", repeating the operation individually on groups of observations within the dataset.
In `dplyr`, you use the `group_by()` function to describe how to break a dataset down into groups of rows. You can then use the resulting object in the verbs functions; they’ll automatically work "by group" when the input is a grouped. Let us see some examples (pay attention to objects class).


```r
# Example data frame
df <- data.frame(x = 1:6, f = rep(1:2, each = 3))

# Grouped data frame
dff <- group_by(df, f)
dff
```

```
## Source: local data frame [6 x 2]
## Groups: f [2]
## 
##       x     f
##   <int> <int>
## 1     1     1
## 2     2     1
## 3     3     1
## 4     4     2
## 5     5     2
## 6     6     2
```

```r
class(dff)
```

```
## [1] "grouped_df" "tbl_df"     "tbl"        "data.frame"
```

```r
# Use dff (grouped data frame) as .data argument value in mutate() 
dffn <- mutate(.data = dff, n = n())
dffn
```

```
## Source: local data frame [6 x 3]
## Groups: f [2]
## 
##       x     f     n
##   <int> <int> <int>
## 1     1     1     3
## 2     2     1     3
## 3     3     1     3
## 4     4     2     3
## 5     5     2     3
## 6     6     2     3
```

```r
class(dffn)
```

```
## [1] "grouped_df" "tbl_df"     "tbl"        "data.frame"
```

```r
# Use dff (grouped data frame) as .data argument value in arrange()
dffa <- arrange(.data = dff, desc(x))
dffa
```

```
## Source: local data frame [6 x 2]
## Groups: f [2]
## 
##       x     f
##   <int> <int>
## 1     6     2
## 2     5     2
## 3     4     2
## 4     3     1
## 5     2     1
## 6     1     1
```

```r
class(dffa)
```

```
## [1] "grouped_df" "tbl_df"     "tbl"        "data.frame"
```

```r
# Use dff (grouped data frame) as data argument value in summarise()
dfg <- summarise(.data = dff, x_avg = mean(x))
dfg
```

```
## # A tibble: 2 × 2
##       f x_avg
##   <int> <dbl>
## 1     1     2
## 2     2     5
```

```r
class(dfg)
```

```
## [1] "tbl_df"     "tbl"        "data.frame"
```

In the following example, you split the complete dataset into years and then summarise each year by counting the number of phone calls (`count = n()`) and computing the average duration call (`dist = mean(duration, na.rm = TRUE)`) and balance (`delay = mean(balance, na.rm = TRUE)`):


```r
# Split the complete dataset (bank) into years (group the df) 
by_year <- group_by(bank, year)
# Summarise each year applying summarise() verb to the grouped df (by_year)
summarise(by_year,
          count = n(),
          mean_duration = mean(duration, na.rm = TRUE),
          mean_balance = mean(balance, na.rm = TRUE))
```

```
## # A tibble: 3 × 4
##    year count mean_duration mean_balance
##   <int> <int>         <dbl>        <dbl>
## 1  2008 27729      252.1936     1315.211
## 2  2009 14862      262.9644     1362.140
## 3  2010  2620      294.1065     1861.092
```

Then, you search for the number of days covered per year. You report also the number of phone calls per year:


```r
summarise(by_year,
          days = n_distinct(date),
          count = n())
```

```
## # A tibble: 3 × 3
##    year  days count
##   <int> <int> <int>
## 1  2008   122 27729
## 2  2009   212 14862
## 3  2010   227  2620
```

When you group by multiple variables, each summary peels off one level of the grouping. That makes it easy to progressively roll up a dataset:


```r
daily <- group_by(bank, year, month, day)
groups(daily)
```

```
## [[1]]
## year
## 
## [[2]]
## month
## 
## [[3]]
## day
```

```r
per_day <- summarise(daily, calls = n())
groups(per_day)
```

```
## [[1]]
## year
## 
## [[2]]
## month
```

```r
per_month <- summarise(per_day, calls = sum(calls))
groups(per_month)
```

```
## [[1]]
## year
```

```r
per_year <- summarise(per_month, calls = sum(calls))
groups(per_year)
```

```
## NULL
```


```r
df <- data.frame(year = rep(c(2010, 2011, 2012), each = 3), 
                 month = rep(1:3, each = 3), 
                 day = rep(20:22, 3), 
                 x = 1:9)

df
```

```
##   year month day x
## 1 2010     1  20 1
## 2 2010     1  21 2
## 3 2010     1  22 3
## 4 2011     2  20 4
## 5 2011     2  21 5
## 6 2011     2  22 6
## 7 2012     3  20 7
## 8 2012     3  21 8
## 9 2012     3  22 9
```

```r
df1 <- df %>% group_by(year, month, day) 

groups(df1)
```

```
## [[1]]
## year
## 
## [[2]]
## month
## 
## [[3]]
## day
```

```r
df2 <-  df1 %>% 
  summarise(x_avg = mean(x), n = n())

df2
```

```
## Source: local data frame [9 x 5]
## Groups: year, month [?]
## 
##    year month   day x_avg     n
##   <dbl> <int> <int> <dbl> <int>
## 1  2010     1    20     1     1
## 2  2010     1    21     2     1
## 3  2010     1    22     3     1
## 4  2011     2    20     4     1
## 5  2011     2    21     5     1
## 6  2011     2    22     6     1
## 7  2012     3    20     7     1
## 8  2012     3    21     8     1
## 9  2012     3    22     9     1
```

```r
groups(df2)
```

```
## [[1]]
## year
## 
## [[2]]
## month
```

```r
summarise(df2, n())
```

```
## Source: local data frame [3 x 3]
## Groups: year [?]
## 
##    year month `n()`
##   <dbl> <int> <int>
## 1  2010     1     3
## 2  2011     2     3
## 3  2012     3     3
```

```r
ungroup(df2) %>% summarise(n())
```

```
## # A tibble: 1 × 1
##   `n()`
##   <int>
## 1     9
```


### Chain Together Multiple Operations

The `dplyr` API (Application Program Interface) is functional in the sense that function calls don't have side-effects, and you must always save their results. This doesn't lead to particularly elegant code if you want to do many operations at once. You either have to do it step-by-step:


```r
a1 <- group_by(bank, date)
a2 <- select(a1, age, balance)
```

```
## Adding missing grouping variables: `date`
```

```r
a3 <- summarise(a2,
                mean_age = mean(age, na.rm = TRUE),
                mean_balance = mean(balance, na.rm = TRUE)
                )
(a4 <- filter(a3, mean_age < 40 & mean_balance > 5000))
```

```
## # A tibble: 5 × 3
##         date mean_age mean_balance
##       <dttm>    <dbl>        <dbl>
## 1 2008-10-18   37.500      5502.75
## 2 2008-12-27   28.000      6100.00
## 3 2009-03-20   28.000      5916.00
## 4 2009-10-02   39.875      5088.00
## 5 2009-12-31   32.000     14533.00
```

Or if you don’t want to save the intermediate results, you need to wrap the function calls inside each other:


```r
filter(
  summarise(
    select(
      group_by(bank, date), age, balance
    ),
    mean_age = mean(age, na.rm = TRUE),
    mean_balance = mean(balance, na.rm = TRUE)
  ),
  mean_age < 40 & mean_balance > 5000
)
```

```
## Adding missing grouping variables: `date`
```

```
## # A tibble: 5 × 3
##         date mean_age mean_balance
##       <dttm>    <dbl>        <dbl>
## 1 2008-10-18   37.500      5502.75
## 2 2008-12-27   28.000      6100.00
## 3 2009-03-20   28.000      5916.00
## 4 2009-10-02   39.875      5088.00
## 5 2009-12-31   32.000     14533.00
```

This is difficult to read because the order of the operations is from inside to out, and the arguments are a long way away from the function. To get around this problem, use the `%>%` operator.


```r
bank %>%
  group_by(date) %>%
  select(age, balance) %>%
  summarise(
    mean_age = mean(age, na.rm = TRUE),
    mean_balance = mean(balance, na.rm = TRUE)
  ) %>%
  filter(mean_age < 40 & mean_balance > 5000)
```

```
## Adding missing grouping variables: `date`
```

```
## # A tibble: 5 × 3
##         date mean_age mean_balance
##       <dttm>    <dbl>        <dbl>
## 1 2008-10-18   37.500      5502.75
## 2 2008-12-27   28.000      6100.00
## 3 2009-03-20   28.000      5916.00
## 4 2009-10-02   39.875      5088.00
## 5 2009-12-31   32.000     14533.00
```

\clearpage

## dplyr verbs for combining data: join


```r
require(dplyr)
```

Very often you will have to deal with many tables that contribute to the analysis you are performing and you need flexible tools to combine them. Supposing that the two tables are already in a tidy form: the rows are observations and the columns are variables, `dplyr` provides  __mutating joins__, which add new variables to one table from matching rows in another.

There are four types of mutating join, which differ in their behaviour when a match is not found. 

* `inner_join(x, y)`
* `left_join(x, y)`
* `right_join(x, y)`
* `outer_join(x, y)`

All these verbs work similarly: 

* the first two arguments, `x` and `y`, provide the tables to combine
* the output is always a new table with the same type as `x`

For the next examples we will consider these two small data frames:


```r
df1 <- data.frame(id = 1:4, x1 = letters[1:4])
df1
```

```
##   id x1
## 1  1  a
## 2  2  b
## 3  3  c
## 4  4  d
```

```r
df2 <- data.frame(id = 3:5, x2 = letters[3:5])
df2
```

```
##   id x2
## 1  3  c
## 2  4  d
## 3  5  e
```

### `inner_join(x, y)`


\includegraphics[width=2.3in]{images/inner_join} 

`inner_join(x, y)` only includes observations that match in both x and y:


```r
inner_join(df1, df2)
```

```
## Joining, by = "id"
```

```
##   id x1 x2
## 1  3  c  c
## 2  4  d  d
```

### `left_join(x, y)`


\includegraphics[width=2.26in]{images/left_join} 


`left_join(x, y)` includes all observations in `x`, regardless of whether they match or not. This is the most commonly used join because it ensures that you don't lose observations from your primary table:


```r
left_join(df1, df2)
```

```
## Joining, by = "id"
```

```
##   id x1   x2
## 1  1  a <NA>
## 2  2  b <NA>
## 3  3  c    c
## 4  4  d    d
```

### `right_join(x, y)`


\includegraphics[width=2.3in]{images/right_join} 

`right_join(x, y)` includes all observations in `y`. It’s equivalent to `left_join(y, x)`, but the columns will be ordered differently:


```r
right_join(df1, df2)
```

```
## Joining, by = "id"
```

```
##   id   x1 x2
## 1  3    c  c
## 2  4    d  d
## 3  5 <NA>  e
```

```r
left_join(df2, df1)
```

```
## Joining, by = "id"
```

```
##   id x2   x1
## 1  3  c    c
## 2  4  d    d
## 3  5  e <NA>
```


### `full_join()`


\includegraphics[width=2.23in]{images/full_join} 


`full_join()` includes all observations from `x` and `y`:


```r
full_join(df1, df2)
```

```
## Joining, by = "id"
```

```
##   id   x1   x2
## 1  1    a <NA>
## 2  2    b <NA>
## 3  3    c    c
## 4  4    d    d
## 5  5 <NA>    e
```

The left, right and full joins are collectively know as outer joins. When a row doesn't match in an outer join, the new variables are filled in with missing values.

\clearpage

## dplyr with backend databases


```r
require(dplyr)
require(ggplot2)
require(DBI)
require(RSQLite)
```


### Getting Started with Large Data 

To experimement with large files you may want to use data from http://stat-computing.org/dataexpo/2009/the-data.html.

The data consists of flight arrival and departure details for all commercial flights within the USA, from October 1987 to April 2008. This is a large dataset: there are nearly 120 million records in total, and takes up 1.6 gigabytes of space compressed and 12Gb when uncompressed. Only four of these files will be considered in the next example for a 29 millions records data frame.

This is clearly a case for SQLite: let us load the `RSQLite` package.


```r
require(RSQLite)
```

As these files might have different encodings you may need to define a simple function that returns the encoding of the file. Note that this function uses unix system commands and may not work under windows based computers.


```r
charset <- function (file){
  info <- system(paste("file -i" ,file ), intern = TRUE)
  info_split <- strsplit(info, split = "charset=")[[1]][2]
  info_split
}
```

You then create an empty SQLite database with a little trick that ensures the database is removed in case it already exists:


```r
path <- "./"
db <- "ontime.sqlite"
path_db <- paste(path, db, sep = "/")
db_exists <- list.files(path, pattern = db)
if(length(db_exists) != 0) system(paste("rm", path_db))
con <- dbConnect(RSQLite::SQLite(), path_db)
```

Now it's time to get the list of files you want to load:


```r
files <- list.files("./../data", pattern = ".csv", full.names = TRUE)
```

and by using a for loop you can load all the files into the newly created data base:


```r
for (i in 1:length(files)){
  head <- ifelse (i == 1, TRUE, FALSE)
  skip <- ifelse (i == 1, 0, 1)
  append <- ifelse (i == 1, FALSE, TRUE)
  this_file <- files[i]
  encoding <- charset(this_file)
  df <- read.table(this_file, sep = ",", head = head, encoding = encoding, skip = skip, nrows = 100)
  dbWriteTable(conn = con, name = "ontime", value = df ,append = append)
  cat(date() , this_file, "loaded", "\n")
  rm(df)
}  
```

finally disconnect from the database:


```r
dbDisconnect(con)
```

You can now start using the data base with dplyr interface:


```r
con_dplyr <- src_sqlite(path_db)
ontime <- tbl(con_dplyr, "ontime")
class(ontime)
dim(ontime)
```

When working with databases, `dplyr` tries to be as lazy as possible. It’s lazy in two ways:

* It never pulls data back to `R` unless you explicitly ask for it;
* It delays doing any work until the last possible minute, collecting together everything you want to do then sending that to the database in one step.

For example, take the following code:


```r
ontime_stat <- ontime %>% group_by(Year, Month) %>% 
   summarise(avg = mean(DepDelay), min = min(DepDelay), max = max(DepDelay)) 
```

Suprisingly, this sequence of operations never actually touches the database. It’s not until you ask for the data (e.g. by printing `ontime_stat`) that `dplyr` generates the SQL and requests the results from the database, and even then it only pulls down 10 rows:


```r
ontime_stat
class(ontime_stat)
```

To pull down all the results use `collect()`, which returns a `tbl` class object:


```r
ontime_dep_delay <- ontime %>%
  select(year = Year, dep_delay = DepDelay, arr_delay = ArrDelay) %>%
  filter(dep_delay > 0) %>%
  collect()
```

Once data are collected you can use it within `R`:


```r
pl <- ggplot(ontime_dep_delay , aes(dep_delay, arr_delay))
pl <- pl + stat_binhex(bins = 30) + facet_wrap(~year, ncol = 2)
print(pl)
```


