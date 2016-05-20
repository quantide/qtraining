## ---- message=FALSE------------------------------------------------------
require(MASS) 
require(ggplot2)
require(nnet)
require(vcd) 
require(qdata)

## ---- echo=FALSE---------------------------------------------------------
rm(list=ls())

## ------------------------------------------------------------------------
data(nes96)
head(nes96)
str(nes96)
summary(nes96)

## ------------------------------------------------------------------------
sPID <- nes96$PID
levels(sPID) <-  c("Democrat","Democrat","Independent","Independent",
                  "Independent","Republican","Republican")
summary(sPID)
nes96$sPID <- sPID

## ------------------------------------------------------------------------
inca <- c(1.5,4,6,8,9.5,10.5,11.5,12.5,13.5,14.5,16,18.5,21,23.5,
         27.5,32.5,37.5,42.5,47.5,55,67.5,82.5,97.5,115)
nincome <- inca[unclass(nes96$income)]
nes96$nincome <- nincome
summary(nes96$nincome)

## ------------------------------------------------------------------------
table(nes96$educ)

ptb <- data.frame(prop.table(table(nes96$educ,nes96$sPID),1))
names(ptb) <- c("Education", "Party", "Freq")
ggp <- ggplot(data = ptb, mapping = aes(x=Education, y = Freq)) +
  geom_line(mapping = aes(colour= Party, linetype=Party, group=Party) ) +
  ggtitle("Proportions of Democrat, Independent, Republican Vs. Education") +
  theme(legend.position="top")
print(ggp)

cutinc <- cut(nes96$nincome,7)
il <- c(8,26,42,58,74,90,107)
ptb <- data.frame(as.factor(il), prop.table(table(cutinc,nes96$sPID),1))
names(ptb) <- c("Income", "cutinc","Party", "Freq")
ggp <- ggplot(data = ptb, mapping = aes(x=Income, y = Freq)) +
  geom_line(mapping = aes(colour= Party, linetype=Party, group=Party) ) +
  ggtitle("Proportions of Democrat, Independent, Republican Vs. Income") +
  theme(legend.position="top")
print(ggp)

cutage <- cut(nes96$age,7)
al <- c(24,34,44,54,65,75,85)
ptb <- data.frame(as.factor(al), prop.table(table(cutage,nes96$sPID),1))
names(ptb) <- c("Age", "cutage","Party", "Freq")
ggp <- ggplot(data = ptb, mapping = aes(x=Age, y = Freq)) +
  geom_line(mapping = aes(colour= Party, linetype=Party, group=Party) ) +
  ggtitle("Proportions of Democrat, Independent, Republican Vs. Age") +
  theme(legend.position="top")
print(ggp)


## ------------------------------------------------------------------------
(mmod0 <- multinom(sPID ~ age + educ + nincome, data=nes96))
summary(mmod0)

## ------------------------------------------------------------------------
mmod <- step(mmod0)

## ------------------------------------------------------------------------
summary(mmod)

## ------------------------------------------------------------------------
(mmod1 <- multinom(sPID ~ age + nincome, data=nes96))
summary(mmod1)

## ------------------------------------------------------------------------
diff <- deviance(mmod1) - deviance(mmod0)
diff
pchisq(diff,mmod0$edf-mmod1$edf,lower=F)

## ------------------------------------------------------------------------
anova(mmod0, mmod1, test="Chisq")

## ------------------------------------------------------------------------
dropterm(mmod0, test="Chisq")

## ------------------------------------------------------------------------
mmod2 <- multinom(sPID ~ educ + nincome, data=nes96)
dropterm(mmod2, test="Chisq")

## ------------------------------------------------------------------------
mmod3 <- multinom(sPID ~ nincome, data=nes96)
dropterm(mmod3, test="Chisq")

## ------------------------------------------------------------------------
summary(mmod)

## ------------------------------------------------------------------------
mmod$edf

## ------------------------------------------------------------------------
coef(mmod)

## ------------------------------------------------------------------------
mmod$deviance

## ------------------------------------------------------------------------
mmod$AIC

## ------------------------------------------------------------------------
head(mmod$residuals); head(mmod$fitted.values)

## ------------------------------------------------------------------------
summary(mmod)

## ------------------------------------------------------------------------
predict(mmod, data.frame(nincome=il), type="probs")

## ------------------------------------------------------------------------
(predInd <- exp(-1.1749331+0.01608683*il) /
   (1+exp(-1.1749331+0.01608683*il)+exp(-0.9503591+0.01766457*il)))

## ------------------------------------------------------------------------
(predRep <- exp(-0.9503591+0.01766457*il) /
   (1+exp(-1.1749331+0.01608683*il)+exp(-0.9503591+0.01766457*il)))

