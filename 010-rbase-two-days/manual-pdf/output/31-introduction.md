


# Introduction to Data Import and Export


\includegraphics[width=2.94in]{images/flow-robj} 


In the following chapters we will explore data import and export methods for:

* Text files
* Microsoft Excel files
* Databases
* R data files

## Text Files


\includegraphics[width=5.52in]{images/import-text-2} 

### Data Import 

The `read.table()` function imports a text file (ASCII) with a table structure where each row represents a case.

A full path can be provided, but it must be modified by each user, otherwise it fails:

```r
df <- read.table("C:/Users/UserName/Documents/data/tennis.txt", header = TRUE, sep = "", dec = ".")
```

```
## Warning in file(file, "rt"): cannot open file 'C:/Users/UserName/Documents/data/tennis.txt': No such file or
## directory
```

```
## Error in file(file, "rt"): cannot open the connection
```

The path uses the slash ("`/`") as delimiting character, in the UNIX-like style. Under Windows, can be used both a slash character or a doubled backslash character ("`\\`").

So, it is strongly suggested to set the working directory to the directory containing the data.  

`getwd()` function allows you to view the current working directory:


```r
getwd() 
```

```
## [1] "C:/Users/Andrea/Documents"
```

and `setwd()` function allows you to set the working directory on "data" folder, in this way:    


```r
setwd("./data") 
```

```
## [1] "C:/Users/Andrea/Documents/data"
```

Now, the the text file can be imported just providing its filename: 


```r
df <- read.table("tennis.txt", header = TRUE)
```


```r
head(df)
```

```
##         Name First.Name Age Sex Rank Slams Won Lost Earnings Citizen
## 1    Sampras       Pete  23   M    1     2  74   11 3607.812      US
## 2     Agassi      Andre  24   M    2     1  51   13 1941.667      US
## 3     Becker      Boris  27   M    3     0  48   16 2029.756 Germany
## 4   Bruguera      Sergi  24   M    4     1  65   23 3031.874   Spain
## 5 Ivanisevic      Goran  23   M    5     0  63   26 2060.278 Croatia
## 6       Graf     Steffi  25   F    1     1  58    6 1487.980 Germany
```

The `header = TRUE` option tells R that the first row of the file contains column headings and it is used to assign the name of variables. If the first row contains the first case the `header = FALSE` ought to be used and the names of the variables are automatically assigned. R assumes a default value for the `header` parameter according to the file format, which is why specifying the correct option is advisable.  Alternatively, the names of the columns can be specified using the `col.names` parameter. This parameter requires a character vector with the same length as the number of the data frame columns.

The `sep` argument specifies the separator between different cases. The default value for the `read.table()` function is `sep = ""` which takes into consideration the fields delimited by a white space, be it one or more spaces or tabulations.

The `dec` argument specifies the decimal separator. The argument usually assumes the `dec = "."`  (default) or `dec = ","` values.

The `nrows` argument specifies the maximum number of rows to read in.


```r
read.table("tennis.txt", header = TRUE, sep = "", dec = ".", nrows = 3)
```

```
##      Name First.Name Age Sex Rank Slams Won Lost Earnings Citizen
## 1 Sampras       Pete  23   M    1     2  74   11 3607.812      US
## 2  Agassi      Andre  24   M    2     1  51   13 1941.667      US
## 3  Becker      Boris  27   M    3     0  48   16 2029.756 Germany
```

The `skip` argument specifies the number of lines of the data file to skip before beginning to read data. If the first line contains the header and it is ignored, than `header = FALSE` should be set.


```r
read.table("tennis.txt", header = FALSE, sep = "", dec = ".", skip = 2)
```

```
##                V1       V2 V3 V4 V5 V6 V7 V8       V9            V10
## 1          Agassi    Andre 24  M  2  1 51 13 1941.667             US
## 2          Becker    Boris 27  M  3  0 48 16 2029.756        Germany
## 3        Bruguera    Sergi 24  M  4  1 65 23 3031.874          Spain
## 4      Ivanisevic    Goran 23  M  5  0 63 26 2060.278        Croatia
## 5            Graf   Steffi 25  F  1  1 58  6 1487.980        Germany
## 6 Sanchez Vicario  Arantxa 23  F  2  2 74  9 2943.665          Spain
## 7        Martinez Conchita 22  F  3  1 55 15 1540.167          Spain
## 8         Novotna     Jana 26  F  4  0 43 11  876.119 Czech Republic
## 9          Pierce     Mary 20  F  5  0 45 18  768.614         France
```

