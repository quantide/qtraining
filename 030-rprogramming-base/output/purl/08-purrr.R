## ---- purl=TRUE----------------------------------------------------------
require(tidyverse)
require(qdata)

## ------------------------------------------------------------------------
df <- tibble(
  "savings" = rnorm(10, 10, 1),
  "salary" = rnorm(10, 20, 1),
  "spending" = rnorm(10, 10, 1)
)

# returns a list of 3
map(df, mean)

# returns a vector of 3
map_dbl(df, mean)

## ------------------------------------------------------------------------
df %>% map_dbl(is.numeric)

## ------------------------------------------------------------------------
all.equal(lapply(df, mean), map(df, mean))

## ------------------------------------------------------------------------
mtcars %>% 
  split(.$cyl) %>% 
  map(~lm(mpg ~ wt, data = .))

## ------------------------------------------------------------------------
mtcars %>% 
  split(.$cyl) %>% 
  map(function(df) lm(mpg ~ wt, data = df))

## ------------------------------------------------------------------------
# the output is a numeric (double) vector 
sapply(df, mean)

all.equal(lapply(df, mean), map(df, mean))

## ------------------------------------------------------------------------
# turns factors into character
data(banknotes)
banknotes %>%
    map_if(is.factor, as.character) %>%
    str()

## ------------------------------------------------------------------------
# turns factors into character
banknotes %>%
    map_at("type", as.character) %>%
    str()

## ------------------------------------------------------------------------
mu <- list(5, 10, -3)
sigma <- list(1, 5, 10)
seq_along(mu) %>% 
  map(~rnorm(5, mu[[.]], sigma[[.]])) 

## ------------------------------------------------------------------------
map2(mu, sigma, rnorm, n = 5) 

## ------------------------------------------------------------------------
n_size <- list(5,10,15)
args <- list(n_size, mu, sigma)
args %>% 
  pmap(rnorm) %>%
  str()

## ------------------------------------------------------------------------

f <- c("runif", "rnorm", "rpois")
param <- list(
  list(min = -1, max = 1), 
  list(sd = 5), 
  list(lambda = 10)
)

invoke_map(f, param, n = 5) 

## ------------------------------------------------------------------------
require(purrrlyr)
banknotes %>%
  slice_rows("type") %>% 
  dmap(mean)

## ------------------------------------------------------------------------
banknotes %>%
    group_by(type) %>% 
    dmap(mean)

## ------------------------------------------------------------------------
data("banknotes")
banknotes %>% keep(is.numeric)

## ------------------------------------------------------------------------
banknotes %>% discard(is.numeric)

## ------------------------------------------------------------------------
banknotes %>% keep(is.numeric)

## ------------------------------------------------------------------------
banknotes %>% some(is.numeric)

## ------------------------------------------------------------------------
banknotes %>%
  slice_rows("type") %>% 
  by_slice(dmap, mean, na.rm = TRUE) %>%
  apply(1, unlist)

