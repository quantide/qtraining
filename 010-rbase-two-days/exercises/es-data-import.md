---
title: 
author:
date: 
output:
  html_document:
    self_contained: no
---



# Data Import
 
First of all, set your working directory in the _data_ folder, using `setwd()` function, like in this example


```r
setwd("C:/Users/Veronica/Documents/rbase/data)
```

We will work inside this folder.

## Text Files
### Exercise 1

a. Import text file named _"tuscany.txt"_ and save it in an R object named `tuscany_df`.   
Open the text file before importing it to control if the first row contains column names and to control the field and the decimal separator characters. Remember to not import the character columns as factors.   


b. Visualize the first rows of `tuscany_df`



### Exercise 2

Import 7 rows of the text file named _"solar.txt"_ skipping the first two rows. Save it in the object `solar_df`.   
Open the text file before importing it to control if the first row contains column names and to control the field and the decimal separator characters. Remember to not import the character columns as factors.   


\clearpage

### Exercise 3

Considering the following data frame, named `df`: 


```r
df <- data.frame(col1=1:4, col2=4:1, col3=c("one", "two", "three", "four"), 
                 stringsAsFactors = FALSE)
```

Save it in a .txt file named _"exercise-3.txt"_ in _data_ folder.






## Excel Files

### Exercise 1

a. Import .xlsx file _"flowers.xlsx"_ using `XLConnect` function `loadWorkbook()` and save it in a R workbook object named `flowers`.  
  Remember to load `XLConnect` package, supposing it is already installed.


```r
require(XLConnect)
```



b. Read _iris_ sheet with  `readWorksheet()` function and save it in `flower_df` object. Then, visualize its first rows.


### Exercise 2

a. Create a new file xlsx, named _"exercise-2.xlsx"_, and save it in the R worksheet object, named `ex_2`. Use: `loadWorkbook()` and `saveWorkbook()` functions of `XLConnect`. 



b. Create a sheet, named `df`, in the R workbook object using `createSheet()` function. Remember to save the changes also in .xlsx file (use `saveWorkbook()` function). 



c. Considering the following data frame, named `numbers_df`:


```r
numbers_df <- data.frame(a= 1:4, b=c("one", "two", "three", "four"), 
                         stringsAsFactors = FALSE)
numbers_df
```

```
##   a     b
## 1 1   one
## 2 2   two
## 3 3 three
## 4 4  four
```
  Add it to `df` sheet of `ex_2` R workbook object, starting from row 3 and from column 2. Use the function `writeWorksheet()`. Remember to save the changes also in .xlsx file (use `saveWorkbook()` function). 





## Databases

### Exercise 1

a. Connect to _"plant.sqlite"_ SQLite database, using `dbConnect()` function of `RSQLite` package. Save the connection in an R object, named `con`.   
  Remember to load `RSQLite` package, supposing it is already installed.


```r
require(RSQLite)
```



b. See the list of available tables in _"plant.sqlite"_ db, using `dbListTables()` function.


c. See list of fields in _"PlantGrowth"_ table of  _"plant.sqlite"_ db, using `dbListFields()` function.



d.  Send query to _"PlantGrowth"_ table of _"plant.sqlite"_ which select the records with `weight` greater than 5.5.



e. Disconnect from the database, using `dbDisconnect()` function. 



## R Data Files

### Exercise 1

Given the following data frame, named `df_rdata`:


```r
df_rdata <- data.frame(a=1:20, b=20:1)
```

Save it in _.Rda_ format in the file _"df\_rdata.Rda"_, using `save()` function. 





### Exercise 2

Load _"drug.Rda"_ file into the environment, using `load()` function.











