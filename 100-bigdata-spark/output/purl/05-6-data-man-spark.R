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
library(DBI)

new_spark_table_detail <- dbGetQuery(sc, "SELECT Year, Month, DayofMonth, DepTime, ArrTime, DepDelay, ArrDelay, TailNum, FlightNum from year2008 LIMIT 5")
new_spark_table_detail
sql_render(spark_table_detail)

class(spark_table_detail)
class(new_spark_table_detail)


## ------------------------------------------------------------------------
get_info <- function(tbl) {
	print(sql_render(tbl))
}

## ------------------------------------------------------------------------

get_info(spark_table)

spark_table_detail_2 <-
    spark_table %>%
    select(Year, DepTime, ArrTime, DepDelay, ArrDelay, TailNum, FlightNum, Distance )
get_info(spark_table_detail_2)

step1 <-
	spark_table_detail_2 %>%
	filter( ! TailNum == "" ) %>%
	arrange( FlightNum, TailNum  )

get_info(step1)

step2 <- 
	step1 %>%
	group_by(TailNum) %>%
	summarise(count = n(), dist = mean(Distance), delay = mean(ArrDelay)) %>%
	filter(count > 20, dist < 2000, !is.na(delay)) 

get_info(step2)

## ------------------------------------------------------------------------
collect(step2)

## ------------------------------------------------------------------------
step3 <- 
	step1 %>%
	group_by(TailNum, FlightNum, Year) %>%
	summarise(count = n(), dist = mean(Distance), delay = mean(ArrDelay)) %>%
	filter(count > 10, dist < 8000, !is.na(delay))

collect(step2)
collect(step3)

## ------------------------------------------------------------------------
computed_step1 <- compute(step1, "step1_sdf")

get_info(step1)
get_info(computed_step1)


## ------------------------------------------------------------------------
optimized_step2 <- 
	computed_step1 %>%
	group_by(TailNum) %>%
	summarise(count = n(), dist = mean(Distance), delay = mean(ArrDelay)) %>%
	filter(count > 20, dist < 2000, !is.na(delay)) 

get_info(optimized_step2)

optimized_step3 <- 
	computed_step1 %>%
	group_by(TailNum, FlightNum, Year) %>%
	summarise(count = n(), dist = mean(Distance), delay = mean(ArrDelay)) %>%
	filter(count > 10, dist < 8000, !is.na(delay))

get_info(optimized_step3)

collect(step2)
collect(step3)

## ------------------------------------------------------------------------
spark_partial <- 	spark_table_detail %>%
		group_by( Year, FlightNum ) %>%
		summarize( avg = mean( ArrDelay ) ) %>%
		arrange( desc(avg) ) %>%
		compute(name = "spark_partial")

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


