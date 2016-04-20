---
title:
author:
date:
output:
  html_document:
    self_contained: no
---



## `mutate()` and its friends
Note: all the exercises of this section are based on the `flights` dataset.  
Times are in minutes and distances are in miles.


```r
library(dplyr)
library(nycflights13)
```


### Exercise 1
Add the following new variables to the `flights` dataset:

* the gained time in minutes, defined as the difference between delay at departure and delay at arrival;
* the speed in miles per hour (`distance` / `air_time` * 60).

Show only the following variables: delay at departure, delay at arrival, distance, air time and the two new variables (gained time and speed).




### Exercise 2
Redo the previous calculations keeping only the new variables.




### Exercise 3
After sorting flights in chronological order, for each flight calculate the difference between its delay at arrival and the delay at arrival of the immediately previous flight. Have R showed only the delay variables (delay at departure, delay at arrival and the new variable).




### Exercise 4
For each flight calculate the 'min ranking' in terms of delay at arrival.




### Exercise 5
For each flight calculate the 'first ranking' in terms of delay at arrival.




### Exercise 6
Create a variable which indicates if each flight took off more than -4 or less than 4 minutes late.