## ------------------------------------------------------------------------
(predDem <- 1-predInd-predRep)

## ------------------------------------------------------------------------
predict(mmod,data.frame(nincome=il))
summary(mmod)

## ------------------------------------------------------------------------
cc <- c(0,-1.1749331,-0.9503591)
exp(cc)/sum(exp(cc))
sum(exp(cc)/sum(exp(cc)))

## ------------------------------------------------------------------------
(pp <- predict(mmod,data.frame(nincome=c(0,1)),type="probs"))
pp[1,1]*pp[2,2]/(pp[1,2]*pp[2,1])
pp[1,1]*pp[2,3]/(pp[1,3]*pp[2,1])

## ------------------------------------------------------------------------
exp(coefficients(mmod)[,2])

## ------------------------------------------------------------------------
table(predict(mmod), sPID)

## ------------------------------------------------------------------------
ds <- data.frame(residuals = mmod$residuals[,2], fitted = mmod$fitted.values[,2])
ggp <- ggplot(data = ds, mapping = aes(x=fitted, y=residuals)) +
  geom_point()
print(ggp)

## ------------------------------------------------------------------------
ds <- data.frame(residuals = mmod$residuals[,3], fitted = mmod$fitted.values[,3])
ggp <- ggplot(data = ds, mapping = aes(x=fitted, y=residuals)) +
  geom_point()
print(ggp)

## ------------------------------------------------------------------------
ds <- data.frame(residuals = mmod$residuals[,1], fitted = mmod$fitted.values[,1])
ggp <- ggplot(data = ds, mapping = aes(x=fitted, y=residuals)) +
  geom_point()
print(ggp)

## ------------------------------------------------------------------------
data(housing)
head(housing)
str(housing)
summary(housing)

## ------------------------------------------------------------------------
ftable(xtabs(Freq ~ Infl+Type+Cont+Sat, data=housing))
prop.table(ftable(xtabs(Freq ~ Infl+Type+Cont+Sat, data=housing)),margin = 1)

## ------------------------------------------------------------------------
strt <- structable(prop.table(ftable(xtabs(Freq ~ Infl+Type+Cont+Sat, data=housing)),margin = 1),
                data=housing)
mosaic(strt,shade=TRUE,main = "Level of satisfation Vs. Influence, Type and Contact",
       highlighting="Sat",highlighting_fill=heat.colors(3))

## ------------------------------------------------------------------------
house_mult0 <- multinom(Sat ~ Infl*Type*Cont, weights=Freq, data=housing)
dropterm(house_mult0, test="Chisq")
house_mult1 <- update(house_mult0, . ~ . - Infl:Type:Cont, data=housing)
dropterm(house_mult1, test="Chisq")
house_mult2 <- update(house_mult1, . ~ . - Infl:Cont, data=housing)
dropterm(house_mult2, test="Chisq")
house_mult <- update(house_mult2, . ~ . - Type:Cont, data=housing)
dropterm(house_mult, test="Chisq")

## ------------------------------------------------------------------------
house_mult <- multinom(Sat ~ Infl+Type+Cont, weights=Freq, data=housing)
summary(house_mult)

anova(house_mult0, house_mult)

## ------------------------------------------------------------------------
coef(house_mult)

## ------------------------------------------------------------------------
llmod <- glm(Freq ~ Infl*Type*Cont + Sat*(Infl+Type+Cont), data=housing, family=poisson)
summary(llmod)
pchisq(llmod$deviance, llmod$df.residual, lower.tail = FALSE)

mlmod1 <- multinom(Sat ~ Infl+Type+Cont, weights=Freq, data=housing)
mlmod2 <- multinom(Sat ~ Infl*Type*Cont, weights=Freq, data=housing)
anova(mlmod2, mlmod1)

## ------------------------------------------------------------------------
op <- par(mfrow=c(2,2))
plot(llmod)
par(op)

## ------------------------------------------------------------------------
hnames <- lapply(housing[, -5], levels) # omit Freq
house_pm <- predict(llmod, expand.grid(hnames), type = "response") # poisson means
house_pm <- matrix(house_pm, ncol = 3, byrow = T, dimnames = list(NULL, hnames[[1]]))
house_pr <- house_pm/drop(house_pm %*% rep(1, 3))
tb <- expand.grid(hnames[-1])
tb$Sat <- house_pr

tb <- xtabs(Sat~Infl+Type+Cont,data=tb)
names(attr(tb,"dimnames"))[4]="Sat"
mosaic(structable(ftable(tb)),shade=TRUE,
       main = "Satisfation Vs. Influence, Type and Contact (model)",
       highlighting = "Sat",highlighting_fill = heat.colors(3))