The `nrows` and `skip` arguments can be mixed. The following example read the second and the third rows of the data frame.


```r
read.table("tennis.txt", header = FALSE, sep = "", dec = ".", nrows = 2, skip = 2)
```

```
##       V1    V2 V3 V4 V5 V6 V7 V8       V9     V10
## 1 Agassi Andre 24  M  2  1 51 13 1941.667      US
## 2 Becker Boris 27  M  3  0 48 16 2029.756 Germany
```

Variables containing text are set as character variables with the `stringsAsFactors = FALSE` option, whereas by default they are set as factors. This setting can be modified with the "global" option for it to be applied until the end of the work session. This can be done with the `options(stringsAsFactors = FALSE)` instruction.


```r
df <- read.table("tennis.txt", header = TRUE, sep = "", dec = ".", stringsAsFactors = FALSE)
head(df)
```

```
##         Name First.Name Age Sex Rank Slams Won Lost Earnings Citizen
## 1    Sampras       Pete  23   M    1     2  74   11 3607.812      US
## 2     Agassi      Andre  24   M    2     1  51   13 1941.667      US
## 3     Becker      Boris  27   M    3     0  48   16 2029.756 Germany
## 4   Bruguera      Sergi  24   M    4     1  65   23 3031.874   Spain
## 5 Ivanisevic      Goran  23   M    5     0  63   26 2060.278 Croatia
## 6       Graf     Steffi  25   F    1     1  58    6 1487.980 Germany
```

When there are missing values the `na.strings` can be used to indicate which string is referred to them. The `na.string` argument can be a character vector. R indicates missing values with the `NA` (Not Available) symbol.


```r
# Data frame imported without na.strings parameter 
df <- read.table("tennis.NA.txt", header = TRUE, sep = "", dec = ".", stringsAsFactors = FALSE)
head(df)
```

```
##         Name First.Name Age Sex Rank Slams Won Lost Earnings Citizen
## 1    Sampras       Pete  23   M    1     2  74   11 3607.812      US
## 2     Agassi      Andre  24   M    2     1  51   13 1941.667      US
## 3     Becker      Boris  MC   M    3     0  48   16 2029.756 Germany
## 4   Bruguera      Sergi  24   M    4     1  65   23 3031.874   Spain
## 5 Ivanisevic      Goran  ND   M    5     0  63   26 2060.278 Croatia
## 6       Graf     Steffi  25   F    1     1  58    6 1487.980 Germany
```

```r
# Data frame imported considering also na.strings parameter
df <- read.table("tennis.NA.txt", header = TRUE, sep = "", dec = ".", na.strings = c("MC", "ND"), stringsAsFactors = FALSE)
head(df)
```

```
##         Name First.Name Age Sex Rank Slams Won Lost Earnings Citizen
## 1    Sampras       Pete  23   M    1     2  74   11 3607.812      US
## 2     Agassi      Andre  24   M    2     1  51   13 1941.667      US
## 3     Becker      Boris  NA   M    3     0  48   16 2029.756 Germany
## 4   Bruguera      Sergi  24   M    4     1  65   23 3031.874   Spain
## 5 Ivanisevic      Goran  NA   M    5     0  63   26 2060.278 Croatia
## 6       Graf     Steffi  25   F    1     1  58    6 1487.980 Germany
```

### Data Export 

To save a data frame in a text file in R use the `write.table()` function.


```r
# It creates a df_write.txt file in the current directory containing df data frame
df <- data.frame(a1 = rnorm(10), a2 = rnorm(10), a3 = rnorm(10))
write.table(df, file = "df_write.txt")
```

\clearpage

## Interacting with Microsoft Excel Files


\includegraphics[width=5.65in]{images/import-excel-2} 

### XLConnect

The R package `XLConnect` permits to create a formatted spreadsheet usable as a dynamic report of the R analisys and it allows one to read existing xlsx files and to modify them from R.  
Let us see how `XLConnect` works.


