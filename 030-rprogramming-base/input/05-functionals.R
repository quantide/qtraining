## ----functionals-002-----------------------------------------------------
n_col <- ncol(airquality)
out <- numeric(n_col)

for (i in 1:n_col){
 out[i] <- max(airquality[,i], na.rm = TRUE)
}
out

## ----functionals-003-----------------------------------------------------
lapply(X = airquality, FUN = max, na.rm = TRUE)

## ----functionals-004-----------------------------------------------------
mean(1:100, trim = 0.1)
mean(0.1, x = 1:100)

## ----functionals-005-----------------------------------------------------
x <- rnorm(100)
lapply(X = c(0.1, 0.2, 0.5), mean, x = x)

## ----functionals-006-----------------------------------------------------
sapply(X = airquality, FUN = max, na.rm = TRUE)

## ----functionals-007-----------------------------------------------------
sapply(list(), is.numeric)

## ----functionals-008-----------------------------------------------------
vapply(list(), is.numeric, FUN.VALUE = logical(1))
vapply(X = airquality, FUN = max, na.rm = TRUE, FUN.VALUE = numeric(1))

## ----functionals-009-----------------------------------------------------
df_list <- list(cars, airquality, trees) 

## ----functionals-010-----------------------------------------------------
sapply(df_list, ncol)

## ----functionals-011-----------------------------------------------------
df_list <- list(df1 = cars, df2 = NULL, df3 = trees) 

## ----functionals-012-----------------------------------------------------
sapply(df_list, ncol)

## ----functionals-013, error=TRUE-----------------------------------------
vapply(df_list, ncol, FUN.VALUE = numeric(1))

## ----datamanagement-applying-df------------------------------------------
df <- as.data.frame(matrix(AirPassengers, ncol=12))
names(df) <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
row.names(df) <- 1949:1960
df

## ----datamanagement-applying-applycol------------------------------------
apply(df, MARGIN = 2, FUN = mean)

## ----datamanagement-applying-applyrow------------------------------------
apply(df, MARGIN = 1, FUN = mean)

## ----datamanagement-applying-applyrowargs--------------------------------
apply(df, MARGIN = 1, FUN = quantile, probs=c(0.05, 0.10, 0.25, 0.50, 0.75, 0.90, 0.95))

## ----datamanagement-applying-warpbreaks----------------------------------
data(warpbreaks)
head(warpbreaks)

## ----datamanagement-applying-tapply1-------------------------------------
tapply(warpbreaks$breaks, INDEX = warpbreaks[, 3], FUN = sum)

## ----datamanagement-applying-tapply2-------------------------------------
tapply(warpbreaks$breaks, INDEX = warpbreaks[,-1], FUN = sum)

## ---- tapply3------------------------------------------------------------
head(iris)

## ---- tapply4------------------------------------------------------------
tapply(iris[, 1], INDEX = iris[, 5], FUN = mean)

## ---- aggregate----------------------------------------------------------
aggregate(iris[, 1:4], by = list(Species = iris[, 5]), FUN = mean)

