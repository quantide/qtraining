## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples

## Datasets from packages
data(Default, Smarket, package = "ISLR")

## Other datasets used
# none

###############################################################
## packages needed: MASS, caret, pROC, GGally, ggplot2, ISLR ##
###############################################################

## ----02h-loadcc----------------------------------------------------------
summary(Default)

## ----first_logit---------------------------------------------------------
res_logit <- glm(default ~ student + balance, data = Default,
				 family = binomial(link = logit))
summary(res_logit)

## ----pred_logit----------------------------------------------------------
post_logit <- predict(res_logit, type = "response")
head(post_logit)

## ----prob_def------------------------------------------------------------
default_logit <- ifelse(post_logit>0.5, "Pred: Yes", "Pred: No")

## ----logit_check---------------------------------------------------------
table(default_logit, Default$default)

## ----message=FALSE-------------------------------------------------------
require(MASS)

## ----02h-ldacc-----------------------------------------------------------
res <- lda(default ~ student + balance, data = Default)
res

## ----02h-predictcc-------------------------------------------------------
default_hat <- predict(res)$class

## ----02h-confusioncc-----------------------------------------------------
table(default_hat, Default$default)

## ----message=FALSE-------------------------------------------------------
require(caret)

## ----02h-confusioncaretcc------------------------------------------------
confusionMatrix(data = default_hat, reference = Default$default,
				positive = "Yes")

## ----02h-predictchgthreshcr----------------------------------------------
post <- predict(res)$posterior
threshold <- 0.2
default_hat_20 <- as.factor(ifelse(post[, 2] > threshold, 1, 0))
levels(default_hat_20) <- c("No", "Yes")
prop.table(table(default_hat_20, Default$default), margin = 2)
confusionMatrix(data = default_hat_20, reference = Default$default,
				positive = "Yes")

## ----message=FALSE-------------------------------------------------------
require(pROC)

## ----02h-roccc-----------------------------------------------------------
roc(response = Default$default, predictor = post[, 2], auc = TRUE, ci = TRUE,
	plot = TRUE, main = "ROC curve")

## ----02h-roclegacycc-----------------------------------------------------
roc(response = Default$default, predictor = post[, 2], auc = TRUE, ci = TRUE,
	plot = TRUE, main = "ROC curve", legacy.axes = TRUE)

## ----02h-roccomparecc----------------------------------------------------
res_new <- lda(default ~ ., data = Default)
res_new
post_new <- predict(res_new)$posterior
# plot the ROC fot original model
roc(response = Default$default, predictor = post[, 2], auc = TRUE, ci = TRUE,
	plot = TRUE, col = "magenta", main = "ROC comparison")
# add the ROC fot new model
roc(response = Default$default, predictor = post_new[, 2], auc = TRUE,
	ci = TRUE, plot = TRUE, col = "cyan", add = TRUE)
legend(x = "bottomright", legend = c("w/o income", "w income"),
	   col = c("magenta", "cyan"), lty = rep(1, 2), lwd = rep(2, 2))

## ----02h-roclogitcc------------------------------------------------------
roc(response = Default$default, predictor = post[, 2], auc = TRUE, ci = TRUE,
	plot = TRUE, col = "magenta", main = "ROC comparison")
roc(response = Default$default, predictor = post_logit, auc = TRUE,
	ci = TRUE, plot = TRUE, col = "cyan", add = TRUE)
legend(x = "bottomright", legend = c("LDA", "logit"),
	   col = c("magenta", "cyan"), lty = rep(1, 2), lwd = rep(2, 2))

## ----02h-qdacc-----------------------------------------------------------
res_qda <- qda(default ~ student + balance, data = Default)
post_qda <- predict(res_qda)$posterior
threshold <- 0.2
default.qda <- as.factor(ifelse(post_qda[, 2] > threshold, 1, 0))
levels(default.qda) <- c("No", "Yes")
prop.table(table(default.qda, Default$default), margin = 2)
confusionMatrix(data = default.qda, reference = Default$default,
				positive = "Yes")
roc(response = Default$default, predictor = post[, 2], auc = TRUE, ci = TRUE,
	plot = TRUE, col = "magenta", main = "ROC comparison")
roc(response = Default$default, predictor = post_qda[, 2], auc = TRUE,
	ci = TRUE, plot = TRUE, col = "cyan", add = TRUE)
legend(x = "bottomright", legend = c("LDA", "QDA"),
	   col = c("magenta", "cyan"), lty = rep(1, 2), lwd = rep(2, 2))

## ----message=FALSE-------------------------------------------------------
require(GGally)

## ----02h-loadsm, message=FALSE-------------------------------------------
summary(Smarket)
ggpairs(Smarket)

## ----02h-lineplotsm------------------------------------------------------
ggp <- ggplot(Smarket, aes(x = 1:length(Volume), y = Volume)) + geom_line() +
	xlab("Day")
plot(ggp)

## ----02h-glmsm-----------------------------------------------------------
glm_fit <- glm(Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume,
               data = Smarket, family = binomial(link = logit))
