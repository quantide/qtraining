## ---- eval=FALSE---------------------------------------------------------
## install.packages("rmarkdown")

## ----eval=FALSE----------------------------------------------------------
## require(rmarkdown)
## render("example.Rmd")

## ----print table---------------------------------------------------------
data(mtcars)
head(mtcars)

## ----kable---------------------------------------------------------------
knitr::kable(head(mtcars))

