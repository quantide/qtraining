## ----read_table, error=TRUE----------------------------------------------
df <- read.table("C:/Users/UserName/Documents/data/tennis.txt", header = TRUE, sep = "", dec = ".")

## ----getwd, eval=FALSE---------------------------------------------------
## getwd()

## ----setwd, eval=FALSE---------------------------------------------------
## setwd("./data")

## ----read_table2---------------------------------------------------------
df <- read.table("tennis.txt", header = TRUE)

## ----head----------------------------------------------------------------
head(df)
str(df)

## ----sepdec--------------------------------------------------------------
df <- read.table("tennis.txt", header = TRUE, sep = "", dec = ".")
head(df)

## ----stringsAsFactors----------------------------------------------------
df <- read.table("tennis.txt", header = TRUE, sep = "", dec = ".", stringsAsFactors = FALSE)
str(df)

## ----require_readxl, message=FALSE---------------------------------------
require(readxl)

## ----excel_file_name_readxl----------------------------------------------
# Excel file (with path) to be loaded into R
file_xls <- "./xlsx/newFile.xlsx"

## ----load_xlsx_readxl----------------------------------------------------
ds <-read_excel(path = file_xls, sheet = 'Airquality', col_names = TRUE)
head(ds)

## ----RODBCsqlQuery, eval=FALSE-------------------------------------------
## # RODBC driver ought be configured to work properly
## require(RODBC)
## conn <- odbcConnect(dsn = "test", uid = "user", pwd = "pass")
## sqlQuery(conn, "select * from tbl where gender = 'F'")
## odbcClose(conn)

## ----require_pkg, message=FALSE------------------------------------------
require(RSQLite)

## ----con_db--------------------------------------------------------------
con <- dbConnect(RSQLite::SQLite(), "mtcars.sqlite")

## ----available_tables----------------------------------------------------
dbListTables(con)

## ----table_fields--------------------------------------------------------
dbListFields(con, "mtcars")

## ------------------------------------------------------------------------
dbReadTable(con, "mtcars")

## ----query---------------------------------------------------------------
dbGetQuery(con, "SELECT * FROM mtcars WHERE cyl = 4")

## ----disconnect_to_db_2--------------------------------------------------
dbDisconnect(con)

