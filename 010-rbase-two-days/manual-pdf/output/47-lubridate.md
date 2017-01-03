


# Managing dates with lubridate



```r
require(lubridate)
require(dplyr)
require(ggplot2)
require(tidyr)
require(qdata)
```


## A First Look to `lubridate`

Among packages that deals with dates and times in R, `lubridate` provides a set of intuitive and coherent functions. Intuitive since each function usually perform a single task described by its name; coherent since `lubridate` is well integrated with other data management tools, like `dplyr`.

Supposing `lubridate` is currently installed, it must be loaded in order to use its functions.

```r
require(lubridate)
```

The starting point is a character string.

```r
chr <- "01-02-12"
class(chr)
```

```
## [1] "character"
```

The above string is an ambiguous date: 

 + in Europe, it can be easily interpreted as 1st February 2012, 
 + in the US, it can be read as January 2, 2012,
 + IT developers write in this way the day 12 February 2001. 

`lubridate` provides a single function for each one of these cases: `dmy()`, `mdy()` and `ymd()`. These functions parse dates according to the order provided, where `y` is the _year_, `m` is the _month_ and `d` is the _day_.


```r
dmy(chr)
```

```
## [1] "2012-02-01"
```

```r
mdy(chr)
```

```
## [1] "2012-01-02"
```

```r
ymd(chr)
```

```
## [1] "2001-02-12"
```


```r
class(dmy(chr))
```

```
## [1] "Date"
```

Parsed objects have now two new classes: `POSIXct` and `POSIXt`. As Wikipedia states, _the Portable Operating System Interface (POSIX) is a family of standards specified by the IEEE Computer Society for maintaining compatibility between operating systems_.

The `POSIXct` format stores dates as the number of seconds since the start of January 1, 1970, as shown by `as.numeric()` below; `POSIXt` is a virtual class common to `POSIXct` and other `POSIX*` classes that are not used here.


```r
as.numeric(dmy(chr))
```

```
## [1] 15371
```

The `lubridate` package provides other parsing functions, to deal with less frequent cases `myd()`, `dym()` and `ydm()`.


```r
myd(chr)
```

```
## [1] "2002-01-12"
```

```r
dym(chr)
```

```
## [1] "2002-12-01"
```

```r
ydm(chr)
```

```
## [1] "2001-12-02"
```

Accordingly to the help, `ymd()`-style _functions recognize arbitrary non-digit separators as well as no separator. As long as the order of formats is correct, these functions will parse dates correctly even when the input vectors contain differently formatted dates_.


```r
x <- c(20160101, "2016-01-02", "2016 01 03", "2016-1-4", "2016-1, 5", 
       "Created on 2016 1 6", "201601 !!! 07")
ymd(x)
```

```
## [1] "2016-01-01" "2016-01-02" "2016-01-03" "2016-01-04" "2016-01-05" "2016-01-06" "2016-01-07"
```


## Extract Date Components

The following function returns an `IBM` data frame with IBM quotation data from Yahoo! Finance. Notice that the function refer to the `quantmod` package, so it should be installed.


```r
quantmod::getSymbols("IBM", return.class = 'data.frame')
```

```
## [1] "IBM"
```

```r
head(IBM)
```

```
##            IBM.Open IBM.High IBM.Low IBM.Close IBM.Volume IBM.Adjusted
## 2007-01-03    97.18    98.40   96.26     97.27    9196800     78.35465
## 2007-01-04    97.25    98.79   96.88     98.31   10524500     79.19241
## 2007-01-05    97.60    97.95   96.91     97.42    7221300     78.47548
## 2007-01-08    98.50    99.50   98.35     98.90   10340000     79.66768
## 2007-01-09    99.08   100.33   99.07    100.07   11108200     80.61016
## 2007-01-10    98.50    99.05   97.93     98.89    8744800     79.65962
```


The data frame contains dates as row names but data manipulation can be performed better on a variable. With a bit of `dplyr` code the new column can be added.


```r
IBM <- IBM %>% mutate(date = row.names(.)) %>% tbl_df 
IBM
```

