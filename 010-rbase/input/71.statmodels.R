## ---- drug---------------------------------------------------------------
load("../data/drug.Rda")
str(drug)

## ---- drugplot, fig = TRUE-----------------------------------------------
plot(time ~ dose, data = drug,
     xlab = "Dose (mg)",
     ylab =  "Reaction Time (secs)")

## ---- lm-----------------------------------------------------------------
fm = lm(time ~ dose, data = drug)

## ---- reg, fig = T-------------------------------------------------------
plot(time ~ dose, data = drug,
     xlab = "Dose (mg)",
     ylab =  "Reaction Time (secs)")

abline(reg = fm)

## ---- summary.lm---------------------------------------------------------
summary(fm)

## ---- anova--------------------------------------------------------------
anova(fm, test = F)

## ---- predict------------------------------------------------------------
newdata = data.frame(dose = c(0.2, 0.4, 0.6 ))
predict (fm , newdata = newdata)

## ---- prediction---------------------------------------------------------
predict (fm , newdata = newdata, interval = "prediction")

## ---- predictionplot, fig = T--------------------------------------------
newdata = data.frame(dose = seq(0, 0.9 , len = 100))
newdata = cbind(newdata, predict(fm, newdata = newdata,
  interval = "prediction"))
ylim = c(min(newdata$lwr), max(newdata$upr)) * c(0.99, 1.01)

plot(time ~ dose, data = drug, type = "n", ylim = ylim,
  xlab = "Dose (mg)", ylab = "Reaction Time (secs)")

with(newdata, {
  polygon(x = c(dose, rev(dose)), y = c(lwr , rev(upr)), col = "gray")
  lines(dose, fit, col = "red")
})

with(drug, points(dose, time, pch = 16, col = "darkblue"))

## ---- lmplot, fig = T----------------------------------------------------
par(mfrow = c(2,2))
plot(fm)

## ---- carseat------------------------------------------------------------
load("../data/carseat.Rda")
str(carseat)

## ---- carseatplot, fig = TRUE--------------------------------------------
boxplot(Strength~Operator, data = carseat, xlab = "Operator",
  ylab = "Resistance", col = "lightgray")
averages =  tapply(carseat$Strength, carseat$Operator, mean)
points(averages, col = "red", pch = 22, lwd = 2, type = "b")

## ---- aov----------------------------------------------------------------
fm = aov(Strength~Operator, data = carseat)

## ---- summary.aov--------------------------------------------------------
summary(fm)

## ---- aov2---------------------------------------------------------------
out = max(carseat$Strength[carseat$Operator == "Michelle"])
fm1 = aov(Strength~Operator, data = carseat[-which(carseat$Strength == out),])
summary(fm1)

## ---- carseat summary.lm-------------------------------------------------
summary.lm(fm)

## ---- residualscarseat, fig = T------------------------------------------
par(mfrow = c(1,2))
plot(fm, which = 1:2)

## ---- boiling------------------------------------------------------------
load("../data/boiling.Rda")
str(boiling)

## ---- boilingxyplot, fig=T-----------------------------------------------
library(lattice)
graph = xyplot(time ~ volume, data = boiling, groups = pan,
  type = "b", auto.key = list(space = "right", lines = F, points = T))
print(graph)

## ---- boling lm----------------------------------------------------------
fm1 = lm(time ~ volume + pan + volume:pan, data = boiling)
summary(fm1)$coeff

## ---- boiling lm2--------------------------------------------------------
fm11 = lm(time ~ pan + volume:pan - 1, data = boiling)
summary(fm11)$coeff

## ---- boiling lm3--------------------------------------------------------
fm12 = lm(time ~ pan/volume - 1, data = boiling)
summary(fm12)$coeff

## ---- boiling lm4--------------------------------------------------------
fm2 = glm(time ~ pan * volume, data = boiling,
  family = gaussian(link = "identity"))
summary(fm12)$coeff

## ---- boiling glm--------------------------------------------------------
fm3 = glm(time ~ pan*volume, data = boiling,
  family = Gamma(link = "identity"))
summary(fm3)$coeff 

## ---- boiling aic--------------------------------------------------------
fm2$aic
fm3$aic

