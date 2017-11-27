## ------------------------------------------------------------------------
# funzione che fa tutta la parte sopra
require(microbenchmark)
.cross_validation <- function(data, i, formula) {
  training <- data[-i,]
  test <- data[i,]
  fm <- lm(formula, data = training)
  out <- predict(fm, newdata = test)
  return(out)
}


## ------------------------------------------------------------------------
# funzione che fa il ciclo per applicare a tutte le righe
cross_validation1 <- function(data, formula) {
  n <- nrow(data)
  cv <- numeric(n)
  for (i in 1:n) {
    cv_i <- .cross_validation(data, i, formula)
    cv[i] <- cv_i
  }
  return(cv)
}

## ------------------------------------------------------------------------
cross_validation2 <- function(data, formula) {
  n <- nrow(data)
  cv <- lapply(1:n, .cross_validation, data = data, formula)
  return(unlist(cv))
}


## ------------------------------------------------------------------------

data(mtcars)

microbenchmark(
#  cross_validation1(data = istat, formula = Height ~ Weight),
  cross_validation2(data = istat, formula = Height ~ Weight), times = 10
)

## ------------------------------------------------------------------------

library(profvis)
profvis({
  cross_validation1(data = istat, formula = Height ~ Weight)
})


