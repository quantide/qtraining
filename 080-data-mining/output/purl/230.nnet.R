###########################################
rm (list = ls())

setwd("~/Dropbox/quantide/int/corsi/20130620.optima.R/instructor/data")

library(nnet)
load("titanic.Rda")
str(titanic)

idx = 1:nrow(titanic)
trainIdx = sample(idx, 1500) 
predictIdx = idx[!is.element(idx, trainIdx)]

titanicTrain  = titanic[trainIdx,]
titanicPredict  = titanic[predictIdx,]

fm = nnet(Status~., data = titanicTrain, size = 2)

titanicPredict$nnetpredict = predict (fm , titanicPredict, type = "class")

classification.nnet = table(observed = titanicPredict$Status, predict = titanicPredict$nnetpredict)

# different glm approach
fm2 = glm(Status~(Class+Gender+Age)^2, data = titanicTrain, family = "binomial")
summary(fm2)

fm2 = glm(Status~Class+Gender+Age+Class:Gender, data = titanicTrain, family = "binomial")
summary(fm2)

titanicTrain$fit  = predict.glm(fm2, titanicTrain, type = "response")
titanicTrain = titanicTrain[order(titanicTrain$fit),]
head(titanicTrain)


x = 1:nrow(titanicTrain)
one = rep(1, nrow(titanicTrain))
zero = rep(0, nrow(titanicTrain))

plot(x , titanicTrain$fit, type = "n", ylim = c(-0.1, 1.1))

points(x[titanicTrain$Status == "Survived"], one[titanicTrain$Status == "Survived"], col = "darkgreen", pch = 1, cex = .5)
points(x[titanicTrain$Status == "Died"], zero[titanicTrain$Status == "Died"], col = "darkred", pch = 1, cex = .5)

lines(x, titanicTrain$fit, col = "darkgray", lwd = 3)
abline(h = 0.5, lty = 2)

head(titanicPredict)
titanicPredict$glmfit = predict (fm2 , titanicPredict, type= "response")
titanicPredict$glmpredict = ifelse(titanicPredict$glmfit > 0.5 , "Survived", "Died")

classification.glm = table(observed = titanicPredict$Status, predict = titanicPredict$glmpredict)


### Results
round(prop.table(classification.nnet, margin = 1), 2)
round(prop.table(classification.glm, margin = 1), 2)




