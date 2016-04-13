## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples
require(dplyr)
require(ggplot2)

## ----message=FALSE-------------------------------------------------------
require(RSQLite)

## ------------------------------------------------------------------------
charset <- function (file){
  info <- system(paste("file -i" ,file ), intern = TRUE)
  info_split <- strsplit(info, split = "charset=")[[1]][2]
  info_split
}

## ------------------------------------------------------------------------
path <- "./"
db <- "ontime.sqlite"
path_db <- paste(path, db, sep = "/")
db_exists <- list.files(path, pattern = db)
if(length(db_exists) != 0) system(paste("rm", path_db))
con <- dbConnect(RSQLite::SQLite(), path_db)

## ------------------------------------------------------------------------
files <- list.files("./../data", pattern = ".csv", full.names = TRUE)

## ------------------------------------------------------------------------
for (i in 1:length(files)){
  head <- ifelse (i == 1, TRUE, FALSE)
  skip <- ifelse (i == 1, 0, 1)
  append <- ifelse (i == 1, FALSE, TRUE)
  this_file <- files[i]
  encoding <- charset(this_file)
  df <- read.table(this_file, sep = ",", head = head, encoding = encoding, skip = skip, nrows = 100)
  dbWriteTable(conn = con, name = "ontime", value = df ,append = append)
  cat(date() , this_file, "loaded", "\n")
  rm(df)
}  

## ------------------------------------------------------------------------
dbDisconnect(con)

## ------------------------------------------------------------------------
con_dplyr <- src_sqlite(path_db)
ontime <- tbl(con_dplyr, "ontime")
class(ontime)
dim(ontime)

## ------------------------------------------------------------------------
ontime_stat <- ontime %>% group_by(Year, Month) %>% 
   summarise(avg = mean(DepDelay), min = min(DepDelay), max = max(DepDelay)) 

## ------------------------------------------------------------------------
ontime_stat
class(ontime_stat)

## ------------------------------------------------------------------------
ontime_dep_delay <- ontime %>%
  select(year = Year, dep_delay = DepDelay, arr_delay = ArrDelay) %>%
  filter(dep_delay > 0) %>%
  collect()

## ------------------------------------------------------------------------
pl <- ggplot(ontime_dep_delay , aes(dep_delay, arr_delay))
pl <- pl + stat_binhex(bins = 30) + facet_wrap(~year, ncol = 2)
print(pl)

