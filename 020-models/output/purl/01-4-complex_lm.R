## ----message=FALSE-------------------------------------------------------
require(ggplot2)
require(dplyr)
require(car)
require(MASS)
require(gridExtra)
require(GGally)
require(qdata)

## ---- echo=FALSE---------------------------------------------------------
rm(list=ls())

## ------------------------------------------------------------------------
data(janka)
head(janka)
str(janka)

## ----fig.cap="Scatterplot of Hardness Vs. Density with loess line"-------
ggp <- ggplot(data = janka, mapping = aes(x = Density, y = Hardness)) +
  geom_point(colour="darkblue", size=2) + 
  geom_smooth(method = "loess", colour="green", se = FALSE, span=0.8)

print(ggp)

## ----fig.cap="Scatterplot of Hardness Vs. Density with loess and lm linear fit"----
ggp <- ggplot(data=janka, mapping = aes(x=Density, y=Hardness)) +
  geom_point(colour="darkblue", size=2) + 
  geom_smooth( method = "lm", colour="red", se=FALSE, size=1) +
  geom_smooth( method = "loess", colour="green", se=FALSE, size=1, span=0.8) 
print(ggp)

## ------------------------------------------------------------------------
fm1 <- lm(Hardness ~ Density, data = janka)
summary(fm1)

## ----fig.show='hold',fig.cap="Residual plot of straight linear model"----
op <- par(mfrow=c(2,2))
plot(fm1)
par(op)

## ----tidy=FALSE,fig.cap="Residuals Vs. fitted values"--------------------
res_fitted_df <- data.frame(res=residuals(fm1), fit=fitted(fm1))

ggp <- ggplot(data= res_fitted_df, mapping = aes(x=fit, y=res)) +
  geom_point(color="darkblue", size=2) + 
  stat_smooth(method="loess", colour="green", se=FALSE, span = 0.8) +
  geom_hline(yintercept = 0, color="red", linetype=2) +
  ylab("Residuals") + xlab("Fitted Values") +
  ggtitle("Hardness ~ Density Residuals Plot")

print(ggp)

## ------------------------------------------------------------------------
fm2 <- update(fm1, . ~ . + I(Density^2))

## ------------------------------------------------------------------------
summary(fm2)

## ------------------------------------------------------------------------
summary(fm2)$coef

## ------------------------------------------------------------------------
anova(fm2,fm1)

## ------------------------------------------------------------------------
fm3 <- update(fm2, . ~ . + I(Density^3))
summary(fm3)$coef

anova(fm2,fm3)

## ------------------------------------------------------------------------
janka <- janka %>% mutate(norm_density = Density - median(Density))

## ----tidy=FALSE,fig.cap="Hardness Vs. normalized (shifted on median) Density plot"----
ggp <- ggplot(data = janka, mapping = aes(x = norm_density, y = Hardness)) +
  geom_point(colour="darkblue") + 
  geom_smooth(method = "loess", colour="green", se = FALSE, span=0.8) +
  geom_smooth(method = "lm", colour="red", se = FALSE) 

print(ggp)

## ------------------------------------------------------------------------
fmd <- lm(Hardness~norm_density+I(norm_density^2), janka)
summary(fmd)$coef

## ------------------------------------------------------------------------
summary(fm2,correlation=TRUE)$correlation
summary(fmd,correlation=TRUE)$correlation

## ------------------------------------------------------------------------
res_fitted_df <- data.frame(res=studres(fmd), fit=fitted(fmd))

ggp1 <- ggplot(data= res_fitted_df, mapping = aes(x=fit, y=res)) +
  geom_point(color="darkblue", size=2) + 
  stat_smooth(method="loess", colour="green", se=FALSE, span = 0.8) +
  geom_hline(yintercept = 0, color="red", linetype=4) +
  ylab("Residuals") + xlab("Fitted Values") +
  ggtitle("Residuals vs Fit Plot")

ggp2 <- ggplot(data = res_fitted_df, mapping = aes(sample = res)) + 
  stat_qq(color="darkblue", size=2) +
  geom_abline(mapping=aes(intercept=mean(res),slope=sd(res)), color="red", linetype=2) +
  xlab("Normal scores") + ylab("Sorted studentized residuals") +
  ggtitle("Residuals Normal Probability Plot")