```
## # A tibble: 2,518 × 7
##    IBM.Open IBM.High IBM.Low IBM.Close IBM.Volume IBM.Adjusted       date
##       <dbl>    <dbl>   <dbl>     <dbl>      <dbl>        <dbl>      <chr>
## 1     97.18    98.40   96.26     97.27    9196800     78.35465 2007-01-03
## 2     97.25    98.79   96.88     98.31   10524500     79.19241 2007-01-04
## 3     97.60    97.95   96.91     97.42    7221300     78.47548 2007-01-05
## 4     98.50    99.50   98.35     98.90   10340000     79.66768 2007-01-08
## 5     99.08   100.33   99.07    100.07   11108200     80.61016 2007-01-09
## 6     98.50    99.05   97.93     98.89    8744800     79.65962 2007-01-10
## 7     99.00    99.90   98.50     98.65    8000700     79.46630 2007-01-11
## 8     98.99    99.69   98.50     99.34    6636500     80.02211 2007-01-12
## 9     99.40   100.84   99.30    100.82    9602200     81.21431 2007-01-16
## 10   100.69   100.90   99.90    100.02    8200700     80.56988 2007-01-17
## # ... with 2,508 more rows
```

At this point, the new `date` column is a string and it must be parsed to be interpreted by R as a date.


```r
IBM <- IBM %>% mutate(date = ymd(date))
IBM
```

```
## # A tibble: 2,518 × 7
##    IBM.Open IBM.High IBM.Low IBM.Close IBM.Volume IBM.Adjusted       date
##       <dbl>    <dbl>   <dbl>     <dbl>      <dbl>        <dbl>     <date>
## 1     97.18    98.40   96.26     97.27    9196800     78.35465 2007-01-03
## 2     97.25    98.79   96.88     98.31   10524500     79.19241 2007-01-04
## 3     97.60    97.95   96.91     97.42    7221300     78.47548 2007-01-05
## 4     98.50    99.50   98.35     98.90   10340000     79.66768 2007-01-08
## 5     99.08   100.33   99.07    100.07   11108200     80.61016 2007-01-09
## 6     98.50    99.05   97.93     98.89    8744800     79.65962 2007-01-10
## 7     99.00    99.90   98.50     98.65    8000700     79.46630 2007-01-11
## 8     98.99    99.69   98.50     99.34    6636500     80.02211 2007-01-12
## 9     99.40   100.84   99.30    100.82    9602200     81.21431 2007-01-16
## 10   100.69   100.90   99.90    100.02    8200700     80.56988 2007-01-17
## # ... with 2,508 more rows
```

The `lubridate` package provide a set of function to extract single components of a date: `month()`, `day()` and `year()`. Using just `lubridate` and `dplyr` the components of a date can be added as new variables to a data frame.


```r
IBM <- IBM %>% mutate(month = month(date), day = day(date), year = year(date))
IBM
```

```
## # A tibble: 2,518 × 10
##    IBM.Open IBM.High IBM.Low IBM.Close IBM.Volume IBM.Adjusted       date month   day  year
##       <dbl>    <dbl>   <dbl>     <dbl>      <dbl>        <dbl>     <date> <dbl> <int> <dbl>
## 1     97.18    98.40   96.26     97.27    9196800     78.35465 2007-01-03     1     3  2007
## 2     97.25    98.79   96.88     98.31   10524500     79.19241 2007-01-04     1     4  2007
## 3     97.60    97.95   96.91     97.42    7221300     78.47548 2007-01-05     1     5  2007
## 4     98.50    99.50   98.35     98.90   10340000     79.66768 2007-01-08     1     8  2007
## 5     99.08   100.33   99.07    100.07   11108200     80.61016 2007-01-09     1     9  2007
## 6     98.50    99.05   97.93     98.89    8744800     79.65962 2007-01-10     1    10  2007
## 7     99.00    99.90   98.50     98.65    8000700     79.46630 2007-01-11     1    11  2007
## 8     98.99    99.69   98.50     99.34    6636500     80.02211 2007-01-12     1    12  2007
## 9     99.40   100.84   99.30    100.82    9602200     81.21431 2007-01-16     1    16  2007
## 10   100.69   100.90   99.90    100.02    8200700     80.56988 2007-01-17     1    17  2007
## # ... with 2,508 more rows
```

At this point, you can easily draw a time series plot with adjusted quotations for the IBM, with a facet for each year.



