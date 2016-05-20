## ---- message=FALSE------------------------------------------------------
require(nortest)
require(car)
require(ggplot2)
require(dplyr)
require(gridExtra)
require(tidyr)
require(qdata)

## ---- echo=FALSE, message=FALSE------------------------------------------
rm(list=ls())

## ----split=TRUE----------------------------------------------------------
data(reaction)
head(reaction)
str(reaction)

## ------------------------------------------------------------------------
# Add an index variable to reaction 
reaction <- data.frame(reaction=reaction, index=1:10)

summary_stat <- reaction %>%  summarise(n=n(),
  min=min(reaction),
  first_qu=quantile(reaction, 0.25),
  mean=mean(reaction),
  median=median(reaction),
  third_qu=quantile(reaction, 0.75),
  max=max(reaction),
  sd=sd(reaction))

print(summary_stat)

## ----fig.cap="Plot of reaction values",tidy=FALSE,comment='tidy=FALSE forza a-capo nel punto in cui si trova', message=FALSE, warning=FALSE----
ggp <- ggplot(data = reaction, mapping=aes(x=index, y=reaction)) + 
  geom_point() + 
  ylim(c(177,183)) +
  geom_hline(yintercept = 180, color="red") +
  geom_hline(yintercept = mean(reaction$reaction), color="darkgreen")

print(ggp)

## ----fig.cap="Stripchart of reaction values",tidy=FALSE------------------
reaction$index <- rep(0, times=10)
ggp <- ggplot(data = reaction, mapping=aes(x=reaction, y=index)) + 
  geom_point() + ylim(c(-2,2)) +
  geom_vline(xintercept = 180, color="red") +
  geom_vline(xintercept = mean(reaction$reaction), color="darkgreen") +
  ylab("") +
  theme(axis.text.y=element_blank(), axis.ticks=element_blank()) +
  annotate("text", label = "reaction mean", x = 178.8, y = 2, size = 4, colour = "darkgreen") +
  annotate("text", label = "target", x = 180.3, y = 2, size = 4, colour = "red")

print(ggp)     

## ------------------------------------------------------------------------
ad.test(reaction$reaction)

## ----fig.cap="Normal probability plot of reaction"-----------------------
ggp <- ggplot(data = reaction, mapping = aes(sample = reaction)) + 
  stat_qq(color="darkblue", size=2) +
  geom_abline(mapping = aes(intercept=mean(reaction),slope=sd(reaction)), color="red", linetype=2)

print(ggp)

## ------------------------------------------------------------------------
t.test(reaction$reaction, mu = 180)

## ------------------------------------------------------------------------
mod <- lm(formula = reaction~1, data = reaction)

## ------------------------------------------------------------------------
mod

## ------------------------------------------------------------------------
summary(mod)

## ------------------------------------------------------------------------
reaction_z <- reaction$reaction-180
fm <- lm(reaction_z~1)

## ------------------------------------------------------------------------
fm <- lm(I(reaction-180)~1, data=reaction)

## ------------------------------------------------------------------------
summary(fm)

## ------------------------------------------------------------------------
mean(reaction$reaction) - 180

## ----fig.cap="Normal probability plot of residuals"----------------------
res <- data.frame(res=fm$residuals)
ad.test(res$res)

ggp <- ggplot(data = res, mapping = aes(sample = res)) + 
  stat_qq(color="darkblue", size=2) +
  geom_abline(mapping = aes(intercept=mean(res),slope=sd(res)), color="red", linetype=2)

print(ggp)

## ----echo=FALSE----------------------------------------------------------
rm(list = ls())

## ----load2---------------------------------------------------------------
data(hormones)
head(hormones)
str(hormones)

## ----tidy=FALSE----------------------------------------------------------
hormones %>% group_by(hormone) %>%
  summarise(min = min(gain), 
    first_qu = quantile(gain, 0.25),
    median = median(gain),
    mean = mean(gain),
    third_qu = quantile(gain, 0.75),
    max = max(gain),
    sd = sd(gain))

## ----preplot2a,tidy=FALSE,fig.cap="Box-and-whiskers plot of gain by hormone"----
ggp <- ggplot(data = hormones, mapping = aes(x=hormone, y=gain, fill=hormone)) +
  geom_boxplot()

print(ggp)

## ----preplot2b,tidy=FALSE,fig.cap="Stripchart with connect line of gain by hormone", message=FALSE, warning=FALSE----
hormones_mean <- hormones %>% group_by(hormone) %>% summarise(gain=mean(gain))

ggp <- ggplot(data = hormones, mapping = aes(x=hormone, y=gain)) +
  geom_jitter(position = "dodge", color="darkblue") +
  geom_point(data=hormones_mean, mapping = aes(x=hormone,y=gain), colour="red", group=1) +
  geom_line(data=hormones_mean, mapping = aes(x=hormone,y=gain), colour="red", group=1) 
  