```r
require(XLConnect)
```


#### Create a new file xlsx 
To create a new empty file xlsx with one empty sheet named *Input* the syntax is:


```r
# Set up output directory and output file name  
outDir <- "./xlsx" 
```

```r
# File path string
file_xls <- paste(outDir,"newFile.xlsx",sep='/')
# Delete file_xls if it already exists 
unlink(file_xls, recursive = FALSE, force = FALSE)
```


```r
exc <- loadWorkbook(filename = file_xls, create = TRUE)
createSheet(object = exc, name = 'Input')
saveWorkbook(exc)
```

`loadWorkbook()` function creates an R workbook object in the path and with the name specified by  `filename` argument. It creates it ex-novo, as `create` argument is set as `TRUE`. An R workbook object represents a Microsoft Excel workbook. 

The function `createSheet()` creates the worksheet *Input* in R object and `saveWorkbook()` function fisically save the R object in a file xlsx. Remember to call this function every time you modified the R object in order to save the changes also in xlsx file. 



\includegraphics[width=6.28in]{images/excel-emptySheet} 

#### Populate a sheet

To add something to an empty sheet use `writeWorkbook` function:


```r
df <- data.frame('inputType'=c('Day','Month'),'inputValue'=c(1,3))
writeWorksheet(object = exc, data = df, sheet = "Input", startRow = 1, startCol = 2)
saveWorkbook(exc)
```

The `df` data frame with 2 rows and 2 column is created and `writeWorkbook()` function write the content of this data frame in the sheet *Input* starting from the cell (1,2).


\includegraphics[width=2.64in]{images/excel-inputSheet} 

#### Create multiple sheets

To add other sheets to an R object workbook, use `createSheet()` function:


```r
# Add a sheet named Airquality to exc object
createSheet(exc,'Airquality')
saveWorkbook(exc)
```

Suppose we want to add a dataset to the sheet just created.  
We want to add `airquality` dataset available in `datasets` package, which reports daily air quality measurements in New York, from May to September 1973.  


```r
# Add an empty column to airquality dataset before add it to 'Airquality' sheet
airquality$isCurrent<-NA
# Add airquality dataset to the sheet Airquality
createName(exc, name='Airquality',formula='Airquality!$A$1')
writeNamedRegion(exc, airquality, name = 'Airquality', header = TRUE)
saveWorkbook(exc)
```

In particular, `createName()` function creates a named region 'Airquality' starting from the cell $A$1 of sheet *Airquality*. In Excel, a named region/range represents cells, a range of cells, a constant value, or a formula with a defined name which make easier to work. It is useful for navigation, to quickly select the named range, for reusing it when referencing it in such things as charts and formulas, ...   
`writeNamedRegion()` function writes `airquality` data frame with headers `(header=TRUE)` in the named region *Airquality*. 


\includegraphics[width=3.18in]{images/excel-airqualitySheet} 

#### Add a formula
Use `setCellFormula()` function to set cell formulas for specific cells in a workbook.  
The empty column *isCurrent* in *Airquality* sheet could be populate with a formula that lies *Input* sheet with *Airquality* sheet.


```r
# Define the column index of the cell to edit
col_index <- which(names(airquality) == 'isCurrent')
# Define the excel letter for the column 'Day' and 'Month' needed by the formula 
letter_day <- idx2col(which(names(airquality) == 'Day'))
letter_month <- idx2col(which(names(airquality) == 'Month'))
```

The function `idx2col()` returns the correspondig excel letter for the index column. With the syntax:


```r
letter_day <- idx2col(which(names(airquality) == 'Day'))
```

the variable `letter_day` contains the excel letter for the column *Day*


```
## letter_day= F
```



```r
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
```

The function `setCellFormula()` apply the formula specified by the argument `formula` to the rows specified by the `row` argument of the column specified by the `col` argument of the sheet of the R object specified by the `sheet` argument.



\includegraphics[width=3.64in]{images/excel-addFormula} 


#### Read an existing xlsx file

To read an existing excel file, the syntax is:


```r
# Excel file (with path) to be loaded into R
file_xls <- "./xlsx/newFile.xlsx"
```


