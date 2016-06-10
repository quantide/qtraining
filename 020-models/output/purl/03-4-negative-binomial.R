## ---- message=FALSE------------------------------------------------------
require(ggplot2)
require(MASS) 
require(qdata)

## ------------------------------------------------------------------------
data(quine)
head(quine)
str(quine)
summary(quine)

## ------------------------------------------------------------------------
quine_pois <- glm(Days ~ (Sex+Age+Eth+Lrn)^4, data = quine, family=poisson)
summary(quine_pois)

## ---- warning=FALSE------------------------------------------------------
op <- par(mfrow=c(2,2))
plot(quine_pois)
par(op)

## ------------------------------------------------------------------------
quine_nb0 <- glm.nb(Days ~ Sex*Age*Eth*Lrn, data = quine)

## ---- message=FALSE------------------------------------------------------
dropterm(quine_nb0, test="Chisq")
quine_nb1 <- update(quine_nb0, . ~ . - Sex:Age:Eth:Lrn, data=quine)
dropterm(quine_nb1, test="Chisq")
quine_nb2 <- update(quine_nb1, . ~ . - Sex:Age:Eth, data=quine)
dropterm(quine_nb2, test="Chisq")
quine_nb3 <- update(quine_nb2, . ~ . - Sex:Age:Lrn, data=quine)
dropterm(quine_nb3, test="Chisq")
quine_nb4 <- update(quine_nb3, . ~ . - Age:Eth:Lrn, data=quine)
dropterm(quine_nb4, test="Chisq")
quine_nb5 <- update(quine_nb4, . ~ . - Age:Lrn, data=quine)
dropterm(quine_nb5, test="Chisq")
quine_nb <- update(quine_nb5, . ~ . - Age:Eth, data=quine)
dropterm(quine_nb, test="Chisq")

## ------------------------------------------------------------------------
summary(quine_nb)
c(quine_nb$theta, quine_nb$SE.theta)

## ------------------------------------------------------------------------
anova(quine_nb, quine_nb0, test="Chisq")

## ------------------------------------------------------------------------
quine_pois=glm(Days~Sex*(Age+Eth*Lrn),family = poisson(),data=quine)
summary(quine_pois)
pchisq(2*(logLik(quine_nb)-logLik(quine_pois)), df=1, lower.tail=F)

## ------------------------------------------------------------------------
quine_nb_step <- step(quine_nb0)
summary(quine_nb_step)

## ------------------------------------------------------------------------
anova(quine_nb_step, quine_nb)

## ------------------------------------------------------------------------
op <- par(mfrow=c(2,2))
plot(quine_nb)
par(op)

## ------------------------------------------------------------------------
set.seed(123)
x <- runif(n=300, min=10, max=40)
set.seed(123)
y <- sapply(x, function(xx) rpois(n=1, lambda=exp(.5+.05*xx)))

## ------------------------------------------------------------------------
ggp <- ggplot(data = data.frame(x=x,y=y), mapping = aes(x=x,y=y)) +
  geom_point(colour="blue", alpha=0.5)
print(ggp)

## ------------------------------------------------------------------------
fit <- glm(y ~ x, family=poisson)
summary(fit)
pchisq(fit$deviance, fit$df.residual, lower.tail = FALSE)

## ------------------------------------------------------------------------
fit.nb <- glm.nb(y ~ x)
summary(fit.nb)

