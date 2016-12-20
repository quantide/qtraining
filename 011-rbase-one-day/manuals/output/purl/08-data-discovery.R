## ----load_dplyr, message=FALSE-------------------------------------------
require(dplyr)

## ----bank_tbl_df, message=FALSE------------------------------------------
require(qdata)
data(bank)
bank

## ----summarise-----------------------------------------------------------
# Compute the mean of balance of the accounts
summarise(bank, mean_balance = mean(balance, na.rm = TRUE))
# Compute the sum of balance of the accounts
bank %>% summarise(max_balance = sum(balance, na.rm = TRUE))
# Compute the minimum and the maximum balance of the accounts
bank %>% summarise(max_balance = max(balance, na.rm = TRUE), min_balance = min(balance, na.rm = TRUE))
# Compute the summary (number of obs, minimum, first quartile, median, mean, third quartile, maximum and standard deviation) of balance of the accounts  
bank %>% summarise(n_obs = n(),
              min=min(balance, na.rm = TRUE),
              first_q=quantile(balance, prob = 0.25, na.rm = TRUE),
              median=median(balance, na.rm = TRUE),
              mean=mean(balance, na.rm =TRUE),
              third_q=quantile(balance, prob = 0.75, na.rm = TRUE),
              max=max(balance, na.rm = TRUE),
              sd=sd(balance, na.rm =TRUE))

## ----group_by------------------------------------------------------------
# Compute the mean of balance of the accounts by job
bank %>% 
  group_by(job) %>%
  summarise(mean_balance = mean(balance, na.rm = TRUE))
# Compute the summary (number of obs, minimum, first quartile, median, mean, third quantile, maximum and standard deviation) of balance of the accounts by job 
bank %>% 
  group_by(job) %>%
  summarise(n_obs = n(),
            min=min(balance, na.rm = TRUE),
            first_q=quantile(balance, prob = 0.25, na.rm = TRUE),
            median=median(balance, na.rm = TRUE),
            mean=mean(balance, na.rm =TRUE),
            third_q=quantile(balance, prob = 0.75, na.rm = TRUE),
            max=max(balance, na.rm = TRUE),
            sd=sd(balance, na.rm =TRUE))

## ----multiple_op---------------------------------------------------------
# Compute the mean of balance of the accounts and the number of obs by job for people not older than 40 years and sort the result in ascending order  
bank %>%
  filter(age < 40) %>%
  group_by(job) %>%
  summarise(n_obs =n(),
            mean_balance = mean(balance, na.rm = TRUE)) %>%
  arrange(mean_balance)

