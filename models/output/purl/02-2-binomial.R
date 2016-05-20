## ---- echo=TRUE, message=FALSE-------------------------------------------
require(MASS)
require(ggplot2)
require(grid)
require(gridExtra)
require(qdata)

## ----split=TRUE----------------------------------------------------------
ldose <- rep(0:5, 2)
numdead <- c(1, 4 ,9 ,13, 18 ,20, 0, 2, 6, 10, 12, 16)
sex <- factor(rep(c("M", "F"), each = 6))
rate <- numdead/20
SF <- rbind(numdead, numalive = 20 - numdead)
Budworms <- data.frame(ldose, sex, rate)
Budworms$SF <- t(SF)

rm(sex, ldose, SF, rate)

head(Budworms)
str(Budworms)

class(Budworms)

## ----tidy=FALSE,fig.cap="Plot of mortality rate Vs. dose and lowess lines by sex"----
ggp <- ggplot(data = Budworms, mapping = aes(x = ldose, y = rate)) +
  geom_point(size=3, colour="darkblue") + 
  geom_smooth(method = "loess", colour="green",span=1, se = FALSE) +
  facet_wrap(facets = ~sex, ncol = 1,labeller = function(x){x$sex <- paste("sex:",x$sex); return(x)})
print(ggp)

## ----tidy=FALSE----------------------------------------------------------
fm0 <- glm(SF ~ sex + ldose + sex:ldose, family = binomial(), 
          data = Budworms, trace = T)

## ------------------------------------------------------------------------
summary(fm0)

## ----tidy=FALSE----------------------------------------------------------
fm1 <-  glm(SF ~ sex + sex:ldose - 1,family = binomial(), 
           data = Budworms, trace = T)
summary(fm1)

## ----tidy=FALSE----------------------------------------------------------
newdata <- data.frame(
  ldose = rep(seq(0, 5, length = 100), 2),
  sex = factor(rep(0:1, each = 100), labels = c("F","M"))
)

## ------------------------------------------------------------------------
newdata$fit <- predict(fm1, type = "response", newdata = newdata)

## ----fig.cap="Plot of mortality rate Vs. dose by sex with first model fit"----
ggp <- ggplot(data = Budworms, mapping = aes(x = ldose, y = rate)) +
  geom_point(size=3, mapping = aes(shape=sex, colour=sex)) + 
  geom_line(data=newdata, mapping = aes(x = ldose, y = fit, colour=sex)) +
  theme(legend.position="top")
print(ggp)

## ------------------------------------------------------------------------
fm2 <-  update(fm0, . ~ sex + I(ldose-3) + sex:I(ldose-3))
summary(fm2, cor = F)$coefficients

## ------------------------------------------------------------------------
fm3 <- glm(SF ~ sex + ldose + sex:ldose + sex:I(ldose^2), 
          family = binomial(), data = Budworms, trace = T)
anova(fm0, fm3, test = "Chisq")

## ------------------------------------------------------------------------
fm4 <- glm(SF ~ sex + ldose, family = binomial(), Budworms, trace = T)
anova(fm0, fm4, test = "Chisq")
summary(fm4)

## ----tidy=FALSE----------------------------------------------------------
newdata <- data.frame(
  ldose = rep(seq(0, 5, length = 100), 2),
  sex = factor(rep(0:1, each = 100), labels = c("F","M")))

## ------------------------------------------------------------------------
newdata$fit <- predict(fm4, type = "response", newdata = newdata)

## ----budwormsFinalModelGraph,fig.cap="Plot of mortality rate Vs. dose by sex with final model fit"----
ggp <- ggplot(data = Budworms, mapping = aes(x = ldose, y = rate)) +
  geom_point(size=3, mapping = aes(shape=sex, colour=sex)) + 
  geom_line(data=newdata, mapping = aes(x = ldose, y = fit, colour=sex)) +
  theme(legend.position="top")
print(ggp)

## ----fig.cap="Residual plot for the model"-------------------------------
op <- par(mfrow = c(2, 2))
plot(fm4)
par(op)

## ----echo=FALSE----------------------------------------------------------
rm(list=ls())

## ------------------------------------------------------------------------
data(bwt)
head(bwt)
str(bwt)

## ------------------------------------------------------------------------
options(contrasts = c("contr.treatment", "contr.poly"))