print(ggp)   

## ----qqmath2,fig.cap="",tidy=FALSE,fig.cap="Normal probability plot of gain by hormone"----
hormones_a <- hormones %>% filter(hormone =="A") 
hormones_b <- hormones %>% filter(hormone =="B")

ggp1 <- ggplot(data = hormones_a, mapping = aes(sample = gain)) + 
  stat_qq(color="#F8766D", size=2) +
  geom_abline(intercept=mean(hormones_a$gain),slope=sd(hormones_a$gain), color="red", linetype=2) +
  ylab("hormone A") + ggtitle("q-q plot of hormone A")

ggp2 <- ggplot(data = hormones_b, mapping = aes(sample = gain)) + 
  stat_qq(color="#00C094", size=2) +
  geom_abline(mapping = aes(intercept=mean(hormones_b$gain),slope=sd(hormones_b$gain)), color="red", linetype=2) +
  ylab("hormone B") + ggtitle("q-q plot of hormone B")

grid.arrange(ggp1, ggp2, nrow = 2)

## ------------------------------------------------------------------------
tapply(hormones$gain, hormones$hormone, ad.test)

## ------------------------------------------------------------------------
var.test(gain ~ hormone, data = hormones)
bartlett.test(gain ~ hormone,data=hormones)
leveneTest(gain ~ hormone,data=hormones)

## ------------------------------------------------------------------------
t.test(gain ~ hormone, data = hormones, var.equal = TRUE) 

## ------------------------------------------------------------------------
mod <- lm(gain ~ hormone, data = hormones) 
mod

## ------------------------------------------------------------------------
summary(mod)

## ------------------------------------------------------------------------
model.matrix(mod)

## ------------------------------------------------------------------------
fm <- aov(mod) 

## ------------------------------------------------------------------------
summary(fm)

## ------------------------------------------------------------------------
fm <- aov(gain ~ hormone, data = hormones) 
summary(fm) 

## ------------------------------------------------------------------------
class(mod)
class(fm)

## ------------------------------------------------------------------------
options("contrasts")
options(contrasts = c("contr.treatment", "contr.poly"))

## ------------------------------------------------------------------------
coefficients(fm)

## ------------------------------------------------------------------------
diff(tapply(hormones$gain, hormones$hormone, mean))

## ------------------------------------------------------------------------
options(contrasts = c("contr.sum", "contr.poly"))

## ------------------------------------------------------------------------
fm <- aov(gain~hormone, data = hormones)

## ------------------------------------------------------------------------
summary(fm)

## ------------------------------------------------------------------------
coefficients(fm)

## ------------------------------------------------------------------------
model.matrix(fm)

## ------------------------------------------------------------------------
options(contrasts = c("contr.treatment", "contr.poly"))

## ------------------------------------------------------------------------
mod <- lm(gain ~ hormone-1, data = hormones)
coefficients(mod)

## ------------------------------------------------------------------------
model.matrix(mod)

## ------------------------------------------------------------------------
fm <- aov(mod) 
summary(fm)
coefficients(fm)

## ------------------------------------------------------------------------
anova(mod,lm(gain ~ 1, data = hormones))

## ----fig.cap="",tidy=FALSE,fig.cap="Overlaid Normal probability plots of residuals"----
res <- cbind(hormones,res=fm$residuals)

ad.test(res$res)

ggp <- ggplot(data = res, mapping = aes(sample = res, color=hormone)) + 
  stat_qq(size=2) +
  geom_abline(mapping = aes(intercept=mean(res), slope=sd(res)), colour="red", linetype=2)

print(ggp)

## ------------------------------------------------------------------------
ad.test(fm$residuals) 

## ----echo=FALSE----------------------------------------------------------
rm(list = ls())

## ------------------------------------------------------------------------
data(carctl)
str(carctl)

## ----fig.cap="Box-and-whiskers plot of parking times for the two cars"----
carctl2 <- carctl %>% gather(car, value, Car_A, Car_B)

ggp <- ggplot(data = carctl2, mapping = aes(x=car, y=value, fill=car)) +
  geom_boxplot()

print(ggp)

## ----fig.cap="Stripchart with connect line of parking times for the two cars",tidy=FALSE, message=FALSE, warning=FALSE----
carctl_mean <- carctl2 %>% group_by(car) %>% summarise(value=mean(value))

ggp <- ggplot(data = carctl2, mapping = aes(x=car, y=value)) +
  geom_jitter(position = "dodge", color="darkblue") +
  geom_point(data=carctl_mean, mapping = aes(x=car,y=value), colour="red", group=1) +
  geom_line(data=carctl_mean, mapping = aes(x=car,y=value), colour="red", group=1) 
  
