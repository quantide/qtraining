




# Data Objects

## Data Frames, Vectors and Factors

### Exercise 1 
a. Generate a data frame, named `df`, corresponding to:


```
##    country population continent
## 1    Italy   59801004    Europe
## 2   France   64668129    Europe
## 3    China 1382323332      Asia
## 4    Japan  126323715      Asia
## 5    Libya    6330159    Africa
## 6 Cameroon   23924407    Africa
```

Remember to maintain character vectors as they are, specifiyng `stringsAsFactors = FALSE`.    


b. Supposing `dplyr` package is already installed, convert the previously defined data frame in tbl_df class.


```r
require(dplyr)
```



### Exercise 2 

a. Generate a numeric vector, named `num_vec`, containing the values from 1 to 7.



b. Genarate a character vector, named `char_vec` with the days of the week.



c. Starting from the vector:  

    
    ```r
    fac <- c("F", "F", "M", "M", "F", "F", "M")
    ```
  Generate the corresponding factor, named `fac`, with two levels: "F" and "M"



d. Generate a data frame, named `df2`, containing the previously defined: `num_vec`, `char_vec` and `fac`. Remember to maintain character vectors as they are, specifiyng `stringsAsFactors = FALSE`. 



e. Supposing `dplyr` package is already installed and loaded, convert the previously defined data frame in tbl_df class. 



## Matrices

### Exercise 1 

Generate a matrix, named `mat`, with 5 rows and 3 columns containing numbers from 1 to 15, using `matrix()` function.



## Lists

### Exercise 1 

Generate a list, named `my_list` that contains the following R elements:


```r
char <- "Veronica"
mat <- matrix(1:9, ncol = 3)
log_vec <- c(TRUE, FALSE, TRUE, TRUE)
```






