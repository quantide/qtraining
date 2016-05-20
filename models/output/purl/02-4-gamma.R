## ----  message=FALSE-----------------------------------------------------
require(ggplot2)
require(dplyr)
require(qdata)

## ----echo=FALSE----------------------------------------------------------
rm(list=ls())

## ------------------------------------------------------------------------
data(boiling)
boiling

## ----tidy=FALSE,fig.cap="time Vs. volume plot for the 2 pans"------------
ggp <- ggplot(data = boiling,mapping = aes(x = volume, y = time)) +
  geom_point(mapping = aes(colour=pan)) + 
  geom_line(mapping = aes(colour=pan))
print(ggp)

## ------------------------------------------------------------------------
fm1 <- glm(time ~ volume + pan - 1, data = boiling, family = gaussian)
summary(fm1)

## ------------------------------------------------------------------------
fm2 <- glm(time ~ pan + volume:pan - 1, data = boiling, family = gaussian)
summary(fm2)

## ------------------------------------------------------------------------
anova(fm1,fm2,test="F")

## ----fig.cap="How dispersion varies with means for Gaussian models and Gamma models"----
set.seed(2000)
means <- (1:300)/100
x1 <- apply(as.matrix(means),MARGIN=1,FUN=function(x){rnorm(1,mean=x)})
x2 <- apply(as.matrix(means),MARGIN=1,FUN=function(x){rgamma(1,shape=x, scale = 1)})
ds <- data.frame(means=rep(means, 2), values=c(x1,x2), distribution=rep(c("Gaussian","Gamma"), each=300))

ggp <- ggplot(data = ds, mapping = aes(x=means, y = values)) +
  geom_point(colour="blue") +
  facet_wrap(facets = ~distribution) 
print(ggp)

rm(means,x1,x2,ds)

## ----tidy=FALSE----------------------------------------------------------
fm3 <- glm(time ~ pan + volume:pan - 1, data = boiling,
          family = Gamma(link = "identity"))
summary(fm3)

## ------------------------------------------------------------------------
fm2$aic ; fm3$aic

## ----tidy=FALSE----------------------------------------------------------
fm3a <- glm(time ~ pan + volume + volume:pan, data = boiling, 
         family = Gamma(link = "identity"))
summary(fm3a)
fm4 <- glm(time ~ pan + volume, data = boiling, family = Gamma(link = "identity"))
summary(fm4)

anova(fm3a,fm4,test="F")

## ------------------------------------------------------------------------
fm5 <- glm(time ~ volume, data = boiling, family = Gamma(link = "identity"))
anova(fm4, fm5, test="F")

## ------------------------------------------------------------------------
anova(fm4,update(fm4,.~.-pan),test="F")
fm6 <- update(fm4, . ~ . -pan)
summary(fm6)


## ------------------------------------------------------------------------
anova(fm3a,glm(time~volume, family=Gamma(link="identity"),data=boiling), test="F")

## ----echo=FALSE----------------------------------------------------------
rm(list=ls())

## ------------------------------------------------------------------------
data(clotting)
head(clotting)
str(clotting)

## ----fig.cap="Clotting time (y) Vs. percentage concentration (u) by lot"----
ggp <- ggplot(data = clotting, mapping = aes(x = u,y = y)) +
  geom_point(colour="red") +
  facet_wrap(facets = ~lot)
print(ggp)

## ----fig.cap="Clotting time (y) Vs. log of percentage concentration log(u) by lot"----
ggp <- ggplot(data = clotting, mapping = aes(x = log(u),y = y)) +
  geom_point(colour="red") +
  facet_wrap(facets = ~lot)
print(ggp)

## ------------------------------------------------------------------------
fm0 <- glm(y ~ 1, data = clotting, family = Gamma())
summary(fm0)

## ------------------------------------------------------------------------
fm1 <- glm(y ~ log(u), data = clotting, family = Gamma())
summary(fm1)

## ------------------------------------------------------------------------
fm2 <- glm(y ~ log(u) + lot, data = clotting, family = Gamma())
summary(fm2)

## ------------------------------------------------------------------------
fm3 <- glm(y ~ lot + log(u) + lot:log(u), data = clotting, family = Gamma())
summary(fm3)

## ------------------------------------------------------------------------
anova(fm2,fm3,test="F")

## ----fig.cap="Residual plot of last model"-------------------------------
op <- par(mfrow = c(2, 2))
plot(fm3)
par(op)

## ----final_graphs,fig.cap="Fitted and observed by lot"-------------------
clotting$pred <- predict(fm3, type = "response") 
clotting <- clotting %>% arrange(lot, u)
ggp <- ggplot(data=clotting, mapping = aes(x=u, y=y)) +
  geom_point(colour="blue") +
  geom_line(mapping = aes(y=pred), colour="red") +
  facet_wrap(facets = ~lot, ncol = 1)
print(ggp)

## ----final_graphs1,fig.cap="Fitted and observed by lot (colours)"--------
ggp <- ggplot(data=clotting, mapping = aes(x=u, y=y, colour=lot)) +
  geom_point() +
  geom_line(mapping = aes(y=pred))
print(ggp)

## ----final_graphs_1,fig.cap="Linear component of model with extended range of x values"----
clotting <- clotting %>% bind_rows(data.frame(u=c(.5,.5), lot=c("a","b"), y=c(NA,NA), pred=c(NA,NA)))
clotting$pred <- predict(fm3,newdata=clotting)
ggp <- ggplot(data=clotting, mapping = aes(x=log(u), y=pred, colour=lot)) +
  geom_line()
print(ggp)

