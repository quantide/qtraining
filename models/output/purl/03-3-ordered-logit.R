## ---- message=FALSE------------------------------------------------------
require(lattice)
require(nnet)
require(vcd)
require(faraway)
require(ggplot2)
require(MASS) # for housing data
require(qdata)

## ------------------------------------------------------------------------
data(nes96)

# We create a new variabile that will contain recoded `PID` data  [*]
sPID <- nes96$PID
levels(sPID) <-  c("Democrat","Democrat","Independent","Independent",
                  "Independent","Republican","Republican")
summary(sPID)
nes96$sPID=sPID

## ------------------------------------------------------------------------
# Now we create a new numerical `nincome` variable containing the numerical transformation of original ordered-factor `income` variable, using midpoints of each range: [*]
inca <- c(1.5,4,6,8,9.5,10.5,11.5,12.5,13.5,14.5,16,18.5,21,23.5,
         27.5,32.5,37.5,42.5,47.5,55,67.5,82.5,97.5,115)
nincome <- inca[unclass(nes96$income)]
nes96$nincome=nincome
summary(nes96$nincome)

(pomod0 <- polr(sPID ~ age + educ + nincome, data=nes96))
summary(pomod0)


(mmod0 <- multinom(sPID ~ age + educ + nincome, data=nes96)) 
mmod <- step(mmod0)
il <- c(8,26,42,58,74,90,107)

## ------------------------------------------------------------------------
pomod <- step(pomod0)
summary(pomod)

## ------------------------------------------------------------------------
(diff <- deviance(pomod)-deviance(pomod0))
pchisq(diff, pomod0$edf-pomod$edf,lower=F)

## ------------------------------------------------------------------------
anova(pomod,pomod0,test="Chisq")

## ------------------------------------------------------------------------
dropterm(pomod0, test="Chisq")
pomod1 <- polr(sPID ~ educ + nincome, data=nes96)
dropterm(pomod1, test="Chisq")
pomod2 <- polr(sPID ~ nincome, data=nes96)
dropterm(pomod2, test="Chisq")
summary(pomod2)

## ------------------------------------------------------------------------
(pim <- prop.table(table(nincome,sPID),1))
ds <- data.frame(logit1 = logit(pim[,1]), logit2 = logit(pim[,1]+pim[,2])) # note: logit() from package faraway
ggp <- ggplot(data = ds, mapping = aes(x=logit1, y=logit2)) +
  geom_point()
print(ggp)

## ------------------------------------------------------------------------
ds$num <- 1:nrow(ds)
ds$ll <- ds$logit1-ds$logit2 

ggp <- ggplot(data = ds, mapping = aes(x=num, y=ll)) +
  geom_point() + 
  geom_hline(mapping = aes(yintercept = mean(ll)))
print(ggp)

## ------------------------------------------------------------------------
pomod$coefficients

## ------------------------------------------------------------------------
coef(pomod)

## ------------------------------------------------------------------------
exp(pomod$coefficients)

## ------------------------------------------------------------------------
pomod$zeta
ilogit(pomod$zeta) # Note: ilogit==inverse logit

## ------------------------------------------------------------------------
ilogit(pomod$zeta)[1]

## ------------------------------------------------------------------------
ilogit(pomod$zeta)[2] - ilogit(pomod$zeta)[1]

## ------------------------------------------------------------------------
1 - ilogit(pomod$zeta)[2]

## ------------------------------------------------------------------------
summary(pomod)

## ------------------------------------------------------------------------
c(deviance(pomod0), pomod0$edf)
c(deviance(mmod0), mmod0$edf)
c(deviance(pomod), pomod$edf)
c(deviance(mmod), mmod$edf)

## ------------------------------------------------------------------------
pomod$df.residual

## ------------------------------------------------------------------------
predict(pomod,data.frame(nincome=il,row.names=il), type="probs")
predict(pomod,data.frame(nincome=il,row.names=il))

## ------------------------------------------------------------------------
ilogit(pomod$zeta[1] - pomod$coefficients*il)
ilogit(pomod$zeta[2] - pomod$coefficients*il) - ilogit(pomod$zeta[1] - pomod$coefficients*il)
1 - ilogit(pomod$zeta[2] - pomod$coefficients*il)

summary(pomod)

