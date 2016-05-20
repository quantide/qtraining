## ---- message=FALSE------------------------------------------------------
require(surveillance)
require(ggplot2)
require(dplyr)
require(qdata)

## ----echo=FALSE----------------------------------------------------------
rm(list=ls())

## ------------------------------------------------------------------------
data(dicentric)
head(dicentric)
str(dicentric)

## ------------------------------------------------------------------------
dicentric <- dicentric %>% mutate(conc=ca/cells)

## ----tidy=FALSE,fig.cap="Plot of doseamt Vs. ca/cells by doserate"-------
ggp <- ggplot(data = dicentric, mapping = aes(x = doseamt, y = conc, colour=factor(doserate))) +
  geom_point() + 
  geom_line() +
  scale_color_discrete(name="doserate") 
print(ggp)

## ----tidy=FALSE,fig.cap="Plot of doserate Vs. ca/cells by doseamt"-------
ggp <- ggplot(data = dicentric, mapping = aes(x = doserate, y = conc, colour=factor(doseamt))) +
  geom_point() + 
  geom_line() +
  scale_color_discrete(name="doseamt")
print(ggp)

## ----tidy=FALSE,fig.cap="Plot of doseamt Vs. ca/cells by doserate (separate plots)"----
ggp <- ggplot(data = dicentric, mapping = aes(x = doseamt, y = conc)) +
  geom_point(colour="blue") + 
  geom_line(colour="blue") +
  facet_wrap(facets = ~doserate,nrow = 1) +
  ggtitle( "doseamt vs ca/cells given doserate")
print(ggp)

## ----tidy=FALSE,fig.cap="Plot of doserate Vs. ca/cells by doseamt (separate plots)"----
ggp <- ggplot(data = dicentric, mapping = aes(x = doserate, y = conc)) +
  geom_point(colour="blue") + 
  geom_line(colour="blue") +
  facet_wrap(facets = ~doseamt,nrow = 1) +
  ggtitle( "doserate vs ca/cells given doseamt")
print(ggp)

## ----tidy=FALSE,fig.cap="Plot of doserate logarithm Vs. ca/cells by doseamt (separate plots)"----
ggp <- ggplot(data = dicentric, mapping = aes(x = log(doserate), y = conc)) +
  geom_point(colour="blue") + 
  geom_line(colour="blue") +
  facet_wrap(facets = ~doseamt,nrow = 1) +
  ggtitle( "log(doserate) vs ca/cells given doseamt")
print(ggp)

## ----tidy=FALSE,fig.cap="log(doserate) vs ca/cells by doseamt"-----------
ggp <- ggplot(data = dicentric, mapping = aes(x = log(doserate), y = conc, colour=factor(doseamt))) +
  geom_point() + 
  geom_line() +
  ggtitle( "log(doserate) vs ca/cells given doseamt")+
  scale_color_discrete(name="doseamt")
print(ggp)

## ----tidy=FALSE,fig.cap="Level plot of conc Vs. doseamt and doserate"----
ggp <- ggplot(data = dicentric, mapping = aes(x = factor(doseamt), y = factor(doserate))) +
  geom_tile(mapping = aes(fill=conc))
print(ggp)


## ------------------------------------------------------------------------
fm0 <- glm(ca ~ log(cells) + doserate * doseamt, family = poisson(), data = dicentric)
summary(fm0)

## ----fig.cap="Residual plot of first model"------------------------------
op <- par(mfrow = c(2, 2))
plot(fm0)
par(op)

## ------------------------------------------------------------------------
fm1 <- glm(ca ~ offset(log(cells)) + factor(doseamt) + doserate:factor(doseamt) - 1,
          family = poisson(), data = dicentric)
summary(fm1)

## ----fig.cap="Residual plot of second model"-----------------------------
op <- par(mfrow = c(2, 2))
plot(fm1)
par(op)

## ----tidy=FALSE----------------------------------------------------------
fm2 <- glm(ca ~ offset(log(cells)) + factor(doseamt) + 
            log(doserate):factor(doseamt) - 1, family = poisson(), data = dicentric)
summary(fm2)

## ----fig.cap="Residual plot of third model"------------------------------
op <- par(mfrow = c(2, 2))
plot(fm2)
par(op)

## ------------------------------------------------------------------------
ds <- data.frame(res = anscombe.residuals(fm2,phi=1), fit = predict(fm2,type="response"))

ggp <- ggplot(data = ds, mapping = aes(x= fit, y= res)) + 
  geom_point() +
  geom_smooth(method="loess", se=FALSE, span=50) + 
  geom_hline(yintercept = 0, colour="red")
print(ggp)

ggp <- ggplot(data = ds, mapping = aes(sample = res)) + 
  stat_qq() +
  geom_abline(mapping = aes(intercept=mean(res),slope=sd(res)), colour="lightblue", size=1.2)
print(ggp)

## ------------------------------------------------------------------------
preddata <- dicentric[, c("cells", "doseamt", "doserate")]
preddata$cells <- 1
dicentric$pred <- predict(fm2, newdata = preddata, type = "response")

## ----tidy=FALSE,fig.cap="Plot of predictions of model with doserate log scale"----
ggp <- ggplot(data = dicentric, mapping = aes(x = log(doserate), y = conc)) +
  geom_point(colour="blue") + 
  geom_line(colour="violet", mapping = aes(y=pred), size=1.2) +
  facet_wrap(facets = ~doseamt,nrow = 1) +
  ggtitle( "ca/cells  vs. log(dosereate) given doseamt \n data = dicentric") 
print(ggp)

## ----tidy=FALSE,fig.cap="Plot of predictions of model with doserate in normal scale"----
ggp <- ggplot(data = dicentric, mapping = aes(x = doserate, y = conc)) +
  geom_point(colour="blue") + 
  geom_line(colour="violet", mapping = aes(y=pred), size=1.2) +
  facet_wrap(facets = ~doseamt,nrow = 1) +
  ggtitle( "ca/cells vs. dosereate given doseamt \n data = dicentric")
print(ggp)

## ----echo=FALSE----------------------------------------------------------
rm(list=ls())

## ------------------------------------------------------------------------
data(skin)
head(skin)
str(skin)

## ------------------------------------------------------------------------
xtabs(Counts ~ Type + Site, data = skin)

## ------------------------------------------------------------------------
chisq.test(matrix(skin$Counts,nrow=4,ncol=3))

## ------------------------------------------------------------------------
fm0 <- glm(Counts ~ Type + Site, family = poisson(), data = skin)
summary(fm0)

## ------------------------------------------------------------------------
1 - pchisq(fm0$deviance, fm0$df.residual)

## ------------------------------------------------------------------------
fm1 <- glm(Counts ~ Type * Site, family = poisson(), data = skin)
summary(fm1)

## ------------------------------------------------------------------------
anova(fm0, fm1, test="LRT")

## ------------------------------------------------------------------------
fm2 <- glm(Counts ~ Type + Site, family = quasipoisson(), data = skin)
summary(fm2)

fm2a=glm(Counts ~ Type, family = quasipoisson(), data = skin)
anova(fm2,fm2a,test="F")

