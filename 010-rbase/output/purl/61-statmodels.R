## ---- options, echo=FALSE, results='hide', message=FALSE, warning=FALSE----
source("options.R")
require(knitr)
opts_knit$set(root.dir = "../data")

## ----first, message=FALSE------------------------------------------------
require(ggplot2)
require(dplyr)

## ----model, eval=FALSE---------------------------------------------------
## linear_model <- lm(formula, data)
## anova_model <- aov(formula, data)

## ---- drug---------------------------------------------------------------
load("drug.Rda")
str(drug)

## ----require_ggplot2, eval=FALSE-----------------------------------------
## require(ggplot2)

## ---- drugplot, fig = TRUE-----------------------------------------------
pl_1 <- ggplot(data = drug, mapping = aes(x = dose, y=time)) + 
  geom_point() +
  xlab(label = "Dose (mg)") +
  ylab(label = "Reaction Time (secs)")

pl_1

## ---- reg, fig = T-------------------------------------------------------
pl_1 + geom_smooth(method="lm", se=FALSE) 

## ---- lm-----------------------------------------------------------------
fm <- lm(formula = time ~ dose, data = drug)

## ---- summary.lm---------------------------------------------------------
summary(fm)

## ---- fm_list------------------------------------------------------------
# regression coefficients
coef(fm)
# residuals
resid(fm)
# fitted values
fitted(fm)

## ---- predict------------------------------------------------------------
newdata <- data.frame(dose = c(0.2, 0.4, 0.6 ))
predict (fm , newdata = newdata)

## ---- lmplot, fig = T, fig.height=7--------------------------------------
par(mfrow = c(2,2))
plot(fm)

## ---- carseat------------------------------------------------------------
load("carseat.Rda")
str(carseat)

## ----require_dplyr, eval=FALSE-------------------------------------------
## require(dplyr)

## ---- carseatplot, fig = TRUE--------------------------------------------
# Data frame of Strength means for each Operator
means_df <- carseat %>% group_by(Operator) %>% summarize(mean=mean(Strength))

pl_2 <- ggplot(data = carseat, mapping = aes(x=Operator, y=Strength)) +
  geom_boxplot(fill = "lightgray", outlier.colour = "blue") +
  geom_point(data=means_df, mapping = aes(x=Operator, y=mean), colour="red", shape=18, size=3) + 
  xlab(label = "Operator") + ylab(label = "Resistance")

pl_2

## ---- aov----------------------------------------------------------------
fm <- aov(Strength~Operator, data = carseat)

## ---- summary.aov--------------------------------------------------------
summary(fm)

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

## ---- boiling glm--------------------------------------------------------
fm_5 <- glm(time ~ pan*volume, data = boiling,
  family = Gamma(link = "identity"))
summary(fm_5) 