grid.arrange(ggp1, ggp2, ncol=2)

## ----fig.cap="Box-Cox log-likelihood Vs. Lambda"-------------------------
bxcx <- boxcox(fmd,lambda = seq(-0.25, 1, len=20))

## ------------------------------------------------------------------------
lfmd <- lm(log(Hardness) ~ norm_density + I(norm_density^2), janka)

## ------------------------------------------------------------------------
lfmd <- update(fmd, log(.) ~ .) 

## ------------------------------------------------------------------------
round(summary(lfmd)$coef, 4)

## ----tidy=FALSE,fig.cap="Studentized residual plot"----------------------
res_fitted_df <- data.frame(res=studres(lfmd), fit=fitted(lfmd))

ggp1 <- ggplot(data= res_fitted_df, mapping = aes(x=fit, y=res)) +
  geom_point(color="darkblue", size=2) + 
  stat_smooth(method="loess", colour="green", se=FALSE, span = 0.8) +
  geom_hline(yintercept = 0, color="red", linetype=4) +
  ylab("Residuals") + xlab("Fitted Values") +
  ggtitle("Residuals vs Fit Plot")

ggp2 <- ggplot(data = res_fitted_df, mapping = aes(sample = res)) + 
  stat_qq(color="darkblue", size=2) +
  geom_abline(mapping=aes(intercept=mean(res),slope=sd(res)), color="red", linetype=2) +
  xlab("Normal scores") + ylab("Sorted studentized residuals") +
  ggtitle("Residuals Normal Probability Plot")

grid.arrange(ggp1, ggp2, ncol=2)

## ----fig.show='hold',fig.cap="'Standard' residual plot on final model"----
op <- par(mfrow = c(2,2))
plot(lfmd)
par(op)

## ----fig.show='hold',tidy=FALSE,fig.cap="Final model predictions with 95% intervals in log-scale and original scale", warning=FALSE----
pred <- data.frame(predict(lfmd, interval = "prediction"))
plot_df <- data.frame(d = janka$norm_density, h = log(janka$Hardness), pred)

ggp1 <- ggplot(data = plot_df, mapping = aes(x=d, y=h)) +
  geom_point(col = "darkblue", size = 2) +
  geom_line(mapping=aes(x=d, y=fit), col = "mediumvioletred") +
  geom_line(mapping=aes(x=d, y=lwr), col = "mediumorchid1", linetype=4) +
  geom_line(mapping=aes(x=d, y=upr), col = "mediumorchid1", linetype=4) +
  xlab("Normalized Density") + ylab("log (Hardness)")

ggp2 <- ggplot(data = plot_df, mapping = aes(x=d, y=exp(h))) +
  geom_point(col = "darkblue", size = 2) +
  geom_line(mapping=aes(x=d, y=exp(fit)), col = "mediumvioletred") +
  geom_line(mapping=aes(x=d, y=exp(lwr)), col = "mediumorchid1", linetype=4) +
  geom_line(mapping=aes(x=d, y=exp(upr)), col = "mediumorchid1", linetype=4) +
  xlab("Normalized Density") + ylab("Hardness")

grid.arrange(ggp1, ggp2, ncol=2)  

## ---- echo=FALSE---------------------------------------------------------
rm(list=ls())

## ------------------------------------------------------------------------
data(oxidant)
str(oxidant)
head(oxidant)

## ----fig.cap="Matrix of scatterplots between metereological variables and also Oxidant"----
ggpairs(data = oxidant)

## ------------------------------------------------------------------------
fm1 <- lm(oxidant ~ windspeed+temperature+humidity+insolation, data = oxidant)
summary(fm1)

## ------------------------------------------------------------------------
fm2 <- lm(oxidant ~ (windspeed+temperature+humidity+insolation)^2, data = oxidant)
summary(fm2) 

## ------------------------------------------------------------------------
anova(fm2, fm1, test = "F")

## ------------------------------------------------------------------------
summary(fm1)

## ------------------------------------------------------------------------
fm3 <- update(fm1,.~.+humidity:insolation)
summary(fm3)

## ------------------------------------------------------------------------
anova(fm1,fm3)

## ----fig.show='hold',fig.cap="Residual plot of first model rescribing Oxidant"----
op <- par(mfrow = c(2, 2))
plot(fm3)
par(op)

