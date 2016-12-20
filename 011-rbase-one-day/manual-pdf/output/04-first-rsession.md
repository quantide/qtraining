
# Your first R session




## Aritmetic with R

Start the R system, the cursor is waiting for you to type in some R commands. For example, use R as a simple calculator:


```r
6 + 3
```

```
## [1] 9
```

```r
5 - 9
```

```
## [1] -4
```

```r
4 * 6
```

```
## [1] 24
```

```r
8 / 3
```

```
## [1] 2.666667
```

```r
5 ^ 2
```

```
## [1] 25
```

```r
(1 + 0.05)^8
```

```
## [1] 1.477455
```

```r
exp(3)
```

```
## [1] 20.08554
```

```r
log(14)
```

```
## [1] 2.639057
```

```r
23.76 * log(8)/(23 + atan(9))
```

```
## [1] 2.01992
```

## Assignment

Results of calculations can be stored in objects using the assignment operator:


```r
x <- log(14)
y <- 23.76 * log(8)/(23 + atan(9))
```

To print the object just enter the name of the object or use `print()` function. 


```r
x
```

```
## [1] 2.639057
```

```r
print(y)
```

```
## [1] 2.01992
```

These objects can then be used in other calculations. 


```r
z <- x + y
z
```

```
## [1] 4.658978
```

## The R Workspace

The workspace is your current R working environment and includes any user-defined objects. It is also known as global environment.

### Objects listing

Objects created during an R session are hold in memory. To list the objects in the current R session, the function `ls()` or the function `objects()` may be used.


```r
ls()
```

```
## [1] "x" "y" "z"
```

```r
objects()
```

```
## [1] "x" "y" "z"
```


### Removing objects

If a value to an object that already exists is assigned then the contents of the object will be overwritten with the new value (without a warning!). The function `rm()` ought be used to remove one or more objects from your session.


```r
rm(x)
ls()
```

```
## [1] "y" "z"
```


## R help

Within R, the following functions provide help about R itself:

 - The HTML version of R's online documentation can be printed on-screen by typing `help.start()`;
 - Online documentation for most of the functions and variables in R can be printed on-screen by typing `help(name)` (or `?name`), where _name_ is the name of the topic help is sought for;
 - Online documentation for finding help pages on a vague topic can be printed on-screen by typing `help.search('topic')`;
 - A list of function containing _topic_ in the name can be printed on-screen by typing `apropos('topic')`;
 - A research in the website can be performed by typing `RSiteSearch('query')`, where _query_ is the search query.

For example, to get help about the `mean()` function, the `help()` function can be used.


```r
help(mean)
```

The `help()` function can be called using the `?`.

```r
?mean
```

To get a list of functions concerning the mean, the `help.search()` function can be used.


```r
help.search("mean")
```

To get a list of function containing "mean" in the name, the `apropos()` function can be used.


```r
apropos("mean")
```
