
# Data Manipulation with R





\begin{center}\includegraphics[width=3.33in]{images/flow-dtman} \end{center}

The `dplyr` package for `R` is very powerful for data management since:

* it simplifies how you can think about common data manipulation tasks
* it provides simple "verbs", functions that correspond to the most common data manipulation tasks
* it uses efficient data storage backends, so you spend less time waiting for the computer


```r
require(dplyr)
```

The examples of this chapter will refer to `bank` data set which contains information about a direct marketing campaigns of a Portuguese banking institution based on phone calls. 


```r
require(qdata)
data(bank) 
bank
```

```
## # A tibble: 45,211 × 20
##       id   age          job  marital education default balance housing
##    <int> <int>       <fctr>   <fctr>    <fctr>  <fctr>   <int>  <fctr>
## 1      1    58   management  married  tertiary      no    2143     yes
## 2      2    44   technician   single secondary      no      29     yes
## 3      3    33 entrepreneur  married secondary      no       2     yes
## 4      4    47  blue-collar  married   unknown      no    1506     yes
## 5      5    33      unknown   single   unknown      no       1      no
## 6      6    35   management  married  tertiary      no     231     yes
## 7      7    28   management   single  tertiary      no     447     yes
## 8      8    42 entrepreneur divorced  tertiary     yes       2     yes
## 9      9    58      retired  married   primary      no     121     yes
## 10    10    43   technician   single secondary      no     593     yes
## # ... with 45,201 more rows, and 12 more variables: loan <fctr>,
## #   contact <fctr>, day <int>, month <fctr>, year <int>, date <dttm>,
## #   duration <int>, campaign <int>, pdays <int>, previous <int>,
## #   poutcome <fctr>, y <fctr>
```

In the following paragraphs, we will explore the innovations introduced by `dplyr` to make our lifes easier when dealing with dataframes manipulation tasks.     
In particular:

* pipe operator (`%>%`) 
* dplyr verbs for data manipulation 
* dplyr verbs for combining data


## Pipe operator (`%>%`)

`dplyr` pipe operator (`%>%`) allows us to pipe the output from one function to the input of another function. The idea of piping is to read the functions from left to right. It is particularly useful with nested functions (reading from the inside to the outside) or with multiple operations.

\clearpage

\begin{figure}

{\centering \includegraphics[width=4in]{images/pipe} 

}

