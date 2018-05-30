---
title: "Statistical Methods for Clustering"
---






# Introduction

Cluster analysis is a very popular tool for analyzing unstructured
multivariate data. It consists of various algorithms each of which seeks to
organize a given dataset into homogeneous subgroups, or "clusters". There
is no guarantee that more than one such group can be found. However, the
underlying hypothesis is that the data forms a heterogeneous set that should
separate into natural groups familiar to the domain experts.

Clustering differs from classification (see the chapter about it):

(1) first, in classification, it is known a priori how many classes or groups
are present in the data and which items are members of which class or group;
in cluster analysis, the number of classes is unknown and as well as the
membership of items into classes;

(2) second, in classification, the objective is to classify new items into
one of the given classes; clustering falls more into the framework of
exploratory data analysis, where no prior information is available regarding
the class structure of the data.

Methods for clustering items (either observations or variables) depend upon
how similar (or dissimilar) the items are to each other. Similar items are
treated as a homogeneous class or group. Much of the output of a cluster
analysis is visual, with the results displayed using scatterplots, trees,
dendrograms, silhouette plots, and other graphical devices.

Clustering algorithms are usually classified into hierarchical and non-hierarchical
(or partitioning) algorithms. Hierarchical algorithms are
also classified in agglomerative and divisive methods. The first set of
approaches aims at merging or splitting sequentially all the items.
Agglomerative methods start with each item being its own cluster; then,
clusters are successively merged, until only a single cluster remains.
Divisive clustering algorithms do the opposite: they start with all items as
members of a single cluster; then, that cluster is split into two separate
clusters, and so on until each item is its own cluster. We will focus here only on
agglomerative methods.

In this part of the course we will see:

1. **Hierarchical (Agglomerative) Clustering (HC)** algorithms;
2. **Non-Hierarchical Clustering (K-Means) (NHC)** algorithms;
3. brief outlines on **Gaussian Mixture Models (GMM)**, which can be seen as an alternative to pure clustering methods, but with a similar objective.