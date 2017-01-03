


# A First Look to R Session

## The First R Session

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

Results of calculations can be stored in objects using the assignment operators:
  
 - an arrow (`<-`) formed by a smaller than character and a hyphen without a space;
 - the equal character (`=`).

These objects can then be used in other calculations. 

There are some restrictions when giving an object a name:
  
 - Object names cannot contain "strange" symbols like `!`, `+`, `-`, `#`.
 - A dot (`.`) and an underscore (`_`) are allowed, also a name starting with a dot.
 - Object names can contain a number but cannot start with a number.
 - R is case sensitive: `X` and `x` are two different objects, as well as `temp` and `temP`.


```r
x <- log(14)
y <- 23.76 * log(8)/(23 + atan(9))
z <- x + y
```
To print the object just enter the name of the object or use `print()` function. 


```r
x
```

```
## [1] 2.639057
```

```r
y
```

```
## [1] 2.01992
```

```r
print(z)
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

So to run the function `ls` the name followed by an opening and a closing bracket must be entered. Entering only `ls` will just print the object, i.e. the underlying R code of the function.

Most functions in R accept certain arguments. For example, one of the arguments of the function `ls()` is pattern. To list all objects starting with the letter `x`:
  

```r
x2 <- log(9)
ls(pattern = "x")
```

```
## [1] "x"  "x2"
```

### Removing objects

If a value to an object that already exists is assigned then the contents of the object will be overwritten with the new value (without a warning!). The function `rm()` ought be used to remove one or more objects from your session.


```r
rm(x2)
ls()
```

```
## [1] "x" "y" "z"
```

### Garbage collection

When objects are no longer used, and this clearly happens when objects are deleted, `R` releases immediately the memory they filled in the system. This is done automatically by the garbage collector `gc()`.

We can call `gc()` also to see how much memory `R` is using for allocating objects


```r
gc()
```

```
##          used (Mb) gc trigger (Mb) max used (Mb)
## Ncells 412003 22.1     750400 40.1   592000 31.7
## Vcells 590170  4.6    1308461 10.0   812817  6.3
```

## The Working Directory

If you want to read files from a specific location or write files to a specific location without typing (on Windows, usually very long) path names you will need to set working directory in R. 

You can set a working directory with `setwd()` function, using absolute or relative paths.
The following example shows how to set the working directory in R using an absolute path. The working directory is set to the folder "Data" within the folder "Documents and Settings" on the C drive.


```r
setwd("C:/User/Andrea/Documents and Settings/Data")
```

Remember that you must use the forward slash / or double backslash \\\\ in R! The Windows format of single backslash will not work.

It is a nice approach, but things get complicated if you move files to different computers, say from home to your office, and have different directory structures, disk names etc. Of course you can change it every time. 
Using relative paths solves this problem. Relative paths are more convenient than absolute paths as they makes your R script or RStudio project independent of the directory structure in which it resides thus facilitating the reproducibility of your work on a different PC.

So, you can use `getwd()` function to get the path of the current working directory:


```r
getwd()
```

```
## [1] "C:/User/Andrea/Documents and Settings/Data"
```
Suppose that your current directory is the previous one ("Data" folder) and you want to set the directory on "Statistics" folder inside "Data" folder: 


```r
setwd("./Statistics")
```

```
## [1] "C:/User/Andrea/Documents and Settings/Data/Statistics"
```

`.` represents your current directory. 

Suppose that your current directory is the previous one ("Statistics" folder) and you want to set the directory on "Maths" folder inside "Data" folder:


```r
setwd("./../Maths")
```

```
## [1] "C:/User/Andrea/Documents and Settings/Data/Maths"
```

`..` are useful to move up the directory hierarchy relative to the current working directory. In particular, you move out from "Statistics" folder, and up into the "Maths" folder. 


## R help

Within R, the following functions provide help about R itself:

 - The HTML version of R's online documentation can be printed on-screen by typing `help.start()`;
 - Online documentation for most of the functions and variables in R can be printed on-screen by typing `help(name)` (or `?name`), where _name_ is the name of the topic help is sought for;
 - Online documentation for finding help pages on a vague topic can be printed on-screen by typing `help.search('topic')`;
 - A list of function containing _topic_ in the name can be printed on-screen by typing `apropos('topic')`;
 - A research in the website can be performed by typing `RSiteSearch('query')`, where _query_ is the search query.

To get help about the `mean()` function, the `help()` function can be used.


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

