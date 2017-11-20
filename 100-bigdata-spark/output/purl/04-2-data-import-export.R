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
require(dplyr)

# Examine structure of tibble
str(R_df)

# Examine structure of data
glimpse(spark_table)


## ------------------------------------------------------------------------
class(mtcars)

mtcars_spark <- copy_to(sc, df = mtcars, name = "mtcars")

class(mtcars_spark)

## ------------------------------------------------------------------------
src_tbls(sc)

## ------------------------------------------------------------------------
spark_sample <- sample_n(spark_table, size = 500)
class(spark_sample)

R_sample <- collect(spark_sample)
class(R_sample)

## ------------------------------------------------------------------------
format( object.size(spark_sample), units = "auto" )
format( object.size(R_sample), units = "auto" )

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

