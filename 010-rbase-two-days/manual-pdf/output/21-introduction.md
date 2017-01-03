


# Introduction to R Objects

There are different types of objects in R, which can be divided in:

* data objects
* function object
 
**Data objects** are specific types of data structures by which is possible to organize data. The most important are:

* vectors 
* matrices 
* lists 
* factors
* data frames

**Function object** refers to operation done on data.

We will deepen these two categories of R objetcs in the following chapters.

\clearpage

## Data Objects

The structures of data objects are represented in the following figure:

![](./images/dataStructure.png)

### Vectors

In R the simplest data structure is a vector. A vector is defined as an ordered sequence of elements of the same kind.

A vector can be defined according to the data type it contains. Therefore, there are:

 - numeric vectors;
 - logical (or Boolean) vectors;
 - character (or string) vectors.

The most common method to define a vector is the `c()` function.


```r
# Numeric vector
num <- c(1, 2, 5.3, 6, -2, 4)
num
```

```
## [1]  1.0  2.0  5.3  6.0 -2.0  4.0
```


```r
# Character vector
char <- c("one", "two", "three")
char
```

```
## [1] "one"   "two"   "three"
```

Logical vectors are often defined as the result of control actions on numerical or character vectors. 


```r
# Logical vector
logic1 <- num > 3
logic1
```

```
## [1] FALSE FALSE  TRUE  TRUE FALSE  TRUE
```

Of course, a logical vector can be created using the `c()` function.


```r
# Logical vector
logic2 <- c(TRUE, FALSE, TRUE)
logic2
```

```
## [1]  TRUE FALSE  TRUE
```

If a vector mixes different data types, R will store it as a character vector.


```r
mixed <- c("foo", 1, TRUE)
mixed
```

```
## [1] "foo"  "1"    "TRUE"
```

The `c()` function can be used to create a vector combining several vectors.


```r
vec1 <- c(11, 12, 13)
vec2 <- c(21, 22, 23)
vec3 <- c(31, 32, 33)
comb <- c(vec1, vec2, vec3)
comb
```

```
## [1] 11 12 13 21 22 23 31 32 33
```


A vector can be created using sequences. The easiest method is using the operator `:`. The inputs of the operator `:` are the first number on the left and the last number on the right. The vector will be composed of numbers comprised between the first and the last number (by one unit).


```r
go <- 1:20
go
```

```
##  [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20
```

```r
back <- 20:1
back
```

```
##  [1] 20 19 18 17 16 15 14 13 12 11 10  9  8  7  6  5  4  3  2  1
```

Other sequences can be created using the `seq()` function. The parameters `from` and `to` of the `seq()` function refer to the starting and end values of the sequence, respectively. The parameter `by` indicates the number by which the sequence has to be incremented. Alternatively, the `length.out` parameter refers to the desired length of the sequence.


```r
seqby <- seq(from = 1, to = 5, by = 0.5)
seqby
```

```
## [1] 1.0 1.5 2.0 2.5 3.0 3.5 4.0 4.5 5.0
```

```r
seqlength <- seq(from = 1, to = 5, length.out = 13) 
seqlength
```

```
##  [1] 1.000000 1.333333 1.666667 2.000000 2.333333 2.666667 3.000000 3.333333 3.666667 4.000000 4.333333
## [12] 4.666667 5.000000
```

Finally, vectors can be created with the `rep()` function which repeats the elements of a vector. The first parameter of the `rep()` function, `x`, is the value or vector to be repeated and the second parameter, `times`, represents the number of repetitions to be made. Alternatively, the `each` parameter enables the repetition of each element of the vector as many times as indicated by the number. 


```r
rep(x = 1 , times = 10)
```

```
##  [1] 1 1 1 1 1 1 1 1 1 1
```

```r
rep(x = 1:5, times = 3)
```

```
##  [1] 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5
```

```r
rep(x = 1:5 , each = 3)
```

```
##  [1] 1 1 1 2 2 2 3 3 3 4 4 4 5 5 5
```

```r
rep(c("ALI", "IPERLANDO"), times=4)
```

```
## [1] "ALI"       "IPERLANDO" "ALI"       "IPERLANDO" "ALI"       "IPERLANDO" "ALI"       "IPERLANDO"
```

```r
rep(x = 1:5 , times = 2 , each = 3)
```

```
##  [1] 1 1 1 2 2 2 3 3 3 4 4 4 5 5 5 1 1 1 2 2 2 3 3 3 4 4 4 5 5 5
```

```r
rep(x = "no",  times = 5)
```

```
## [1] "no" "no" "no" "no" "no"
```

```r
rep(x = c("a", "b", "c"), times = c(3, 2, 1))
```

```
## [1] "a" "a" "a" "b" "b" "c"
```

```r
rep(x = c("a", "b", "c"), times = rep(4,3))
```

```
##  [1] "a" "a" "a" "a" "b" "b" "b" "b" "c" "c" "c" "c"
```

```r
mydata <- c("a", "b", "c")
myrep <- rep(4,3)
rep(x = mydata, times = myrep)
```

```
##  [1] "a" "a" "a" "a" "b" "b" "b" "b" "c" "c" "c" "c"
```

A subset of the vector `x` can be extracted with `x[subscripts]`. The selection can be done in three ways.

 1. A vector of positive integers indicating the elements of the vector to be extracted.


```r
x <- c(1, 4, 2, 5, 6, 8, 6, 9, 10)
x[3]
```

