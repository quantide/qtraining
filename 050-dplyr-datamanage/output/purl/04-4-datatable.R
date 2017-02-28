## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
# load packages
require(tidyverse) # alternatively: require(dplyr); require(ggplot2)
require(data.table)  

## ------------------------------------------------------------------------
data2006 <- fread("file:///home/emanuela/ema/sp-data/2006.csv")
is.data.table(data2006)    # imports in data.table format
data2006     # prints first 5 and last 5 rows

## ------------------------------------------------------------------------
system.time(fread("file:///home/emanuela/ema/sp-data/2006.csv"))

## ----example dplyr-------------------------------------------------------
system.time(read_csv("/home/emanuela/ema/sp-data/2006.csv"))

## ------------------------------------------------------------------------
# with data.table
system.time(data2006[, mean(ArrDelay, na.rm = TRUE), keyby = Month])

# with dplyr
system.time(data2006 %>% 
              group_by(Month) %>% 
              summarise(mean(ArrDelay, na.rm = TRUE)))

## ------------------------------------------------------------------------
# with data.table
system.time(
  data2006[, list(mean(ArrDelay, na.rm = TRUE), sd(ArrDelay, na.rm=TRUE)), keyby = Month]
  )

# with dplyr
system.time( 
  data2006 %>% 
    group_by(Month) %>% 
    summarise_each(funs(mean(., na.rm = TRUE), sd(., na.rm = TRUE)), ArrDelay)
  )

## ------------------------------------------------------------------------
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

