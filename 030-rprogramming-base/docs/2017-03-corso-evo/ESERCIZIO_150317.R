rm(list = ls())

#' @title single convolution
#' @description calcolo della convoluzione
#' @param np_i int frequenza ritardo
#' @param shape double
#' @param scale double
#' @return double ritardo comulato in un anno
#' @examples
#' single_convolution(np_i = 100, shape = 2, scale = 24)
#' @export

single_convolution <- function(np_i, shape, scale){
  b <- rweibull(np_i, shape,scale)
  out <- sum(b)
  out
}

######################################################

#' @title single convolution on the ith np
#' @description calcolo della convoluzione sull'i-esimo np
#' @param i int i-esima componente
#' @param np_i int frequenza ritardo
#' @param shape double
#' @param scale double
#' @return double ritardo comulato in un anno
#' @examples
#' single_convolution_i(i=2, np = c(100, 120, 140), shape = 2, scale = 24)
#' @export

single_convolution_i <- function(i, np, shape, scale){
  np_i <- np[i]
  out <- single_convolution(np_i = np_i, shape = shape, scale = scale)
  out
}

############################################################

#' @title Convoluzione
#' @description calcolo della convoluzione totale
#' @param n int
#' @param lambda int
#' @param shape double
#' @param scale double
#' @return double vector of length n
#' @examples
#' convolution(n=5, lambda = 100, shape = 2, scale = 24)
#' @export

convolution <- function(n, lambda, shape, scale){
  np <- rpois (n = n, lambda = lambda)
  x <- 1:n
  out <- lapply(X = x, FUN = single_convolution_i, np = np, shape = shape, scale = scale)
  out <- unlist(out)
  out
}

###############################################################

#' @title ritardo di giuseppe
#' @description calcolo del ritardo di
#' @param lambda int default 100
#' @param shape double default 2
#' @param scale double default 24
#' @param n int default 10^5
#' @param p double default 0.999
#' @return list of three elements:
#' \itemize{
#' \item conv: convolution vector
#' \item ritardo_atteso: ritardo medio
#' \item ritardo_a_rischio: quantile del ritardo di Giuseppe
#' }
#' @examples
#' ritardo_g <- ritardo_giuseppe()
#' ritardo_g$ritardo_a_rischio
#' ritardo_g$ritardo_atteso
#' head(ritardo_g$conv)
#' class(ritardo_g)
#' @export

ritardo_giuseppe <- function(lambda = 100, shape = 2, scale = 24, n = 10^5, p = 0.999){
  conv <- convolution(n = n, lambda = lambda, shape = shape, scale = scale)
  out <- list(conv = conv, ritardo_atteso = mean(conv), ritardo_a_rischio = quantile(conv, p))
  class(out) <- "ritardo_giuseppe"
  print(out)
  invisible(out)
    }

#####################################################################

#' @title Print method per la classe ritardo_giuseppe
#' @description print specifico per oggetti classe ritardo_giuseppe
#' @param x object of class ritardo_giuseppe
#' @return invisible(NULL).
#' @examples
#' ritardo_g <- ritardo_giuseppe()
#' print(ritardo_g)
#' @export

print.ritardo_giuseppe <- function(x){
  ritardo_atteso <- x$ritardo_atteso
  ritardo_a_rischio <- x$ritardo_a_rischio
  cat('Ritardo atteso = ', ritardo_atteso, '\n')
  cat('Ritardo a rischio = ', ritardo_a_rischio, '\n')
  invisible(NULL)
  }

########################################################################

#' @title Plot method per la classe ritardo_giuseppe
#' @description plot method per oggetti classe ritardo_giuseppe
#' @param x object of class ritardo_giuseppe
#' @param ... extra parameter for geom_histogram
#' @return invisible(NULL). Plot histogram as side effect
#' @importFrom ggplot2 ggplot xlab ylab geom_histogram
#' @examples
#' ritardo_g <- ritardo_giuseppe()
#' plot(ritardo_g, fill = 'green', col = 'darkgreen')
#' @export

plot.ritardo_giuseppe <- function(x, ...){
conv <- data.frame(conv = x$conv)
ggplot(conv, aes(conv)) +
  geom_histogram(...) +
  xlab('Ritardo Giuseppe (minuti)') +
  ylab('Frequenza')
}