```
## [1] 2
```

```r
x[1:3]
```

```
## [1] 1 4 2
```

```r
x[c(2,4)]
```

```
## [1] 4 5
```

 2. A vector of negative integers indicating the elements which must not be extracted. 


```r
x <- c(1, 4, 2, 5, 6, 8, 6, 9, 10)
x[-2]
```

```
## [1]  1  2  5  6  8  6  9 10
```

```r
x[-c(2, 5, 7)]
```

```
## [1]  1  2  5  8  9 10
```

 3. A Boolean vector indicating the elements to be extracted (`TRUE`) or to be left (`FALSE`).


```r
x <- c(1, 4, 2, 5, 6)
x[c(TRUE, TRUE, FALSE, FALSE, TRUE)]
```

```
## [1] 1 4 6
```

```r
y <- c(TRUE, TRUE, FALSE, FALSE, TRUE)
x[y]
```

```
## [1] 1 4 6
```

```r
x[!y]
```

```
## [1] 2 5
```

  The `!` symbol identifies the "not" logical operator. The logical operator "not" reverses the logical value of a condition on which it operates.  
  
  In this way elements satisfying a logical condition can be extracted. Usually, the logical vectors are obtained as the result of logical expressions.



```r
x <- c(1, 4, 2, 5, 6, 8, 6, 9, 10)
y <- x > 5
x[y]
```

```
## [1]  6  8  6  9 10
```

  The logical expression can be defined inside the square brackets, directly.


```r
x[x > 5]
```

```
## [1]  6  8  6  9 10
```

  The `&` symbol identifies the "and" logical operator. The "and" logical operator compare two (or more) logical expression and return TRUE if both are TRUE. The following example returns the `x` values greater or equal than 2 but less or equal than 8.
  

```r
x[x >= 2 & x <= 8]
```

```
## [1] 4 2 5 6 8 6
```

  The `|` symbol identifies the "or" logical operator. The "or" logical operator compare two (or more) logical expression and return TRUE if at least one is TRUE. The following example returns the `x` values less than 2 or greater than 8.
  

```r
x[x < 2 | x > 8]
```

```
## [1]  1  9 10
```

<!--
x[!(x >= 2 & x <= 8)]
-->

Extracting unique values contained in a vector can sometimes be useful. This can be done with the `unique()` function. 


```r
x <- c(1, 2, 1, 1, 2, 3, 3, 2, 1, 2, 2, 3)
unique(x)
```

```
## [1] 1 2 3
```


### Matrices

Matrices are generalizations of vectors. Like vectors, matrices need to contain elements of the same kind. This Paragraph introduces numeric matrices.

A matrix can be created using the `matrix()` function.


```r
matrix(1:8, nrow = 2, ncol = 4)
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    1    3    5    7
## [2,]    2    4    6    8
```

By default, a matrix is filled by columns. The `byrow = TRUE` argument of the `matrix()` function fills the matrix by rows. 


```r
matrix(1:8, nrow = 2, ncol = 4, byrow = TRUE)
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    1    2    3    4
## [2,]    5    6    7    8
```

Alternatively, a matrix can be created by applying the `dim()` function to a vector. 


```r
x <- 1:8
x
```

```
## [1] 1 2 3 4 5 6 7 8
```

```r
dim(x) <- c(2, 4)
x
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    1    3    5    7
## [2,]    2    4    6    8
```

Finally, a matrix can be created by joining two or more vectors, both as column vectors (`cbind()` function) and row vectors (`rbind()` function).


```r
cmat <- cbind(1:3, 4:6, 7:9)
cmat
```

```
##      [,1] [,2] [,3]
## [1,]    1    4    7
## [2,]    2    5    8
## [3,]    3    6    9
```

```r
rmat <- rbind(1:3, 4:6, 7:9)
rmat
```

```
##      [,1] [,2] [,3]
## [1,]    1    2    3
## [2,]    4    5    6
## [3,]    7    8    9
```

The `cbind()` and `rbind()` functions can be used to join two (ore more) matrices or vectors and matrices.


```r
cbind(cmat, 10:12)
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    1    4    7   10
## [2,]    2    5    8   11
## [3,]    3    6    9   12
```

```r
rbind(cmat, rmat, cmat)
```

```
##       [,1] [,2] [,3]
##  [1,]    1    4    7
##  [2,]    2    5    8
##  [3,]    3    6    9
##  [4,]    1    2    3
##  [5,]    4    5    6
##  [6,]    7    8    9
##  [7,]    1    4    7
##  [8,]    2    5    8
##  [9,]    3    6    9
```

Like vectors, a subset of the matrix `x` can be extracted with `x[subscripts]`. Subscripts can be: 

 1. a set `[rows, cols]`, where `rows` is a vector of row numbers and `cols` is a vector of column numbers. Numbers are negative when they indicate a row or column to be excluded.
 2. A number, a vector of numbers or a logical condition. In this case, the matrix is treated as if it were a single vector created by stacked matrix columns.


```r
x <- matrix(1:24, nrow = 4, ncol = 6, byrow = TRUE)
x[1:2, ]
```

```
##      [,1] [,2] [,3] [,4] [,5] [,6]
## [1,]    1    2    3    4    5    6
## [2,]    7    8    9   10   11   12
```

```r
x[, c(1, 3, 5)]
```

```
##      [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    7    9   11
## [3,]   13   15   17
## [4,]   19   21   23
```

