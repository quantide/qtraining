## ------------------------------------------------------------------------
require(sparklyr)

### Cluster Version
Sys.setenv(SPARK_HOME = "/usr/lib/spark/")

sc <- spark_connect(master = "yarn-client", version = "1.6.0")
connection_is_open(sc)

spark_disconnect_all()


## ------------------------------------------------------------------------

csv_file <- "file:///data/2008.csv"

spark_table <- spark_read_csv(
  sc = sc,
  name = "year2008",
  path = csv_file
)

spark_table

## hdfs dfs -ls /user/hive/warehouse/sample_07/sample_07

## ------------------------------------------------------------------------
csv_file <- "hdfs:///user/hive/warehouse/sample_07/sample_07"

spark_table <- spark_read_csv(
  sc = sc,
  name = "year2008",
  path = csv_file, delimiter = "\t"
)

spark_table

## ------------------------------------------------------------------------
src_tbls(sc)

mtcars_d <- tbl(sc, "mtcars_d")
mtcars_d
class(mtcars_d)

## ------------------------------------------------------------------------
class(mtcars_d)
# do the caching
tbl_cache(sc, "mtcars_d")
# delete the cache
tbl_uncache(sc, "mtcars_d")

