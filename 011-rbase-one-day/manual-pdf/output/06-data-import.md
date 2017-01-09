
# Data Import from external sources




\includegraphics[width=3.33in]{images/flow-robj} 


In the following paragraphs we will explore data import methods for:

* Text files
* Microsoft Excel files
* Databases

Datasets used in this chapter are available at www.github.com/quantide/my-first-date-with-r/tree/master/data. 

## Text files


\includegraphics[width=5.39in]{images/import-text} 

The `read.table()` function imports a text file (ASCII) with a table structure where each row represents a case.

A full path can be provided, but it must be modified by each user, otherwise it fails:

```r
df <- read.table("C:/Users/UserName/Documents/data/tennis.txt", header = TRUE, sep = "", dec = ".")
```

```
## Warning in file(file, "rt"): cannot open file 'C:/Users/UserName/Documents/
## data/tennis.txt': No such file or directory
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

Now, the text file can be imported just providing its filename: 


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

```r
str(df)
```

```
## 'data.frame':	10 obs. of  10 variables:
##  $ Name      : Factor w/ 10 levels "Agassi","Becker",..: 9 1 2 3 5 4 10 6 7 8
##  $ First.Name: Factor w/ 10 levels "Andre","Arantxa",..: 8 1 3 9 5 10 2 4 6 7
##  $ Age       : int  23 24 27 24 23 25 23 22 26 20
##  $ Sex       : Factor w/ 2 levels "F","M": 2 2 2 2 2 1 1 1 1 1
##  $ Rank      : int  1 2 3 4 5 1 2 3 4 5
##  $ Slams     : int  2 1 0 1 0 1 2 1 0 0
##  $ Won       : int  74 51 48 65 63 58 74 55 43 45
##  $ Lost      : int  11 13 16 23 26 6 9 15 11 18
##  $ Earnings  : num  3608 1942 2030 3032 2060 ...
##  $ Citizen   : Factor w/ 6 levels "Croatia","Czech Republic",..: 6 6 4 5 1 4 5 5 2 3
```

The `header = TRUE` option tells R that the first row of the file contains column headings and it is used to assign the name of variables. If the first row contains the first case the `header = FALSE` ought to be used and the names of the variables are automatically assigned.

The `sep` argument specifies the separator between different cases. The default value for the `read.table()` function is `sep = ""` which takes into consideration the fields delimited by a white space, be it one or more spaces or tabulations.

The `dec` argument specifies the decimal separator. The argument usually assumes the `dec = "."`  (default) or `dec = ","` values.


```r
df <- read.table("tennis.txt", header = TRUE, sep = "", dec = ".")
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

Variables containing text are set as character variables with the `stringsAsFactors = FALSE` option, whereas by default they are set as factors. 

```r
df <- read.table("tennis.txt", header = TRUE, sep = "", dec = ".", stringsAsFactors = FALSE)
str(df)
```

```
## 'data.frame':	10 obs. of  10 variables:
##  $ Name      : chr  "Sampras" "Agassi" "Becker" "Bruguera" ...
##  $ First.Name: chr  "Pete" "Andre" "Boris" "Sergi" ...
##  $ Age       : int  23 24 27 24 23 25 23 22 26 20
##  $ Sex       : chr  "M" "M" "M" "M" ...
##  $ Rank      : int  1 2 3 4 5 1 2 3 4 5
##  $ Slams     : int  2 1 0 1 0 1 2 1 0 0
##  $ Won       : int  74 51 48 65 63 58 74 55 43 45
##  $ Lost      : int  11 13 16 23 26 6 9 15 11 18
##  $ Earnings  : num  3608 1942 2030 3032 2060 ...
##  $ Citizen   : chr  "US" "US" "Germany" "Spain" ...
```

## Microsoft Excel files


\includegraphics[width=5.49in]{images/import-excel} 


One of the most important R package for importing excel files into R is `readxl`.
Let us see how it works.


```r
require(readxl)
```

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

## Databases


\includegraphics[width=5.52in]{images/import-db} 



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
conn <- odbcConnect(dsn = "test", uid = "user", pwd = "pass")
sqlQuery(conn, "select * from tbl where gender = 'F'") 
odbcClose(conn)
```


### SQLlite 

`RSQLite` package embeds the SQLite database engine in R, providing a DBI-compliant interface. SQLite is a public-domain, single-user, very light-weight database engine that implements a decent subset of the SQL 92 standard, including the core table creation, updating, insertion, and selection operations, plus transaction management.  


```r
require(RSQLite)
```


The function `dbConnect` connect to a SQLite database, or creates it if it doesn't exist:


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
##  [1] "row_names" "mpg"       "cyl"       "disp"      "hp"       
##  [6] "drat"      "wt"        "qsec"      "vs"        "am"       
## [11] "gear"      "carb"
```

The next function mimic its R/S-Plus counterpart `get`, except that it generates code that gets remotely executed in a database engine:


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