## ----fig.cap="Matrix of scatterplot between all variables and also residuals"----
oxidant2 <- oxidant %>% bind_cols(data.frame(res=residuals(fm3)))
ggpairs(cbind(oxidant2))

## ------------------------------------------------------------------------
fm4 <- update(fm3,.~.+I(humidity^2))
summary(fm4)

## ------------------------------------------------------------------------
fm4 <- update(fm4,.~.-humidity:insolation)
summary(fm4)

## ------------------------------------------------------------------------
fm <- update(fm4, .~.-insolation)
summary(fm)

## ------------------------------------------------------------------------
anova(fm, update(fm , .~.+windspeed:temperature), test = "F")

## ----fig.show='hold',fig.cap="Residual plot for second model"------------
op <- par(mfrow = c(2, 2))
plot(fm)
par(op)

## ----fig.show='hold',fig.cap="Matrix of scatterplot between variables and also residuals"----
oxidant3 <- oxidant %>% bind_cols(res=data.frame(residuals(fm)))
ggpairs(oxidant3)

## ----echo=FALSE----------------------------------------------------------
options(contrasts = c("contr.treatment", "contr.poly"))
rm(list = ls())

## ------------------------------------------------------------------------
data(hotdogs)
str(hotdogs)
head(hotdogs)

## ----fig.cap="Box and whisker plot of calories by type of hot dog"-------
ggp <- ggplot(data = hotdogs, mapping = aes(x = type, y=calories, fill=type)) +
  geom_boxplot()
print(ggp)

## ----tidy=FALSE,fig.cap="Simple scatterplot of calories Vs. sodium"------
ggp <- ggplot(data=hotdogs, mapping = aes(x=sodium, y=calories)) +
  geom_point(size=2, color="darkblue")
print(ggp)

## ----tidy=FALSE,fig.cap="Scatterplot of calories Vs. sodium with types with different colors"----
ggp <- ggplot(data=hotdogs, mapping = aes(x=sodium, y=calories, color=type)) +
  geom_point(size=2)
print(ggp)

## ----tidy=FALSE,fig.cap="Scatterplot of calories Vs. sodium with types with different symbols"----
ggp <- ggplot(data=hotdogs, mapping = aes(x=sodium, y=calories, shape=type)) +
  geom_point(size=2)
print(ggp)


## ----tidy=FALSE,fig.cap="Scatterplot of calories Vs. sodium with types with different colors and symbols"----
ggp <- ggplot(data=hotdogs, mapping = aes(x=sodium, y=calories, shape= type, color=type)) +
  geom_point(size=2)
print(ggp)

## ----tidy=FALSE,fig.cap="Scatterplot of calories Vs. sodium by type"-----
ggp <- ggplot(data=hotdogs, mapping = aes(x=sodium,y=calories)) + 
  geom_point(color="darkblue", size=2)+ 
  geom_smooth(method = "lm", se=FALSE, colour="red") +
  geom_smooth(method = "loess", se=FALSE, colour="green") + 
  facet_wrap(facets = ~type)
print(ggp)

## ------------------------------------------------------------------------
fm <- lm(calories ~type*sodium, data = hotdogs) 
summary(fm)
summary.aov(fm) 

## ------------------------------------------------------------------------
fm <- lm(calories ~ sodium * type, data = hotdogs) 
summary(fm)
summary.aov(fm) 

## ------------------------------------------------------------------------
fm <- update(fm, .~.-sodium:type) 
summary.aov(fm)
summary(fm)

## ------------------------------------------------------------------------
fm <- lm(calories ~ sodium + type - 1, data = hotdogs)

## ------------------------------------------------------------------------
summary(fm)

## ------------------------------------------------------------------------
contrasts(hotdogs$type) <- matrix(c(-1,-1,1,-1,0,2),ncol=2,nrow=3,byrow=TRUE) 
fm3 <- lm(calories ~ sodium + type, data = hotdogs)
summary(fm3)

## ------------------------------------------------------------------------
hotdogs$type2 <- as.character(hotdogs$type)
hotdogs$type2[hotdogs$type2 == "beef"] = "meat"
hotdogs$type2 <- factor(hotdogs$type2, levels = c("meat", "poultry"))

