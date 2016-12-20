## ----require_dplyr, message=FALSE----------------------------------------
require(dplyr)

## ----bank_tbl_df, message=FALSE------------------------------------------
require(qdata)
data(bank) 
bank

## ----pipe1---------------------------------------------------------------
head(bank)

## ----pipe2---------------------------------------------------------------
bank %>% head()

## ----pipe3---------------------------------------------------------------
bank %>% head(n=10)

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
# filter all calls made to students with balance above 20,000 in bank data frame
filter(bank, job == "student", balance > 20000)

## ----filter2-------------------------------------------------------------
# Filter all calls made to student of 18 years in bank data frame
bank %>% filter(age == 18 & job == "student")

## ----filter3-------------------------------------------------------------
# Filter all calls made to people of 18 or 95 years in bank data frame
bank %>% filter(age == 18 | age == 95)

## ----filter4-------------------------------------------------------------
# Filter all calls made to people of 18 or 95 years in bank data frame
bank %>% filter(age %in% c(18,95))
# Filter all calls made to people whose job is admin. or technician in bank data frame
bank %>% filter(job %in% c("admin.","technician"))
# Filter all calls made to people whose job is admin. or technician in bank data frame
bank %>% filter(job == "admin." | job == "technician")

## ----arrange1------------------------------------------------------------
# Order `bank` data frame by the balance of the account in ascending order
arrange(bank, balance)

## ----arrange2------------------------------------------------------------
# Order `bank` data frame by the balance of the account in descending order
bank %>% arrange(desc(balance))

## ----arrange3------------------------------------------------------------
# Order `bank` data frame by age of the client and by the balance of the account in descending order
bank %>% arrange(age, desc(balance))

## ----mutate--------------------------------------------------------------
# generate a variable indicating the total number of times each person has been contacted 
# during this campaign and during the previous ones 
mutate(bank, contacts_n = campaign + previous)

## ----mutate_col_just_created---------------------------------------------
# generate two variable: one indicating the year of birth and one the year of birth without century 
bank %>% mutate(year_of_birth = year - age, year_of_birth_no_century = year_of_birth - 1900)

## ------------------------------------------------------------------------
df1 <- data.frame(id = 1:4, x1 = letters[1:4])
df1
df2 <- data.frame(id = 3:5, x2 = letters[3:5])
df2

## ------------------------------------------------------------------------
inner_join(df1, df2)

## ------------------------------------------------------------------------
left_join(df1, df2)

## ------------------------------------------------------------------------
right_join(df1, df2)
left_join(df2, df1)

## ------------------------------------------------------------------------
full_join(df1, df2)

