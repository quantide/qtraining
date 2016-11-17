## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples

## Datasets from packages
# none

## Other datasets used
# none

###############################################################
## packages needed: leaps, MASS, pls, glmnet, ddplot2 GGally ##
###############################################################

## ----a-------------------------------------------------------------------
# Generate simulate data
set.seed(10)
n <- 1000
p <- 100
X <- data.frame(matrix(runif(n*p), nrow = n, ncol = p))
# Give names to data columns
names(X) <- paste("x", 1:ncol(X), sep = "")
# The first column is really correlated with the columns from 2 to 5.
X$x1 <- X$x2 + 2*X$x3 + 3*X$x4 - 4*X$x5 + rnorm(n, sd = .000001)
# The model for dependent variable
X$y <- 4 + 0.2*X$x1 + .5*X$x2 - .9*X$x3 + X$x4 - 0.5*X$x5 + 0.2*X$x6 + rnorm(n, mean = 0, sd = 1)

dt <- X
rm(X)

## ----a2, message=FALSE---------------------------------------------------
require(ggplot2)
require(GGally)

ggpairs(data = dt, columns = c(1:10,101), mapping = aes(alpha = 0.3))

## ----a3------------------------------------------------------------------
# Collinearity test
X <- as.matrix(dt[,1:10])
require(Matrix)
rankMatrix(X)
try(solve(t(X)%*%X))


## ----b-------------------------------------------------------------------
# Splits the data into training and test data frames
sel_train <- sample(1:nrow(dt), replace = FALSE, size = n*.75)
dt_train <- dt[sel_train, ]
dt_test <- dt[setdiff(1:n, sel_train), ]

## ----c-------------------------------------------------------------------
ols_fit <- lm(y ~ ., data = dt_train)
summary(ols_fit)

## ----c2------------------------------------------------------------------
mse <- summary((predict(ols_fit, newdata = dt_test) - dt_test$y)^2)
print(mse)
ggp <- ggplot(data = data.frame(fit=predict(ols_fit, newdata = dt_test), obs=dt_test$y), mapping = aes(x = obs, y = fit)) +
  geom_point() +
  ggtitle("OLS: Observed Vs. Predicted") +
  xlab("Observed Y's") + ylab("Fitted Y's") + 
  geom_abline(slope = 1,intercept = 0, colour="red")
print(ggp)

## ----message=FALSE-------------------------------------------------------
require(MASS)

## ----g-------------------------------------------------------------------
m_init <- lm(y ~ 1, data = dt_train)
upr <- paste("x",1:100, sep="", collapse=" + ")
upr <- as.formula(paste("~",upr))
forw_fit <- stepAIC(m_init, scope = list(upper = upr, lower = ~ 1) , direction = "forward", trace = FALSE)
summary(forw_fit)

## ----g1------------------------------------------------------------------
# Plots Observed Vs. Predicted values
ggp <- ggplot(data = data.frame(fit=predict(forw_fit, newdata = dt_test), obs=dt_test$y), mapping = aes(x = obs, y = fit)) +
  geom_point() +
  ggtitle("Forward Stepwise: Observed Vs. Predicted") +
  xlab("Observed Y's") + ylab("Fitted Y's") + 
  geom_abline(slope = 1,intercept = 0, colour="red")
print(ggp)

y_pred_forw <- predict(forw_fit, newdata = dt_test)
mse <- rbind(mse, summary((y_pred_forw - dt_test$y)^2))
rownames(mse)[nrow(mse)] <- "Forward"
mse

## ----h, cache=cacheTF----------------------------------------------------
m_init <- lm(y ~ ., data = dt_train)
back_fit <- stepAIC(m_init, scope = list(upper = ~ ., lower = ~ 1) , direction = "backward", trace = FALSE)
summary(back_fit)


## ----h1------------------------------------------------------------------
# Plots Observed Vs. Predicted values
ggp <- ggplot(data = data.frame(fit=predict(back_fit, newdata = dt_test), obs=dt_test$y), mapping = aes(x = obs, y = fit)) +
  geom_point() +
  ggtitle("Backward Stepwise: Observed Vs. Predicted") +
  xlab("Observed Y's") + ylab("Fitted Y's") + 
  geom_abline(slope = 1,intercept = 0, colour="red")