## ------------------------------------------------------------------------
fm1 <- lm(calories ~ sodium + type2, data = hotdogs)
summary(fm1)

## ------------------------------------------------------------------------
summary(fm)$sigma
summary(fm1)$sigma

## ----fig.show='hold',fig.cap="Residual plot of model with distinct types for meat and beef"----
op <- par(mfrow = c(2, 2))
plot(fm)
par(op)

## ----fig.show='hold',fig.cap="Residual plot of model with pooled types for meat and beef"----
op <- par(mfrow = c(2, 2))
plot(fm1)
par(op)

## ----echo=FALSE----------------------------------------------------------
rm(list = ls())

## ------------------------------------------------------------------------
data(istat)
str(istat)
head(istat)

## ----fig.cap="Scatterplot of Weight Vs. Height"--------------------------
ggp <- ggplot(data=istat, mapping = aes(x=Height, y=Weight))+
  geom_point(color="darkblue")

print(ggp)

## ----tidy=FALSE,fig.cap="Scatterplot of Weight Vs. Height by Gender"-----
ggp <- ggplot(data=istat,mapping = aes(x=Height, y= Weight)) + 
  geom_point(colour="darkblue") +
  facet_wrap(facets = ~Gender) + 
  geom_smooth(method = "lm", colour= "red", se=FALSE)

print(ggp)

## ----tidy=FALSE,fig.cap="Scatterplot of Weight Vs. Height by Area and Gender"----
ggp <- ggplot(data=istat, mapping = aes(x=Height, y= Weight)) + 
  geom_point(colour="darkblue") +
  facet_grid(facets = Gender~Area) + 
  geom_smooth(method = "lm", colour= "red", se=FALSE)

print(ggp)

## ------------------------------------------------------------------------
fm <- lm(Weight ~ (Height + Gender + Area)^2, data = istat)
summary.aov(fm)

## ------------------------------------------------------------------------
fm <- lm(Weight ~ Height + Gender + Area + Height:Gender, data = istat)
summary.aov(fm)

anova(fm,update(fm, .~. +Height:Area+Gender:Area))

## ----fig.show='hold',fig.cap="Residual plot of first model"--------------
op <- par(mfrow = c(2, 2))
plot(fm)
par(op)

## ----fig.cap="Scatterplot of Weight Vs. Height by Gender with lowess and fitted line"----
ggp <- ggplot(data=istat,mapping = aes(x=Height, y= Weight)) + 
  geom_point(colour="darkblue") +
  facet_wrap(facets = ~Gender) + 
  geom_smooth(method = "lm", colour= "red", se=FALSE) +
  geom_smooth(method = "loess", colour= "green", se=FALSE, span=0.5)

print(ggp)

## ------------------------------------------------------------------------
fm <- lm(Weight ~ Area + Height * Gender, data = istat)

## ----fig.cap="Box-Cox likelihood graph for Istat toy model"--------------
boxcox(fm, lambda = seq(-0.5, 0.5, 1/20))
grid()

## ------------------------------------------------------------------------
fm_l <- update(fm, Weight^(-0.2)~.)
summary.aov(fm_l)

## ------------------------------------------------------------------------
fm_l <- update(fm_l, .~.-Area)

## ----fig.show='hold',fig.cap="Residual plot for Istat toy model"---------
op <- par(mfrow = c(2, 2))
plot(fm_l)
par(op)

## ------------------------------------------------------------------------
newdata <- data.frame(Height = c(150:199, 150:199), Gender = factor(rep(c("Female", "Male"), each = 50)))
pred <- predict(fm_l, newdata = newdata, se = T, interval = "prediction")

## ------------------------------------------------------------------------
newdata$fit <- pred$fit[,1] # predicted values
newdata$lwr <- pred$fit[,2] # UPL
newdata$upr <- pred$fit[,3] # LPL
ylim <- range(istat$Weight^(-0.2))*c(0.95, 1.05) # compute y range