```r
ggplot(data=IBM, mapping=aes(x=date)) +
  geom_line(aes(y=IBM.Adjusted)) + 
  facet_wrap(~ year, scales="free_x")
```

![](47-lubridate_files/figure-latex/lubridate_ggp_facets-1.pdf)<!-- --> 

Similarly, you can explore differences among months with a box plot for each month.


```r
ggplot(data=IBM, mapping=aes(x=factor(month), y=IBM.Adjusted, group=month)) +
  geom_boxplot() +
  facet_wrap(~ year)
```

![](47-lubridate_files/figure-latex/lubridate_ggp_boxplot-1.pdf)<!-- --> 

The last function shown here is `wday()`: it extracts the week day of a date, returning a number from Sunday (1) to Saturday (7).


```r
IBM <- IBM %>% mutate(weekday = wday(date))
IBM
```

```
## # A tibble: 2,518 × 11
##    IBM.Open IBM.High IBM.Low IBM.Close IBM.Volume IBM.Adjusted       date month   day  year weekday
##       <dbl>    <dbl>   <dbl>     <dbl>      <dbl>        <dbl>     <date> <dbl> <int> <dbl>   <dbl>
## 1     97.18    98.40   96.26     97.27    9196800     78.35465 2007-01-03     1     3  2007       4
## 2     97.25    98.79   96.88     98.31   10524500     79.19241 2007-01-04     1     4  2007       5
## 3     97.60    97.95   96.91     97.42    7221300     78.47548 2007-01-05     1     5  2007       6
## 4     98.50    99.50   98.35     98.90   10340000     79.66768 2007-01-08     1     8  2007       2
## 5     99.08   100.33   99.07    100.07   11108200     80.61016 2007-01-09     1     9  2007       3
## 6     98.50    99.05   97.93     98.89    8744800     79.65962 2007-01-10     1    10  2007       4
## 7     99.00    99.90   98.50     98.65    8000700     79.46630 2007-01-11     1    11  2007       5
## 8     98.99    99.69   98.50     99.34    6636500     80.02211 2007-01-12     1    12  2007       6
## 9     99.40   100.84   99.30    100.82    9602200     81.21431 2007-01-16     1    16  2007       3
## 10   100.69   100.90   99.90    100.02    8200700     80.56988 2007-01-17     1    17  2007       4
## # ... with 2,508 more rows
```

Of course, also the new variable can be used as grouping variable for box plots.


```r
ggplot(data=IBM, mapping=aes(
    x=factor(weekday, labels=c("Mon", "Tue", "Wed", "Thu", "Fri")), y=IBM.Volume, 
    group=weekday)
  ) + geom_boxplot() + xlab("Week day")
```

![](47-lubridate_files/figure-latex/lubridate_ggp_weekday-1.pdf)<!-- --> 

## Dealing with Years: Leap Year and Date Differences 

A leap year (also known as a bissextile year) is a year containing 366 days instead of the usual 365, by extending February to 29 days rather than the common 28.

Since 2016 is a leap year, the difference between March 17, 2016 and March 17, 2015 is 366 days.


```r
ymd("2016-03-17") - ymd("2015-03-17")
```

```
## Time difference of 366 days
```

By the way, if you add an year to a date may be you expect the same day/month of the following year. The function `years()` add a number of years, ignoring leap years. Notice the spelling difference among this function, `years()` and the function to extract the `year()` component of a date, that have the singular form of the units as a name.


```r
ymd("2015-03-17") + years(1)
```

```
## [1] "2016-03-17"
```

In some cases, you may be interested in the exact time differences. The function `dyears()` adds an year (i.e. 365 days) according to leap years.


```r
ymd("2015-03-17") + dyears(1)
```

```
## [1] "2016-03-16"
```


## Dealing with Months and Days

Similarly to `years()`, the `months()` function return the same day shifted by a specified number of months.


```r
ymd("2016-06-01") + months(1)
```

```
## [1] "2016-07-01"
```

```r
ymd("2016-06-01") - months(6)
```

```
## [1] "2015-12-01"
```

If you try to add a month to January 31, you get a `NA` value. This is because February does _not_ have 31 days.


```r
ymd("2016-01-31") + months(1)
```

```
## [1] NA
```

In these cases you may want to add to January 31 a "standard" month, that is 30 days. You can solve the issue with the `days()` function.