```r
exc2 <- loadWorkbook(file_xls)
dt_air <- readWorksheet(exc2, sheet = 'Airquality')
head(dt_air)
```

```
##   Ozone Solar.R Wind Temp Month Day isCurrent
## 1    41     190  7.4   67     5   1         0
## 2    36     118  8.0   72     5   2         0
## 3    12     149 12.6   74     5   3         0
## 4    18     313 11.5   62     5   4         0
## 5    NA      NA 14.3   56     5   5         0
## 6    28      NA 14.9   66     5   6         0
```

`loadWorkbook()` function loads a Microsoft Excel workbook, in this case "newFile.xlsx", into R creating a R workbook object, `exc2`.  
`readWorksheet()` function reads data from *Airquality* sheet of `exc2` object (the workbook that has been previously loaded). 

#### Modify an existing xlsx file

Suppose we want to create another sheet named *OzonePlot*, with a named region *OzonePlot*:


```r
createSheet(exc2, name = "OzonePlot")
createName(exc2, name='OzonePlot',formula='OzonePlot!$A$1')
saveWorkbook(exc2)
```

`createSheet()` function adds the new sheet *OzonePlot* to `exc2` object and `createName()` function creates a new named region *OzonePlot* starting from *OzonePlot!$A$1* cell. `saveWorkbook()` function fisically save the change done to R object also in the corresponding xlsx file, in this case "newFile.xlsx".


#### Adding a plot (image)

After creating a new sheet it is possible to put in this sheet a picture of a graph created in R with the function `addImage()`:


```r
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
```

```
FALSE [1] TRUE
```


\includegraphics[width=5.12in]{images/excel-ozonePlot} 

### readxl

Another R package for importing excel files into R is `readxl`.
Let us see how `readxl` works.


```r
require(readxl)
```

#### Read an existing xlsx file

To read an existing excel file, the syntax is:


```r
# Excel file (with path) to be loaded into R
file_xls <- "./xlsx/newFile.xlsx"
```


```r
ds <-read_excel(path = file_xls, sheet = 'Airquality', col_names = TRUE)
head(ds)
```

```
## # A tibble: 6 × 7
##   Ozone Solar.R  Wind  Temp Month   Day isCurrent
##   <dbl>   <dbl> <dbl> <dbl> <dbl> <dbl>     <dbl>
## 1    41     190   7.4    67     5     1         0
## 2    36     118   8.0    72     5     2         0
## 3    12     149  12.6    74     5     3         0
## 4    18     313  11.5    62     5     4         0
## 5    NA      NA  14.3    56     5     5         0
## 6    28      NA  14.9    66     5     6         0
```

`read_excel()` function allows us to read xls and xlsx files, specified in `path` argument. `sheet` argument specifies the sheet to read and `col_names` indicates if the first row has to be used as column names (set as `TRUE`).

\clearpage

## Working with databases


\includegraphics[width=5.81in]{images/import-db-2} 

### ODBC

Open Database Connectivity (ODBC) is a standard programming language interface for accessing database management systems (DBMS). ODBC is independent from database systems and operating systems. An application can use ODBC to query data from a DBMS, regardless of the operating system or DBMS it uses. ODBC accomplishes DBMS independence by using an ODBC driver as a translation layer between the application and the DBMS.

With the `RODBC` package R enables the use of ODBC for interacting with databases. This solution is particularly useful when data occupies much space, is frequently updated or shared by two or more users. In this case, data is kept in the database. With R it is possible to make a query in the database, load data in the R workspace and carry out analyses.

The following code shows some examples of how to use ODBC in a MySQL database. For the following examples to work, it is necessary to modify the following functions with the parameters related to the available MySQL database.

The `odbcConnect()` function establishes the connection to the MySQL database. Its main arguments are: `dsn`, a string containing the name of the data source, `uid` and `pwd`, i.e. the user name and the password for the login.\

The `sqlQuery()` function performs queries to the MySQL database. The use of single and double quotation marks require attention. In the following example the query is contained in a string and is delimited by double quotation marks. The strings belonging to the query are delimited by single quotation marks.

Finally, the `odbcClose()` function closes the connection to the database.


```r
# RODBC driver ought be configured to work properly
require(RODBC)
conn = odbcConnect(dsn = "test", uid = "user", pwd = "pass")
sqlQuery(conn, "select * from tbl where gender = 'F'") 
odbcClose(conn)
```


