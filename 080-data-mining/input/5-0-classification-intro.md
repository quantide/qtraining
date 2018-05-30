---
title: "Statistical Methods for Classification"
---






# Introduction

The process of predicting qualitative responses $Y$ from a set of predictors $\underline{X}$ is known as *classification*. Predicting a
qualitative response for an observation can be referred to as
classifying that observation, since it involves assigning the
observation to a category, or class. Often the classification first 
predicts the probability of each
of the categories of a qualitative variable, as the basis for making
the classification.

Suppose we have to predict a variable that is binary, i.e. it takes either one of two
possible levels (i.e., Presence/Absence, TRUE/FALSE, ...). Usually these levels are
coded as 0 and 1. We could think to
fit a linear regression on of $X$ (the predictors) to this binary response and predict a 1 if the
predicted response is > 0.5, and a 0 otherwise. The predictions obtained
using linear regression are strictly speaking estimates of the probability
that the Y = 1, given the values of the predictors. However, if we use
linear regression, some of our estimates might be outside the $[0, 1]$
interval, making them hard to interpret as probabilities. Moreover, the
linear regression approach cannot be easily extended to accommodate
qualitative responses with more than two levels.  
In all these cases, linear regression may thus produce inappropriate results, hence 
more specific methods, truly suited for qualitative
responses, need to be considered.

In this part we will present a set of methodologies specifically developed for
classification:

1. Recalls on **Logistic Regression**
2. **Linear and Quadratic Discriminant Analyses (LDA and QDA)**
3. **K-Nearest Neighbors (KNN)**
4. **Classification Trees (CTREE)**
5. **Support Vector Machines (SVM)**
6. **Random Forests (RF)**
7. **Neural Networks (NN)**

All these techiniques fall in the class of data analysis
methodologies that in the machine learning literature are known as
supervised learning" techniques.