```r
ymd("2016-01-31") + days(30)
```

```
## [1] "2016-03-01"
```

Otherwise, you may want a month later January 31, without exceeding the following month. The package `lubridate` allows you to deal with this case, using the special operator `%m+%`.


```r
ymd("2016-01-31") %m+% months(1)
```

```
## [1] "2016-02-29"
```

As shown above, you can shift a date by a given number of `days()`:

```r
ymd("2016-01-31") + days(7)
```

```
## [1] "2016-02-07"
```

```r
ymd("2016-03-26") - days(360)
```

```
## [1] "2015-04-01"
```


## Time Parsing

Package `lubridate` allow you to deal with times, too. Times have no mean without dates, so you will parse the whole date-time string.

When data has date and time in two different variables, you can merge it an a single variable with a bit of `tidyr`. The following example requires data frame `diabetes` from `qdata` package.


```r
data(diabetes)
names(diabetes)
```

```
## [1] "patient" "date"    "time"    "code"    "value"
```

```r
diabetes <- diabetes %>% unite(datetime, date, time)
diabetes
```

```
## # A tibble: 29,297 × 4
##    patient         datetime  code value
## *    <chr>            <chr> <int> <chr>
## 1       01  04-21-1991_9:09    58   100
## 2       01  04-21-1991_9:09    33     9
## 3       01  04-21-1991_9:09    34    13
## 4       01 04-21-1991_17:08    62   119
## 5       01 04-21-1991_17:08    33     7
## 6       01 04-21-1991_22:51    48   123
## 7       01  04-22-1991_7:35    58   216
## 8       01  04-22-1991_7:35    33    10
## 9       01  04-22-1991_7:35    34    13
## 10      01 04-22-1991_13:40    33     2
## # ... with 29,287 more rows
```

As for dates, you can use the parsing functions to tell R that `datetime` is a date-time object.


```r
diabetes <- diabetes %>% mutate(datetime = mdy_hm(datetime))
```

```
## Warning: 7 failed to parse.
```

```r
diabetes
```

```
## # A tibble: 29,297 × 4
##    patient            datetime  code value
##      <chr>              <dttm> <int> <chr>
## 1       01 1991-04-21 09:09:00    58   100
## 2       01 1991-04-21 09:09:00    33     9
## 3       01 1991-04-21 09:09:00    34    13
## 4       01 1991-04-21 17:08:00    62   119
## 5       01 1991-04-21 17:08:00    33     7
## 6       01 1991-04-21 22:51:00    48   123
## 7       01 1991-04-22 07:35:00    58   216
## 8       01 1991-04-22 07:35:00    33    10
## 9       01 1991-04-22 07:35:00    34    13
## 10      01 1991-04-22 13:40:00    33     2
## # ... with 29,287 more rows
```

The `lubridate` package provides three types of functions that deal with date-time strings: 

* `ymd_h()` when time has only hours
* `ymd_hm()` when time has hours and minutes
* `ymd_hms()` when time has hours, minutes and seconds. 

Notice that `ymd()` can be replaced by any date style (e.g. `mdy`, `dmy` etc.) as seen above. Also in this case, functions recognize arbitrary separators.


```r
ymd_h("2016-03-10 08")
```

```
## [1] "2016-03-10 08:00:00 UTC"
```

```r
ymd_hm("2016-03-10 08:15")
```

```
## [1] "2016-03-10 08:15:00 UTC"
```

```r
ymd_hms("2016-03-10 08:15:40")
```

```
## [1] "2016-03-10 08:15:40 UTC"
```

```r
ymd_hms("16+03/10*08.15,40")
```

```
## [1] "2016-03-10 08:15:40 UTC"
```

```r
ymd_hms("160310:081540")
```

```
## [1] "2016-03-10 08:15:40 UTC"
```

The function `now` returns the current date-time.


```r
now()
```

```
## [1] "2017-01-03 13:26:58 CET"
```



## Time Zones

Date and times may vary with refer to timezone. When you define a `POSIXct` class object with parsing function seen above, you can refer to a specified timezone.

For example, you can set March 1, 2016 at 2.00 PM in the Central European Time (CET).


```r
ymd_hms("2016-03-01 14:00:00", tz="CET")
```

