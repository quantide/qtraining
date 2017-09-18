## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples

## Datasets from packages
require(qdata)
data(titanic)

## Other datasets used
# none

###########################################################
## packages needed: nnet                                 ##
###########################################################

## ----06a-summary,split=TRUE----------------------------------------------
head(titanic)
summary(titanic)

## ----06b-libraries-------------------------------------------------------
require(nnet)

## ------------------------------------------------------------------------
(tb1 <- table(titanic$Status,titanic$Class))
round(prop.table(tb1,margin=2)*100,2)
(tb2 <- table(titanic$Status,titanic$Gender))
round(prop.table(tb2,margin=2)*100,2)
(tb3 <- table(titanic$Status,titanic$Class,titanic$Gender))
round(prop.table(tb3,margin=c(2,3))*100,2)

## ----06c-descrgraphs, fig.width=plot_with_legend_fig_width_short, fig.cap="Box-plot of Age within levels of Status"----
require(ggplot2)
ggp <- ggplot(data=titanic, mapping = aes(y=Age, x=Status)) +
  geom_boxplot() +
  ggtitle("Boxplot of Age Vs. Status")
print(ggp)

## ----06d-model-----------------------------------------------------------
set.seed(100)
nn0 <- nnet(Status ~ Class+Gender+Age,data=titanic,size=3)

## ----06d-confusionmatrix-------------------------------------------------
titanic$pred <- as.vector(predict(nn0, type="raw"))

titanic$pred_class <- factor(ifelse(titanic$pred < 0.5, "Died", "Survived"))

require(caret)

confusionMatrix(titanic$pred_class, reference = titanic$Status)


## ----06e-prediction------------------------------------------------------
require(dplyr)

ds_pred <- titanic %>%
  group_by(Class, Gender) %>%
  summarise(Age = mean(Age, na.rm=TRUE))

ds_pred$prob <- predict(nn0, newdata = ds_pred, type="raw")

ds_pred