## ----fig.show='hold',tidy=FALSE,fig.cap="Plot of model predictions by Gender with 95% prediction intervals on transformed scale", warning=FALSE----
ggp1 <- ggplot(data=istat %>% filter(Gender=="Male"),mapping=aes(x=Height, y=Weight^(-0.2))) +
  geom_point(color="darkblue") +
  geom_line(data=newdata %>% filter(Gender=="Male"),
    mapping=aes(x=Height, y=fit), color="mediumvioletred") +
  geom_line(data=newdata %>% filter(Gender=="Male"),
    mapping=aes(x=Height, y=upr), color="mediumorchid1", linetype=2) +
  geom_line(data=newdata %>% filter(Gender=="Male"),
    mapping=aes(x=Height, y=lwr), color="mediumorchid1", linetype=2) +
  ggtitle("Male") + ylim(ylim) 

ggp2 <- ggplot(data=istat %>% filter(Gender=="Female"),mapping=aes(x=Height, y=Weight^(-0.2))) +
  geom_point(color="darkblue") +
  geom_line(data=newdata %>% filter(Gender=="Female"),
    mapping=aes(x=Height, y=fit), color="mediumvioletred") +
  geom_line(data=newdata %>% filter(Gender=="Female"),
    mapping=aes(x=Height, y=upr), color="mediumorchid1", linetype=2) +
  geom_line(data=newdata %>% filter(Gender=="Female"),
    mapping=aes(x=Height, y=lwr), color="mediumorchid1", linetype=2) +
  ggtitle("Female") +ylim(ylim) 
  
grid.arrange(ggp1, ggp2, ncol=2)

## ------------------------------------------------------------------------
ylim <- range(istat$Weight * c(0.95, 1.05))

## ----fig.show='hold',tidy=FALSE,fig.cap="Plot of model predictions by Gender with 95% prediction intervals on original scale", warning=FALSE----
ggp1 <- ggplot(data=istat %>% filter(Gender=="Male"), mapping=aes(x=Height, y=Weight)) +
  geom_point(color="darkblue") +
  geom_line(data=newdata %>% filter(Gender=="Male"), 
    mapping=aes(x=Height, y=(fit^(-5))), color="mediumvioletred") +
  geom_line(data=newdata %>% filter(Gender=="Male"), 
    mapping=aes(x=Height, y=(upr^(-5))), color="mediumorchid1", linetype=2) +
  geom_line(data=newdata %>% filter(Gender=="Male"), 
    mapping=aes(x=Height, y=(lwr^(-5))), color="mediumorchid1", linetype=2) +
  ggtitle("Male") + ylim(ylim) 

ggp2 <- ggplot(data=istat %>% filter(Gender=="Female"), mapping=aes(x=Height, y=Weight)) +
  geom_point(color="darkblue") +
  geom_line(data=newdata %>% filter(Gender=="Female"), 
    mapping=aes(x=Height, y=(fit^(-5))), color="mediumvioletred") +
  geom_line(data=newdata %>% filter(Gender=="Female"), 
    mapping=aes(x=Height, y=(upr^(-5))), color="mediumorchid1", linetype=2) +
  geom_line(data=newdata %>% filter(Gender=="Female"), 
    mapping=aes(x=Height, y=(lwr^(-5))), color="mediumorchid1", linetype=2) +
  ggtitle("Female") + ylim(ylim) 
  
grid.arrange(ggp1, ggp2, ncol=2)

## ----echo=FALSE----------------------------------------------------------
rm(list = ls())

## ------------------------------------------------------------------------
data(iowheat)
str(iowheat)
head(iowheat)

## ----fig.cap="Matrix of scatterplot between dataframe variables"---------
ggpairs(iowheat)

## ------------------------------------------------------------------------
fmA <- lm(Yield ~ .^2, data = iowheat)
fmA

## ------------------------------------------------------------------------
dim(iowheat)

## ------------------------------------------------------------------------
fmA <- lm(Yield ~ ., data = iowheat)
summary(fmA)

## ------------------------------------------------------------------------
lower_step_aic_fm <- stepAIC(fmA, scope = list(lower  =  ~Year, upper = ~ .), direction = "both")
summary(lower_step_aic_fm)

## ------------------------------------------------------------------------
upper_step_aic_fm <- stepAIC(lower_step_aic_fm, scope = list(upper  =  ~.^2), direction = "both")
summary(upper_step_aic_fm)

## ----fig.show='hold',fig.cap="Residual plot of model"--------------------
op <- par(mfrow = c(2,2))
plot(upper_step_aic_fm)
par(op)

