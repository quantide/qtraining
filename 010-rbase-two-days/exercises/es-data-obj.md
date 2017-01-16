---
title: 
author:
date: 
output:
  html_document:
    self_contained: no
---


 
# Data Object
## Vectors
### Exercise 1

a. Create a vector, named `vec1`, containing the following values:  
1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80, 90    


b. Select the 5-th element of `vec1`. 


c. Select the first 10 elements of `vec1.`  


d. Select all the elements of `vec1` apart from the 2nd and the 6th element.  



### Exercise 2

a. Generate a vector, named `vec2`, containing the numbers from 1 to 10 and of length 8, using the function `seq()`.  


b. Select the values of `vec2` which are greater than 4.  


c. Select the values of `vec2` which are equal or less than 2 or which are equal or greater than 6.  



### Exercise 3

a. Generate the following vector using the function `rep()`:   
`vec3 <- c("one", "two", "one", "two", "one", "two")`  



b. Generate a new vector, named `vec5`, combining the previous vector, `vec3`, with the following one:   
 

```r
vec4 <- c("three", "four")
```



## Matrices

### Exercise 1

Generate a matrix, named `mat1`, with 5 rows and 3 columns, using `matrix()` function:


```
##      [,1] [,2] [,3]
## [1,]    1    2    3
## [2,]    4    5    6
## [3,]    7    8    9
## [4,]   10   11   12
## [5,]   13   14   15
```






### Exercise 2

Starting from the following vector:  

```r
mat2 <- 1:8
```

Generate a matrix with 2 rows and 4 columns using `dim()` function. 




### Exercise 3

a. Generate a matrix, named `mat3`, combining the following columns:

```r
a <- 1:3
b <- 7:9
c <- 8:6
```



b. Add the following row to `mat3`: 


```r
d <- 4:6
```




\clearpage

### Exercise 4

Considering the following matrix, named `mat4`:


```r
mat4 <- matrix(1:24, nrow = 6, ncol = 4, byrow = TRUE)
mat4
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    1    2    3    4
## [2,]    5    6    7    8
## [3,]    9   10   11   12
## [4,]   13   14   15   16
## [5,]   17   18   19   20
## [6,]   21   22   23   24
```

a. Select the third and the fifth row of `mat4`.  


b. Select all columns of `mat4` apart from the first.  


c. Select second and third rows and second and third columns of `mat4`.  



## Lists

### Exercise 1

a. Generate a list, named `list1` that contains the following R elements:


```r
vec <- 1:10
mat <- matrix(1:9, ncol = 3)
name <- "Oscar"
```



b. Add to `list1` the following element:


```r
letters <- c("a", "b", "c", "d")
```



\clearpage

### Exercise 2

Given the following list, named `list2`:

```r
list2 <- list(vec = c(1,3,5,7,8), mat = matrix(1:12, ncol = 4), 
              sub_list = list(names = c("Veronica", "Enrico", "Andrea", "Anna"), 
                              numbers = 1:4))
list2
```

```
## $vec
## [1] 1 3 5 7 8
## 
## $mat
##      [,1] [,2] [,3] [,4]
## [1,]    1    4    7   10
## [2,]    2    5    8   11
## [3,]    3    6    9   12
## 
## $sub_list
## $sub_list$names
## [1] "Veronica" "Enrico"   "Andrea"   "Anna"    
## 
## $sub_list$numbers
## [1] 1 2 3 4
```

a. Entract the first element of `list2`.  


b. Extract the objects contained in the first element of `list2`.  


c. Extract the element named `sub_list` of `list2`.  


d. Extract the second rows of the matrix included in the second element of `list2`.  


\clearpage

## Factors

### Exercise 1

Starting from the vector:  

```r
fac1 <- c("F", "F", "M", "M" , "F")
```

Generate the corresponding factor with two levels: "F" and "M"



### Exercise 2

Starting from the vector:  

```r
fac2 <- c(1, 1, 1, 2, 2, 2) 
```

a. Generate the corresponding factor considering that 1 = "Female", 2 = "Male" e 3 = "Trans".  


b. Select the all elements of `fac2` apart from "Male".     


\clearpage

## Data Frames


### Exercise 1

a. Generate a data frame, named `df1`, corresponding to:


```
##    id     name class mean
## 1   1     Luca    5A  6.0
## 2   2   Chiara    5A  7.0
## 3   3     Lisa    5A  5.0
## 4   4   Matteo    5A  6.5
## 5   5    Alice    5A  7.5
## 6   6    Marco    5B  4.5
## 7   7 Veronica    5B  9.0
## 8   8   Nicola    5B  8.0
## 9   9    Elena    5B  8.5
## 10 10  Daniele    5B  7.0
```

Remember to maintain character vectors as they are, specifiyng `stringsAsFactors = FALSE`.    



b. Select the first 3 rows of `df1`.  


c. Select the last 6 rows and the first 3 columns of `df1`.    


d. Select the column `class` of `df1`.   


e. Convert the column `class` of `df1` in a factor with levels: "5A" and "5B"


f. How many columns and rows `df1` has?   


g. Generate another dataframe, named `df2` composed by the columns `name` and `mean` of `df1`, specifying the argument `stringsAsFactors = FALSE`.   


h. Show the first rows and the structure of `df2`.    






