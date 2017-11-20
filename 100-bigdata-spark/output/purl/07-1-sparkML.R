## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(eval = FALSE)

## ----packages, results="hide"--------------------------------------------
library(tidyverse)
library(sparklyr)

## ---- eval = FALSE-------------------------------------------------------
## sc <- spark_connect("yarn", version = "2.0.0")
## spark_disconnect(sc)
## sc <- spark_connect("local", version = "1.6.2")
## csv_file <- '~/data/*.csv'
## ontime_tbl <- spark_read_csv(sc = sc,
##                              'ontime_tbl' ,
##                              path = csv_file,
##                              header = TRUE, delimiter = ',')
## 

## ------------------------------------------------------------------------
model <- lm(Petal.Length ~ Petal.Width, data = iris)

iris %>%
	select(Petal.Width, Petal.Length) %>%
	ggplot(aes(Petal.Length, Petal.Width)) +
	geom_point(data = iris, aes(Petal.Width, Petal.Length), size = 2, alpha = 0.5) +
	geom_abline(aes(slope = coef(model)[["Petal.Width"]],
									intercept = coef(model)[["(Intercept)"]],
									color = "red"))

## ------------------------------------------------------------------------
model <- iris_tbl %>%
	select(Petal_Width, Petal_Length) %>%
	ml_linear_regression(response = "Petal_Length", features = c("Petal_Width"))

iris_tbl %>%
	select(Petal_Width, Petal_Length) %>%
	collect %>%
	ggplot(aes(Petal_Length, Petal_Width)) +
	geom_point(aes(Petal_Width, Petal_Length), size = 2, alpha = 0.5) +
	geom_abline(aes(slope = coef(model)[["Petal_Width"]],
									intercept = coef(model)[["(Intercept)"]],
									color = "red"))

## ------------------------------------------------------------------------
# Prepare beaver dataset
beaver <- beaver2
beaver$activ <- factor(beaver$activ, labels = c("Non-Active", "Active"))

# Fit model
model <- glm(activ ~ temp, data = beaver, family = binomial(link = "logit"))
print(model)

# Plot prediction curve
newdata <- data.frame(
	temp = seq(min(beaver$temp), max(beaver$temp), length.out = 128)
)

df <- data.frame(
	x = newdata$temp,
	y = predict(model, newdata = newdata, type = "response") + 1
)

ggplot(beaver, aes(x = temp, y = activ)) +
	geom_point() +
	geom_line(data = df, aes(x, y), col = "red") +
	labs(
		x = "Body Temperature (ºC)",
		y = "Activity",
		title = "Beaver Activity vs. Body Temperature",
		subtitle = "From R's built-in 'beaver2' dataset"
	)


## ------------------------------------------------------------------------
beaver_tbl <- copy_to(sc, beaver, "beaver", overwrite = TRUE)

model <- beaver_tbl %>%
	mutate(response = as.numeric(activ == "Active")) %>%
	ml_logistic_regression(response = "response", features = "temp")

print(model)

## ------------------------------------------------------------------------
mForest <- iris_tbl %>%
	ml_random_forest(
		response = "Species",
		features = c("Petal_Length", "Petal_Width"),
		max.bins = 32L,
		max.depth = 5L,
		num.trees = 20L
	)
mPredict <- predict(mForest, iris_tbl)
head(mPredict)

## ------------------------------------------------------------------------
mDecisionTree <- iris_tbl %>%
	ml_decision_tree(
		response = "Species",
		features = c("Petal_Length", "Petal_Width"),
		max.bins = 32L,
		max.depth = 5L
	)
mPredict <- predict(mDecisionTree, iris_tbl)
head(mPredict)

## ------------------------------------------------------------------------
spark_disconnect(sc)