```r
x[c(1,3), c(1, 4)]
```

```
##      [,1] [,2]
## [1,]    1    4
## [2,]   13   16
```

```r
x[-1, ]
```

```
##      [,1] [,2] [,3] [,4] [,5] [,6]
## [1,]    7    8    9   10   11   12
## [2,]   13   14   15   16   17   18
## [3,]   19   20   21   22   23   24
```

```r
x[1:18]
```

```
##  [1]  1  7 13 19  2  8 14 20  3  9 15 21  4 10 16 22  5 11
```

```r
x[x >= 3 & x < 12]
```

```
## [1]  7  8  3  9  4 10  5 11  6
```

### Array  

They are similar to matrices but they can be multi-dimensional (more than two dimensions)


```r
z <- array(1:24, dim=c(2,3,4))
z
```

```
## , , 1
## 
##      [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    2    4    6
## 
## , , 2
## 
##      [,1] [,2] [,3]
## [1,]    7    9   11
## [2,]    8   10   12
## 
## , , 3
## 
##      [,1] [,2] [,3]
## [1,]   13   15   17
## [2,]   14   16   18
## 
## , , 4
## 
##      [,1] [,2] [,3]
## [1,]   19   21   23
## [2,]   20   22   24
```


### Lists

A list is an ordered collection of objects. Each object is a component of the list. Each element of the list can have a different structure. It can be a list itself, a vector, a matrix, an array, a factor or a data frame. A list allows you to gather a variety of (possibly unrelated) objects under one name.

Lists are not usually created by users but are the result of statistical procedures in R.

For example, in its simplest form, the `lsfit()` function estimates a least-squares regression.


```r
x <- 1:5
y <- c(-0.0921, 0.4543, -0.1473, -0.0235, -0.3923)
out <- lsfit(x, y)
out
```

```
## $coefficients
## Intercept         X 
##   0.28328  -0.10782 
## 
## $residuals
## [1] -0.26756  0.38666 -0.10712  0.12450 -0.13648
## 
## $intercept
## [1] TRUE
## 
## $qr
## $qt
## [1]  0.08984521 -0.34095678  0.05740271  0.42144605  0.29288939
## 
## $qr
##       Intercept          X
## [1,] -2.2360680 -6.7082039
## [2,]  0.4472136  3.1622777
## [3,]  0.4472136 -0.1954395
## [4,]  0.4472136 -0.5116673
## [5,]  0.4472136 -0.8278950
## 
## $qraux
## [1] 1.447214 1.120788
## 
## $rank
## [1] 2
## 
## $pivot
## [1] 1 2
## 
## $tol
## [1] 1e-07
## 
## attr(,"class")
## [1] "qr"
```

The output of the function is a list made of four objects called "coefficients", "residuals", "intercept" e "qr". The first element of the list is a vector with intercept and slope. The second element is a vector with the residuals of the model. The third element is a Boolean vector of length one indicating if the model contains the intercept. The fourth element is a list containing the QR matrix decomposition of the independent variables.

Even if rarely used, `list()` is the basic function to create a list. Its arguments are the elements of the list.


```r
my_list <- list(vec = 1:7, mat = matrix(1:12, ncol = 3),
  lis = list(a = 1, b = letters[1:4]))
my_list
```

```
## $vec
## [1] 1 2 3 4 5 6 7
## 
## $mat
##      [,1] [,2] [,3]
## [1,]    1    5    9
## [2,]    2    6   10
## [3,]    3    7   11
## [4,]    4    8   12
## 
## $lis
## $lis$a
## [1] 1
## 
## $lis$b
## [1] "a" "b" "c" "d"
```

The elements of a list can be extracted in three different ways:

  1. with square brackets;
  2. with double square brackets;
  3. with the name of the object inside the list.

In the first case, square brackets can be used to extract a list made of one or more objects. As for vectors, the position of the elements to be included or excluded ought to be specified. 


```r
my_list[1:2]
```

```
## $vec
## [1] 1 2 3 4 5 6 7
## 
## $mat
##      [,1] [,2] [,3]
## [1,]    1    5    9
## [2,]    2    6   10
## [3,]    3    7   11
## [4,]    4    8   12
```

```r
my_list[-3]
```

```
## $vec
## [1] 1 2 3 4 5 6 7
## 
## $mat
##      [,1] [,2] [,3]
## [1,]    1    5    9
## [2,]    2    6   10
## [3,]    3    7   11
## [4,]    4    8   12
```

```r
ml1 <- my_list[1]
ml1
```

```
## $vec
## [1] 1 2 3 4 5 6 7
```

In the second case, double square brackets can be used to extract one object (only) from the list. 


```r
ml2 <- my_list[[1]]
ml2
```

```
## [1] 1 2 3 4 5 6 7
```

```r
my_list[[2]]
```

```
##      [,1] [,2] [,3]
## [1,]    1    5    9
## [2,]    2    6   10
## [3,]    3    7   11
## [4,]    4    8   12
```

```r
my_list[[3]]
```

```
## $a
## [1] 1
## 
## $b
## [1] "a" "b" "c" "d"
```

Please note the difference between `my_list[1]` and `my_list[[1]]`. The first argument extracts a list with only the first object contained in `my_list`; in our case a vector. On the other hand, the second argument extracts the vector, which is the content of the first object of the list.

The third way enables the extraction of the content of an object in the list. The use of the object position in the list, as for double square brackets, is replaced by the use of the object name preceded by the symbol $.


