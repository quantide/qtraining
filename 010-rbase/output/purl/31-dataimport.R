## ----date-requirePackages, echo=FALSE------------------------------------
# Install required packages
if(! "XLConnect" %in% installed.packages()) {install.packages("XLConnect")}
if(! "RSQLite" %in% installed.packages()) {install.packages("RSQLite")}
###################################################################

## ----read.table, error=TRUE----------------------------------------------
df = read.table("C:/Users/UserName/Documents/dati/tennis.txt", header = TRUE, sep = "", dec = ".")

## ---- getwd--------------------------------------------------------------
getwd() 

## ---- setwd, eval=FALSE--------------------------------------------------
## setwd("C:/Users/UserName/Documents")

## ---- read.table2--------------------------------------------------------
df = read.table("tennis.txt", header = TRUE)

## ---- head---------------------------------------------------------------
head(df)

## ---- nrows1-------------------------------------------------------------
read.table("tennis.txt", header = TRUE, sep = "", dec = ".", nrows = 3)

## ---- nrows2-------------------------------------------------------------
read.table("tennis.txt", header = FALSE, sep = "", dec = ".", skip = 2)

## ---- nrows3-------------------------------------------------------------
read.table("tennis.txt", header = FALSE, sep = "", dec = ".", nrows = 2, skip = 2)

## ---- stringsAsFactors---------------------------------------------------
df = read.table("tennis.txt", header = TRUE, sep = "", dec = ".", stringsAsFactors = FALSE)
head(df)

## ---- na.strings---------------------------------------------------------
df = read.table("tennis.NA.txt", header = TRUE, sep = "", dec = ".", na.strings = c("MC", "ND"), stringsAsFactors = FALSE)
head(df)

## ---- write.table, eval = FALSE------------------------------------------
## # It creates a dfWrite.txt file in the current directory
## df = data.frame(a1 = rnorm(10), a2 = rnorm(10), a3 = rnorm(10))
## write.table(df, file = "dfWrite.txt")

## ----use.text, comment=FALSE---------------------------------------------
require("XLConnect")

## ----outDir_set_up, eval=FALSE-------------------------------------------
## # Set up output directory and output file name
## outDir <- "/home/marco/Desktop/xlsx"

## ------------------------------------------------------------------------
fileXls <- paste(outDir,"newFile.xlsx",sep='/')
# Delete fileXls if it already exists 
unlink(fileXls, recursive = FALSE, force = FALSE)


## ----new.xlsx, comment=FALSE---------------------------------------------
exc <- loadWorkbook(filename = fileXls, create = TRUE)
createSheet(object = exc, name = 'Input')
saveWorkbook(exc)

## ----g1, echo=FALSE, fig.width=6-----------------------------------------
include_graphics("images/excel-emptySheet.png")

## ----add.input, comment=FALSE--------------------------------------------
df <- data.frame('inputType'=c('Day','Month'),'inputValue'=c(1,3))
writeWorksheet(object = exc, data = df, sheet = "Input", startRow = 1, startCol = 2)
saveWorkbook(exc)

## ----g2, echo=FALSE, fig.width=3-----------------------------------------
include_graphics("images/excel-inputSheet.png")

## ----add.airquality, comment=FALSE---------------------------------------
# Add a sheet named Airquality to exc object
createSheet(exc,'Airquality')
saveWorkbook(exc)

## ------------------------------------------------------------------------
# Add an empty column to airquality dataset before add it to 'Airquality' sheet
airquality$isCurrent<-NA
createName(exc, name='Airquality',formula='Airquality!$A$1')
writeNamedRegion(exc, airquality, name = 'Airquality', header = TRUE)
saveWorkbook(exc)

## ----g3, echo=FALSE, fig.width=3-----------------------------------------
include_graphics("images/excel-airqualitySheet.png")

## ----add.formula, comment=FALSE------------------------------------------
# Define the column index of the cell to edit
colIndex <- which(names(airquality) == 'isCurrent')
# Define the excel letter for the column 'Day' and 'Month' needed by the formula 
letterDay <- idx2col(which(names(airquality) == 'Day'))
letterMonth <- idx2col(which(names(airquality) == 'Month'))

## ----idx2col1 ,results='markup'------------------------------------------
letterDay <- idx2col(which(names(airquality) == 'Day'))

## ----idx2col2, echo=FALSE,results='markup'-------------------------------
cat('letterDay=',letterDay)

## ----apply_formula-------------------------------------------------------
# Define the formula to apply to the cell
formulaXls <- paste('IF(AND(',
                    letterMonth,
                    2:(nrow(airquality)+1),
                    '=Input!C3,',
                    letterDay,
                    2:(nrow(airquality)+1),
                    '=Input!C2)',
                    ',1,0)',sep='')
setCellFormula(exc, sheet='Airquality', row = 2:(nrow(airquality)+1), col = colIndex, formula = formulaXls)
saveWorkbook(exc)

## ----g4, echo=FALSE, fig.width=4-----------------------------------------
include_graphics("images/excel-addFormula.png")

## ----load.xlsx, comment=FALSE--------------------------------------------
exc2 <- loadWorkbook(fileXls)
dtAir <- readWorksheet(exc2, 'Airquality')

## ------------------------------------------------------------------------
createSheet(exc2, name = "OzonePlot")
createName(exc2, name='OzonePlot',formula='OzonePlot!$A$1')
saveWorkbook(exc2)

## ----add.plot, comment=FALSE,warning=FALSE-------------------------------
require(ggplot2)
# Generate a graph and save it in png format
fileGraph <- paste(outDir,'graph.png',sep='/')
png(filename = fileGraph, width = 800, height = 600)
ozone_plot <- ggplot(dtAir, aes(x=Day, y=Ozone)) + 
geom_point() + 
geom_smooth()+
facet_wrap(~Month, nrow=1)
print(ozone_plot)
invisible(dev.off())
# Add image file created to 'OzonePlot' named region with its original size 
addImage(exc2, filename =  fileGraph, name = 'OzonePlot', originalSize = TRUE)
saveWorkbook(exc2)

## ----g5, echo=FALSE, fig.width=6-----------------------------------------
include_graphics("images/excel-ozonePlot.png")

## ---- message=FALSE------------------------------------------------------
require(RSQLite)

## ------------------------------------------------------------------------
con <- dbConnect(RSQLite::SQLite(), "mtcars.sqlite")

## ------------------------------------------------------------------------
dbWriteTable(con, "mtcars", mtcars)

## ------------------------------------------------------------------------
dbDisconnect(con)

## ------------------------------------------------------------------------
con <- dbConnect(RSQLite::SQLite(), "mtcars.sqlite")

## ------------------------------------------------------------------------
dbListTables(con)

## ------------------------------------------------------------------------
dbListFields(con, "mtcars")

## ------------------------------------------------------------------------
dbReadTable(con, "mtcars")

## ------------------------------------------------------------------------
dbGetQuery(con, "SELECT * FROM mtcars WHERE cyl = 4")

## ------------------------------------------------------------------------
dbDisconnect(con)

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

