## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples

## Datasets from packages
require(qdata)
data(bostonhousing)

## Other datasets used
# none

###########################################################
## packages needed: nnet                                 ##
###########################################################

## ----06a-summary,split=TRUE----------------------------------------------
summary(bostonhousing)

## ----06b-libraries-------------------------------------------------------
require(nnet)
require(dplyr)

## ----06c-descrgraphs, fig.width=plot_with_legend_fig_width_short, fig.cap="Relationship between variables"----
require(ggplot2)
require(GGally)
ggpairs(bostonhousing)

## ----06d-model-----------------------------------------------------------
set.seed(100)

bostonhousing$lstat <- log(bostonhousing$lstat)
bostonhousing$rm <- bostonhousing$rm^2
bostonhousing$chas <- factor(bostonhousing$chas, levels = 0:1, labels = c("no", "yes"))
bostonhousing$rad <- factor(bostonhousing$rad, ordered = TRUE)

bostonhousing <- bostonhousing %>%
  select(medv, age, lstat, rm, zn, indus, chas, nox, age, dis, rad, tax, crim, b, ptratio)

train <- sample(nrow(bostonhousing), 400)
bh_train <- bostonhousing[train,]
bh_test <-  bostonhousing[-train,]

set.seed(100)

nn0 <- nnet(medv ~ ., data = bh_train, size = 14)

## ----06e-plots-----------------------------------------------------------
require(dplyr)
data_gr <- bh_train %>%
  mutate(set="train") %>%
  bind_rows(bh_test %>% mutate(set="test"))

data_gr$fit <- predict(nn0, data_gr)

require(ggplot2)
ggp <- ggplot(data = data_gr, mapping = aes(x=fit, y=medv)) +
  geom_point(aes(colour=set), alpha=0.6) +
  geom_abline(slope=1, intercept = 0) +
  geom_smooth(method = "lm", se = FALSE, aes(colour=set), alpha=0.6)
print(ggp)

