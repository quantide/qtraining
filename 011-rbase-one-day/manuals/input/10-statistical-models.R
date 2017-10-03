## ----drug, message=FALSE-------------------------------------------------
require(qdata)
data(drug)
str(drug)

## ----drugplot, message=FALSE---------------------------------------------
require(ggplot2)
pl <- ggplot(data = drug, mapping = aes(x = dose, y=time)) + 
  geom_point() +
  xlab(label = "Dose (mg)") +
  ylab(label = "Reaction Time (secs)")

pl

## ----reg-----------------------------------------------------------------
pl + geom_smooth(method="lm", se=FALSE) 

## ----lm------------------------------------------------------------------
fm <- lm(formula = time ~ dose, data = drug)

## ----summary.lm----------------------------------------------------------
summary(fm)

## ----fm_list-------------------------------------------------------------
# regression coefficients
coef(fm)
# residuals
resid(fm)
# fitted values
fitted(fm)

## ----predict-------------------------------------------------------------
newdata <- data.frame(dose = c(0.2, 0.4, 0.6 ))
predict (fm, newdata = newdata)

## ----lmplot, fig.height=7------------------------------------------------
par(mfrow = c(2,2))
plot(fm)

