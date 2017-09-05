## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
# load packages
require(tidyverse)
require(data.table) 

## ------------------------------------------------------------------------
data2006 <- fread("~/data/2006.csv")
is.data.table(data2006)    

## ------------------------------------------------------------------------
data2006[, mean(ArrDelay, na.rm = TRUE), keyby = Month]

## ------------------------------------------------------------------------
data2006[, list(mean(ArrDelay, na.rm = TRUE), sd(ArrDelay, na.rm=TRUE)), keyby = Month]

## ------------------------------------------------------------------------
data2006[, list(mean(ArrDelay, na.rm = TRUE), sd(ArrDelay, na.rm=TRUE),
                  mean(Distance, na.rm = TRUE), sd(Distance, na.rm=TRUE)), keyby = Month]


## ---- message = FALSE----------------------------------------------------
require(dtplyr)
data2006_tbl_dt <- tbl_dt(data2006)

microbenchmark::microbenchmark(
datatable_dplyr = data2006_tbl_dt %>% 
    group_by(Month) %>% 
    summarise(m_Arrdelay = mean(ArrDelay, na.rm = TRUE), 
              m_Distance = mean(Distance, na.rm = TRUE), 
              sd_ArrDelay = sd(ArrDelay, na.rm = TRUE), 
              sd_Distance = sd(Distance, na.rm = TRUE)),
datatable = data2006[, list(mean(ArrDelay, na.rm = TRUE), sd(ArrDelay, na.rm=TRUE),
                  mean(Distance, na.rm = TRUE), sd(Distance, na.rm=TRUE)), keyby = Month],
times = 20
)


