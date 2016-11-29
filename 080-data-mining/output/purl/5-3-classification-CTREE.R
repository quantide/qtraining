## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples

## Datasets from packages
require(qdata)
data(german)
data(Carseats, package = "ISLR")
data(kyphosis, package = "rpart")

## Other datasets used
# iris

####################################################################
## packages needed: tree, caret, rpart, ggplot2, rpart.plot, ISLR ##
####################################################################

## ----iris_1, message=FALSE-----------------------------------------------
require(pROC)
require(caret)
require(rpart)
set.seed(123456)

str(iris)
head(iris)

iris_rp <- rpart(Species ~ ., method = "class", data = iris,
								 control = rpart.control(minsplit = 4, cp = 0.000001))

## ----iris_2--------------------------------------------------------------
# Print the object
print(iris_rp)

## ----iris_3--------------------------------------------------------------
# Detailed summary
summary(iris_rp)

## ----iris_4--------------------------------------------------------------
plot(iris_rp, uniform = TRUE)
text(iris_rp)

## ----bp1-----------------------------------------------------------------
plot(iris_rp, uniform = TRUE, compress = TRUE, margin = 0.2, branch = 0.3)
text(iris_rp, use.n = TRUE, digits = 3, cex = 0.6)

## ----dg------------------------------------------------------------------
labels(iris_rp)

## ----message=FALSE-------------------------------------------------------
require(ggplot2)

## ----bq------------------------------------------------------------------
ggp <- ggplot(data = iris)
ggp <- ggp + geom_point(aes(x = Petal.Length, y = Petal.Width, colour = Species))
ggp <- ggp + geom_vline(xintercept = 2.45, linetype = 2)
ggp <- ggp + geom_segment(x = 2.45, y = 1.75, xend = max(iris$Petal.Length)*2,yend = 1.75, linetype = 2)
ggp <- ggp + geom_segment(x = 4.95, y = min(iris$Petal.Width)*-2, xend = 4.95,yend = 1.75, linetype = 2)
ggp <- ggp + geom_segment(x = 2.45, y = 1.65, xend = 4.95, yend = 1.65, linetype = 2)
ggp <- ggp + geom_segment(x = 4.95, y = 1.55, xend = max(iris$Petal.Length)*2,yend = 1.55, lty = 2)
ggp <- ggp + ggtitle("Partitions with respect to Petal.Length and Petal.Width" )
ggp

## ----br------------------------------------------------------------------
printcp(iris_rp)

## ----bs------------------------------------------------------------------
ggp <- ggplot(data = data.frame(iris_rp$cptable, Tree.number = 1:nrow(iris_rp$cptable)), mapping = aes(x = Tree.number, y = rel.error))
ggp <- ggp + geom_line()
ggp <- ggp + geom_point()
ggp

## ----bt------------------------------------------------------------------
plotcp(iris_rp)

## ----bu, eval=FALSE------------------------------------------------------
## plot(iris_rp, uniform = TRUE)
## text(iris_rp)
## iris_rp1 <- snip.rpart(iris_rp)
## plot(iris_rp1)
## text(iris_rp1)

## ----bv, eval=TRUE-------------------------------------------------------
plotcp(iris_rp)
with(iris_rp, {
	lines(cptable[, 2] + 1, cptable[ , 3], type = "b", col = "red")
	legend("topright", c("Resub. Error", "CV Error", "min(CV Error) + 1se"),
				 lty = c(1, 1, 2), col = c("red", "black", "black"), bty = "n")
})

## ----bw------------------------------------------------------------------
iris.pruned <- prune(iris_rp, cp=0.01)
plot(iris.pruned, compress = TRUE, margin = 0.2, branch = 0.3)
text(iris.pruned, use.n = TRUE, digits = 3, cex = 0.8)

## ----bx------------------------------------------------------------------
ggp <- ggplot(data = iris)
ggp <- ggp + geom_point(aes(x = Petal.Length, y = Petal.Width, colour = Species))
ggp <- ggp + geom_vline(xintercept = 2.45, linetype = 2)
ggp <- ggp + geom_segment(x = 2.45, y = 1.75, xend = max(iris$Petal.Length)*2,yend = 1.75, linetype = 2)
ggp <- ggp + ggtitle("Partitions with respect to Petal.Length and Petal.Width for the pruned tree")
ggp

## ----by------------------------------------------------------------------
iris_pred <- predict(iris.pruned, type = "class")

## ----bz------------------------------------------------------------------
table(iris_pred, iris$Species)

## ----iris_confusionmatrix------------------------------------------------
confusionMatrix(data = iris_pred, reference = iris$Species)


## ----ch------------------------------------------------------------------
table(german$Class)

## ----ci------------------------------------------------------------------
set.seed(20)
sel <- sample(1:1000, size = 600, replace = FALSE)
train <- german[sel, ]
test <- german[setdiff(1:1000, sel), ]
table(train$Class)
table(test$Class)

## ----cj_1----------------------------------------------------------------
set.seed(20)
modelg0 <- rpart(Class ~ ., data = train, cp = 0)
plotcp(modelg0)

## ----cj_2, fig.width=8, fig.height=8-------------------------------------
plot(modelg0)
text(modelg0)

## ----gc_ROC1-------------------------------------------------------------
probs <- predict(modelg0, newdata = test, type = "prob")[,1] 
roc(response = (test$Class=="Bad"), predictor = probs, auc = TRUE, ci = TRUE,
	plot = TRUE, main = "ROC curve on German Credit", legacy.axes = TRUE)

## ----gc_test1------------------------------------------------------------
train$pred <- predict(modelg0, newdata = train, type = "class") 
table(train$pred, train$Class)
confusionMatrix(data = train$pred, reference = train$Class, positive = "Bad")

## ----gc_test2------------------------------------------------------------
test$pred <- predict(modelg0, newdata = test, type = "class") 
table(test$pred, test$Class)
confusionMatrix(data = test$pred, reference = test$Class, positive = "Bad")

## ----ck------------------------------------------------------------------
modelg0 <- prune(modelg0, cp = 0.031)
plot(modelg0)
text(modelg0)

## ----cl------------------------------------------------------------------
test$pred <- predict(modelg0, newdata = test, type = "class") 
table(test$pred, test$Class)
confusionMatrix(data = test$pred, reference = test$Class, positive = "Bad")

## ----cm_1----------------------------------------------------------------
# Reset previous predictions
train$pred <- NULL
train$pred <- NULL
# Set Loss matrix
(lmat <- matrix(c(0, 1, 5, 0), byrow = TRUE, nrow = 2))
# Grows the tree
modelg1 <- rpart(Class ~ ., parms = list(loss = lmat), data = train, cp = 0)
# CP table
printcp(modelg1)
plotcp(modelg1)

## ----cm_2, fig.width=8, fig.height=8-------------------------------------
# Tree
plot(modelg1, uniform = FALSE, compress = TRUE, margin = 0.1, branch = 0.1)
text(modelg1, use.n = TRUE, digits = 3, cex = 0.6)

## ----message=FALSE, fig.width=10, fig.height=10--------------------------
require(rpart.plot) # provides alternative ways to plot the tree
rpart.plot(modelg1)
print(modelg1)

## ----co------------------------------------------------------------------
test$pred <- predict(modelg1, newdata = test, type = "class") 
table(test$pred, test$Class)
confusionMatrix(data = test$pred, reference = test$Class, positive = "Bad")


