## ----first, message=FALSE------------------------------------------------
require(dplyr)
require(qdata)

## ----bank_tbl_df---------------------------------------------------------
data(bank) 

## ----select--------------------------------------------------------------
# Select columns: year, month and day of bank data frame
select(bank, year, month, day)
# Select columns: year, month and day of bank data frame
bank %>% select(year:day)
# Select all columns of bank data frame apart from: year, month and day
bank %>% select(-(year:day))

## ----select_rename-------------------------------------------------------
# Rename id variable as ID
bank %>% select(ID = id)

## ----filter1-------------------------------------------------------------
filter(bank, job == "student", balance > 20000)

## ----filter2-------------------------------------------------------------
# Select all calls made to student of 18 years 
bank %>% filter(age == 18 & job == "student")

## ----filter3-------------------------------------------------------------
# Select all calls made to people of 18 or 95 years
bank %>% filter(age == 18 | age == 95)

## ----filter4-------------------------------------------------------------
# Select all calls made to people of 18 or 95 years
bank %>% filter(age %in% c(18,95))

## ----filter5-------------------------------------------------------------
# Select all calls made to people whose job is admin. or technician 
bank %>% filter(job %in% c("admin.","technician"))
# Select all calls made to people whose job is admin. or technician 
bank %>% filter(job == "admin." | job == "technician")

## ----arrange1------------------------------------------------------------
arrange(bank, balance)

## ----arrange2------------------------------------------------------------
bank %>% arrange(desc(balance))

## ----arrange3------------------------------------------------------------
bank %>% arrange(age, desc(balance))

## ----mutate_1------------------------------------------------------------
df <- data.frame(x = 1:3, y = 3:1)

mutate(df, x1 = x+1)

mutate(df, x = x+1)

mutate(df, x = x+1, y = x+1)

mutate(df, x1 = x+1, y1 = x1+1)

mutate(df, y1 = x+1, x1 = x+1)

mutate(df, xx = x)

## ----mutate_2------------------------------------------------------------
# generate a variable indicating the total number of times each person has been contacted 
# during this campaign and during the previous ones 
mutate(bank, contacts_n = campaign + previous)

## ----mutate_col_just_created---------------------------------------------
# generate two variable: one indicating the year of birth and one the year of birth without century 
bank %>% mutate(year_of_birth = year - age, year_of_birth_no_century = year_of_birth - 1900)

## ----summarise-----------------------------------------------------------
# Compute the mean of balance variable of bank data frame
bank %>% summarise(mean_balance = mean(balance, na.rm = TRUE))
# Compute the minimum and the maximum value of balance of bank data frame
bank %>% summarise(max_balance = max(balance, na.rm = TRUE), min_balance = min(balance, na.rm = TRUE))

