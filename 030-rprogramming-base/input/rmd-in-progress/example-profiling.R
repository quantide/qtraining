library(profvis)

  data(diamonds, package = "ggplot2")
  
  plot(price ~ carat, data = diamonds)
  m <- lm(price ~ carat, data = diamonds)
  abline(m, col = "red")


prime_numbers <- function(n){
  if (n >= 2) {
    sieve <- seq(2, n)
    primes <- c()
    for (i in seq(2, n)) {
      if (any(sieve == i)) {
        primes <- c(primes, i)

        sieve <- c(sieve[(sieve %% i) != 0], i)
      }
    }
    return(primes)
  } else {
    stop("n should be at least 2.")
  }
}

dati <- c(10000, 20000)

for (i in 1:length(dati)){
  numeri <- prime_numbers(dati[i])
}

plot(numeri)