## exercises using simple cherry tree size data 
library(mgcv)
## 1. look at the data....
trees
pairs(trees) 

## 2. Try a simple model
ctm <- gam(Volume~s(Girth)+s(Height),data=trees,family=Gamma(link=log))
ctm

## 3. check using `gam.check', and `plot'

## 4. Try out different smoothing parameter selection methods using 
## `method' argument to `gam'... how robust is the fit to this choise?

## 5. Is a smooth interaction of Girth and Height needed? Find out.

## 6. Examine the `summary' of your selected model.

## 7. Try out `vis.gam' to get a pretty visualization of your selected model. Experiment with the
##    `plot.type' argument.

## 7. Try a model in which E(Vol) = f(Height)*Girth, vol~Gamma. Is this better or worse than 
##    your previous model? 
