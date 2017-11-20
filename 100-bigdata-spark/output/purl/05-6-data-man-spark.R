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