## ------------------------------------------------------------------------
ggp1 <- ggplot(data = bwt, mapping = aes(x = age, y= low)) +
  geom_jitter(mapping = aes(y=low), colour="red",height = 0.01) +
  geom_smooth(method = "loess", colour="blue", se = FALSE, span=2/3) +
  facet_wrap(facets = ~smoke) +
  ggtitle("Low birthweight Vs Age of mother By Smoking status")

## ------------------------------------------------------------------------
ggp2 <- ggplot(data = bwt, mapping = aes(x = lwt, y= low)) +
  geom_jitter(mapping = aes(y=low), colour="red",height = 0.01) +
  geom_smooth(method = "loess", colour="blue", se = FALSE, span=2/3) +
  facet_wrap(facets = ~smoke) +
  ggtitle("Low birthweight Vs Weight of mother By Smoking status")

## ----fig.cap="Graph of low Vs. age and Vs. lwt by smoke with loess"------
grid.arrange(ggp1, ggp2, nrow = 2)

## ------------------------------------------------------------------------
fm1 <- glm(low ~ age + lwt + smoke, data = bwt, family = binomial())
summary(fm1)

## ------------------------------------------------------------------------
fm2 <- update(fm1, . ~ .^2)
summary(fm2, corr = F)$coefficients

## ------------------------------------------------------------------------
dropterm(fm2, test = "Chisq")
fm3 <- update(fm2, . ~ . -age:lwt)
anova(fm3, test = "Chisq")

## ------------------------------------------------------------------------
anova(fm1, fm3, test = "Chisq")

## ------------------------------------------------------------------------
fm4 <- update(fm1, . ~ . + I(age^2) + I(lwt^2))
summary(fm4)

## ------------------------------------------------------------------------
anova(fm1,fm4,test="Chisq")

## ------------------------------------------------------------------------
anova(fm1,fm2,test="Chisq")

## ------------------------------------------------------------------------
dropterm(fm1,test="Chisq")

## ------------------------------------------------------------------------
fm0 <- update(fm1, . ~ . -age)
summary(fm0)

## ----fig.cap="Residual plots of final model"-----------------------------
op <- par(mfrow = c(2, 2))
plot(fm0)
par(op)

## ------------------------------------------------------------------------
bwt$prob <- predict(fm0, type = "response")
bwt <- bwt[order(bwt$prob),]

## ----tidy=FALSE,fig.cap="Plot of final model predictions with data points"----
bwtPred  <- reshape(bwt, varying = list(c(1,5)), direction = "long")
ggp <- ggplot(data = bwt, mapping = aes(x = lwt, y = low)) +
  geom_point(colour="blue") + 
  geom_line(mapping = aes(x = lwt, y = prob), colour="red") +
  facet_wrap(facets = ~smoke)
print(ggp)

## ----echo=FALSE----------------------------------------------------------
rm(list=ls())

## ------------------------------------------------------------------------
data(toxo)
head(toxo)
str(toxo)

## ----tidy=FALSE,fig.cap="Rate of toxoplasmosys cases Vs. rain (point size proportional to sqrt(n)) "----
ggp <- ggplot(data=toxo, mapping = aes(x=rain,y = prop)) +
  geom_point(mapping = aes(size=sqrt(num))) + 
  geom_smooth(method = "loess", mapping = aes(weight= num), col="red")
print(ggp)


## ------------------------------------------------------------------------
fm1 <- glm(ill ~ rain, family = binomial(), data = toxo)
summary(fm1)
fm2 <- glm(ill ~ rain + I(rain^2), family = binomial(), data = toxo)
summary(fm2)
fm3 <- glm(ill ~ rain + I(rain^2) + I(rain^3), family = binomial(), data = toxo)
summary(fm3)
fm4 <- glm(ill ~ rain + I(rain^2) + I(rain^3) + I(rain^4), family = binomial(), data = toxo)
summary(fm4)

## ------------------------------------------------------------------------
fm0 <- glm(ill ~ 1, family = binomial(), data = toxo)
summary(fm0)
mc <- anova(fm0, fm3)
pchisq(mc$Deviance[2], mc$Df[2],lower.tail = FALSE)

## ----results='hide'------------------------------------------------------
anova(fm0, fm3,test="LRT")

## ----results='hide'------------------------------------------------------
anova(fm0, fm3,test="Chisq")