```r
my_list$vec
```

```
## [1] 1 2 3 4 5 6 7
```

```r
my_list$mat
```

```
##      [,1] [,2] [,3]
## [1,]    1    5    9
## [2,]    2    6   10
## [3,]    3    7   11
## [4,]    4    8   12
```

```r
my_list$lis
```

```
## $a
## [1] 1
## 
## $b
## [1] "a" "b" "c" "d"
```

Indices for the selection can be combined to extract elements in an object of the list using the above-mentioned methods. 


```r
my_list[[1]][1:3]
```

```
## [1] 1 2 3
```

```r
my_list$mat[3:4, c(1, 3)]
```

```
##      [,1] [,2]
## [1,]    3   11
## [2,]    4   12
```

```r
my_list$lis[1]
```

```
## $a
## [1] 1
```

```r
my_list$lis[[1]]
```

```
## [1] 1
```

```r
my_list$lis$a
```

```
## [1] 1
```


### Factors

A factor is a vector-like object used to specify a discrete classification (grouping) of the components of other vectors of the same length. R provides both _ordered_ and _unordered_ factors.

Factor variables are categorical variables that can be either numeric or string variables. There are a number of advantages to converting categorical variables to factor variables. Perhaps the most important advantage is that they can be used in statistical modeling where they will be implemented correctly, e.g., they will then be assigned the correct number of degrees of freedom. Factor variables are also very useful in many different types of graphics. Furthermore, storing string variables as factor variables is a more efficient use of memory.

Vectors, matrices and lists contain numerical data, characters or logics and are basic objects in R. Factors, on the other hand, are a more complex structure, as they contain both the numerical data vector and the labels associated with each level.

To create a factor variable the `factor()` function is used. The only required argument is a vector of values which can be either string or numeric. Optional arguments include the `levels` argument, which determines the categories of the factor variable, and the default is the sorted list of all the distinct values of the data vector. The `labels` argument is another optional argument which is a vector of values that will be the labels of the categories in the `levels` argument. The `exclude` argument is also optional; it defines which levels will be classified as NA in any output using the factor variable.


```r
grade <- c(3, 4, 2, 2, 4, 1, 1, 4, 2, 2)
factor(grade)  
```

```
##  [1] 3 4 2 2 4 1 1 4 2 2
## Levels: 1 2 3 4
```

```r
gender <- c(rep("male", 3), rep("female", 4))
gender <- factor(gender, levels=c("male", "female", "trans"))
gender
```

```
## [1] male   male   male   female female female female
## Levels: male female trans
```

Once a vector has been defined, it is always possible to modify the labels of the vector's levels. This can be done with the `levels()` function.


```r
size <- factor(c(2, 3, 1, 1, 1, 2, 3, 3), levels = c(1, 2, 3),
  labels = c("small", "medium", "large"))
levels(size)
```

```
## [1] "small"  "medium" "large"
```

```r
levels(size) <- c("S", "M", "L")
size
```

```
## [1] M L S S S M L L
## Levels: S M L
```

The `order` parameter of the `factor()` function creates a factor with ordered levels. 


```r
mark <- sample(c("D", "C", "B", "A"), 12, replace = T)
mark1 <- factor(mark)
mark2 <- factor(mark, levels = c("D", "C", "B", "A"), order = T)
mark1
```

```
##  [1] C A D A A A A A C D B A
## Levels: A B C D
```

```r
mark2
```

```
##  [1] C A D A A A A A C D B A
## Levels: D < C < B < A
```

The `as.numeric()` and `as.character()` functions transform a factor into a numeric vector or into a vector whose elements are the levels' labels. 

```r
as.numeric(size)
```

```
## [1] 2 3 1 1 1 2 3 3
```

```r
as.character(size)
```

```
## [1] "M" "L" "S" "S" "S" "M" "L" "L"
```

The elements of a factor can be extracted in the same way as the elements of a vector. The logic conditions on the elements of a factor are referred to the factor's levels which can be obtained with the`levels()` function.


```r
size <- factor(c(2, 3, 1, 1, 1, 2, 3, 3), levels = c(1, 2, 3),
  labels = c("small", "medium", "large"))
size
```

```
## [1] medium large  small  small  small  medium large  large 
## Levels: small medium large
```

```r
size[1:5]
```

```
## [1] medium large  small  small  small 
## Levels: small medium large
```

```r
size[-4]
```

```
## [1] medium large  small  small  medium large  large 
## Levels: small medium large
```

```r
levels(size)
```

```
## [1] "small"  "medium" "large"
```

```r
size[size == "medium" | size == "large"]
```

```
## [1] medium large  medium large  large 
## Levels: small medium large
```


### Data Frames

A data frame in R can be thought of as:

 - a generalization of a matrix;
 - a list of particular kind.

In the first case a data frame can be thought of as a matrix whose columns can be both factors and vectors of the same length but (possibly) of different types (numeric, character, Boolean).

In the second case, the data frame is a list completely made of either vectors (of any kind) or factors, all with the same length.

From a formal point of view, data frames are not a new type of objects. They are objects of list type and data frame class. From a practical point of view, a data frame is a very well-know structure in statistics. Its different kinds of information are organized in columns, whereas rows represent different types of observational units.

Furthermore, data imported in R from external sources, such as text files, Excel files or databases, is saved in R as data frame-like objects.

