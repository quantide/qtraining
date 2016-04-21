## ---- read.table---------------------------------------------------------
df = read.table("/home/veronica/dev/qtraining/010-rbase/data/noR/tennis.txt", header = TRUE, sep = "", dec = ".")
head(df)

## ---- read.table2, eval=FALSE--------------------------------------------
## df = read.table("noR/tennis.txt", head = TRUE)
## df = read.table("noR\\tennis.txt", head = TRUE)

## ---- nrows1-------------------------------------------------------------
read.table("noR/tennis.txt", header = TRUE, sep = "", dec = ".", nrows = 3)

## ---- nrows2-------------------------------------------------------------
read.table("noR/tennis.txt", header = FALSE, sep = "", dec = ".", skip = 2)

## ---- nrows3-------------------------------------------------------------
read.table("noR/tennis.txt", header = FALSE, sep = "", dec = ".", nrows = 2, skip = 2)

## ---- stringsAsFactors---------------------------------------------------
df = read.table("noR/tennis.txt", header = TRUE, sep = "", dec = ".", stringsAsFactors = FALSE)
head(df)

## ---- na.strings---------------------------------------------------------
df = read.table("noR/tennis.NA.txt", header = TRUE, sep = "", dec = ".", na.strings = c("MC", "ND"), stringsAsFactors = FALSE)
head(df)

## ---- write.table, eval = FALSE------------------------------------------
## # It creates a dfWrite.txt file in the current directory
## df = data.frame(a1 = rnorm(10), a2 = rnorm(10), a3 = rnorm(10))
## write.table(df, file = "dfWrite.txt")

## ---- RODBCsqlFetch, eval=FALSE------------------------------------------
## # RODBC driver ought be configured to work properly
## library("RODBC")
## conn = odbcConnectExcel("dataManual/dat/weight.xls")
## sqlTables(conn)$TABLE_NAME
## df = sqlFetch(conn, "Sheet1")
## head(df)
## close(conn)

## ---- RODBCsqlQuery, eval=FALSE------------------------------------------
## # RODBC driver ought be configured to work properly
## library(RODBC)
## conn = odbcConnect(dsn = "test", uid = "user", pwd = "pass")
## sqlQuery(conn, "select * from tbl where gender = 'F'")
## odbcClose(conn)

## ---- save1, eval=FALSE--------------------------------------------------
## # It creates a mtcars.Rda file in the current directory
## save(mtcars, file = "mtcars.Rda")

## ---- save2, eval=FALSE--------------------------------------------------
## # It creates a datasets.Rda file in the current directory
## save(mtcars, iris, file = "datasets.Rda")

## ---- save3, eval=FALSE--------------------------------------------------
## # It creates a datasets.Rda file in the current directory
## datalist = c("mtcars", "iris")
## save(list = datalist, file = "datasets.Rda")

## ---- load, eval=FALSE---------------------------------------------------
## # It reads the datasets.Rda file previously created in the current directory
## load("datasets.Rda")

## ---- history, eval=FALSE------------------------------------------------
## # It saves and loads command history files
## savehistory("hist.Rhistory")
## loadhistory("hist.Rhistory")

## ---- source, eval=FALSE-------------------------------------------------
## # It reads the script.R file in the current directory
## source("script.R")

