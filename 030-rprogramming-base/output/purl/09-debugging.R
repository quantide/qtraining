## ----debug1--------------------------------------------------------------
prime_numbers <- function(n){
    if (n >= 2) {
      sieve <- seq(2, n)
      primes <- c()

      for (i in seq(2, n)) {
        if (any(sieve == i)) {
          primes <- c(primes)
          sieve <- c(sieve[(sieve %% i) != 0], i)
        }
      }
      return(primes)
    } else {
      stop("n should be at least 2.")
    }
}

prime_numbers(7)


## ----debug2--------------------------------------------------------------
debugonce(prime_numbers)
prime_numbers(7)

## ----debug3--------------------------------------------------------------
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

prime_numbers(7)


## ----debug4--------------------------------------------------------------

prime_numbers <- function(n){
    if (n >= 2) {
      sieve <- seq(2, n)
      primes <- c()

      for (i in seq(2, n)) {
        if (any(sieve == i)) {
          primes <- c(primes, i)
          browser()
          sieve <- c(sieve[(sieve %% i) != 0], i)
        }
      }
      return(primes)
    } else {
      stop("n should be at least 2.")
    }
}

prime_numbers(7)


## ----traceback1----------------------------------------------------------

prime_numbers <- function(n){
    if (n >= 2) {
      sieve <- seq(2, n)
      primes <- c()

      for (i in seq(2, n)) {
        if (any(sieve == i)) {
          primes <- c(primes, i)
          browser()
          sieve <- c(sieve[(sieve %% i) != 0], i)
        }
      }
      return(primes)
    } else {
      stop("n should be at least 2.")
    }
}


prime_numbers(n = c(10,20))


## ----traceback-----------------------------------------------------------

traceback()


## ----options error-------------------------------------------------------

options(error = browser())

prime_numbers(c(10,20))


## ----fix error-----------------------------------------------------------

prime_numbers <- function(n){
  .prime_numbers <- function(n) {
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
  .prime_numbers_vec <- Vectorize(.prime_numbers, "n")
  .prime_numbers_vec(n)
}

prime_numbers(c(10,20))


## ----options error2------------------------------------------------------

options(error = NULL)


