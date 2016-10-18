## ----save1, eval=FALSE---------------------------------------------------
## # It creates a mtcars.Rda file in the current directory
## save(mtcars, file = "mtcars.Rda")

## ----save2, eval=FALSE---------------------------------------------------
## # It creates a datasets.Rda file in the current directory
## save(mtcars, iris, file = "datasets.Rda")

## ----save3, eval=FALSE---------------------------------------------------
## # It creates a datasets.Rda file in the current directory
## datalist = c("mtcars", "iris")
## save(list = datalist, file = "datasets.Rda")

## ----load, eval=FALSE----------------------------------------------------
## # It reads the datasets.Rda file previously created in the current directory
## load("datasets.Rda")

