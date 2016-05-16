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