### SQLlite 

`RSQLite` package embeds the SQLite database engine in R, providing a DBI-compliant interface. SQLite is a public-domain, single-user, very light-weight database engine that implements a decent subset of the SQL 92 standard, including the core table creation, updating, insertion, and selection operations, plus transaction management.  


```r
require(RSQLite)
```

The function `dbConnect` connect to a SQLite database, or creates it if it doesn't exist, as in this case:


```r
con <- dbConnect(RSQLite::SQLite(), "mtcars.sqlite")
```

To write a local data frame to the database, `dbWriteTable` is required:


```r
dbWriteTable(con, "mtcars", mtcars)
```

```
## [1] TRUE
```

`dbDisconnect` disconnects from the database:


```r
dbDisconnect(con)
```

```
## [1] TRUE
```

Now `mtcars.sqlite` exists and `dbConnect` connects us to it:


```r
con <- dbConnect(RSQLite::SQLite(), "mtcars.sqlite")
```

To see a list of available SQLite tables:


```r
dbListTables(con)
```

```
## [1] "mtcars"
```

or a list of fields in specified table:


```r
dbListFields(con, "mtcars")
```

```
##  [1] "row_names" "mpg"       "cyl"       "disp"      "hp"        "drat"      "wt"        "qsec"     
##  [9] "vs"        "am"        "gear"      "carb"
```

The next function mimic their R/S-Plus counterpart get, assign, exists, remove, and objects,
except that they generate code that gets remotely executed in a database engine:


```r
dbReadTable(con, "mtcars")
```

```
##                      mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4           21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag       21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710          22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive      21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout   18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
## Valiant             18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
## Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
## Merc 240D           24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
## Merc 230            22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
## Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
## Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
## Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
## Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
## Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
## Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
## Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
## Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
## Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
## Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
## Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
## Toyota Corona       21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
## Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
## AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
## Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
## Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
## Fiat X1-9           27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
## Porsche 914-2       26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
## Lotus Europa        30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
## Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
## Ferrari Dino        19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
## Maserati Bora       15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
## Volvo 142E          21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
```

The function `dbGetQuery` send query, retrieve results and then clear result set:


```r
dbGetQuery(con, "SELECT * FROM mtcars WHERE cyl = 4")
```

```
##         row_names  mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## 1      Datsun 710 22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
## 2       Merc 240D 24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
## 3        Merc 230 22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
## 4        Fiat 128 32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
## 5     Honda Civic 30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
## 6  Toyota Corolla 33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
## 7   Toyota Corona 21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
## 8       Fiat X1-9 27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
## 9   Porsche 914-2 26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
## 10   Lotus Europa 30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
## 11     Volvo 142E 21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
```


And finally disconnect from the database:


```r
dbDisconnect(con)
```

```
## [1] TRUE
```



\clearpage

## R Data Files 

### Save R Data Files 

Statistical packages often provide the opportunity to save the working environment with all the objects it contains in their own formats. Even if rarely used, this function is available in R as well. The format used by R is called `Rdata` (or `Rda`).

In this way, different objects can be saved in a single file. Moreover, all the features of a data frame which cannot be saved in a text file, such as the levels of a factor, can be kept in the file. 

To save an object of the R workspace in a file use the `save()` function. The first argument of the function is the object to be saved, whereas the file name is defined in the `file` argument. If the position is not specified, R saves the file in the current directory.


```r
# It creates a mtcars.Rda file in the current directory
save(mtcars, file = "mtcars.Rda")
```

To save more than one object list their names.


```r
# It creates a datasets.Rda file in the current directory
save(mtcars, iris, file = "datasets.Rda")
```

An alternative method to save more than one object is provided by the `list` argument. The names of the objects to be saved in a vector can be inserted with the `list` argument. This method is advisable when the list of the files to be saved is contained in a vector.


```r
# It creates a datasets.Rda file in the current directory
datalist = c("mtcars", "iris")
save(list = datalist, file = "datasets.Rda")
```

### Load R Data Files

To upload `Rda` files in R use the `load()` function.


```r
# It reads the datasets.Rda file previously created in the current directory
load("datasets.Rda")
```