summary(glm_fit)
glm_probs <- predict(glm_fit, type = "response")
glm_pred <- rep("Down", nrow(Smarket))
glm_pred[glm_probs > .5] <- "Up"
confusionMatrix(data = glm_pred, reference = Smarket$Direction,
				positive = "Up")

## ----02h-glm2sm----------------------------------------------------------
train <- (Smarket$Year < 2005)
Smarket_2005 <- Smarket[!train, ]
glm_fit <- glm(Direction ~Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume,
			   data = Smarket, family = binomial(link = logit), subset = train)
glm_probs <- predict(glm_fit, Smarket_2005, type = "response")
glm_pred <- rep("Down", nrow(Smarket_2005))
glm_pred[glm_probs > .5] <- "Up"
confusionMatrix(data = glm_pred, reference = Smarket_2005$Direction,
				positive = "Up")

## ----02h-glm3sm----------------------------------------------------------
glm_fit <- glm(Direction ~ Lag1 + Lag2, data = Smarket,
			   family = binomial(link = logit), subset = train)
glm_probs <- predict(glm_fit, Smarket_2005, type = "response")
glm_pred <- rep("Down", nrow(Smarket_2005))
glm_pred[glm_probs > .5] <- "Up"
confusionMatrix(data = glm_pred, reference = Smarket_2005$Direction,
				positive = "Up")

## ----02h-ldasm-----------------------------------------------------------
lda_fit <- lda(Direction ~ Lag1 + Lag2, data = Smarket, subset = train)
lda_probs <- predict(lda_fit, Smarket_2005)$posterior[, 2]
lda_class <- predict(lda_fit, Smarket_2005)$class
confusionMatrix(data = lda_class, reference = Smarket_2005$Direction,
				positive = "Up")

## ----02h-qdasm-----------------------------------------------------------
qda_fit <- qda(Direction ~ Lag1 + Lag2, data = Smarket, subset = train)
qda_probs <- predict(qda_fit, Smarket_2005)$posterior[, 2]
qda_class <- predict(qda_fit, Smarket_2005)$class
confusionMatrix(data = qda_class, reference = Smarket_2005$Direction,
				positive = "Up")

## ----02h-rocqdasm--------------------------------------------------------
roc(response = Smarket_2005$Direction, predictor = glm_probs, auc = TRUE, ci = TRUE, plot = TRUE, col = "magenta", main = "ROC comparison",
	legacy.axes = TRUE)
roc(response = Smarket_2005$Direction, predictor = lda_probs, auc = TRUE,
	ci = TRUE, plot = TRUE, col = "cyan", add = TRUE, legacy.axes = TRUE)
roc(response = Smarket_2005$Direction, predictor = qda_probs, auc = TRUE,
	ci = TRUE, plot = TRUE, col = "darkgray", add = TRUE, legacy.axes = TRUE)
legend(x = "bottomright", legend = c("Logistic regression", "LDA", "QDA"),
	   col = c("magenta", "cyan", "darkgray"), lty = rep(1, 3),
	   lwd = rep(2, 3))

## ----message=FALSE-------------------------------------------------------
require(ggplot2)

## ----02h-thplot1, echo=FALSE, message=FALSE, fig.width=plot_with_legend_fig_width_short----
set.seed(seed = 12345)
mu1 <- c(1.3,3)
mu2 <- c(2,1.2)
Sigma <- matrix(data = c(.5,.35,.35,.9),nrow = 2)
data <- mvrnorm(n = 50,mu = mu1,Sigma = Sigma)
data <- rbind(data,mvrnorm(n = 50,mu = mu2,Sigma = Sigma))
data <- data.frame(data,group=factor(rep(c(1,2),each=50)))
names(data)[1:2] <- c("x1","x2")
mds <- aggregate(x = data[,1:2], by = list(group=data$group),FUN = mean)
ggp <- ggplot(data = mds,mapping = aes(x = x1,y=x2,colour=group))
ggp <- ggp + geom_point(shape=13,size=10)
m <- (mds[2,3]-mds[1,3])/((mds[2,2]-mds[1,2]))
q <- mds[1,3]-m*mds[1,2]
df1 <- data.frame(m=m,q=q)
ggp <- ggp + geom_abline(data=df1, mapping = aes(intercept=q,slope=m))
ggp <- ggp + geom_point(data = data,mapping = aes(x=x1,y=x2,colour=group))
#ggp <- ggp + geom_line(mapping = aes(group=""),colour="black")
print(ggp)

## ----02h-plotzetas,echo=FALSE, fig.width=plot_with_legend_fig_width_short----
lds <- lda(group~x1+x2,data=data)
a <- lds$scaling
data$z <- as.vector(as.matrix(data[,1:2]) %*% a)
ggp <- ggplot(data, aes(x=z, fill=group)) 
ggp <- ggp + geom_density(alpha=0.3)
ggp <- ggp + ggtitle("z scores from sample data (vertical line: threshold between groups)")
ggp <- ggp + geom_vline(xintercept=mean(data$z),linetype="dashed")
ggp <- ggp + geom_vline(xintercept=mean(data$z[1:50]),col="red")
ggp <- ggp + geom_vline(xintercept=mean(data$z[51:100]),col="blue")
ggp <- ggp + geom_rug(aes(col=group))
print(ggp)

