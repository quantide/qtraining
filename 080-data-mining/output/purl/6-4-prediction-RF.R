## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples

## Datasets from packages
require(qdata)
data(bostonhousing)

## Other datasets used
# none

###########################################################
## packages needed: randomForest, caret, ISLR (for data) ##
###########################################################

## ----05a-summary---------------------------------------------------------
summary(bostonhousing)

## ----message=FALSE-------------------------------------------------------
require(dplyr)
require(randomForest)

## ----06b-RFregr, fig.width=plot_with_legend_fig_width_short--------------
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

(rf_fit <- randomForest(medv ~ ., data = bh_train))

plot(rf_fit)

## ----05c-plots-----------------------------------------------------------
require(dplyr)
data_gr <- bh_train %>%
  mutate(set="train") %>%
  bind_rows(bh_test %>% mutate(set="test"))

data_gr$fit <- predict(rf_fit, data_gr)

require(ggplot2)
ggp <- ggplot(data = data_gr, mapping = aes(x=fit, y=medv)) +
  geom_point(aes(colour=set), alpha=0.6) +
  geom_abline(slope=1, intercept = 0) +
  geom_smooth(method = "lm", se = FALSE, aes(colour=set), alpha=0.6)
print(ggp)

## ----06c-numberofvars, fig.width=plot_with_legend_fig_width_short--------
set.seed(100)
oob_err <- double(13)
test_err <- double(13)

#mtry is no of Variables randomly chosen at each split
for(mtry in 1:13) 
{
  rf <- randomForest(medv ~ . , data = bh_train, mtry=mtry,ntree=400) 
  oob_err[mtry] <- rf$mse[400] #Error of all Trees fitted
  
  pred <- predict(rf,bh_test) #Predictions on Test Set for each Tree
  test_err[mtry] <- with(bh_test, mean( (medv - pred)^2)) #Mean Squared Test Error
}

# Test Error
test_err

# Out of Bag Error Estimation
oob_err

## ----06d-numberofvarsplot, fig.width=plot_with_legend_fig_width_short----
ds_gr <- data_frame(type=c(rep("test", length(test_err)), rep("oob", length(oob_err))), mtry = c(1:length(test_err), 1:length(oob_err)), error=c(test_err, oob_err))

ggp <- ggplot(data = ds_gr, mapping = aes(x=mtry,y=error)) +
  geom_line(aes(colour=type)) +
  geom_point(aes(colour=type)) + 
  ggtitle("OOB and Test error Vs. Number of variables in trees (mtry)")
  
print(ggp)

## ----06e-final-model, fig.width=plot_with_legend_fig_width_short---------
set.seed(100)
(rf_fit <- randomForest(medv ~ ., data = bh_train, mtry=8))
plot(rf_fit)

data_gr <- bh_train %>%
  mutate(set="train") %>%
  bind_rows(bh_test %>% mutate(set="test"))

data_gr$fit <- predict(rf_fit, data_gr)

require(ggplot2)
ggp <- ggplot(data = data_gr, mapping = aes(x=fit, y=medv)) +
  geom_point(aes(colour=set), alpha=0.6) +
  geom_abline(slope=1, intercept = 0) +
  geom_smooth(method = "lm", se = FALSE, aes(colour=set), alpha=0.6)
print(ggp)