To sum up, unless we have specific needs, data frames in R are the ideal tool for data filing and management.

Data frames are usually imported from external sources but the creation of a data frame object in R might sometimes be needed. The most widespread method to define a data frame is the `data.frame()` function. Its inputs are a series of vectors or factors of the same length. The generated object is made of as many columns as input elements. 


```r
name <- c("James", "Stevie", "Otis", "Bob", "Levon", "Patti", "Karen")
height <- c(180, 170, 175, 190, 168, 160, 165)
gender <- factor(c("M", "M", "M", "M", "M", "F", "F"))
df <- data.frame(name, height, gender, stringsAsFactors = FALSE)
df
```

```
##     name height gender
## 1  James    180      M
## 2 Stevie    170      M
## 3   Otis    175      M
## 4    Bob    190      M
## 5  Levon    168      M
## 6  Patti    160      F
## 7  Karen    165      F
```

Alternatively, the vectors composing the data frame can be defined inside the `data.frame()` function itself.


```r
df <- data.frame(
  height = c(180, 170, 175, 190, 168, 160, 165),
  name = c("James", "Stevie", "Otis", "Bob", "Levon", "Patti", "Karen"),
  gender = factor(c("M", "M", "M", "M", "M", "F", "F")),
  stringsAsFactors = FALSE
)
df
```

```
##   height   name gender
## 1    180  James      M
## 2    170 Stevie      M
## 3    175   Otis      M
## 4    190    Bob      M
## 5    168  Levon      M
## 6    160  Patti      F
## 7    165  Karen      F
```

The management of character vectors in R requires a detailed explanation. By default, numeric vectors become part of data frames as such, whereas character vectors are transformed into factors whose levels correspond to the vector's unique values.

This behaviour is surely effective when character vectors represent categorical variables with a definite number of modes, such as education qualification or job.

