---
title: "Statistical Methods for Prediction"
---






# Introduction

In this part we consider some approaches for extending the linear model
framework for *predicting* quantitative (i.e., numerical) outcome variables.

In particular we will discuss ways to improve the linear model, by replacing plain
least squares fitting with some alternative fitting procedures. The
main motivation for considering other fitting procedures is that these
can yield better prediction accuracy and model interpretability. As a
matter of fact, it is often the case that some or many of the variables
included in a multiple regression model are in fact not associated with
the response. Including such irrelevant variables leads to unnecessary
complexity in the resulting model. By removing these variables (that
is, by setting the corresponding coefficient estimates to zero) we can
obtain a model that is more easily interpreted. Least squares is
extremely unlikely to yield any coefficient estimates that are exactly
zero.

In what follows, we'll see some approaches for automatically
performing feature selection or variable selection, that is, for
excluding irrelevant variables from a multiple regression model:

1. **Linear Model Variations (LM)** (different alternative fitting techniques for a linear model);
2. **Regression Trees (RTREE)**;
3. Outlines on **Bootstrap Techniques**.
4. Introduction to **Random Forests**
