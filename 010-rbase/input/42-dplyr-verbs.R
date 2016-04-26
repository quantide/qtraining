## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
require(dplyr)
require(lubridate)
require(qdata)
data(bank) 
bank <-  tbl_df(bank)

## ----bank----------------------------------------------------------------
select(bank, year, month, day)
select(bank, year:day)
select(bank, -(year:day))

## ------------------------------------------------------------------------
select(bank, ID = id)

## ------------------------------------------------------------------------
select(bank, contains("at"))

## ------------------------------------------------------------------------
select(bank, ends_with("tion"))

## ------------------------------------------------------------------------
select(bank, starts_with("d"))

## ------------------------------------------------------------------------
select(bank, everything())
# change the order of columns
select(bank, ends_with("tion"), everything() ) 

## ------------------------------------------------------------------------
# match all variables containing "r", but not at the first place
select(bank, matches(".r")) 

## ------------------------------------------------------------------------
data(tennis)
wimbledon
select(wimbledon ,num_range("s", c(1:3, 5)))

## ------------------------------------------------------------------------
select(bank, one_of(c("marital","education")))
vars <- c("marital","education")
select(bank, one_of(vars))

## ------------------------------------------------------------------------
select(bank, job:balance)

## ------------------------------------------------------------------------
select(bank, -job)
select(bank, -starts_with("d"))

## ------------------------------------------------------------------------
distinct(select(bank, housing))
distinct(select(bank, housing, loan))

## ------------------------------------------------------------------------
rename(bank, ID = id)

## ------------------------------------------------------------------------
filter(bank, job == "student", balance > 20000)

## ------------------------------------------------------------------------
filter(bank, job == "student", as.character(date) == "2008-05-05")
filter(bank, job == "student", date == ymd("2008-05-05"))

## ------------------------------------------------------------------------
filter(bank, age == 18 & job == "student")

## ------------------------------------------------------------------------
filter(bank, age == 18 | age == 95)

## ------------------------------------------------------------------------
filter(bank, age %in% c(18,95))

## ------------------------------------------------------------------------
filter(bank, job %in% c("admin.","technician"))
filter(bank, job == "admin." | job == "technician")

## ------------------------------------------------------------------------
slice(bank, 1:5)

## ------------------------------------------------------------------------
slice(bank, n()) 

## ------------------------------------------------------------------------
sample_n(bank, 3)

## ------------------------------------------------------------------------
sample_frac(bank, 0.0001)

## ------------------------------------------------------------------------
nrow(mtcars)
nrow(sample_frac(mtcars, size = 2, replace = TRUE))
nrow(sample_n(mtcars, size = 40, replace = TRUE))

## ------------------------------------------------------------------------
sample_n(mtcars, 5, weight = mpg)

## ------------------------------------------------------------------------
arrange(bank, balance)

## ------------------------------------------------------------------------
arrange(bank, desc(balance))

## ------------------------------------------------------------------------
arrange(bank, age , desc(balance))

## ------------------------------------------------------------------------
arrange(bank, age , desc(balance)) %>% 
  group_by(age) %>%
  filter(row_number() <= 3) %>%
  select(id, age, balance)

## ------------------------------------------------------------------------
df <- data.frame(x = 1:3, y = 3:1)

mutate(df, x1 = x+1)

mutate(df, x = x+1)

mutate(df, x = x+1, y = x+1)

mutate(df, x1 = x+1, y1 = x1+1)

mutate(df, y1 = x+1, x1 = x+1)

mutate(df, xx = x)

## ------------------------------------------------------------------------
bank <- tbl_df(bank)
bank %>% 
  select (year, age, balance) %>%
  mutate(balance_by_age = balance / age, year_of_birth = year - age)

## ------------------------------------------------------------------------
mutate(bank, year_of_birth = year - age, year_of_birth_no_century = year_of_birth - 1900)

## ---- error=TRUE---------------------------------------------------------
transform(bank, year_of_birth = year - age, year_of_birth_no_century = year_of_birth - 1900)

## ------------------------------------------------------------------------
transmute(bank, year_of_birth = year - age, year_of_birth_no_century = year_of_birth - 1900)

## ------------------------------------------------------------------------
time <- select(bank, duration)
mutate(time, lead_duration = lead(duration) ,delta_duration = lead_duration - duration)

## ------------------------------------------------------------------------
mutate(time, lag_duration = lag(duration) ,delta_duration = duration - lag_duration)

## ------------------------------------------------------------------------
mutate(time, duration_rank = min_rank(duration))

## ------------------------------------------------------------------------
mutate(time, duration_rank = dense_rank(duration))

## ------------------------------------------------------------------------
mutate(time, duration_rank = percent_rank(duration))

## ------------------------------------------------------------------------
mutate(time, duration_rank = row_number(duration))

## ------------------------------------------------------------------------
mutate(time, duration_rank = ntile(duration, 10))

## ------------------------------------------------------------------------
mutate(time, duration_rank = cume_dist(duration))

## ------------------------------------------------------------------------
mutate(time, duration_rank = between(duration, 0, 90))

## ------------------------------------------------------------------------
mutate(time, long_duration = cumall(duration > 100))

## ------------------------------------------------------------------------
mutate(time, short_duration = cumany(duration < 100))

## ------------------------------------------------------------------------
mutate(time, mean_duration = cummean(duration))

## ------------------------------------------------------------------------
summarise(bank, mean_balance = mean(balance, na.rm = TRUE))
summarise(bank, max_balance = max(balance, na.rm = TRUE), min_balance = min(balance, na.rm = TRUE))

## ------------------------------------------------------------------------
summarise(bank, first(job))

## ------------------------------------------------------------------------
summarise(bank, last(job))

## ------------------------------------------------------------------------
summarise(bank, nth(job,8))

## ------------------------------------------------------------------------
summarise(bank, n())

## ------------------------------------------------------------------------
summarise(bank, n_distinct(job))
summarise(bank, n_distinct(education))

