## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
require(dplyr)
require(tidyr)
require(qdata)
require(broom)
data(people)

## ------------------------------------------------------------------------
people %>% group_by(Gender) %>%
  do(data.frame(p = (1:3)/4, quantile = quantile(.$Weight, probs = (1:3)/4, na.rm = TRUE)))            

## ------------------------------------------------------------------------
qq <- function(x, probs = seq(0, 1, 0.25), ...){
  
  data <- data.frame(prob = probs,  
  quantile = quantile(x, probs, ...))
    
  return(data)
  
}

## ------------------------------------------------------------------------
people %>% group_by(Gender) %>%
  do(qq(.$Weight, probs = (1:3)/4, na.rm = TRUE))

## ------------------------------------------------------------------------
fun <- function(x, ...)  c(mean = mean(x, ...), sd = sd(x, ...))

## ------------------------------------------------------------------------
people %>% group_by(Area) %>%
  do(data.frame(stats = c("mean", "sd") , value = fun(.$Height, na.rm = TRUE)))

## ------------------------------------------------------------------------
people %>% group_by(Area) %>%
  summarise_each(funs("mean", "sd") , Height) %>%
  gather(key = stat, value = value, -Area)

## ------------------------------------------------------------------------
data.frame(id  = 1:3, what = I(list(4:6, 7:9, 10:12)))

## ------------------------------------------------------------------------
models <- people %>% group_by(Gender) %>% 
  do(mod = lm(Weight~Area, data = .))

## ------------------------------------------------------------------------
mutate(models, intercept  = coefficients(mod)[[1]], slope = coefficients(mod)[[2]], Rsq = summary(mod)$r.squared)

## ------------------------------------------------------------------------
intercept <- function(model) coefficients(model)[[1]]
slope <- function(model) coefficients(model)[[2]]
RSq <- function(model, i) summary(model)$r.squared

models %>% mutate_each(funs(intercept, slope , RSq), mod)

## ------------------------------------------------------------------------
people %>% group_by(Gender) %>% 
  do(tidy(lm(Weight~Area, data = .)))

