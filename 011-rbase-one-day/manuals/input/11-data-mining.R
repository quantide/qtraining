## ----require_nnet, message=FALSE-----------------------------------------
require(nnet)

## ----load_data, message=FALSE--------------------------------------------
require(qdata)
data(titanic)
head(titanic)

## ----table_status, message=FALSE-----------------------------------------
require(dplyr)
# frequency table of the counts and percentage of Died and Survived people 
titanic %>% 
  group_by(Status) %>%
  summarise(n = n()) %>%
  mutate(freq = paste(round(n/sum(n)* 100, 2), "%")) 

## ----table_status_class--------------------------------------------------
# frequency table of the counts and percentage of Died and Survived people by Class
titanic %>% 
  group_by(Status, Class) %>%
  summarise(n = n()) %>%
  mutate(freq = paste(round(n/sum(n)* 100, 2), "%"))

## ----table_status_gender-------------------------------------------------
# frequency table of the counts and percentage of Died and Survived people by Gender
titanic %>% 
  group_by(Status, Gender) %>%
  summarise(n= n()) %>%
  mutate(freq = paste(round(n/sum(n)* 100, 2), "%"))

## ----plot_status_age, message=FALSE--------------------------------------
require(ggplot2)
ggplot(data=titanic, mapping=aes(x=Status, y=Age)) +
  geom_boxplot(fill="#74a9cf", colour="#034e7b")+ 
  ggtitle("Box-plot of Age within levels of Status")

## ----train_test_samples--------------------------------------------------
# generate train and test sample 
train <- titanic %>% sample_frac(0.7)
test <- titanic %>% slice(-as.numeric(rownames(train)))

## ----nn_mod_estimate-----------------------------------------------------
nn_mod <- nnet(Status ~ Class + Gender + Age, data = train, size = 3)

## ----nn_mod_predictions--------------------------------------------------
pr <- predict(object = nn_mod, newdata = test)
head(pr)

## ----nn_mod_predictions_class--------------------------------------------
test <- test %>% mutate(pr_mod = pr < .5)

## ----performance_table---------------------------------------------------
test %>% 
  group_by(Status, pr_mod) %>%
  summarise(n = n()) %>%
  mutate(freq = paste(round(n/sum(n)* 100, 2), "%"))

