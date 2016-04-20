---
title: 
author:
date: 
output:
  html_document:
    self_contained: no
---



Combining data
================================

## Joins: `inner_join()`, `left_join()`, `right_join()`, etc.
Note: all the exercises of this section are based on `flights`, `airlines`, `airports` or `planes` datasets.


```r
library(dplyr)
library(nycflights13)
```


### Exercise 1
Keep only the following variables of the `flights` dataset: month, day, hour, origin, destination and carrier. Save this dataset in a data frame and call it `flights_red`. Through a proper join command, add the carrier name to `flights_red` (this piece of information is available in `airlines`).






### Exercise 2
Through a proper join command, add name, latitude, longitude and altitude of the origin airport to `flights_red` (these pieces of information are available in `airlines`). Do the same also for the destination airport. (If you are able to, try to keep variables about both origin and destination airports in the same final dataset).




### Exercise 3
Through the `inner_join()` function, redo the same for the destination airport but keep only the flights whose information is available in both datasets (`flights` and `airports`).




### Exercise 4
Redo the exercise 3 by using `full_join()` instead of `inner_join()`. What is the difference in the result?




### Exercise 5
Through the `anti_join()` function, extract all the flights from `flights` whose information about destination airport is not available in `airports`.




### Exercise 6
Sort the `planes` dataset by increasing year. Then create two datasets: the first will deal with planes older than 2000; the second will deal with planes of 2000 or newer. Finally create a unique dataset where the first rows will deal with the newest planes, whereas the last rows will deal with the oldest planes.




