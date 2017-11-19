## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(eval = FALSE)

## cd ~

## head -n 5 2008.csv

## 	

## ------------------------------------------------------------------------
ontime <- read.table(file = "~/data/ontime.csv", header = T, sep = ",", quote = "\"")

## head -n 30000 2008.csv > mini.csv

## ------------------------------------------------------------------------
csv_file <- "~/data/mini.csv"
R_df <- read.table(file = csv_file, header = T, sep = ",", quote = "\"")
R_df

## ----sparklyr installation-----------------------------------------------
install.packages("devtools")
devtools::install_github("rstudio/sparklyr")

## ----require-sparklyr----------------------------------------------------
require(sparklyr)

## ------------------------------------------------------------------------
spark_install(version = "2.0.0")

## ------------------------------------------------------------------------
sc <- spark_connect( master = "local", version = "2.0.0" )

## ------------------------------------------------------------------------
spark_version(sc)

## ------------------------------------------------------------------------
spark_disconnect(sc)

## ------------------------------------------------------------------------

csv_file <- "/data/2008.csv"

spark_table <- spark_read_csv(
  sc = sc,
  name = "year2008",
  path = csv_file
)

spark_table

## ------------------------------------------------------------------------
R_df <- read.table(file = csv_file, header = T, sep = ",", quote = "\"")
R_df <- tbl_df( R_df )
R_df

format( object.size(R_df), units = "auto" )
format( object.size(spark_table), units = "auto" )


## ------------------------------------------------------------------------
# Examine structure of tibble
str(R_df)

# Examine structure of data
glimpse(spark_table)


## ------------------------------------------------------------------------
require(dplyr)

colnames(spark_table)

## or

tbl_vars(spark_table)

 ## we are interested only in some columns, for example
spark_table_detail <-
    spark_table %>%
    select(Year, Month, DayofMonth, DepTime, ArrTime, DepDelay, ArrDelay, TailNum, FlightNum )
spark_table_detail

spark_table_detail %>%
    filter( ! TailNum == "" ) %>%
    arrange( FlightNum, TailNum  )

spark_table_detail %>%
    group_by( Year, FlightNum ) %>%
    summarize( avg = mean( ArrDelay ) ) %>%
    arrange( desc(avg) )


## ------------------------------------------------------------------------
spark_table_detail %>%
    group_by( Year, FlightNum ) %>%
    mutate( ArrDelay = as.integer( ArrDelay ) ) %>%   # cast 
    summarize( avg = mean( ArrDelay ) ) %>%
    arrange( desc(avg) )


## ------------------------------------------------------------------------
spark_table_1 <-
    spark_table_detail %>%
    mutate(
        DepDelay = as.integer(DepDelay) ,
        ArrDelay = as.integer(ArrDelay) ) %>% # cast
    select(                             # only a column sorting
        ArrDelay,
        DepDelay,
        everything() )
spark_table_1

## ------------------------------------------------------------------------
 ## Collect some data
delay <-
    spark_table %>% 
    group_by(TailNum) %>%
    summarise(count = n(), dist = mean(Distance), delay = mean(ArrDelay)) %>%
    filter(count > 20, dist < 2000, !is.na(delay)) %>%
    collect()

 ## Plot delays
library(ggplot2)
ggplot(delay, aes(dist, delay)) +
  geom_point(aes(size = count), alpha = 1/2) 

## ------------------------------------------------------------------------
library(DBI)

new_spark_table_detail <- dbGetQuery(sc, "SELECT Year, Month, DayofMonth, DepTime, ArrTime, DepDelay, ArrDelay, TailNum, FlightNum from year2008 LIMIT 5")
new_spark_table_detail
sql_render(spark_table_detail)

class(spark_table_detail)
class(new_spark_table_detail)


## ------------------------------------------------------------------------
mini_spark_table <- 
  head(spark_table, n=10)

out_csv_dir <- "/home/cloudera/data/mini_spark_table"

if (dir.exists(out_csv_dir))
  unlink(out_csv_dir, recursive = TRUE)

spark_write_csv(x = mini_spark_table, path = out_csv_dir)

if (dir.exists(out_csv_dir))
  unlink(out_csv_dir, recursive = TRUE)

spark_write_csv(x = spark_table, path = out_csv_dir )

## ------------------------------------------------------------------------
spark_read_tbl <- spark_read_csv(sc = sc, 'read', path = out_csv_dir, header = T )

class(spark_read_tbl)

## ------------------------------------------------------------------------
src_tbls(sc) 

dim( spark_table )
dim( collect(spark_table) )

## ----set spark-home------------------------------------------------------
Sys.setenv( SPARK_HOME = "/usr/local/spark")
Sys.getenv("SPARK_HOME")

## ------------------------------------------------------------------------
spark_install(version = "2.0.0", hadoop_version = "2.6")


## ------------------------------------------------------------------------
Sys.setenv( SPARK_HOME = "~/.cache/spark/spark-2.0.0-bin-hadoop2.6/")
sc <- spark_connect(master = "yarn", version = "2.0.0" )

## ------------------------------------------------------------------------
spark_partial <- 	spark_table_detail %>%
		group_by( Year, FlightNum ) %>%
		summarize( avg = mean( ArrDelay ) ) %>%
		arrange( desc(avg) ) %>%
		compute(name = "spark_partial")

tmp <- collect(spark_partial)
tmp
library(microbenchmark)
microbenchmark({
	tmp_1 <- 
		spark_table_detail %>%
		group_by( Year, FlightNum ) %>%
		summarize( avg = mean( ArrDelay ) ) %>%
		arrange( desc(avg) ) %>%
		compute()
},{
	tmp_2 <- 
		spark_table_detail %>%
		group_by( Year, FlightNum ) %>%
		summarize( avg = mean( ArrDelay ) ) %>%
		arrange( desc(avg) ) %>%
		collect()
},{
	tmp_3 <- collect(spark_partial)
},{
	tmp_4 <- 
		R_df %>%
		group_by( Year, FlightNum ) %>%
		summarize( avg = mean( ArrDelay ) ) %>%
		arrange( desc(avg) ) %>%
		collect()
}, times = 10)

 ## todo
tmp_1
tmp_2
identical(tmp_2, tmp_3)

tmp_3 %>% ungroup() %>% summarise_all(funs(n(), mean, sd))
tmp_4 %>% ungroup() %>% summarise_all(funs(n(), mean, sd))
class(tmp_3)


## ------------------------------------------------------------------------
spark_web(sc)
spark_log(sc)

## ------------------------------------------------------------------------
spark_config(file = "config.yml", use_default = TRUE)

