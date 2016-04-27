## ---- eval=FALSE---------------------------------------------------------
## #install.packages("ggplot2")

## ---- eval=FALSE---------------------------------------------------------
## #require(ggplot2)

## ----ggplot, warning=FALSE-----------------------------------------------
#ggplot(data = bands, mapping = aes(x = humidity, y = viscosity))

## ----scatterplot_first, message=FALSE, warning=FALSE---------------------
#ggplot(data=bands, mapping=aes(x=humidity, y=viscosity)) + geom_point()

