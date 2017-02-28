## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
require(tidyverse) # alternatively: require(dplyr)

## ---- eval = FALSE-------------------------------------------------------
## install.packages("sparklyr")

## ------------------------------------------------------------------------
require(sparklyr)

## ---- eval = FALSE-------------------------------------------------------
## # this may take a while
## spark_install(version = "1.6.2")

## ---- eval = FALSE-------------------------------------------------------
## cd ~
## mkdir data			# create data dir
## cd data	  			# enter this dir
## wget http://stat-computing.org/dataexpo/2009/2006.csv.bz2 # download the data in the newly created directory
## wget http://stat-computing.org/dataexpo/2009/2007.csv.bz2 # download the data in the newly created directory
## wget http://stat-computing.org/dataexpo/2009/2008.csv.bz2 # download the data in the newly created directory
## bunzip2 *.csv.bz2 # unzip data on all downloaded years
## ls # shows what's in the folder

## ---- eval = FALSE-------------------------------------------------------
## # set configuration parameters
## config <- spark_config()
## config$`sparklyr.shell.driver-memory` <- "4G"
## config$`sparklyr.shell.executor-memory` <- "4G"
## config$`spark.yarn.executor.memoryOverhead` <- "1G"

## ---- eval = FALSE-------------------------------------------------------
## sc <- spark_connect(master = "local", config = config)

## ---- eval = FALSE-------------------------------------------------------
## csv_file <- 'file:///home/emanuela/ema/sp-data/*.csv'
## ontime_tbl <- spark_read_csv(sc = sc,
##                              'ontime_tbl' ,
##                              path = csv_file,
##                              header = TRUE, delimiter = ',')
## 

## ---- eval = FALSE-------------------------------------------------------
## ontime_tbl %>% summarise(n = n())

## ---- eval = FALSE-------------------------------------------------------
## ontime_tbl %>% head()

## ---- eval = FALSE-------------------------------------------------------
## ontime_tbl_detail <- ontime_tbl %>%
##   select(Year, Month, DayofMonth, DepTime, ArrTime, DepDelay, ArrDelay, TailNum, FlightNum ) %>%    # select columns
##   arrange(Year)             # sort by year
## 
## ontime_tbl_detail

## ---- eval = FALSE-------------------------------------------------------
## ontime_tbl_detail %>%
##   mutate( ArrDelay = as.integer(ArrDelay)) %>%
##   group_by(Year, FlightNum) %>%
##   summarize(avg = mean(ArrDelay), n = n()) %>%
##   arrange(desc(avg))

## ---- eval = FALSE-------------------------------------------------------
## ontime_tbl %>%
##     filter(Year == 2006, FlightNum == 9024) %>%
##     select(Origin, Dest, Distance)

## ---- eval = FALSE-------------------------------------------------------
## ontime_tbl_detail %>%
##     group_by(Year, FlightNum) %>%
##     summarize(avg = mean(ArrDelay), n = n(), quart1 = quantile(ArrDelay, 0.25), quart3 = quantile(ArrDelay, 0.75)) %>%
##     arrange(desc(n))

## ---- eval = FALSE-------------------------------------------------------
##  ## Collect some data
## delay <-
##     ontime_tbl %>%
##     group_by(TailNum) %>%
##     summarise(count = n(), dist = mean(Distance), delay = mean(ArrDelay)) %>%
##     filter(count > 20, dist < 2000, !is.na(delay)) %>%
##     collect()
## 
##  ## Plot delays
## require(ggplot2)
## ggplot(delay, aes(dist, delay)) +
##   geom_point(aes(size = count), alpha = 1/2)

## ---- eval = FALSE-------------------------------------------------------
## spark_disconnect(sc)

