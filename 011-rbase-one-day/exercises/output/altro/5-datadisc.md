


# Data Discovery with R

Load `dplyr` package, supposing it is already installed.


```r
require(dplyr)
```

## Data

Also these exercises are based on the `nycflights13` data, taken from the `nycflights13` package.  
Load `nycflights13` package, supposing it is already installed.


```r
require(nycflights13)
```

The `nycflights13` package contains information about all flights that departed from NYC (e.g. EWR, JFK and LGA) in 2013: 336,776 flights in total. For more information see _Data Manipulation with R_ section.

The following exercises refers to `flights` dataset:


```r
data("flights")
```

## Descriptive statistics with `summarise()` and `group_by()`

### Exercise 1

Calculate the mean delay at arrival (`arr_delay` variable). Remember to add `na.rm=TRUE` option to all calculations.




### Exercise 2

Calculate the summary (minimum, first quartile, median, mean, third quartile, maximum and standard deviation) of delay at departure (`dep_delay` variable) for flights.  
Remember to add `na.rm=TRUE` option to mean calculations.




### Exercise 3

Calculate minimum and maximum delay at departure (`arr_delay` variable) for flights by month.  
Remember to add `na.rm=TRUE` option to all calculations.




## Multiple operations

### Exercise 1

For each destination (`dest` variable), compute the mean delay at arrival (`arr_delay` variable) and filter the mean delays greater than 30 minutes.  
Remember to add `na.rm=TRUE` option to mean calculations.



### Exercise 2

Filter the observations recorded on June 13 and count the number of flights (use `n()` function inside `summarise()`) for each destination. Then sort the result in ascending order.






