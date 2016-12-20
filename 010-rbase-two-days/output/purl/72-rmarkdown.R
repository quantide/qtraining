## ---- eval=FALSE---------------------------------------------------------
## install.packages("rmarkdown")

## ----echo=FALSE,comment=""-----------------------------------------------
show_chunk(
"```
This text is displayed verbatim / preformatted
```"
  )

## ----echo=FALSE,comment=""-----------------------------------------------
show_chunk(
"```{r}
summary(cars)
```"
  )

## ----echo=FALSE ,comment=""----------------------------------------------
summary(cars)

## ----echo=FALSE,comment=""-----------------------------------------------
show_chunk(
"```{r, echo=FALSE}
summary(cars)
```"
  )

## ----echo=FALSE ,comment=""----------------------------------------------
summary(cars)

## ----echo=FALSE, comment=""----------------------------------------------
show_chunk(
"```{r, echo=FALSE}
plot(cars)
```"
  )

## ----echo=FALSE----------------------------------------------------------
plot(cars)

## ----echo=FALSE,comment=""-----------------------------------------------
show_chunk(
"```{r, eval=FALSE}
summary(cars)
```"
  )

## ----eval=FALSE ,comment=""----------------------------------------------
summary(cars)

## ----comment=""----------------------------------------------------------
b <- c(1,2,3,4,5)
c <- c(2,3,4)
a <- b/c
a

## ----echo=FALSE,comment=""-----------------------------------------------
show_chunk(
"```{r, warning=FALSE}
b <- c(1,2,3,4,5)
c <- c(2,3,4)
a <- b/c
a
```"
  )

## ---- warning=FALSE, echo=FALSE, comment=""------------------------------
b <- c(1,2,3,4,5)
c <- c(2,3,4)
a <- b/c
a

## ----echo=FALSE,comment=""-----------------------------------------------
show_chunk(
"```{r, error=TRUE}
b <- 4/\"a\"
```"
  )

## ---- echo=FALSE, error=TRUE, comment=""---------------------------------
b <- 4/"a"

## ----echo=FALSE,comment=""-----------------------------------------------
show_chunk(
"```{r, results='asis'}
knitr::kable(mtcars)
```"
  )

## ----echo=FALSE,comment=""-----------------------------------------------
show_chunk(
"```{r, include=FALSE}
knitr::opts_chunk$set(cache=TRUE)
```"
  )

## ----echo=FALSE,comment=""-----------------------------------------------
show_chunk(
"I counted`r 1+1`red trucks on the highway." )

## ----error=FALSE, eval=FALSE---------------------------------------------
## rmarkdown::render("input.Rmd")

## ----echo=FALSE,comment=""-----------------------------------------------
show_chunk("
---
title: \"Sample Document\"
output:
  html_document:
    toc: true
    theme: united
---
  ")

## ----echo=FALSE,comment=""-----------------------------------------------
show_chunk("
---
title: \"Sample Document\"
output:
  pdf_document:
    toc: true
    highlight: zenburn
---
  ")

## ----echo=FALSE,comment=""-----------------------------------------------
show_chunk("
---
title: \"Sample Document\"
output: pdf_document
---"
  )

## ----echo=FALSE,comment=""-----------------------------------------------
show_chunk("
---
title: \"Sample Document\"
output:
  html_document:
    toc: true
    theme: united
  pdf_document:
    toc: true
    highlight: zenburn
---"
  )

## ---- eval=FALSE---------------------------------------------------------
## render("input.Rmd", "pdf_document")

## ---- eval=FALSE---------------------------------------------------------
## render("input.Rmd", "all")

