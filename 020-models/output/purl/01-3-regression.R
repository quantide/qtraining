## ---- message=FALSE------------------------------------------------------
require(ggplot2)
require(qdata)

## ----echo=FALSE----------------------------------------------------------
rm(list = ls())

## ------------------------------------------------------------------------
data(drug)
str(drug)
head(drug)

## ----tidy=FALSE,fig.cap="Scatterplot of time Vs. dose with fitted linear regression and loess line"----
ggp <- ggplot(data=drug, mapping = aes(x=dose, y=time)) +
  geom_point(color="darkblue", size=2) +
  geom_smooth(method = "lm", colour="red", se = FALSE) +
  geom_smooth(method = "loess", colour="green", se = FALSE, span=1) +
  xlab("dose (mg)") + ylab("reaction time (secs)")
print(ggp)

## ------------------------------------------------------------------------
fm <- lm(time ~ dose, data = drug)
summary(fm) 

## ------------------------------------------------------------------------
anova(fm,update(fm,.~.-dose))

## ----fig.show='hold',fig.cap="Residual plot of simple linear model"------
op <- par(mfrow = c(2, 2))
plot(fm)
par(op)

## ----echo=FALSE----------------------------------------------------------
rm(list = ls())

## ------------------------------------------------------------------------
data(labonline)
str(labonline)

## ----tidy=FALSE,fig.cap="Scatterplot of Online Vs. Lab"------------------
summary(labonline)
ggp <- ggplot(data=labonline, mapping = aes(x=Lab, y=Online)) +
  geom_point(color="darkblue") +
  geom_smooth(method = "lm", colour="red", se = FALSE) +
  geom_smooth(method = "loess", colour="green", se = FALSE, span=1) +
  xlab("Laboratory (pH)") + ylab("On-line (pH)")

print(ggp)

## ------------------------------------------------------------------------
fm <- lm(Online ~ Lab, data = labonline) 
fm1 <- summary(fm) 
fm1

## ----tidy=FALSE----------------------------------------------------------
2*pt(abs(fm1$coefficients[2,1]-1)/fm1$coefficients[2,2],
     df=fm1$df[2],
     lower.tail=FALSE)

## ----fig.show='hold',fig.cap="Residual plot of Online Vs. Lab model"-----
op <- par(mfrow = c(2, 2))
plot(fm)
par(op)

## ----echo=FALSE----------------------------------------------------------
rm(list = ls())

## ------------------------------------------------------------------------
data(polyester)
str(polyester)
head(polyester)

## ----tidy=FALSE,fig.cap="Scatterplot of conversion Vs. temperature"------
ggp <- ggplot(data = polyester, mapping=aes(x = temperature, y=conversion)) +
  geom_point(color="darkblue") + xlab("temperature   (°C)") +
  ylab("percentage conversion (%)")

print(ggp)

## ----tidy=FALSE,fig.cap="Scatterplot of conversion Vs. temperature with linear fit"----
fm0 <- lm(conversion ~ temperature, data = polyester) 
summary(fm0)

ggp0 <- ggp + geom_smooth(method = "lm", colour="red", se = FALSE)

print(ggp0)

## ----fig.show='hold',fig.cap="Residual analysis of simple linear model conversion Vs. temperature "----
op <- par(mfrow=c(2,2))
plot(fm0)
par(op)

## ----fig.cap="Scatterplot of residuals Vs. temperature"------------------
df <- data.frame(temperature = polyester$temperature, mod_residuals =residuals(fm0))

ggp <- ggplot(data = df, mapping = aes(x=temperature, y=mod_residuals)) +
  geom_point(color="darkblue") + geom_hline(yintercept = 0, colour="darkgreen")

print(ggp)

## ------------------------------------------------------------------------
fm <- lm(conversion ~ poly(temperature, 2, raw = TRUE), data = polyester) 

## ------------------------------------------------------------------------
fm <- update(fm0,.~. + I(temperature^2))

## ------------------------------------------------------------------------
summary(fm) 

## ----fig.show='hold',fig.cap="Residual plot of final model"--------------
op <- par(mfrow=c(2,2))
plot(fm)
par(op)

## ------------------------------------------------------------------------
(fm1 <- update(fm,.~. + I(temperature^3)))
summary(fm1)
anova(fm1,fm)

## ----tidy=FALSE,fig.cap="Plot of predition from quadratic model"---------
newdata <- data.frame(temperature = seq(min(polyester$temperature), 
  max(max(polyester$temperature)), length = 100))
newdata$predict <- predict(fm, newdata = newdata)

ggp <- ggplot(data=polyester, mapping = aes(x=temperature, y=conversion)) +
  geom_point(colour="darkblue", size=3) + 
  geom_line(data=newdata, mapping=aes(x=temperature, y=predict), colour="mediumvioletred") + 
  xlab("temperature (°C)") + ylab("percentage conversion (%)")

print(ggp)