print(ggp)

y_pred_back <- predict(back_fit, newdata = dt_test)
mse <- rbind(mse, summary((y_pred_back - dt_test$y)^2))
rownames(mse)[nrow(mse)] <- "Backward"
mse

## ----message=FALSE-------------------------------------------------------
require(leaps)

## ----d1, warning=FALSE---------------------------------------------------
# Performs a best-subset exhaustive (see 'method' parameter) model search
nvmax <- 20
dt_t <- dt_train
dt_train <- dt_train[, c(1:70,101)]
bs_fit <- regsubsets(x = dt_train[, 1:(ncol(dt_train)-1)], y = dt_train[, ncol(dt_train)], method = "exhaustive", nvmax = nvmax, really.big = TRUE) 
l <- summary(bs_fit)

# Plots the BIC index
ggp <- ggplot(data = data.frame(size=1:nvmax, cp=l$cp), mapping = aes(x = size, y = cp)) +
  geom_point() +
  xlab("Model size") + ylab("Mallows' Cp")
print(ggp)

## ----e1------------------------------------------------------------------
# Selects the predictors of best model
bestfeat <- l$which[which.min(l$cp), ]
# Adds the dependent variable
bestfeat <- c(bestfeat[-1], TRUE)

## ----f-------------------------------------------------------------------
m_bestsubset <- lm(y ~ ., data = dt_train[, bestfeat])
summary(m_bestsubset)

## ----f2------------------------------------------------------------------

# Plots Observed Vs. Predicted values
ggp <- ggplot(data = data.frame(fit=predict(m_bestsubset, newdata = dt_test), obs=dt_test$y), mapping = aes(x = obs, y = fit)) +
  geom_point() +
  ggtitle("Best Subset: Observed Vs. Predicted") +
  xlab("Observed Y's") + ylab("Fitted Y's") + 
  geom_abline(slope = 1,intercept = 0, colour="red")
print(ggp)

y_pred_bestsubset <- predict(m_bestsubset, dt_test[, bestfeat])
mse <- rbind(mse, summary((y_pred_bestsubset - dt_test$y)^2))
rownames(mse)[1] <- "OLS"
rownames(mse)[nrow(mse)] <- "Best subset"
mse

dt_train <- dt_t
rm(dt_t)

## ----i-------------------------------------------------------------------
1/(1 - summary(lm(x1 ~ ., data = dt_train[,1:100]))$r.squared)

## ----j-------------------------------------------------------------------
ridge_fit <- lm.ridge(y ~ ., data = dt_train, lambda = seq(0, 400, by = 0.01))
select(ridge_fit) ## Note: HKB and L-W are alternative estimators of ridge parameter
# Plot of CV Lambda values with its RSS:
ggp <- ggplot(data = as.data.frame(ridge_fit[c("lambda", "GCV")]), mapping = aes(x=lambda, y=GCV)) +
  geom_line() +
  xlab("Lambda (tuning parameter)") + ylab("Generalized Cross-Validation (GCV) values")
print(ggp)

ridge_fit <- lm.ridge(y ~ ., data = dt_train, lambda = ridge_fit$GCV[which(ridge_fit$GCV == min(ridge_fit$GCV))])

## ----k-------------------------------------------------------------------
y_pred_ridge <- as.numeric(cbind(1, as.matrix(dt_test[, 1:(ncol(dt) - 1)])) %*% coef(ridge_fit))

## ----k1------------------------------------------------------------------
# Plots Observed Vs. Predicted values
ggp <- ggplot(data = data.frame(fit=y_pred_ridge, obs=dt_test$y), mapping = aes(x = obs, y = fit)) +
  geom_point() +
  ggtitle("Ridge regression: Observed Vs. Predicted") +
  xlab("Observed Y's") + ylab("Fitted Y's") + 
  geom_abline(slope = 1,intercept = 0, colour="red")