print(ggp)   

## ----fig.cap="Normal probability plot of parking times of two cars", tidy=FALSE----
ggp <- ggplot(data = carctl2, mapping = aes(sample = value, color=car)) + 
  stat_qq() +
  geom_abline(data= carctl2 %>% filter(car=="Car_A"), mapping=aes(intercept=mean(value), 
    slope=sd(value), color=car), size=1) +
  geom_abline(data= carctl2 %>% filter(car=="Car_B"), mapping=aes(intercept=mean(value),
    slope=sd(value), color=car), size=1)

print(ggp)

## ------------------------------------------------------------------------
lapply(X=carctl, FUN=ad.test) 

## ------------------------------------------------------------------------
t.test(x=carctl$Car_A, y=carctl$Car_B) 

## ----fig.cap="Scattrplot of parking times of Car_A Vs. Car_B"------------
ggp <- ggplot(data = carctl, mapping = aes(x=Car_A, y=Car_B)) + 
  geom_point(col="darkblue")

print(ggp)

## ------------------------------------------------------------------------
carctl <- carctl %>% mutate(car_diff = Car_A - Car_B)
t.test(x=carctl$car_diff, mu=0)

## ------------------------------------------------------------------------
t.test(x=carctl$Car_A, y=carctl$Car_B, paired=TRUE)

## ----fig.cap="Normal probability plot of difference of parking times of two cars"----
ggp <- ggplot(data = carctl, mapping = aes(sample = car_diff)) + 
  stat_qq(color="darkblue", size=2) +
  geom_abline(mapping = aes(intercept=mean(car_diff), slope=sd(car_diff)), colour="red", linetype=2)

print(ggp)

## ------------------------------------------------------------------------
ad.test(x=carctl$car_diff)  

## ------------------------------------------------------------------------
mod <- lm(car_diff ~ 1, data = carctl) 
mod
summary(mod)

## ------------------------------------------------------------------------
mod <- lm(I(Car_A-Car_B)~1, data=carctl)
summary(mod)

## ------------------------------------------------------------------------
ad.test(mod$residuals) 

## ------------------------------------------------------------------------
ad.test(residuals(mod))

## ----echo=FALSE----------------------------------------------------------
rm(list = ls())

## ------------------------------------------------------------------------
data(tissue)
head(tissue)
str(tissue)

## ----fig.cap="Stripchart of Strenght by Operator with connect line"------
tissue_mean <- tissue %>% group_by(Operator) %>% summarise(Strength=mean(Strength))

ggp <- ggplot() +
  geom_point(data = tissue, mapping = aes(x=Operator, y=Strength), colour="darkblue") + 
  geom_line(data=tissue_mean, mapping = aes(x=Operator,y=Strength), colour="red", group=1)

print(ggp)

## ----fig.cap="Plot of univariate effects of Operator on Strenght"--------
plot.design(Strength ~ Operator, data = tissue)

## ------------------------------------------------------------------------
options("contrasts")
options(contrasts = c("contr.treatment", "contr.poly"))
fm_treatment <- aov(Strength~Operator, data = tissue)
summary(fm_treatment)
summary.lm(fm_treatment)

## ------------------------------------------------------------------------
fm_treatment <- lm(Strength~Operator, data = tissue)
summary.aov(fm_treatment)
summary(fm_treatment)

## ------------------------------------------------------------------------
options(contrasts = c("contr.sum", "contr.poly"))
fm_sum <- aov(Strength~Operator, data = tissue)
summary(fm_sum)
summary.lm(fm_sum)

## ------------------------------------------------------------------------
options(contrasts = c("contr.helmert", "contr.poly"))
fm_helm <- aov(Strength~Operator, data = tissue)
summary(fm_helm)
summary.lm(fm_helm)

## ------------------------------------------------------------------------
options(contrasts = c("contr.treatment", "contr.poly"))

## ----fig.show='hold',fig.cap="Compound diagnostic residual plot of Strenght Vs. Operator ANOVA model"----
op <- par(mfrow = c(2, 2))
plot(fm_treatment)
par(op)

## ----echo=FALSE----------------------------------------------------------
rm(list = ls())

## ------------------------------------------------------------------------
data(distance)
head(distance)
str(distance)

## ----fig.cap="Plot of univariate factors effects on Distance response variable"----
plot.design(Distance ~ ., data = distance)

## ----fig.cap="Plots of two-way interaction effects of factors on Distance response variable"----
op <- par(mfrow = c(3, 1))
with(distance, {
  interaction.plot(ABS, Tire, Distance)
  interaction.plot(ABS, Tread, Distance)
  interaction.plot(Tread, Tire, Distance)
  }
)
par(op)

