## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
require(dplyr)
require(tidyr)
require(qdata)

## ---- include=TRUE, purl=TRUE--------------------------------------------
NA+1
NA == 1
x <- c(1, 2, 3, 4, NA); mean(x)

## ---- include=TRUE, purl=TRUE--------------------------------------------
is.na(x)

## ---- include=TRUE, purl=TRUE--------------------------------------------
# example with different types of missing data
df <- tibble(
  year = c(2013, 2014, 2014, 2015, 2015, 2016, 2016),
  sem = c(1, 1, 2, 1, 2, 1, 2),
  unemployment_rate = c(7.1, 6.5, 7.6, 8.2, 7.3, NA, 6.8),
  lab_force_participation = c(60, 63.5, 61.4, 999.99, 62.7, 61.8, 63.2)
)

## ---- include=TRUE, purl=TRUE--------------------------------------------
df %>% summarise(mean(unemployment_rate))

## ---- include=TRUE, purl=TRUE--------------------------------------------
df %>% summarise(mean(lab_force_participation))

## ---- include=TRUE, purl=TRUE--------------------------------------------
y <- c(1, 2, 3, "")

## ---- include=TRUE, purl=TRUE--------------------------------------------
na_if(y, "")

## ---- include=TRUE, purl=TRUE--------------------------------------------
df_new <- na_if(df, 999.99)

## ----missing, include=TRUE, purl=TRUE, engine="complete"-----------------
df %>% complete(year, sem)

## ---- include=TRUE, purl=TRUE--------------------------------------------
df_new <- df_new %>% complete(year, sem)

## ---- include=TRUE, purl=TRUE--------------------------------------------
df_new %>% drop_na()

## ---- include=TRUE, purl=TRUE--------------------------------------------
df_new %>% 
summarise_at(vars(unemployment_rate, lab_force_participation), 
funs(mean), na.rm = TRUE)

## ---- include=TRUE, purl=TRUE--------------------------------------------
df <- tibble(
  year = c(2014, NA, 2015, NA, 2016, NA),
  sem = c(1, 2, 1, 2, 1, 2),
  unemployment_rate = c(6.5, 7.6, 8.2, 7.3, NA, 6.8),
  lab_force_participation = c(63.5, 61.4, NA, 62.7, 61.8, 63.2)
)

## ---- include=TRUE, purl=TRUE--------------------------------------------
df %>% fill(year)

