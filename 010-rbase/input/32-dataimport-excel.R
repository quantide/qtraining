## ----inst.text, eval=FALSE-----------------------------------------------
## install.packages("XLConnect")

## ----use.text, comment=FALSE---------------------------------------------
require("XLConnect")

## ----outDir_set_up, eval=FALSE-------------------------------------------
## # Set up output directory
## outDir <- "/home/marco/Desktop/xlsx"

## ----new.xlsx, comment=FALSE---------------------------------------------
fileXls <- paste(outDir,"newFile.xlsx",sep='/')
unlink(fileXls, recursive = FALSE, force = FALSE)
exc <- loadWorkbook(fileXls, create = TRUE)
createSheet(exc,'Input')
saveWorkbook(exc)

## ----g1, echo=FALSE, fig.width=6-----------------------------------------
include_graphics("images/excel-emptySheet.png")

## ----add.input, comment=FALSE--------------------------------------------
input <- data.frame('inputType'=c('Day','Month'),'inputValue'=c(1,3))
writeWorksheet(exc, input, sheet = "input", startRow = 1, startCol = 2)
saveWorkbook(exc)

## ----g2, echo=FALSE, fig.width=3-----------------------------------------
include_graphics("images/excel-inputSheet.png")

## ----chiedere, echo=FALSE------------------------------------------------
if (!require(reshape)){install.packages("reshape", repos = "http://cran.us.r-project.org")}

## ----add.airquality, comment=FALSE---------------------------------------
createSheet(exc,'Airquality')
airquality$isCurrent<-NA
createName(exc, name='Airquality',formula='Airquality!$A$1')
writeNamedRegion(exc, airquality, name = 'Airquality', header = TRUE)
saveWorkbook(exc)

## ----g3, echo=FALSE, fig.width=3-----------------------------------------
include_graphics("images/excel-airqualitySheet.png")

## ----add.formula, comment=FALSE------------------------------------------
colIndex <- which(names(airquality) == 'isCurrent')
letterDay <- idx2col(which(names(airquality) == 'Day'))
letterMonth <- idx2col(which(names(airquality) == 'Month'))
formulaXls <- paste('IF(AND(',
                    letterMonth,
                    2:(nrow(airquality)+1),
                    '=Input!C3,',
                    letterDay,
                    2:(nrow(airquality)+1),
                    '=Input!C2)',
                    ',1,0)',sep='')
setCellFormula(exc, sheet='Airquality',2:(nrow(airquality)+1),colIndex,formulaXls)
saveWorkbook(exc)

## ----idx2col1 ,results='markup'------------------------------------------
letterDay <- idx2col(which(names(airquality) == 'Day'))

## ----idx2col2, echo=FALSE,results='markup'-------------------------------
cat('letterDay=',letterDay)

## ----g4, echo=FALSE, fig.width=4-----------------------------------------
include_graphics("images/excel-addFormula.png")

## ----load.xlsx, comment=FALSE--------------------------------------------
exc2 <- loadWorkbook(fileXls, create = FALSE)
dtAir <- readWorksheet(exc2,'Airquality')
createSheet(exc2, name = "OzonePlot")
createName(exc2, name='OzonePlot',formula='OzonePlot!$A$1')
saveWorkbook(exc2)

## ----add.plot, comment=FALSE,warning=FALSE-------------------------------
require(ggplot2)
fileGraph <- paste(outDir,'graph.png',sep='/')
png(filename = fileGraph, width = 800, height = 600)
ozone.plot <- ggplot(dtAir, aes(x=Day, y=Ozone)) + 
geom_point() + 
geom_smooth()+
facet_wrap(~Month, nrow=1)
print(ozone.plot)
invisible(dev.off())
addImage(exc2,fileGraph, 'OzonePlot',TRUE)
saveWorkbook(exc2)

## ----g5, echo=FALSE, fig.width=6-----------------------------------------
include_graphics("images/excel-ozonePlot.png")