print(ggp)

## ----l-------------------------------------------------------------------
mse <- rbind(mse, summary((y_pred_ridge - dt_test$y)^2))
rownames(mse)[nrow(mse)] <- "Ridge"
mse

## ----m-------------------------------------------------------------------
coef(ridge_fit)
coef(ols_fit)

## ----message=FALSE-------------------------------------------------------
require(pls)

## ----n-------------------------------------------------------------------
pcr_fit <- pcr(y ~ ., data = dt_train, validation = "CV")

## ----o-------------------------------------------------------------------
# Plot of CV components values with its RSS:
ggp <- ggplot(data = data.frame(comps=1:100, t(pcr_fit$validation$PRESS)), mapping = aes(x=comps, y=y)) +
  geom_line() +
  xlab("Number of components") + ylab("Generalized Cross-Validation (GCV) values")
print(ggp)

(ncomp <- which.min(pcr_fit$validation$PRESS))

## ----q-------------------------------------------------------------------
y_pred_pcr <- as.vector(predict(pcr_fit, dt_test, ncomp = ncomp))
mse <- rbind(mse, summary((y_pred_pcr - dt_test$y)^2))
rownames(mse)[nrow(mse)] <- "PCR"
mse

## ----q1------------------------------------------------------------------
# Plots Observed Vs. Predicted values
ggp <- ggplot(data = data.frame(fit=y_pred_pcr, obs=dt_test$y), mapping = aes(x = obs, y = fit)) +
  geom_point() +
  ggtitle("Ridge regression: Observed Vs. Predicted") +
  xlab("Observed Y's") + ylab("Fitted Y's") + 
  geom_abline(slope = 1,intercept = 0, colour="red")
print(ggp)

## ----r-------------------------------------------------------------------
pls_fit <- as.vector(plsr(y ~ ., data = dt_train, validation = "CV"))
# Plot of CV components values with its RSS:
ggp <- ggplot(data = data.frame(comps=1:100, t(pls_fit$validation$PRESS)), mapping = aes(x=comps, y=y)) +
  geom_line() +
  xlab("Number of components") + ylab("Generalized Cross-Validation (GCV) values")
print(ggp)

(ncomp <- which.min(pls_fit$validation$PRESS))
y_pred_pls <- predict(pls_fit, dt_test, ncomp = ncomp)
mse <- rbind(mse, summary((y_pred_pls - dt_test$y)^2))
rownames(mse)[nrow(mse)] <- "PLS"
mse

## ----message=FALSE-------------------------------------------------------
require(glmnet)

## ----s-------------------------------------------------------------------
set.seed(10)

## ----t-------------------------------------------------------------------
# Set folding parameter
foldid <- sample(rep(seq(10),length=nrow(dt_train)))
cv <- cv.glmnet(x = as.matrix(dt_train[, 1:100]), y = dt_train$y, alpha = 0.9, foldid=foldid)
plot(cv)

## ----u-------------------------------------------------------------------
glmnet_fit <- glmnet(x = as.matrix(dt_train[, 1:100]), y = dt_train$y, lambda = cv$lambda.min, alpha = 0.9)
coef(glmnet_fit)
y_pred_glmnet <- as.numeric(predict(glmnet_fit, newx = as.matrix(dt_test[, 1:100])))
mse <- rbind(mse, summary((y_pred_glmnet - dt_test$y)^2))
rownames(mse)[nrow(mse)] <- "glmnet"
mse

## ----v-------------------------------------------------------------------
glmnet_fit <- glmnet(x = as.matrix(dt_train[, 1:100]), y = dt_train$y, alpha=1) # default alpha (LASSO)
plot(glmnet_fit,xvar="lambda")

glmnet_fit <- glmnet(x = as.matrix(dt_train[, 1:100]), y = dt_train$y, alpha=0.9) # elastic-net
plot(glmnet_fit,xvar="lambda")

glmnet_fit <- glmnet(x = as.matrix(dt_train[, 1:100]), y = dt_train$y, alpha=0) # ridge
plot(glmnet_fit,xvar="lambda")

