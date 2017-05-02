## ----functionals-025-----------------------------------------------------
mapply(mean ,trees, trim = c(0.1 , 0.2, 0.3), 
  MoreArgs = list(na.rm = TRUE),
  SIMPLIFY = FALSE) 

## ----functionals-, eval = FALSE------------------------------------------
## mapply(FUN, ..., MoreArgs=NULL, SIMPLIFY = TRUE)

## ----functionals-026-----------------------------------------------------
Map(function(...) mean(..., na.rm = TRUE), 
  x = trees , trim = c(0.1 , 0.2, 0.3))

## ----functionals-027-----------------------------------------------------
f = function(i , j) {
  result = 99
  if( j %% 2 == 0){
  result <- ifelse(i %% 2 == 0 , i+j , i-j)
  }
  result
}

grid <- expand.grid(i = 1:4, j = 1:2)

## ----functionals-028-----------------------------------------------------
with(grid , mapply(f, i=i , j=j, SIMPLIFY = TRUE))

## ----functionals-029-----------------------------------------------------
unlist(with(grid , Map(f, i=i , j=j)))

