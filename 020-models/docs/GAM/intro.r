## mgcv demo.
library(mgcv);library(MASS)
with(mcycle,plot(times,accel))

## initial fit
mm1 <- gam(accel~s(times),data=mcycle)
mm1
par(mfrow=c(2,1))
plot(mm1,residuals=TRUE,pch=19)

## try higher df...
mm2 <- gam(accel~s(times,k=40),data=mcycle)
mm2
plot(mm2,residuals=TRUE,pch=19)

gam.check(mm2)

## adaptive...
plot(mm2,residuals=TRUE,pch=19)
mm3 <- gam(accel~s(times,bs="ad"),data=mcycle)
mm3
plot(mm3,residuals=TRUE,pch=19)

AIC(mm1,mm2,mm3)

summary(mm3)
predict(mm3,data.frame(times=c(20,30)),se=TRUE)

###############################
## 2D smoothing --- brain scan
###############################

library(gamair)
data(brain)

## plot raw data...
par(mfrow=c(1,1))
brain <- brain[brain$medFPQ>5e-3,] ## exclude two faulty pixels
X<-sort(unique(brain$X));Y<-sort(unique(brain$Y))
z <- matrix(NA,49,43)
mx<-min(brain$X)-1;my<-min(brain$Y)-1
for (i in 1:length(brain$medFPQ)) 
z[brain$Y[i]-my,brain$X[i]-mx] <- brain$medFPQ[i]
image(Y,X,log(z),zlim=c(-4,4),main="medFPQ brain image")

## Smooth it (in a model based way)...
m0 <- gam(medFPQ~s(X,Y),data=brain)
gam.check(m0)
rsd <- residuals(m0)
rm <- gam(rsd~s(X,Y,k=100),data=brain)
rm
m0 <- gam(medFPQ~s(X,Y,k=100),data=brain)
gam.check(m0)
m1 <- gam(medFPQ~s(X,Y,k=100),data=brain,family=Gamma(link=log))
gam.check(m1)
m2 <- gam(medFPQ~s(X,Y,k=100),data=brain,family=Gamma(link=log),method="REML")
gam.check(m2)
plot(m2)
vis.gam(m2,view=c("Y","X"),too.far=.03,plot.type="contour")

##########################################
## Wisconsin diabetic retinopathy example,
## From Chong Gu's gss package....
##########################################

### EDIT NEXT LINE!!
wesdr <- read.table("c:/lnotes/short-mgcv/Examples/wesdr.txt")
pairs(wesdr)
b <- gam(ret~te(dur)+te(gly)+te(bmi)+te(dur,gly)+te(dur,bmi)+te(gly,bmi),
         data=wesdr,family=binomial(),method="ML")
b
gam.check(b)
par(mfrow=c(2,3),mar=c(4,4,1,1))
for (i in 1:3) plot(b,residuals=TRUE,pch=".",shade=TRUE,select=i)
for (i in 4:6) plot(b,pers=TRUE,ticktype="detailed",select=i,zlim=c(-1,1.5),
                    col="lightblue")
par(mfrow=c(1,1),mar=c(5,5,4,4))
vis.gam(b,view=c("gly","bmi"),phi=30,theta=-30,too.far=.1)
vis.gam(b,view=c("gly","bmi"),se=T,phi=30,theta=-30,too.far=.1)
vis.gam(b,view=c("gly","bmi"),plot.type="contour",too.far=.1)

#########################
## gasoline data example 
#########################

library(pls)
data(gasoline)
gas <- gasoline
nm <- seq(900,1700,by=2)

plot(nm,gas$NIR[1,],type="l",ylab="log(1/R)",xlab="wavelength (nm)",col=1)
text(1000,1.2,"octane");text(1000,1.2-.1,gas$octane[i],col=1)

for (i in 2:8) { lines(nm,gas$NIR[i,],col=i)
  text(1000,1.2-.1*i,gas$octane[i],col=i)
}

gas$nm <- t(matrix(nm,length(nm),length(gas$octane)))
gas$nm[1:2,1:10]
gas$NIR[1:2,1:10]

b <- gam(octane~s(nm,by=NIR,bs="ad"),data=gas,method="REML")
b
gam.check(b)
plot(b,rug=FALSE,shade=TRUE)

## let's get a simultaneous CI on coef function

library(MASS);n <- 1000
pd <- data.frame(nm=nm,NIR=nm*0+1)
pred <- predict(b,pd,se=TRUE,type="terms") ## for CI
Xp <- predict(b,pd,type="lpmatrix") ## Xp maps coefs to preds
Xp[,1] <- 0 ## just smooth, not intercept, here
bs <- mvrnorm(n,coef(b),b$Vp) ## simulate from posterior
r <- Xp%*%t(bs) ## 1000 replicate curves from posterior
sim.cp <- 0;m <- 2.6
while(sim.cp<.95) { ## expand CI until simult cp >=.95
  m <- m + .01      ## CI half width multiplier
  ll <- as.numeric(pred$fit - m * pred$se.fit)
  ul <- as.numeric(pred$fit + m * pred$se.fit)
  sim.cp <- mean(colSums(r<=ul&r>=ll)==length(nm))
}
plot(b,rug=FALSE,shade=TRUE,ylim=range(c(ul,ll)))
lines(nm,ll,col=2,lwd=2);lines(nm,ul,col=2,lwd=2)

##########################
## temperature in Cairo...
##########################

data(cairo)
names(cairo)
with(cairo,plot(time,temp,type="l"))
ctm <- gamm(temp~s(day.of.year,bs="cc",k=20)+s(time,bs="cr"),data=cairo,
            correlation=corAR1(form=~1|year))
ctm$gam
par(mfrow=c(1,2))
plot(ctm$gam,residuals=TRUE,shade=TRUE,scale=0)
summary(ctm$gam)