## ----fig.cap="Fitted means plot with data points"------------------------
ggp <- ggplot(data = data.frame(toxo, srt_rain=sort(toxo$rain), fit=fitted(fm3)[order(toxo$rain)]), mapping = aes(x=rain,y=prop)) +
  geom_point(colour="red", size=1.5) +
  geom_line(mapping = aes(x=srt_rain, y=fit), colour="darkblue", size=1.2) +
  geom_hline(yintercept = c(0,1), colour="darkgray") 
print(ggp)

## ---- fig.cap="Residuals plot of model"----------------------------------
op <- par(mfrow = c(2, 2))
plot(fm3)
par(op)

## ------------------------------------------------------------------------
pchisq(fm3$deviance, fm3$df.residual,lower.tail=FALSE)

## ----tidy=FALSE----------------------------------------------------------
fm_q <- glm(ill ~ rain + I(rain^2) + I(rain^3), 
          family = quasibinomial(), data = toxo)
summary(fm_q)

## ----test_quasi----------------------------------------------------------
fm_q_red <- update(fm_q, .~. -I(rain^3))
anova(fm_q, fm_q_red, test="F")

## ----fig.cap="Residual plot for overdispersed (quasi-binomial) model"----
op <- par(mfrow = c(2, 2))
plot(fm_q)
par(op)

## ------------------------------------------------------------------------
pchisq(fm_q$deviance/summary(fm_q)$dispersion, fm_q$df.residual,lower.tail=FALSE)

## ----echo=FALSE----------------------------------------------------------
rm(list = ls())

## ------------------------------------------------------------------------
data(irished)
head(irished)
str(irished)

## ------------------------------------------------------------------------
fm1 <- glm(lvcert ~ DVRT, family = binomial(), data = irished)
summary(fm1)

## ----fig.cap="jittered lvcert Vs. DVRT with fitted means"----------------
ds <- cbind(irished, fit=fitted(fm1))
ds <- ds[order(ds$DVRT),]
ggp <- ggplot(data = ds, mapping = aes(x = DVRT, y = jitter(lvcert,factor = 0.05))) +
  geom_point(colour="red", shape=4) + 
  geom_line(mapping =  aes(x = DVRT, y=fit), colour="darkblue")
print(ggp)


## ------------------------------------------------------------------------
fm3 <- glm(lvcert ~ DVRT + fathocc + sex, family = binomial(), data = irished)
summary(fm3)

## ------------------------------------------------------------------------
anova(fm3, update(fm3, . ~ . -sex), test = "Chisq")

## ---- error=TRUE---------------------------------------------------------
anova(fm3, update(fm3, . ~ . -fathocc), test = "Chisq")

## ------------------------------------------------------------------------
pchisq(q=fm3$deviance,df=fm3$df.residual,lower.tail=FALSE)

## ----tidy=FALSE----------------------------------------------------------
newdata <- with(irished, 
  expand.grid(
    sex = unique(sex),
    DVRT = min(DVRT):max(DVRT),
    fathocc = min(fathocc, na.rm = T):max(fathocc, na.rm = T)
  )
)
newdata$pred <- predict(fm3, newdata = newdata , type = "response")

## ----tidy=FALSE,fig.cap="Categorized surface plot of model predictions Vs. DVRT and fathocc by sex using trellis", eval=FALSE----
## require(lattice) # (For wireframe)
## wireframe(pred~DVRT+fathocc | sex, data = newdata,
##           drape = T, layout = c(2,1))

## ----tidy=FALSE,fig.cap="Categorized surface plot of model predictions Vs. DVRT and fathocc by sex"----
ggp <- ggplot(data = newdata,mapping = aes(x=DVRT,y=fathocc,fill=pred))+
  geom_tile() + 
  facet_wrap(facets = ~sex)
print(ggp)


## ------------------------------------------------------------------------
fm4 <- glm(lvcert ~ DVRT+sex, data = na.omit(irished), family = binomial())
summary(fm4)

## ------------------------------------------------------------------------
anova(fm3, fm4, test = "Chisq")

## ------------------------------------------------------------------------
fm5 <- glm(lvcert ~ DVRT+fathocc, data = na.omit(irished), family = binomial())
summary(fm5)

## ------------------------------------------------------------------------
anova(fm3, fm5, test = "Chisq")

## ------------------------------------------------------------------------
fm6 <- glm(lvcert ~ DVRT, data = na.omit(irished), family = binomial())
summary(fm6)

## ------------------------------------------------------------------------
anova(fm3, fm6, test = "Chisq")

## ------------------------------------------------------------------------
pchisq(q=fm4$deviance,df=fm4$df.residual,lower.tail=FALSE)