## ------------------------------------------------------------------------
x <- seq(-4,4,by=0.05)
par(mfrow=c(3,1))
plot(x,dlogis(x),type="l",main="Probabilites for income=$0")
minx=-4
maxx=.2091
x1=c(seq(minx,maxx,by=.01))
y1=dlogis(x1)
polygon(c(minx,x1,maxx), c(0,y1,0), density=20, col = "blue", angle=45) 
minx=.2091
maxx=1.2916
x1=c(seq(minx,maxx,by=.01))
y1=dlogis(x1)
polygon(c(minx,x1,maxx), c(0,y1,0), density=20, col = "red",angle=-45) 
minx=1.2916
maxx=4
x1=c(seq(minx,maxx,by=.01))
y1=dlogis(x1)
polygon(c(minx,x1,maxx), c(0,y1,0), density=20, col = "green",angle=45) 
legend(x = "topleft",legend = c("Democrat","Independent","Republican"),
       fill = c("blue","red","green"),angle = c(45,-45,45),density = 40,
       border = c("blue","red","green"),bty = "n")
#abline(v=c(0.2091,1.2916),col="blue")

plot(x,dlogis(x),type="l",main="Probabilites for income=$100,000")
minx <- -4
maxx <- .2091-50*0.013120
x1 <- c(seq(minx,maxx,by=.01))
y1 <- dlogis(x1)
polygon(c(minx,x1,maxx), c(0,y1,0), density=20, col = "blue", angle=45) 
minx <- .2091-50*0.013120
maxx <- 1.2916-50*0.013120
x1 <- c(seq(minx,maxx,by=.01))
y1 <- dlogis(x1)
polygon(c(minx,x1,maxx), c(0,y1,0), density=20, col = "red",angle=-45) 
minx <- 1.2916-50*0.013120
maxx <- 4
x1 <- c(seq(minx,maxx,by=.01))
y1 <- dlogis(x1)
polygon(c(minx,x1,maxx), c(0,y1,0), density=20, col = "green",angle=45) 
legend(x = "topleft",legend = c("Democrat","Independent","Republican"),
       fill = c("blue","red","green"),angle = c(45,-45,45),density = 40,
       border = c("blue","red","green"),bty = "n")
#abline(v=c(0.2091,1.2916)-50*0.013120,lty=2,col="red")

plot(x,dlogis(x),type="l",main="Probabilites for income=$200,000")
minx <- -4
maxx <- .2091-100*0.013120
x1 <- c(seq(minx,maxx,by=.01))
y1 <- dlogis(x1)
polygon(c(minx,x1,maxx), c(0,y1,0), density=20, col = "blue", angle=45) 
minx <- .2091-100*0.013120
maxx <- 1.2916-100*0.013120
x1 <- c(seq(minx,maxx,by=.01))
y1 <- dlogis(x1)
polygon(c(minx,x1,maxx), c(0,y1,0), density=20, col = "red",angle=-45) 
minx <- 1.2916-100*0.013120
maxx <- 4
x1 <- c(seq(minx,maxx,by=.01))
y1 <- dlogis(x1)
polygon(c(minx,x1,maxx), c(0,y1,0), density=20, col = "green",angle=45) 
legend(x = "topleft",legend = c("Democrat","Independent","Republican"),fill = c("blue","red","green"),angle = c(45,-45,45),density = 40,border = c("blue","red","green"),bty = "n")
#abline(v=c(0.2091,1.2916)-100*0.013120,lty=5,col="green")

## ------------------------------------------------------------------------
data(housing)
head(housing)
str(housing)
summary(housing)

## ------------------------------------------------------------------------
(ord_hous0 <- polr(Sat ~ Infl*Type*Cont, weights=Freq, data=housing))
summary(ord_hous0)

## ------------------------------------------------------------------------
dropterm(ord_hous0, test="Chisq")
ord_hous1 <- update(ord_hous0, . ~ . -Infl:Type:Cont)
dropterm(ord_hous1, test="Chisq")
ord_hous <- update(ord_hous1, . ~ . -Infl:Cont)
dropterm(ord_hous, test="Chisq")

## ------------------------------------------------------------------------
summary(ord_hous)

## ------------------------------------------------------------------------
anova(ord_hous0, ord_hous)

## ------------------------------------------------------------------------
tbl <- ftable(xtabs(Freq ~ Infl+Type+Cont+Sat, data=housing))

logit1 <- log(tbl[,1]/(tbl[,2]+tbl[,3]))
logit2 <- log((tbl[,1]+tbl[,2])/tbl[,3])

ds <- data.frame(logit1 = logit1, logit2 = logit2, ll = logit1-logit2, num = 1:length(logit1))

ggp <- ggplot(data = ds, mapping = aes(x=logit1, y=logit2)) +
  geom_point()
print(ggp)

ggp <- ggplot(data = ds, mapping = aes(x=num, y=ll)) +
  geom_point() +
  geom_hline(mapping = aes(yintercept=mean(ll)))
print(ggp)

