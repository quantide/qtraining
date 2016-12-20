


# Data Import from external sources
 
First of all, set your working directory in the _data_ folder, using `setwd()` function, like in this example


```r
setwd("C:/Users/Veronica/Documents/rbase/data")
```

We will work inside this folder.

## Text Files
### Exercise 1

a. Import text file named _"tuscany.txt"_ and save it in an R object named `tuscany_df`.   
Open the text file before importing it to control if the first row contains column names and to control the field and the decimal separator characters. Remember to not import the character columns as factors.   


b. Visualize the first rows of `tuscany_df`



### Exercise 2

a. Import text file named _"solar.txt"_ and save it in an R object `solar_df`.   
Open the text file before importing it to control if the first row contains column names and to control the field and the decimal separator characters. Remember to not import the character columns as factors.   


b. Visualize the first rows of `solar_df`.




## Excel Files

### Exercise 1

a. Import `iris` sheet of .xlsx file _"flowers.xlsx"_ by using `read_excel` function of `readxl` package and save it in a R object named `flowers`.  
  Remember to load `read_excel` package, supposing it is already installed.


```r
require(readxl)
```



b. Visualize the first rows of `flowers` 



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











