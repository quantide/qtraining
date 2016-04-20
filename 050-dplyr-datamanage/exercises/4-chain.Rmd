---
title: 
author:
date: 
output:
  html_document:
    self_contained: no
---



Chainining verbs
================================

## Chain together multiple operations (`%>%`)
Note: all the exercises of this section are based on the `flights` or the `weather` datasets.


```r
library(dplyr)
library(nycflights13)
```


### Exercise 1
Calculate number of flights, mean flights distance, mean delay at departure and at arrival for each of the three origin airports.




### Exercise 2
Calculate number of flights and monthly mean gained time in minutes, where the gained time is defined as the difference between delay at departure and delay at arrival.




### Exercise 3
Select all days where the mean delay at departure or the mean delay at arrival is greater than 30 minutes.




### Exercise 4
From the `weather` dataset select the days taken off from EWR in 2013 where minimum visibility was 5 or lower.



