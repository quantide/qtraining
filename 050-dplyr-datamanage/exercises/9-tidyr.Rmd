---
title:
author:
date:
output:
  html_document:
    self_contained: no
---



Tidy data with `tidyr`
================================

## `tidyr`


```r
library(dplyr)
library(tidyr)
library(nycflights13)
```


### Exercise 1
Consider the following dataset:


```r
heartrate_wide <- data.frame(
  name = c("Aldo", "Giovanni", "Giacomo"),
  surname = c("Baglio", "Storti", "Poretti"),
  morning = c(67, 80, 64),
  afternoon = c(56, 90, 50)
)
heartrate_wide
```

```
##       name surname morning afternoon
## 1     Aldo  Baglio      67        56
## 2 Giovanni  Storti      80        90
## 3  Giacomo Poretti      64        50
```

It represents the heart rate measured to three patients in the morning and in the afternoon. The dataset is in the wide format: change it to the long format through a proper `tidyr` function. Save the result in a data frame and call it `heartrate_long`.




### Exercise 2
Starting from `heartrate_long`, come back to a dataset in a wide format through a proper `tidyr` function. The result should be obviously equal to `heartrate_wide`.




### Exercise 3
Consider the dataset `heartrate_wide` and unite name and surname of the patients in a unique column through a proper `tidyr` function. Save the result in a new data frame called `heartrate_united`.




### Exercise 4
Starting from `heartrate_united`, come back to a dataset where name and surname are in two different columns through a proper `tidyr` function. The result should be obviously equal to `heartrate_wide`.