## ----w-------------------------------------------------------------------
glmnet_fit <- glmnet(x = as.matrix(dt_train[, 1:100]), y = dt_train$y, lambda = cv$lambda.1se, alpha = 0.9)
y_pred_glmnet <- as.numeric(predict(glmnet_fit, newx = as.matrix(dt_test[, 1:100])))
summary((y_pred_glmnet - dt_test$y)^2)

## ----x-------------------------------------------------------------------
cv <- cv.glmnet(x = as.matrix(dt_train[, 1:100]), y = dt_train$y, alpha = 1)
plot(cv)

## ----y-------------------------------------------------------------------
# Plots the model parameters with alpha=0 (ridge) when varying the L1 norm
glmnet_fit <- glmnet(x = as.matrix(dt_train[, 1:100]), y = dt_train$y, alpha = 0)
plot(glmnet_fit, label = TRUE)

# Compares the models with alpha=1 (LASSO) with lambda.min and lambda.1se
glmnet_fit <- glmnet(x = as.matrix(dt_train[, 1:100]), y = dt_train$y, lambda = cv$lambda.min, alpha = 1)
y_pred_glmnet <- as.numeric(predict(glmnet_fit, newx = as.matrix(dt_test[, 1:100])))
summary((y_pred_glmnet - dt_test$y)^2)

glmnet_fit <- glmnet(x = as.matrix(dt_train[, 1:100]), y = dt_train$y, lambda = cv$lambda.1se, alpha = 1)
y_pred_glmnet <- as.numeric(predict(glmnet_fit, newx = as.matrix(dt_test[, 1:100])))
summary((y_pred_glmnet - dt_test$y)^2)

## ----z-------------------------------------------------------------------
alphas <- (0:101)/101
cv_fits <- lapply(X = alphas,FUN = function(a, dt_train, foldid){
      fit <- cv.glmnet(x = as.matrix(dt_train[, 1:100]), y = dt_train$y, alpha = a, foldid = foldid)
      return(fit)
    },
    dt_train=dt_train, foldid=foldid
  )

mins <- t(sapply(X = cv_fits, FUN = function(x){return(c(lambda=x$lambda.min, cvm=min(x$cvm, na.rm = TRUE) ))}))
wm <- which.min(mins[,"cvm"])
alpha_opt <- alphas[wm]
(opt <- c(alpha=alpha_opt, mins[wm,]))

glmnet_fit <- glmnet(x = as.matrix(dt_train[, 1:100]), y = dt_train$y, lambda = opt["lambda"], alpha = opt["alpha"])
coef(glmnet_fit, label = TRUE)
y_pred_glmnet <- as.numeric(predict(glmnet_fit, newx = as.matrix(dt_test[, 1:100])))

mse <- rbind(mse, summary((y_pred_glmnet - dt_test$y)^2))
rownames(mse)[nrow(mse)] <- "best-glmnet"
mse


## ---- message=FALSE------------------------------------------------------
require(hdm)

## ------------------------------------------------------------------------
post_lasso_reg = rlasso(x = dt_train[,1:100], y = dt_train$y, post = TRUE) #now use post-lasso
summary(post_lasso_reg, all = FALSE) # or use summary(post.lasso.reg, all=FALSE)

## ------------------------------------------------------------------------
y_pred_lasso_post_lasso = c(predict(post_lasso_reg, newdata = dt_test)) #out-of-sample prediction
# Plots Observed Vs. Predicted values
ggp <- ggplot(data = data.frame(fit=y_pred_lasso_post_lasso, obs=dt_test$y), mapping = aes(x = obs, y = fit)) +
  geom_point() +
  ggtitle("Forward Stepwise: Observed Vs. Predicted") +
  xlab("Observed Y's") + ylab("Fitted Y's") + 
  geom_abline(slope = 1,intercept = 0, colour="red")
print(ggp)

## ------------------------------------------------------------------------
mse <- rbind(mse, summary((y_pred_lasso_post_lasso - dt_test$y)^2))
rownames(mse)[nrow(mse)] <- "Post-Lasso"
mse

