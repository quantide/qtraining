## mackerel survey example. Run the code here and expand it to 
## produce a reasonable model for these survey data, and some 
## simple predictions form it....

library(mgcv)
library(gamair)
data(mack)
data(coast)
data(mack)

## plot the egg densities against location

plot(mack$lon,mack$lat,cex=0.2+mack$egg.dens/150,col="red")
lines(coast)

names(mack)[12] <- "net.area"
mack$log.net.area <- log(mack$net.area)

## The following fits an initial model in which egg density
## follows a Tweedie distribution, with log mean given by a sum 
## of smooth functions of covariates + log sample net area.

gm <- gam(egg.count~s(lon,lat)+s(I(b.depth^.5))+ s(c.dist) + 
s(salinity) + s(temp.surf) + s(temp.20m)+offset(log.net.area),
data=mack,family=Tweedie(1.3),select=TRUE,method="REML")

plot(fitted(gm),residuals(gm))

par(mfrow=c(2,3))
plot(gm)


## now refit without salinity (lots of NA's for this, so must drop on its own)

## check k for s(lon,lat) and adjust if needed...

## continue with model selection...

op<-par()
layout(matrix(c(1,1,2,3),2,2))

## use plot.gam's `select' argument to produce pretty pictures
## of spatial smooth with coast line + remaining smooths in nice 
## layout...


## Use posterior simulation to obtain a CI for the average egg density, over the sample stations. 




