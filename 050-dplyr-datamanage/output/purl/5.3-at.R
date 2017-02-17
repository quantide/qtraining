## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
require(dplyr)
require(qdata)
data(bank)

## ------------------------------------------------------------------------
first(bank$job) # you may add order_by = for choosing a specific order
bank %>% summarise(first(job))

## ------------------------------------------------------------------------
bank %>% 
  summarise_at(vars(balance_mean = balance), mean)

bank %>% 
  summarise_at(vars(age_mean = age, balance_mean = balance), mean)

bank %>% 
  summarise_at(vars(age, balance), funs(mean, sd)) # no need to specify names

## ------------------------------------------------------------------------
bank %>% 
  summarise_at(c(2, 7), mean) # indicate the position of the variables to summarise

bank %>% 
  summarise_at(c(2, 7), .funs = mean) 

bank %>% 
  summarise_at(c(2, 7), funs (mean, sd))

## ------------------------------------------------------------------------
bank %>% 
  mutate_at(vars(age_log = age), log)

bank %>% 
  mutate_at(2, .funs = log)

bank %>% 
  mutate_at(c(2, 7), funs (-10, +1)) # how do you choose the new name?

