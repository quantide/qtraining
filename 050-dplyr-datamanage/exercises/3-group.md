---
title: 
author:
date: 
output:
  html_document:
    self_contained: no
---



Grouping data
================================

## `group_by()`
Note: all the exercises of this section are based on the `flights` dataset.


```r
library(dplyr)
library(nycflights13)
```


### Exercise 1
Calculate number of flights, minimum, mean and maximum delay at arrival for flights by month.




### Exercise 2
Calculate number of flights, mean delay at departure and arrival for flights by origin.




### Exercise 3
Calculate the number of planes and the number of flights that go to each possible destination.




### Exercise 4
Calculate the number of flights for each day. Save the result in a data frame called `per_day`.




### Exercise 5
By exploiting `per_day`, calculate the number of flights for each month. Save the result in a data frame called `per_month`.




### Exercise 6
Calculate the mean daily number of flights per month.