```
## [1] "2016-03-01 14:00:00 CET"
```

In the same way, you can set April 1, 2016 at 2.00 PM.


```r
ymd_hms("2016-04-01 14:00:00", tz="CET")
```

```
## [1] "2016-04-01 14:00:00 CEST"
```
The parsed object return `CEST` instead of `CET`. This is because April is during Daylight Saving Time, and CET area move to Central European _Summer_ Time (CEST).


The next examples show how to set timezone when parsing date. 

<!--
The following examples will show how to modify a date to change its timezone. 
-->

Function `force_tz()` forces a date-time to a new time zone

Function `with_tz()` returns a date-time as it would appear in a different time zone


```r
d <- ymd_hms("2016-03-01 14.00.00")
d
```

```
## [1] "2016-03-01 14:00:00 UTC"
```

```r
force_tz(d, tz="CET")
```

```
## [1] "2016-03-01 14:00:00 CET"
```

```r
with_tz(d, tz="CET")
```

```
## [1] "2016-03-01 15:00:00 CET"
```


## Dealing with Hours, Minutes and Seconds

Similarly to functions `years()` and `dyears`, `lubridate` provides functions for time duration: 

* `hours()`
* `minutes()`
* `seconds()` 

for relative time spans and:

* `dhours()`
* `dminutes()`
* `dseconds()` 

for exact time spans.  

Relative time spans shift times according to the input (e.g. one hour more), while exact time spans return the exact time after _n_ seconds, being _n_ the function input. Relative and exact time spans are identical, unless there are "external" adjustments of time, like Daylight Saving Time.

As an example, you can substract an hour to October 30, 2016 at 2.00 AM. The `hours()` function returns 1.00 AM, since it just subtract an hour; the `dhours()` function returns 2.00 AM again, because in this night DST ends and clocks are set back, as if to repeat one hour.


```r
ymd_hms("2016-10-30 02:00:00", tz="CET") - hours(1)
```

```
## [1] "2016-10-30 01:00:00 CEST"
```

```r
ymd_hms("2016-10-30 02:00:00", tz="CET") - dhours(1)
```

```
## [1] "2016-10-30 02:00:00 CEST"
```

If you want to go crazy, take a look to this example. If you add an hour to 1.30 AM of March 27, 2016 using `hours()` you get a `NA` value, because the 2.59 AM does not exists in this night: DST begins and clocks skip an hour. If you add an hour to 1.30 AM of March 27, 2016 using `dhours()` you get 3.30 AM, the exact time an hour later.


```r
ymd_hms("2016-03-27 01:30:00", tz="CET") + hours(1)
```

```
## [1] NA
```

```r
ymd_hms("2016-03-27 01:30:00", tz="CET") + dhours(1)
```

```
## [1] "2016-03-27 03:30:00 CEST"
```


## Rounding Date and Times

The `lubridate` package provides a set of functions to round date and times, whose names recall numeric rounding functions of base R:

- `ceiling_date()` rounds a date-time up to the nearest integer value;
- `floor_date()` rounds a date-time down to the nearest integer value;
- `round_date()` rounds a date-time to the nearest integer value.
  
Value refers to the specified time unit: you can specify whether to round to the nearest second, minute, hour, day, week, month, or year using the `unit` argument.


```r
dttm <- c(ymd_hms("2016-03-27 14:15:00"), ymd_hms("2016-03-27 14:30:00"), 
          ymd_hms("2016-03-27 14:45:00"))
dttm
```

```
## [1] "2016-03-27 16:15:00 CEST" "2016-03-27 16:30:00 CEST" "2016-03-27 16:45:00 CEST"
```

```r
ceiling_date(dttm, unit="hour")
```

```
## [1] "2016-03-27 17:00:00 CEST" "2016-03-27 17:00:00 CEST" "2016-03-27 17:00:00 CEST"
```

```r
floor_date(dttm, unit="hour")
```

```
## [1] "2016-03-27 16:00:00 CEST" "2016-03-27 16:00:00 CEST" "2016-03-27 16:00:00 CEST"
```

```r
round_date(dttm, unit="hour")
```

```
## [1] "2016-03-27 16:00:00 CEST" "2016-03-27 17:00:00 CEST" "2016-03-27 17:00:00 CEST"
```