\caption{Source: www.datacamp.com}(\#fig:g2)
\end{figure}

Pipes can work with nearly any functions (`dplyr` and not-`dplyr` functions), let us see an example.

Suppose we want to visualize the first rows of `bank` dataframe, by using `head()` function.   

Usually we write:


```r
head(bank)
```

```
## # A tibble: 6 × 20
##      id   age          job marital education default balance housing
##   <int> <int>       <fctr>  <fctr>    <fctr>  <fctr>   <int>  <fctr>
## 1     1    58   management married  tertiary      no    2143     yes
## 2     2    44   technician  single secondary      no      29     yes
## 3     3    33 entrepreneur married secondary      no       2     yes
## 4     4    47  blue-collar married   unknown      no    1506     yes
## 5     5    33      unknown  single   unknown      no       1      no
## 6     6    35   management married  tertiary      no     231     yes
## # ... with 12 more variables: loan <fctr>, contact <fctr>, day <int>,
## #   month <fctr>, year <int>, date <dttm>, duration <int>, campaign <int>,
## #   pdays <int>, previous <int>, poutcome <fctr>, y <fctr>
```

By using `%>%`, the code becomes:


```r
bank %>% head()
```

```
## # A tibble: 6 × 20
##      id   age          job marital education default balance housing
##   <int> <int>       <fctr>  <fctr>    <fctr>  <fctr>   <int>  <fctr>
## 1     1    58   management married  tertiary      no    2143     yes
## 2     2    44   technician  single secondary      no      29     yes
## 3     3    33 entrepreneur married secondary      no       2     yes
## 4     4    47  blue-collar married   unknown      no    1506     yes
## 5     5    33      unknown  single   unknown      no       1      no
## 6     6    35   management married  tertiary      no     231     yes
## # ... with 12 more variables: loan <fctr>, contact <fctr>, day <int>,
## #   month <fctr>, year <int>, date <dttm>, duration <int>, campaign <int>,
## #   pdays <int>, previous <int>, poutcome <fctr>, y <fctr>
```

Pipe takes the argument on the left (`bank`) and passes it to the function on the right (`head()`). So you don't need to write the first argument of the function. 

Other arguments of the function must be added to the function itself, as usually done. By default `head()` prints the first 6 rows of the dataframe. Suppose we want to print 10 rows, by setting `n` argument to 10:


```r
bank %>% head(n=10)
```

```
## # A tibble: 10 × 20
##       id   age          job  marital education default balance housing
##    <int> <int>       <fctr>   <fctr>    <fctr>  <fctr>   <int>  <fctr>
## 1      1    58   management  married  tertiary      no    2143     yes
## 2      2    44   technician   single secondary      no      29     yes
## 3      3    33 entrepreneur  married secondary      no       2     yes
## 4      4    47  blue-collar  married   unknown      no    1506     yes
## 5      5    33      unknown   single   unknown      no       1      no
## 6      6    35   management  married  tertiary      no     231     yes
## 7      7    28   management   single  tertiary      no     447     yes
## 8      8    42 entrepreneur divorced  tertiary     yes       2     yes
## 9      9    58      retired  married   primary      no     121     yes
## 10    10    43   technician   single secondary      no     593     yes
## # ... with 12 more variables: loan <fctr>, contact <fctr>, day <int>,
## #   month <fctr>, year <int>, date <dttm>, duration <int>, campaign <int>,
## #   pdays <int>, previous <int>, poutcome <fctr>, y <fctr>
```

\clearpage

## dplyr verbs for data manipulation

`dplyr` aims to provide a function for each basic verb of data manipulation and data discovery.

All these functions are very similar:

* the first argument is a data frame;
* the subsequent arguments describe what to do with it, and you can refer to columns in the data frame directly without using $. Note that the column names must be unquoted;
* the result is a new data frame.

Let us have a look to `dplyr` verbs for data manipulation:

* `select()`: select variables of interest 
* `filter()`: filter records of interest
* `arrange()`: reorder the rows 
* `mutate()`: add new variables that are functions of existing ones

###  `select()`

Often you work with large datasets with many columns where only a few are actually of interest to you. 

`select()` allows you to rapidly zoom in on a useful subset of columns.  

![select scheme](images/sel.png) 




```r
# Select columns: year, month and day of bank data frame
select(bank, year, month, day)
```

```
## # A tibble: 45,211 × 3
##     year  month   day
##    <int> <fctr> <int>
## 1   2008    may     5
## 2   2008    may     5
## 3   2008    may     5
## 4   2008    may     5
## 5   2008    may     5
## 6   2008    may     5
## 7   2008    may     5
## 8   2008    may     5
## 9   2008    may     5
## 10  2008    may     5
## # ... with 45,201 more rows
```

```r
# Select columns: year, month and day of bank data frame
bank %>% select(year:day)
```

```
## # A tibble: 45,211 × 3
##     year  month   day
##    <int> <fctr> <int>
## 1   2008    may     5
## 2   2008    may     5
## 3   2008    may     5
## 4   2008    may     5
## 5   2008    may     5
## 6   2008    may     5
## 7   2008    may     5
## 8   2008    may     5
## 9   2008    may     5
## 10  2008    may     5
## # ... with 45,201 more rows
```

```r
# Select all columns of bank data frame apart from: year, month and day
bank %>% select(-(year:day))
```

```
## # A tibble: 45,211 × 17
##       id   age          job  marital education default balance housing
##    <int> <int>       <fctr>   <fctr>    <fctr>  <fctr>   <int>  <fctr>
## 1      1    58   management  married  tertiary      no    2143     yes
## 2      2    44   technician   single secondary      no      29     yes
## 3      3    33 entrepreneur  married secondary      no       2     yes
## 4      4    47  blue-collar  married   unknown      no    1506     yes
## 5      5    33      unknown   single   unknown      no       1      no
## 6      6    35   management  married  tertiary      no     231     yes
## 7      7    28   management   single  tertiary      no     447     yes
## 8      8    42 entrepreneur divorced  tertiary     yes       2     yes
## 9      9    58      retired  married   primary      no     121     yes
## 10    10    43   technician   single secondary      no     593     yes
## # ... with 45,201 more rows, and 9 more variables: loan <fctr>,
## #   contact <fctr>, date <dttm>, duration <int>, campaign <int>,
## #   pdays <int>, previous <int>, poutcome <fctr>, y <fctr>
```

You can rename variables with `select()` by using named arguments:


```r
# Rename id variable as ID
bank %>% select(ID = id)
```

```
## # A tibble: 45,211 × 1
##       ID
##    <int>
## 1      1
## 2      2
## 3      3
## 4      4
## 5      5
## 6      6
## 7      7
## 8      8
## 9      9
## 10    10
## # ... with 45,201 more rows
```


### `filter()`

`filter()` allows you to select a subset of the rows of a data frame.

![filter scheme](images/fil.png) 



```r
# filter all calls made to students with balance above 20,000 in bank data frame
filter(bank, job == "student", balance > 20000)
```

```
## # A tibble: 3 × 20
##      id   age     job marital education default balance housing   loan
##   <int> <int>  <fctr>  <fctr>    <fctr>  <fctr>   <int>  <fctr> <fctr>
## 1 31125    24 student  single secondary      no   23878      no     no
## 2 39536    24 student  single secondary      no   23878      no     no
## 3 41923    27 student  single  tertiary      no   24025      no     no
## # ... with 11 more variables: contact <fctr>, day <int>, month <fctr>,
## #   year <int>, date <dttm>, duration <int>, campaign <int>, pdays <int>,
## #   previous <int>, poutcome <fctr>, y <fctr>
```

`filter()` allows you to give it any number of filtering conditions which are joined together with `&` and/or the other operators.  


```r
# Filter all calls made to student of 18 years in bank data frame
bank %>% filter(age == 18 & job == "student")
```

```
## # A tibble: 12 × 20
##       id   age     job marital education default balance housing   loan
##    <int> <int>  <fctr>  <fctr>    <fctr>  <fctr>   <int>  <fctr> <fctr>
## 1  40737    18 student  single   primary      no    1944      no     no
## 2  40745    18 student  single   unknown      no     108      no     no
## 3  40888    18 student  single   primary      no     608      no     no
## 4  41223    18 student  single   unknown      no      35      no     no
## 5  41253    18 student  single secondary      no       5      no     no
## 6  41274    18 student  single   unknown      no       3      no     no
## 7  41488    18 student  single   unknown      no     108      no     no
## 8  42147    18 student  single secondary      no     156      no     no
## 9  42275    18 student  single   primary      no     608      no     no
## 10 42955    18 student  single   unknown      no     108      no     no
## 11 43638    18 student  single   unknown      no     348      no     no
## 12 44645    18 student  single   unknown      no     438      no     no
## # ... with 11 more variables: contact <fctr>, day <int>, month <fctr>,
## #   year <int>, date <dttm>, duration <int>, campaign <int>, pdays <int>,
## #   previous <int>, poutcome <fctr>, y <fctr>
```


```r
# Filter all calls made to people of 18 or 95 years in bank data frame
bank %>% filter(age == 18 | age == 95)
```

```
## # A tibble: 14 × 20
##       id   age     job  marital education default balance housing   loan
##    <int> <int>  <fctr>   <fctr>    <fctr>  <fctr>   <int>  <fctr> <fctr>
## 1  33700    95 retired divorced   primary      no    2282      no     no
## 2  40737    18 student   single   primary      no    1944      no     no
## 3  40745    18 student   single   unknown      no     108      no     no
## 4  40888    18 student   single   primary      no     608      no     no
## 5  41223    18 student   single   unknown      no      35      no     no
## 6  41253    18 student   single secondary      no       5      no     no
## 7  41274    18 student   single   unknown      no       3      no     no
## 8  41488    18 student   single   unknown      no     108      no     no
## 9  41664    95 retired  married secondary      no       0      no     no
## 10 42147    18 student   single secondary      no     156      no     no
## 11 42275    18 student   single   primary      no     608      no     no
## 12 42955    18 student   single   unknown      no     108      no     no
## 13 43638    18 student   single   unknown      no     348      no     no
## 14 44645    18 student   single   unknown      no     438      no     no
## # ... with 11 more variables: contact <fctr>, day <int>, month <fctr>,
## #   year <int>, date <dttm>, duration <int>, campaign <int>, pdays <int>,
## #   previous <int>, poutcome <fctr>, y <fctr>
```

`filter()` can be used also with `%in%` to establish conditions under which filter: 


```r
# Filter all calls made to people of 18 or 95 years in bank data frame
bank %>% filter(age %in% c(18,95))
```

```
## # A tibble: 14 × 20
##       id   age     job  marital education default balance housing   loan
##    <int> <int>  <fctr>   <fctr>    <fctr>  <fctr>   <int>  <fctr> <fctr>
## 1  33700    95 retired divorced   primary      no    2282      no     no
## 2  40737    18 student   single   primary      no    1944      no     no
## 3  40745    18 student   single   unknown      no     108      no     no
## 4  40888    18 student   single   primary      no     608      no     no
## 5  41223    18 student   single   unknown      no      35      no     no
## 6  41253    18 student   single secondary      no       5      no     no
## 7  41274    18 student   single   unknown      no       3      no     no
## 8  41488    18 student   single   unknown      no     108      no     no
## 9  41664    95 retired  married secondary      no       0      no     no
## 10 42147    18 student   single secondary      no     156      no     no
## 11 42275    18 student   single   primary      no     608      no     no
## 12 42955    18 student   single   unknown      no     108      no     no
## 13 43638    18 student   single   unknown      no     348      no     no
## 14 44645    18 student   single   unknown      no     438      no     no
## # ... with 11 more variables: contact <fctr>, day <int>, month <fctr>,
## #   year <int>, date <dttm>, duration <int>, campaign <int>, pdays <int>,
## #   previous <int>, poutcome <fctr>, y <fctr>
```

```r
# Filter all calls made to people whose job is admin. or technician in bank data frame
bank %>% filter(job %in% c("admin.","technician"))
```

```
## # A tibble: 12,768 × 20
##       id   age        job  marital education default balance housing
##    <int> <int>     <fctr>   <fctr>    <fctr>  <fctr>   <int>  <fctr>
## 1      2    44 technician   single secondary      no      29     yes
## 2     10    43 technician   single secondary      no     593     yes
## 3     11    41     admin. divorced secondary      no     270     yes
## 4     12    29     admin.   single secondary      no     390     yes
## 5     13    53 technician  married secondary      no       6     yes
## 6     14    58 technician  married   unknown      no      71     yes
## 7     17    45     admin.   single   unknown      no      13     yes
## 8     26    44     admin.  married secondary      no    -372     yes
## 9     30    36 technician   single secondary      no     265     yes
## 10    31    57 technician  married secondary      no     839      no
## # ... with 12,758 more rows, and 12 more variables: loan <fctr>,
## #   contact <fctr>, day <int>, month <fctr>, year <int>, date <dttm>,
## #   duration <int>, campaign <int>, pdays <int>, previous <int>,
## #   poutcome <fctr>, y <fctr>
```

```r
# Filter all calls made to people whose job is admin. or technician in bank data frame
bank %>% filter(job == "admin." | job == "technician")
```

```
## # A tibble: 12,768 × 20
##       id   age        job  marital education default balance housing
##    <int> <int>     <fctr>   <fctr>    <fctr>  <fctr>   <int>  <fctr>
## 1      2    44 technician   single secondary      no      29     yes
## 2     10    43 technician   single secondary      no     593     yes
## 3     11    41     admin. divorced secondary      no     270     yes
## 4     12    29     admin.   single secondary      no     390     yes
## 5     13    53 technician  married secondary      no       6     yes
## 6     14    58 technician  married   unknown      no      71     yes
## 7     17    45     admin.   single   unknown      no      13     yes
## 8     26    44     admin.  married secondary      no    -372     yes
## 9     30    36 technician   single secondary      no     265     yes
## 10    31    57 technician  married secondary      no     839      no
## # ... with 12,758 more rows, and 12 more variables: loan <fctr>,
## #   contact <fctr>, day <int>, month <fctr>, year <int>, date <dttm>,
## #   duration <int>, campaign <int>, pdays <int>, previous <int>,
## #   poutcome <fctr>, y <fctr>
```


### `arrange()`

Function `arrange()` reorders a data frame by one or more variables. If you provide more than one column name, each additional column will be used to break ties in the values of preceding columns:

![arrange scheme](images/arr.png)



```r
# Order `bank` data frame by the balance of the account in ascending order
arrange(bank, balance)
```

```
## # A tibble: 45,211 × 20
##       id   age           job  marital education default balance housing
##    <int> <int>        <fctr>   <fctr>    <fctr>  <fctr>   <int>  <fctr>
## 1  12910    26   blue-collar   single secondary     yes   -8019      no
## 2  15683    49    management  married  tertiary     yes   -6847      no
## 3  38737    60    management divorced  tertiary      no   -4057     yes
## 4   7414    43    management  married  tertiary     yes   -3372     yes
## 5   1897    57 self-employed  married  tertiary     yes   -3313     yes
## 6  32714    39 self-employed  married  tertiary      no   -3058     yes
## 7  18574    40    technician  married  tertiary     yes   -2827     yes
## 8  31510    52    management  married  tertiary      no   -2712     yes
## 9  25120    49   blue-collar   single   primary     yes   -2604     yes
## 10 14435    51    management divorced  tertiary      no   -2282     yes
## # ... with 45,201 more rows, and 12 more variables: loan <fctr>,
## #   contact <fctr>, day <int>, month <fctr>, year <int>, date <dttm>,
## #   duration <int>, campaign <int>, pdays <int>, previous <int>,
## #   poutcome <fctr>, y <fctr>
```



```r
# Order `bank` data frame by the balance of the account in descending order
bank %>% arrange(desc(balance))
```

```
## # A tibble: 45,211 × 20
##       id   age          job  marital education default balance housing
##    <int> <int>       <fctr>   <fctr>    <fctr>  <fctr>   <int>  <fctr>
## 1  39990    51   management   single  tertiary      no  102127      no
## 2  26228    59   management  married  tertiary      no   98417      no
## 3  42559    84      retired  married secondary      no   81204      no
## 4  43394    84      retired  married secondary      no   81204      no
## 5  41694    60      retired  married   primary      no   71188      no
## 6  19786    56   management divorced  tertiary      no   66721      no
## 7  21193    52  blue-collar  married   primary      no   66653      no
## 8  19421    59       admin.  married   unknown      no   64343      no
## 9  41375    32 entrepreneur   single  tertiary      no   59649      no
## 10 12927    56  blue-collar  married secondary      no   58932      no
## # ... with 45,201 more rows, and 12 more variables: loan <fctr>,
## #   contact <fctr>, day <int>, month <fctr>, year <int>, date <dttm>,
## #   duration <int>, campaign <int>, pdays <int>, previous <int>,
## #   poutcome <fctr>, y <fctr>
```



```r
# Order `bank` data frame by age of the client and by the balance of the account in descending order
bank %>% arrange(age, desc(balance))
```

```
## # A tibble: 45,211 × 20
##       id   age     job marital education default balance housing   loan
##    <int> <int>  <fctr>  <fctr>    <fctr>  <fctr>   <int>  <fctr> <fctr>
## 1  40737    18 student  single   primary      no    1944      no     no
## 2  40888    18 student  single   primary      no     608      no     no
## 3  42275    18 student  single   primary      no     608      no     no
## 4  44645    18 student  single   unknown      no     438      no     no
## 5  43638    18 student  single   unknown      no     348      no     no
## 6  42147    18 student  single secondary      no     156      no     no
## 7  40745    18 student  single   unknown      no     108      no     no
## 8  41488    18 student  single   unknown      no     108      no     no
## 9  42955    18 student  single   unknown      no     108      no     no
## 10 41223    18 student  single   unknown      no      35      no     no
## # ... with 45,201 more rows, and 11 more variables: contact <fctr>,
## #   day <int>, month <fctr>, year <int>, date <dttm>, duration <int>,
## #   campaign <int>, pdays <int>, previous <int>, poutcome <fctr>, y <fctr>
```


\clearpage

### `mutate()`

As well as selecting from the set of existing columns, it’s often useful to add new columns that are functions of existing ones. This is the job of `mutate()`:

![mutate scheme](images/mut.png) 


```r
# generate a variable indicating the total number of times each person has been contacted 
# during this campaign and during the previous ones 
mutate(bank, contacts_n = campaign + previous)
```

```
## # A tibble: 45,211 × 21
##       id   age          job  marital education default balance housing
##    <int> <int>       <fctr>   <fctr>    <fctr>  <fctr>   <int>  <fctr>
## 1      1    58   management  married  tertiary      no    2143     yes
## 2      2    44   technician   single secondary      no      29     yes
## 3      3    33 entrepreneur  married secondary      no       2     yes
## 4      4    47  blue-collar  married   unknown      no    1506     yes
## 5      5    33      unknown   single   unknown      no       1      no
## 6      6    35   management  married  tertiary      no     231     yes
## 7      7    28   management   single  tertiary      no     447     yes
## 8      8    42 entrepreneur divorced  tertiary     yes       2     yes
## 9      9    58      retired  married   primary      no     121     yes
## 10    10    43   technician   single secondary      no     593     yes
## # ... with 45,201 more rows, and 13 more variables: loan <fctr>,
## #   contact <fctr>, day <int>, month <fctr>, year <int>, date <dttm>,
## #   duration <int>, campaign <int>, pdays <int>, previous <int>,
## #   poutcome <fctr>, y <fctr>, contacts_n <int>
```

`mutate()` allows you to refer to columns that you just created:


```r
# generate two variable: one indicating the year of birth and one the year of birth without century 
bank %>% mutate(year_of_birth = year - age, year_of_birth_no_century = year_of_birth - 1900)
```

```
## # A tibble: 45,211 × 22
##       id   age          job  marital education default balance housing
##    <int> <int>       <fctr>   <fctr>    <fctr>  <fctr>   <int>  <fctr>
## 1      1    58   management  married  tertiary      no    2143     yes
## 2      2    44   technician   single secondary      no      29     yes
## 3      3    33 entrepreneur  married secondary      no       2     yes
## 4      4    47  blue-collar  married   unknown      no    1506     yes
## 5      5    33      unknown   single   unknown      no       1      no
## 6      6    35   management  married  tertiary      no     231     yes
## 7      7    28   management   single  tertiary      no     447     yes
## 8      8    42 entrepreneur divorced  tertiary     yes       2     yes
## 9      9    58      retired  married   primary      no     121     yes
## 10    10    43   technician   single secondary      no     593     yes
## # ... with 45,201 more rows, and 14 more variables: loan <fctr>,
## #   contact <fctr>, day <int>, month <fctr>, year <int>, date <dttm>,
## #   duration <int>, campaign <int>, pdays <int>, previous <int>,
## #   poutcome <fctr>, y <fctr>, year_of_birth <int>,
## #   year_of_birth_no_century <dbl>
```

<!--
elaborazioni non assegnate. modificare?
-->


## dplyr verbs for combining data

Very often you will have to deal with many tables that contribute to the analysis you are performing and you need flexible tools to combine them. Supposing that the two tables are already in a tidy form: the rows are observations and the columns are variables, `dplyr` provides  __mutating joins__, which add new variables to one table from matching rows in another.

There are four types of mutating join, which differ in their behaviour when a match is not found. 

* `inner_join(x, y)`
* `left_join(x, y)`
* `right_join(x, y)`
* `outer_join(x, y)`

All these verbs work similarly: 

* the first two arguments, `x` and `y`, provide the tables to combine
* the output is always a new table with the same type as `x`

<!--
While mutating joins are primarily used to add new variables, they can also generate new observations. If a match is not unique, a join will add all possible combinations (the Cartesian product) of the matching observations.
-->

For the next examples we will consider these two small data frames:


```r
df1 <- data.frame(id = 1:4, x1 = letters[1:4])
df1
```

```
##   id x1
## 1  1  a
## 2  2  b
## 3  3  c
## 4  4  d
```

```r
df2 <- data.frame(id = 3:5, x2 = letters[3:5])
df2
```

```
##   id x2
## 1  3  c
## 2  4  d
## 3  5  e
```

### `inner_join(x, y)`


\begin{center}\includegraphics[width=1.73in]{images/inner_join} \end{center}

`inner_join(x, y)` only includes observations that match in both x and y:


```r
inner_join(df1, df2)
```

```
## Joining, by = "id"
```

```
##   id x1 x2
## 1  3  c  c
## 2  4  d  d
```

### `left_join(x, y)`


\begin{center}\includegraphics[width=1.7in]{images/left_join} \end{center}

`left_join(x, y)` includes all observations in `x`, regardless of whether they match or not. This is the most commonly used join because it ensures that you don't lose observations from your primary table:


```r
left_join(df1, df2)
```

```
## Joining, by = "id"
```

```
##   id x1   x2
## 1  1  a <NA>
## 2  2  b <NA>
## 3  3  c    c
## 4  4  d    d
```

### `right_join(x, y)`


\begin{center}\includegraphics[width=1.73in]{images/right_join} \end{center}

`right_join(x, y)` includes all observations in `y`. It’s equivalent to `left_join(y, x)`, but the columns will be ordered differently:


```r
right_join(df1, df2)
```

```
## Joining, by = "id"
```

```
##   id   x1 x2
## 1  3    c  c
## 2  4    d  d
## 3  5 <NA>  e
```

```r
left_join(df2, df1)
```

```
## Joining, by = "id"
```

```
##   id x2   x1
## 1  3  c    c
## 2  4  d    d
## 3  5  e <NA>
```


### `full_join()`


\begin{center}\includegraphics[width=1.68in]{images/full_join} \end{center}

`full_join()` includes all observations from `x` and `y`:


```r
full_join(df1, df2)
```

```
## Joining, by = "id"
```

```
##   id   x1   x2
## 1  1    a <NA>
## 2  2    b <NA>
## 3  3    c    c
## 4  4    d    d
## 5  5 <NA>    e
```

The left, right and full joins are collectively know as outer joins. When a row doesn't match in an outer join, the new variables are filled in with missing values.


