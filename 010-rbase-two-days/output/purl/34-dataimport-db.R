## ---- RODBCsqlQuery, eval=FALSE------------------------------------------
## # RODBC driver ought be configured to work properly
## require(RODBC)
## conn = odbcConnect(dsn = "test", uid = "user", pwd = "pass")
## sqlQuery(conn, "select * from tbl where gender = 'F'")
## odbcClose(conn)

## ----require_pkg, message=FALSE------------------------------------------
require(RSQLite)

## ----connect_to_db-------------------------------------------------------
con <- dbConnect(RSQLite::SQLite(), "mtcars.sqlite")

## ----write_in_db---------------------------------------------------------
dbWriteTable(con, "mtcars", mtcars)

## ----disconnect_to_db----------------------------------------------------
dbDisconnect(con)

## ------------------------------------------------------------------------
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

