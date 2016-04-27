## ---- drug---------------------------------------------------------------
load("drug.Rda")
str(drug)

## ---- drugplot, fig = TRUE-----------------------------------------------
pl_1 <- ggplot(data = drug, mapping = aes(x = dose, y=time)) + 
  geom_point() +
  xlab(label = "Dose (mg)") +
  ylab(label = "Reaction Time (secs)")

pl_1

## ---- reg, fig = T-------------------------------------------------------
pl_1 + geom_smooth(method="lm", se=FALSE) 

## ---- lm-----------------------------------------------------------------
fm <- lm(time ~ dose, data = drug)

## ---- summary.lm---------------------------------------------------------
summary(fm)

## ---- anova--------------------------------------------------------------
anova(fm, test = F)

## ---- fm_list------------------------------------------------------------
# regression coefficients
coef(fm)
# residuals
resid(fm)
# fitted values
fitted(fm)

## ---- predict------------------------------------------------------------
newdata = data.frame(dose = c(0.2, 0.4, 0.6 ))
predict (fm , newdata = newdata)

## ---- prediction---------------------------------------------------------
predict (fm , newdata = newdata, interval = "prediction")

## ---- predictionplot, fig = T--------------------------------------------
# Compute predictions with interval from estimated model
newdata = data.frame(dose = seq(0, 0.9 , len = 100))
newdata = cbind(newdata, predict(fm, newdata = newdata,
  interval = "prediction"))
# Compute limits for y axis
ylim = c(min(newdata$lwr), max(newdata$upr)) * c(0.99, 1.01)
# data frame containing the information for drawing prediction interval 
df2 <- data.frame(x_values=c(newdata$dose, rev(newdata$dose)), y_values=c(newdata$lwr , rev(newdata$upr)))

# prediction interval
pl_1 + ylim(ylim) + geom_polygon(mapping = aes(x= x_values, y= y_values), data=df2, alpha=0.3) +
  geom_line(mapping = aes(x=dose, y=fit), data=newdata, col="red")

## ---- lmplot, fig = T, fig.height=7--------------------------------------
par(mfrow = c(2,2))
plot(fm)

## ---- carseat------------------------------------------------------------
load("carseat.Rda")
str(carseat)

## ---- carseatplot, fig = TRUE--------------------------------------------
pl_2 <- ggplot(data = carseat, mapping = aes(x=Operator, y=Strength)) +
  geom_boxplot(fill = "lightgray", outlier.colour = "red") +
  xlab(label = "Operator") + ylab(label = "Resistance")

pl_2

## ---- aov----------------------------------------------------------------
fm <- aov(Strength~Operator, data = carseat)

## ---- summary.aov--------------------------------------------------------
summary(fm)

## ---- aov2---------------------------------------------------------------
# Remove outlier of "Michelle" Operator from dataset 
carseat_2 <- carseat %>% filter(!(Operator == "Michelle" & Strength == max(Strength)))

# Compute analysis of variance on carseat_2 dataframe (without outlier of "Michelle" Operator)
fm_2 <- aov(Strength~Operator, data = carseat_2)
summary(fm_2)

## ---- carseat summary.lm-------------------------------------------------
summary.lm(fm)

## ---- residualscarseat, fig = T------------------------------------------
par(mfrow = c(1,2))
plot(fm, which = 1:2)

## ---- boiling------------------------------------------------------------
load("boiling.Rda")
str(boiling)

## ---- boilingxyplot, fig=T-----------------------------------------------
pl_3 <- ggplot(data = boiling, mapping = aes(x=volume, y=time, colour=pan)) + 
  geom_line() + geom_point()

pl_3

## ---- boling lm----------------------------------------------------------
fm_3 = lm(time ~ volume + pan + volume:pan, data = boiling)
# To visualize only coefficients part of summary output, the sintax is:
summary(fm_3)$coeff

## ---- boiling lm2--------------------------------------------------------
fm_31 = lm(time ~ pan + volume:pan - 1, data = boiling)
summary(fm_31)$coeff

## ---- boiling lm3--------------------------------------------------------
fm_32 = lm(time ~ pan/volume - 1, data = boiling)
summary(fm_32)$coeff

## ---- boiling lm4--------------------------------------------------------
fm_4 = glm(time ~ pan * volume, data = boiling,
  family = gaussian(link = "identity"))
summary(fm_4)$coeff

## ---- boiling glm--------------------------------------------------------
fm_5 = glm(time ~ pan*volume, data = boiling,
  family = Gamma(link = "identity"))
summary(fm_5)$coeff 

## ---- boiling aic--------------------------------------------------------
fm_4$aic
fm_5$aic