## ------------------------------------------------------------------------
fm <- aov(Distance ~ ABS * Tire * Tread, data = distance)

## ------------------------------------------------------------------------
fm <- aov(Distance ~ ABS + Tire + Tread + ABS:Tire + ABS:Tread + Tire:Tread
         + ABS:Tire:Tread, data = distance)
summary(fm)

## ------------------------------------------------------------------------
fm <- update(fm, . ~ . -ABS:Tire:Tread)
summary(fm)

## ------------------------------------------------------------------------
fm1 <- update(fm, .~ABS+Tire+Tread)
summary(fm1)

## ------------------------------------------------------------------------
anova(fm, fm1)

## ------------------------------------------------------------------------
model.tables(fm1,type="effects")

## ------------------------------------------------------------------------
model.tables(fm1,type="means")

## ------------------------------------------------------------------------
fm <- aov(Distance ~ ABS + Tire, data = distance)
summary(fm)

## ----fig.cap="Compound residual plot for final brake distance model"-----
op <-  par(mfrow = c(2, 2))
plot(fm)
par(op)

## ------------------------------------------------------------------------
distance %>% group_by(ABS, Tire) %>% summarise(mean(Distance))

## ------------------------------------------------------------------------
model.tables(fm, type="means")

## ------------------------------------------------------------------------
df_pred <- data.frame(ABS=c("enabled","disabled"),Tire=c("GT","LS"))
predict(object=fm,newdata=df_pred)

## ----echo=FALSE----------------------------------------------------------
rm(list = ls())

## ------------------------------------------------------------------------
data(distance)
head(distance)
str(distance)

## ------------------------------------------------------------------------
distance1 <- distance[-24,]

## ----fig.cap="Univariate effects plot of unbalanced model"---------------
plot.design(Distance ~ ., data = distance1)

## ----fig.cap="Two-way interaction effects plots of unbalanced model"-----
op <- par(mfrow = c(3, 1))
with(distance1, {
  interaction.plot(ABS, Tire, Distance)
  interaction.plot(ABS, Tread, Distance)
  interaction.plot(Tread, Tire, Distance)
  }
)
par(op)

## ------------------------------------------------------------------------
fm <- aov(Distance ~ ABS * Tire * Tread, data = distance1)
summary(fm)

## ------------------------------------------------------------------------
fm <- update(fm, . ~ . -ABS:Tire:Tread)
summary(fm)

## ------------------------------------------------------------------------
fm1 <- update(fm, .~ABS+Tire+Tread)
summary(fm1)

## ------------------------------------------------------------------------
anova(fm, fm1)

## ------------------------------------------------------------------------
fm <- aov(Distance ~ ABS + Tire, data = distance1)
summary(fm)
fminv <- aov(Distance ~ Tire + ABS, data = distance1)
summary(fminv)

## ------------------------------------------------------------------------
drop1(object=fm,test="F")
drop1(object=fminv,test="F")

## ----fig.show='hold',fig.cap="Residual plots of unbalanced model"--------
op <- par(mfrow = c(2, 2))
plot(fm)
par(op)

## ---- echo=FALSE---------------------------------------------------------
rm(list = ls())

## ------------------------------------------------------------------------
data(diameters)
str(diameters)

## ------------------------------------------------------------------------
summary(diameters)
xtabs(formula=Pin.Diam~Lathe+Operator,data=diameters)

## ----fig.cap="Boxplot of Pin.Diam by Lathe x Operator"-------------------
ggp <- ggplot(data = diameters, mapping = aes(x=Lathe, y=Pin.Diam, fill=Operator)) + 
  geom_boxplot()

print(ggp)

## ------------------------------------------------------------------------
fm1 <- aov(formula = Pin.Diam~Lathe*Operator, data = diameters)
summary(fm1)

## ------------------------------------------------------------------------
diameters$Lathe_op <- factor(diameters$Lathe:diameters$Operator)
xtabs(formula=Pin.Diam~Lathe+Lathe_op,data=diameters)

## ------------------------------------------------------------------------
fm1 <- aov(formula=Pin.Diam~Lathe+Lathe/Operator,data=diameters)
summary(fm1)

## ------------------------------------------------------------------------
fm1a <- aov(formula=Pin.Diam~Lathe+Operator:Lathe,data=diameters)
summary(fm1a)

## ------------------------------------------------------------------------
#alternative correct model
fm1b <- aov(formula=Pin.Diam~Lathe+Operator:Lathe_op,data=diameters)
summary(fm1b)

## ----fig.cap="Residual plot of Late by Operator nested model"------------
op <-  par(mfrow = c(2, 2))
plot(fm1)
par(op)

