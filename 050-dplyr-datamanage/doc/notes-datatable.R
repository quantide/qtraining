# data.table: some trials and notes

# 1) importa as data.table and compare the performance of the data.table syntax
# as compared to dplyr syntax

# load packages
require(tidyverse) 
require(data.table) 
require(microbenchmark)
require(dtplyr)

# data.table
data2006 <- fread("~/data/2006.csv")
is.data.table(data2006)    
data2006     # prints first 5 and last 5 rows

system.time(fread("~/data/2006.csv"))

# dplyr
data2006_tbl <- read_csv("~/data/2006.csv")
system.time(read_csv("~/data/2006.csv"))

# tbl_dt
data2006_tbl_dt <- tbl_dt(data2006)


# with data.table
system.time(data2006[, mean(ArrDelay, na.rm = TRUE), keyby = Month])

# with dplyr
microbenchmark(system.time(data2006 %>% 
              group_by(Month) %>% 
              summarise(mean(ArrDelay, na.rm = TRUE))), times= 10)

microbenchmark(system.time(data2006_tbl %>% 
                             group_by(Month) %>% 
                             summarise(mean(ArrDelay, na.rm = TRUE))), times= 10)

microbenchmark(system.time(data2006_tbl_dt %>% 
                             group_by(Month) %>% 
                             summarise(mean(ArrDelay, na.rm = TRUE))), times= 10)

# with data.table
microbenchmark(system.time(
  data2006[, list(mean(ArrDelay, na.rm = TRUE), sd(ArrDelay, na.rm=TRUE)), keyby = Month]
), times = 10)

# with dplyr
system.time( 
  data2006 %>% 
    group_by(Month) %>% 
    summarise_each(funs(mean(., na.rm = TRUE), sd(., na.rm = TRUE)), ArrDelay)
)

# with data.table
system.time(
  data2006[, list(mean(ArrDelay, na.rm = TRUE), sd(ArrDelay, na.rm=TRUE),
                  mean(Distance, na.rm = TRUE), sd(Distance, na.rm=TRUE)), keyby = Month]
)

# with dplyr
system.time( 
  data2006 %>% 
    group_by(Month) %>% 
    summarise_at(vars(ArrDelay, Distance), funs(mean(., na.rm = TRUE), sd(., na.rm = TRUE)))
)



# 2) import as data.table and then as tibble and then compare speed of
# dplyr syntax on data.table and on tibble

# how long does dplyr syntax take on data.table? how long on tibbles?
# moreover use benchmark for performance evaluation

require(rbenchmark)

data2006_tbl <- read_csv("~/data/2006.csv")
data2006_dt <- fread("~/data/2006.csv")

system.time(data2006_tbl %>% 
              group_by(Month) %>% 
              summarise(mean(ArrDelay, na.rm = TRUE)))

system.time(data2006_dt %>% 
              group_by(Month) %>% 
              summarise(mean(ArrDelay, na.rm = TRUE)))

benchmark(replications= 10, columns = c("elapsed"), data2006_tbl %>% 
            group_by(Month) %>% 
            summarise(mean(ArrDelay, na.rm = TRUE)))

benchmark(replications= 10, columns = c("elapsed"), data2006_dt %>% 
            group_by(Month) %>% 
            summarise(mean(ArrDelay, na.rm = TRUE)))

# it seems that tibbles are faster than data.table!



##############################################


data2006 <- fread("~/data/2006.csv")

data2006 %>% select(Year)

library(dplyr, warn.conflicts = FALSE)

require("nycflights13")
require("microbenchmark")

microbenchmark(data2006[, list(mean(ArrDelay, na.rm = TRUE), sd(ArrDelay, na.rm=TRUE)), keyby = Month],
    times = 20)

data2006 <- tbl_dt(data2006)
microbenchmark(data2006 %>% 
                   group_by(Month) %>% 
                   summarise_each(funs(mean(., na.rm = TRUE), sd(., na.rm = TRUE)), ArrDelay),
               times = 20
)



