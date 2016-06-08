## ----use.text, message=FALSE---------------------------------------------
require(XLConnect)

## ----outDir_set_up, eval=FALSE-------------------------------------------
## # Set up output directory and output file name
## outDir <- "./xlsx"

## ------------------------------------------------------------------------
# File path string
file_xls <- paste(outDir,"newFile.xlsx",sep='/')
# Delete file_xls if it already exists 
unlink(file_xls, recursive = FALSE, force = FALSE)

## ----new.xlsx, comment=FALSE---------------------------------------------
exc <- loadWorkbook(filename = file_xls, create = TRUE)
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
# Add airquality dataset to the sheet Airquality
createName(exc, name='Airquality',formula='Airquality!$A$1')
writeNamedRegion(exc, airquality, name = 'Airquality', header = TRUE)
saveWorkbook(exc)

## ----g3, echo=FALSE, fig.width=3-----------------------------------------
include_graphics("images/excel-airqualitySheet.png")

## ----add.formula, comment=FALSE------------------------------------------
# Define the column index of the cell to edit
col_index <- which(names(airquality) == 'isCurrent')
# Define the excel letter for the column 'Day' and 'Month' needed by the formula 
letter_day <- idx2col(which(names(airquality) == 'Day'))
letter_month <- idx2col(which(names(airquality) == 'Month'))

## ----idx2col1 ,results='markup'------------------------------------------
letter_day <- idx2col(which(names(airquality) == 'Day'))

## ----idx2col2, echo=FALSE,results='markup'-------------------------------
cat('letter_day=',letter_day)

## ----apply_formula-------------------------------------------------------
# Define the formula to apply to the cell
formula_xls <- paste('IF(AND(',
                    letter_month,
                    2:(nrow(airquality)+1),
                    '=Input!C3,',
                    letter_day,
                    2:(nrow(airquality)+1),
                    '=Input!C2)',
                    ',1,0)',sep='')
setCellFormula(exc, sheet='Airquality', row = 2:(nrow(airquality)+1), col = col_index, formula = formula_xls)
saveWorkbook(exc)

## ----g4, echo=FALSE, fig.width=4-----------------------------------------
include_graphics("images/excel-addFormula.png")

## ----excel_file_name, eval=FALSE-----------------------------------------
## # Excel file (with path) to be loaded into R
## file_xls <- "./xlsx/newFile.xlsx"

## ----load.xlsx-----------------------------------------------------------
exc2 <- loadWorkbook(file_xls)
dt_air <- readWorksheet(exc2, sheet = 'Airquality')
head(dt_air)

## ------------------------------------------------------------------------
createSheet(exc2, name = "OzonePlot")
createName(exc2, name='OzonePlot',formula='OzonePlot!$A$1')
saveWorkbook(exc2)

## ----add.plot, comment=FALSE,warning=FALSE, message=FALSE----------------
require(ggplot2)
# Generate a graph and save it in png format
fileGraph <- paste(outDir,'graph.png',sep='/')
png(filename = fileGraph, width = 800, height = 600)
ozone_plot <- ggplot(dt_air, aes(x=Day, y=Ozone)) + 
geom_point() + 
geom_smooth()+
facet_wrap(~Month, nrow=1)
print(ozone_plot)
invisible(dev.off())
# Add image file created to 'OzonePlot' named region with its original size 
addImage(exc2, filename =  fileGraph, name = 'OzonePlot', originalSize = TRUE)
saveWorkbook(exc2)
# Remove the graph file created 
file.remove(fileGraph)

## ----g5, echo=FALSE, fig.width=6-----------------------------------------
include_graphics("images/excel-ozonePlot.png")

