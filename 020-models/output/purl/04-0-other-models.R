## ------------------------------------------------------------------------
rm(list=ls())

## ---- message=FALSE------------------------------------------------------
require(qdata)
require(nnet)
require(rpart)
require(mgcv)
require(MASS)
require(ggplot2)

## ----split=TRUE----------------------------------------------------------
data(titanic)
head(titanic)
str(titanic)

## ------------------------------------------------------------------------
(tb1 <- table(titanic$Status,titanic$Class))
round(prop.table(tb1,margin=2)*100,2)
(tb2 <- table(titanic$Status,titanic$Gender))
round(prop.table(tb2,margin=2)*100,2)
(tb3 <- table(titanic$Status,titanic$Class,titanic$Gender))
round(prop.table(tb3,margin=c(2,3))*100,2)

## ----fig.cap="Box-plot of Age within levels of Status"-------------------
ggp <- ggplot(data=titanic, mapping=aes(x=Status, y=Age)) +
  geom_boxplot()+ ggtitle("Box-plot of Age within levels of Status")

## ------------------------------------------------------------------------
fm1 <- glm(Status ~ Class+Gender+Class:Gender+Age, data = titanic, family = binomial)
summary(fm1)

## ------------------------------------------------------------------------
fm2 <- glm(Status ~ Class+Gender+Class:Gender+Age+Class:Age, data = titanic, family = binomial)
summary(fm2)

anova(fm1,fm2,test="LRT")

## ------------------------------------------------------------------------
fm3 <- glm(Status ~ Class+Gender+Class:Gender+Age+Gender:Age, data = titanic, family = binomial)
summary(fm3)

anova(fm1,fm3,test="LRT")

## ------------------------------------------------------------------------
predglm <- predict(fm1,type="response")


## ------------------------------------------------------------------------
nn0 <- nnet(Status ~ Class+Gender+Age,data=titanic,size=3)

prednn <- predict(nn0)

## ------------------------------------------------------------------------
rt0 <- rpart(Status ~ Class+Gender+Age,data=titanic)

predrt <- predict(rt0)[,2]

## ------------------------------------------------------------------------
titanic$predglm <- (predglm<.5) ## TRUE=Dead
titanic$prednn <- (prednn<.5)  ## TRUE=Dead
titanic$predrt <- (predrt<.5)  ## TRUE=Dead

table(titanic$Status,titanic$predglm)
table(titanic$Status,titanic$prednn)
table(titanic$Status,titanic$predrt)

## ---- echo=FALSE---------------------------------------------------------
rm(list=ls())

## ------------------------------------------------------------------------
data(ozone)

str(ozone)
head(ozone)

ammgcv <- gam(O3 ~ s(temp)+s(ibh)+s(ibt),data=ozone)
summary(ammgcv)

op <- par(mfrow=c(1,3))
plot(ammgcv)
par(op)

## ------------------------------------------------------------------------
am1 <- gam(O3 ~ s(temp)+s(ibh), data=ozone)
am2 <- gam(O3 ~ temp+s(ibh), data=ozone)
anova(am2,am1,test="F")

## ------------------------------------------------------------------------
amint <- gam(O3 ~ s(temp, ibh)+s(ibt), data=ozone)
summary(amint)

anova(ammgcv,amint,test="F")

op=par(mfrow=c(1,3))
plot(amint)
vis.gam(amint,theta=-45,color="gray")
par(op)

## ------------------------------------------------------------------------
op=par(mfrow=c(1,2))
plot (predict (ammgcv), residuals
      (ammgcv),xlab="Predicted",ylab="Residuals")
qqnorm (residuals (ammgcv), main="")
qqline(residuals (ammgcv))
par(op)

## ------------------------------------------------------------------------
ammgcv <- gam(O3 ~ s(temp)+s(ibh)+s(ibt),data=ozone,family=Gamma(link="identity"))
summary(ammgcv)

op=par(mfrow=c(1,2))
plot (predict (ammgcv), residuals
      (ammgcv,type="pearson"),xlab="Predicted",ylab="Residuals")
qqnorm (residuals (ammgcv,type="pearson"), main="")
qqline(residuals (ammgcv,type="pearson"))
par(op)