A character vector can also represent a set of strings which are not necessarily referable to a definite number of modes (e.g. person's proper names) or to numerous and/or unique modes (e.g. Italian municipalities are about 8,000 and have different names). In this case R's behaviour becomes a disturbing factor because it tends to transform variables of a different nature into factors. 
 
Unfortunately, there is not an optimal solution to this problem. Much depends on the most used types of variables dealt with by a single user.

This behaviour is managed by the `stringsAsFactors` logical parameter.

As already mentioned, the default setting is `stringsAsFactors = TRUE` which tells R to transform character vectors into factors inside a data frame; `stringsAsFactors = FALSE` does not change character vectors. This parameter can be set both in "local" option with the `stringsAsFactors` parameter inside the `data.frame()` function and in "global" option with `stringsAsFactors` inside the `options()` function.
Clearly, the "global" option of the `stringsAsFactors` lasts for the whole session of work but can be locally modified in any moment in a single call to a function.

There are several ways to extract a subset from a data frame. Data management is not among topics of this introductory manual. Like matrices, data can be extracted using `x[subscripts]` where subscripts is a set `[rows, cols]`, where `rows` is a vector of row numbers and `cols` is a vector of column numbers. Numbers are negative when they indicate a row or column to be excluded. 

The following code chunk shows how to extract the first, the third and the seventh row from the `df` dataframe.


```r
df[c(1, 3, 7), ]
```

```
##   height  name gender
## 1    180 James      M
## 3    175  Otis      M
## 7    165 Karen      F
```

The code below shows how to extract the first and the second column from the `df` dataframe.


```r
df[, c(1, 2)]
```

```
##   height   name
## 1    180  James
## 2    170 Stevie
## 3    175   Otis
## 4    190    Bob
## 5    168  Levon
## 6    160  Patti
## 7    165  Karen
```

Like lists, data can be extracted using `x$column` where column is the column name.


```r
df$height
```

```
## [1] 180 170 175 190 168 160 165
```

```r
is.vector(df$height)
```

```
## [1] TRUE
```

The above code returns a vector. To get a data frame, the `data.frame()` function can be used.


```r
data.frame(height = df$height)
```

```
##   height
## 1    180
## 2    170
## 3    175
## 4    190
## 5    168
## 6    160
## 7    165
```

```r
data.frame(height = df$height, name = df$name)
```

```
##   height   name
## 1    180  James
## 2    170 Stevie
## 3    175   Otis
## 4    190    Bob
## 5    168  Levon
## 6    160  Patti
## 7    165  Karen
```

The `dim()` function can be used to know the number of rows and of columns of a data frame. The same information can be obtained using `nrow()` and `ncol()` functions, respectively.


```r
dim(df)
```

```
## [1] 7 3
```

```r
nrow(df)
```

```
## [1] 7
```

```r
ncol(df)
```

```
## [1] 3
```

The `str()` function returns the structure of a dataframe. For each variable (column), it shows: the name, the type (numeric, character, factor etc.) and first elements.


```r
df
```

```
##   height   name gender
## 1    180  James      M
## 2    170 Stevie      M
## 3    175   Otis      M
## 4    190    Bob      M
## 5    168  Levon      M
## 6    160  Patti      F
## 7    165  Karen      F
```

```r
str(df)
```

```
## 'data.frame':	7 obs. of  3 variables:
##  $ height: num  180 170 175 190 168 160 165
##  $ name  : chr  "James" "Stevie" "Otis" "Bob" ...
##  $ gender: Factor w/ 2 levels "F","M": 2 2 2 2 2 1 1
```

The `head()` function show the first rows of a data frame. Its use is particularly convenient when data sets are long. `iris` is a built in R data set. It contains the measurements in centimeters of the variables sepal length and width and petal length and width, respectively, for 50 flowers from each of 3 species of iris.


```r
nrow(iris)
```

```
## [1] 150
```

```r
head(iris)
```

```
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
## 3          4.7         3.2          1.3         0.2  setosa
## 4          4.6         3.1          1.5         0.2  setosa
## 5          5.0         3.6          1.4         0.2  setosa
## 6          5.4         3.9          1.7         0.4  setosa
```


### Missing Values, Null Objects and Infinite

In R missing values are represented by the symbol `NA` (Not Available).


```r
x <- c(4, 1, "a")
y <- as.integer(x)
```

```
## Warning: NAs introduced by coercion
```

```r
y
```

```
## [1]  4  1 NA
```

The above chunk create a vector `x`.  The vector contains three values: 4, 1 and the character string "a". Then, elements of the vector are transformed into integer values. 

The character string "a" cannot be transformed, so a `NA` value is returned.

To check if data is missing, the function `is.na()` can be used.


```r
is.na(y)
```

```
## [1] FALSE FALSE  TRUE
```

The `NaN` symbol (Not a Number) represents a missing value obtained as a result of an impossible numerical operation. `NaN` can be detected with the function is.nan. 


```r
log(-1)
```

```
## Warning in log(-1): NaNs produced
```

```
## [1] NaN
```

```r
sqrt(-4)
```

```
## Warning in sqrt(-4): NaNs produced
```

```
## [1] NaN
```

```r
x <- log(c(-1, 1, 2))
```

```
## Warning in log(c(-1, 1, 2)): NaNs produced
```

```r
x
```

```
## [1]       NaN 0.0000000 0.6931472
```

```r
is.nan(x)
```

```
## [1]  TRUE FALSE FALSE
```

The `NULL` symbol represents the null object in R. `NULL` is often returned by expressions and functions whose value is undefined. The `is.null()` function returns `TRUE` if its argument is `NULL` and FALSE otherwise.


```r
x <- c()
x
```

```
## NULL
```

```r
is.null(x)
```

```
## [1] TRUE
```

Infinite values are represented by the `+Inf` and `-Inf` symbols in R.


```r
log(0)
```

```
## [1] -Inf
```

In the above example, R calculates the limit of the function $log(x)$ as $x$ approaches zero.

## Function Object

Functions are one of the most important objects in R as when working with R we all make constant use of functions.

A function is characterised by an input and an output. The input of the function, i.e. the set of the arguments, can be either null or made of one or more R objects. The output of the function can be either null or a single R object. If the function has to return more than one object, the objects are to be inserted in a list.

Let us see some examples:

The function `ls()` doesn't require any input and returns an output.


```r
ls()
```

```
##  [1] "back"      "char"      "cmat"      "comb"      "df"        "gender"    "go"        "grade"    
##  [9] "height"    "logic1"    "logic2"    "mark"      "mark1"     "mark2"     "mixed"     "ml1"      
## [17] "ml2"       "mydata"    "my_list"   "myrep"     "name"      "num"       "out"       "rmat"     
## [25] "seqby"     "seqlength" "size"      "vec1"      "vec2"      "vec3"      "x"         "y"        
## [33] "z"
```

The function `rm()` requires an input and doesn't return an output.


```r
foo <- 3
rm(foo)
```

Usually, functions require an input and returns an output.


```r
sum(1:10)
```

```
## [1] 55
```

It is advisable to use the help command of each function to understand not only the arguments which can be used as function inputs, but also the output:
  

```r
help(read.table)
```

or


```r
?read.table
```


Let us deeply explore function structure.

### Function structure

We can create and assign functions to a variable name as we do with any other object:


```r
f <- function(x, y = 0) {
  z <- x + y
  z
}
```

Eventually, we can delete any function with the usual call to `rm()` or `remove()`

Function structure is made up by three basic components: 

* a formal arguments list
* a body
* an environment. 


```r
formals(f)
```

```
## $x
## 
## 
## $y
## [1] 0
```

```r
body(f)
```

```
## {
##     z <- x + y
##     z
## }
```

```r
environment(f)
```

```
## <environment: R_GlobalEnv>
```


#### Formals
Formals are the formal arguments of a function.

When we call a function, formals arguments can be specified by position or by name and we can mix positional matching with matching by name so that the following are equivalent:


```r
mean(x = 1:5, trim = 0.1)
```

```
## [1] 3
```

```r
mean(1:5, trim = 0.1)
```

```
## [1] 3
```

```r
mean(x = 1:5, 0.1)
```

```
## [1] 3
```

```r
mean(1:5, 0.1)
```

```
## [1] 3
```

```r
mean(trim = 0.1, x = 1:5)
```

```
## [1] 3
```

Along with position and name, we can also specify formals by partial matching so that:


```r
mean(1:5, tr = 0.1)
```

```
## [1] 3
```

```r
mean(tr = 0.1, x = 1:5)
```

```
## [1] 3
```

would work anyway.

Functions formals may also have the construct `symbol = default`, that unless differently specified, forces any argument to be used with its default value.

Specifically, function `mean()` also have a third argument `na.rm` that defaults to `FALSE` and, as a result passing vectors with `NA` values to `mean()` returns `NA`


```r
mean(c(1, 2, NA))
```

```
## [1] NA
```

While, by specifying `na.rm=TRUE` we get the mean of all non missing elements of vector `x`.


```r
mean(c(1, 2, NA), na.rm = TRUE)
```

```
## [1] 1.5
```

The order `R` uses for matching formals against value is:

1. Check for exact match for a named argument
2. Check for a partial match
3. Check for a positional match


#### Body of a function

The body of a function is a parsed R statement. In practice, this implies that the body of a function needs to be correct from a formal point of view but no evaluation of the body of a function occurred yet. 

As a result, this function would return an error:


```r
wrong <- function(x) {x =}
```

as its body is not a correct `R` statement.

While this function:


```r
right <- function(x){x+h}
```

is accepted by `R` as is formally correct even thought, except under specific circumstances, will always return an error:


```r
right(x = 2)
```

```
## Error in right(x = 2): object 'h' not found
```

The body of a function, is usually a collection of statements in braces but it can be a single statement, a symbol or even a constant.

#### Environment of a function

Environments are a fundamental concept in R and their knowledge is essential for advanced programming.

Environments have the following fundamental concepts:

 * The environment of a function is the environment that was active at the time that the function was created. Generally, for user defined function, the Global environment:

    
    ```r
    f <- function(x){x+1}
    environment(f)
    ```
    
    ```
    ## <environment: R_GlobalEnv>
    ```
    or, when a function is defined within a package, the environment associated to that package:

    
    ```r
    environment(mean)
    ```
    
    ```
    ## <environment: namespace:base>
    ```

 * Objects defined within a function, exists in the environment of the function itself.
 
    
    ```r
    f <- function(x){x+1}
    x
    ```
    
    ```
    ## NULL
    ```

### Function Examples
   
There are lots of function types, let us see some examples.

#### Mathematical Functions

The names of the basic functions and mathematical operators in R follow the standards of programming languages. In this paragraph the functions and operators enabling basic mathematical operations to be performed will be dealt with. R can also be used to perform more complex calculations, such as matrix operations or calculations with complex numbers.

Functions are usually applied to one or more vectors. In this case, operations are performed on each element of each vector. Vectors have to be the same length.


```r
x <- 1:10
y <- 11:20
z <- -4:5
x + y + z
```

```
##  [1]  8 11 14 17 20 23 26 29 32 35
```

```r
exp(x)
```

```
##  [1]     2.718282     7.389056    20.085537    54.598150   148.413159   403.428793  1096.633158  2980.957987
##  [9]  8103.083928 22026.465795
```

```r
log(z)
```

```
## Warning in log(z): NaNs produced
```

```
##  [1]       NaN       NaN       NaN       NaN      -Inf 0.0000000 0.6931472 1.0986123 1.3862944 1.6094379
```

```r
abs(z)
```

```
##  [1] 4 3 2 1 0 1 2 3 4 5
```

```r
sqrt(x)
```

```
##  [1] 1.000000 1.414214 1.732051 2.000000 2.236068 2.449490 2.645751 2.828427 3.000000 3.162278
```

The `sum()` function calculates the sum of all the elements of a vector.


```r
sum(x)
```

```
## [1] 55
```

The `floor`, `ceiling`, `trunc` and `round` functions can be used to round a number. `floor()` returns a numeric vector containing the largest integers not greater than the corresponding input elements. `ceiling()` returns a numeric vector containing the smallest integers not less than the corresponding input elements. `trunc()` returns a numeric vector containing the integers formed by truncating the input values toward 0. `round()` rounds the values in its first argument to the specified number of decimal places (default 0).


```r
floor(3.14)
```

```
## [1] 3
```

```r
floor(3.67)
```

```
## [1] 3
```

```r
ceiling(3.14)
```

```
## [1] 4
```

```r
ceiling(3.67)
```

```
## [1] 4
```

```r
trunc(3.14)
```

```
## [1] 3
```

```r
trunc(3.67)
```

```
## [1] 3
```

```r
round(3.14, digits = 1)
```

```
## [1] 3.1
```

```r
round(3.19, digits = 1)
```

```
## [1] 3.2
```

#### Probabilistic Functions

Probabilistic functions in R fall into four categories:

 1. `r*` functions for generating random numbers,
 2. `d*` functions for calculating the value of the density function in a point,
 3. `p*` functions for calculating the cumulative distribution function,
 4. `q*` functions for calculating quantiles.

The asterisk indicates the distribution which is used: `norm` for normal distribution, `t` for Student's t-distribution, `binom` for binomial distribution, `gamma` distribution, `beta` distribution, `weibull` distribution, etc. R integrates numerous statistical distributions. The list of all the probability distributions included in the base R can be obtained by typing `help(Distributions)`. Other probability distributions become available when loading additional packages.

The following functions:

```r
rnorm(n = 10)
```

```
##  [1]  0.02337421 -1.44410066 -0.43434366 -0.04781239 -0.34635967  0.11256413  0.07641944  0.42482086
##  [9]  0.53604628  0.31538745
```

```r
rnorm(n = 20, mean = 3, sd = 5)
```

```
##  [1]  5.3239927  3.3400441  4.4148980  0.5964838 19.1105153  5.3903611  3.6090670  4.4191646 -5.1875807
## [10]  7.0353226 -4.4877227  3.4662121  5.2164005 -5.6929351  9.8080872  7.2742448 -2.4244734  9.8496841
## [19]  6.3544117  4.6772858
```

```r
rbinom(n = 50, size = 20, prob = 0.8)
```

```
##  [1] 16 11 20 16 13 17 14 18 15 17 14 17 15 16 18 16 16 17 13 14 13 15 15 16 19 16 16 14 20 14 16 13 16 14
## [35] 15 18 15 17 19 16 16 14 18 14 18 19 14 18 16 19
```

```r
rweibull(n = 30, shape = 5, scale = 3)
```

```
##  [1] 1.743297 2.161191 3.681191 2.646652 1.756540 2.784472 3.198930 1.682767 2.309938 2.361880 2.541066
## [12] 2.460120 1.928519 2.473901 1.855068 2.857655 2.785827 3.155953 2.253992 2.801523 2.753235 2.993436
## [23] 3.200559 2.797460 1.371322 2.415364 3.553419 2.900355 2.251122 2.618322
```
generate, respectively:

 - 10 pseudorandom values from a normal distribution with parameters (0, 1);
 - 20 pseudorandom values from a normal distribution with parameters (3, 5);
 - 50 pseudorandom values from a binomial distribution with $n = 20$ and $\pi = 0.8$;
 - 50 pseudorandom values from a Weibull distribution with parameters (5, 3).

The following functions:

```r
dbinom(x = 20, size = 20, prob = 0.8)
```

```
## [1] 0.01152922
```

```r
dnorm(x = -5:5, mean = 0, sd = 1)
```

```
##  [1] 1.486720e-06 1.338302e-04 4.431848e-03 5.399097e-02 2.419707e-01 3.989423e-01 2.419707e-01 5.399097e-02
##  [9] 4.431848e-03 1.338302e-04 1.486720e-06
```
calculate, respectively:

 - the probability that `x` is equal to 20, if `x` is distributed as a binomial distribution with $n = 20$ and $\pi = 0.8$;
 - thee values of the density function of a standard normal for integer values comprised between -5 and 5. As expected, the highest value is obtained with 0. 

The following functions:

```r
pnorm(q = 0, mean = 0, sd = 1)
```

```
## [1] 0.5
```

```r
pbinom(q = 20, size = 20, prob = 0.8)
```

```
## [1] 1
```
calculate, respectively:

 - the value of the cumulative distribution function of a standard normal distribution at zero; as expected the result is 0.5.
 - the value of a cumulative distribution function of a binomial distribution with parameters $n = 20$ and $\pi = 0.8$ at 20; as expected, the result is 1.

The following functions:

```r
qnorm(p = 0.5, mean = 0, sd = 1)
```

```
## [1] 0
```

```r
qbinom(p = 0.5, size = 20, prob = 0.8)
```

```
## [1] 16
```
calculate, respectively:

 - the quantile with which a 0.5 probability on the left is obtained in a standard normal distribution;
 - The quantile with which a 0.5 probability on the left is obtained in a binomial distribution with parameters $n = 20$ and $\pi = 0.8$.

#### Statistical Functions

Any kind of statistical analysis can be performed in R thanks to the built-in functions of the base version or the numerous additional packages. The functions enabling the calculation of the main descriptive statistical analyses are explained below.
 
The `mean()`, `median()`, `sd()` and `var()` functions are used to calculate the mean, the median, the sample standard deviation and the sample variance of a numeric vector. 


```r
x <- mtcars$mpg
mean(x)
```

```
## [1] 20.09062
```

```r
median(x)
```

```
## [1] 19.2
```

```r
sd(x)  
```

```
## [1] 6.026948
```

```r
var(x)
```

```
## [1] 36.3241
```

The `quantile()` function calculates one or more quantiles.


```r
quantile(x, .9) 
```

```
##   90% 
## 30.09
```

```r
quantile(x, c(.3, .84))
```

```
##    30%    84% 
## 15.980 26.052
```

```r
quantile(x, c(.25, .50, .75))
```

```
##    25%    50%    75% 
## 15.425 19.200 22.800
```

The `min()` and `max()` functions return the minimum and maximum  value respectively.


```r
min(x)
```

```
## [1] 10.4
```

```r
max(x)
```

```
## [1] 33.9
```

The `summary()` generic function applied to a numeric vector returns minimum, maximum, quartiles and arithmetic mean.


```r
summary(x)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   10.40   15.42   19.20   20.09   22.80   33.90
```

Correlation and covariance can be calculated with the `cor()` and `cov()` functions, respectively.


```r
data <- mtcars[, c(1, 3, 4, 5, 6)]
cor(data)
```

```
##             mpg       disp         hp       drat         wt
## mpg   1.0000000 -0.8475514 -0.7761684  0.6811719 -0.8676594
## disp -0.8475514  1.0000000  0.7909486 -0.7102139  0.8879799
## hp   -0.7761684  0.7909486  1.0000000 -0.4487591  0.6587479
## drat  0.6811719 -0.7102139 -0.4487591  1.0000000 -0.7124406
## wt   -0.8676594  0.8879799  0.6587479 -0.7124406  1.0000000
```

```r
cov(data)
```

```
##              mpg        disp         hp        drat          wt
## mpg    36.324103  -633.09721 -320.73206   2.1950635  -5.1166847
## disp -633.097208 15360.79983 6721.15867 -47.0640192 107.6842040
## hp   -320.732056  6721.15867 4700.86694 -16.4511089  44.1926613
## drat    2.195064   -47.06402  -16.45111   0.2858814  -0.3727207
## wt     -5.116685   107.68420   44.19266  -0.3727207   0.9573790
```

