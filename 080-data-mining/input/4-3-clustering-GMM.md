---
title: "Outlines on Gaussian Mixture Models (MM)"
---






# Introduction

The clustering methods described so far are not based on formal models for
cluster structure in the data, making problems such as deciding between
methods, estimating the number of clusters, etc., particularly difficult.
Again, if one needs to use the clustering solution for predictive purposes,
without a model, formal inference is precluded.

One approach to clustering that postulates a formal statistical model for
the population from which the data are sampled, is known as a finite mixture
density model. This model postulates that the population consists of a number of
subpopulations (the "clusters"), each having variables with a different
multivariate probability density function. By adopting this approach, the
clustering problem becomes that of estimating the parameters of the assumed
mixture and then using the estimated parameters to calculate the (posterior)
probabilities of cluster membership. Moreover, determining the number of
clusters reduces to a model selection problem for which objective procedures
exist. Cluster analyses based on finite mixture models are also known as
model-based clustering methods.

Usually parameters of the subpopulation densities are estimated with maximum
likelihood using the expectation-maximization (EM) algorithm.

Fraley and Raftery (Model-based clustering, discriminant analysis, and
density estimation, Journal of the American Statistical Association, 97,
611-631) developed a series of finite mixture density models with
multivariate normal component densities in which they allow some of the
features of the covariance matrix to vary between clusters while constraining
others to be the same. This approach is implemented for example in the mclust
package, but many other packages have been developed in this field (see the
CRAN task view at [http://cran.r-project.org/web/views/Cluster.html](http://cran.r-project.org/web/views/Cluster.html) on cluster
analysis).


```r
require(mclust)
require(ggplot2)
```

The function for performing a cluster analysis is `Mclust()`. As an illustration, consider the bivariate `faithful` dataset included in the base `R`
distribution (see the section *Introduction and datasets used* for further information):


```r
ggp <- ggplot(data=faithful, mapping = aes(x=eruptions, y= waiting)) +
  geom_point()
print(ggp)
```

![plot of chunk 02g-plotanalysisff](figure/02g-plotanalysisff-1.png)

```r
faithfulMclust <- Mclust(faithful)
summary(faithfulMclust)
```

```
## ----------------------------------------------------
## Gaussian finite mixture model fitted by EM algorithm 
## ----------------------------------------------------
## 
## Mclust EEE (ellipsoidal, equal volume, shape and orientation) model with 3 components:
## 
##  log.likelihood   n df       BIC       ICL
##       -1126.361 272 11 -2314.386 -2360.865
## 
## Clustering table:
##   1   2   3 
## 130  97  45
```

In this case, the best model according to the BIC criterion is an equal-
covariance model with 3 components (i.e., clusters). A more detailed summary
including the estimated parameters can be obtained with the following code


```r
summary(faithfulMclust, parameters = TRUE)
```

```
## ----------------------------------------------------
## Gaussian finite mixture model fitted by EM algorithm 
## ----------------------------------------------------
## 
## Mclust EEE (ellipsoidal, equal volume, shape and orientation) model with 3 components:
## 
##  log.likelihood   n df       BIC       ICL
##       -1126.361 272 11 -2314.386 -2360.865
## 
## Clustering table:
##   1   2   3 
## 130  97  45 
## 
## Mixing probabilities:
##         1         2         3 
## 0.4632682 0.3564512 0.1802806 
## 
## Means:
##                [,1]      [,2]      [,3]
## eruptions  4.475059  2.037798  3.817687
## waiting   80.890383 54.493272 77.650757
## 
## Variances:
## [,,1]
##            eruptions    waiting
## eruptions 0.07734049  0.4757779
## waiting   0.47577787 33.7403885
## [,,2]
##            eruptions    waiting
## eruptions 0.07734049  0.4757779
## waiting   0.47577787 33.7403885
## [,,3]
##            eruptions    waiting
## eruptions 0.07734049  0.4757779
## waiting   0.47577787 33.7403885
```

The clustering results can be displayed as follows


```r
op <- par(mfrow = c(2, 2))
plot(faithfulMclust, what = "BIC")
plot(faithfulMclust, what = "classification")
plot(faithfulMclust, what = "uncertainty")
plot(faithfulMclust, what = "density")
```

![plot of chunk 02g-plotsff](figure/02g-plotsff-1.png)

```r
par(op)
```

The list with description of the available models in the `mclust` package is easily obtained as


```r
?mclustModelNames
```
And the models currently available are:

__Univariate mixture__  
"E"	 =	 equal variance (one-dimensional)  
"V"	 =	 variable variance (one-dimensional)  
__Multivariate mixture__  
"EII"	 =	 spherical, equal volume  
"VII"	 =	 spherical, unequal volume  
"EEI"	 =	 diagonal, equal volume and shape  
"VEI"	 =	 diagonal, varying volume, equal shape  
"EVI"	 =	 diagonal, equal volume, varying shape  
"VVI"	 =	 diagonal, varying volume and shape  
"EEE"	 =	 ellipsoidal, equal volume, shape, and orientation  
"EVE"	 =	 ellipsoidal, equal volume and orientation  
"VEE"	 =	 ellipsoidal, equal shape and orientation  
"VVE"	 =	 ellipsoidal, equal orientation  
"EEV"	 =	 ellipsoidal, equal volume and equal shape  
"VEV"	 =	 ellipsoidal, equal shape  
"EVV"	 =	 ellipsoidal, equal volume  
"VVV"	 =	 ellipsoidal, varying volume, shape, and orientation  
__Single component__  
"X"	 =	 univariate normal  
"XII"	 =	 spherical multivariate normal  
"XXI"	 =	 diagonal multivariate normal  
"XXX"	 =	 ellipsoidal multivariate normal  

By default, the `Mclust()` function compares BIC values for parameters
optimized for up to nine components (clusters) and all covariance structures
currently available in the software. The output includes the parameters of
the maximum-BIC model (where the maximum is taken over all of the models and
numbers of components considered), and the corresponding classification and
uncertainty. Any missing value (i.e., NA) returned in the output corresponds
to models and numbers of clusters for which parameter values could not be
fit.

For more details about the many functionalities of the mclust package, see
the package help pages:


```r
help(package = "mclust")
```


# Some Theoretical Backgrounds

The _Normal Mixture Model_ assumes that data actually arises from a finite mixture of $G$ $p$-multivariate normal distributions, i.e., the population density may be expressed as:
$$
f(\underline{y};\underline\theta,\underline\tau)=\sum_{k=1}^G {\tau_k f_k(\underline{y};\theta_k)}
$$
where $f_k$ and $\theta_k$ are the density and the parameters of $k$-th component of mixture, and $\tau_k$ if the probability that the observation $\underline{y}$ belongs to the $k$-th component ($\tau_k \ge 0; \sum_{k=1}^G {\tau_k}=1$), and $f_k$ is a multivariate Normal density function, with $\theta_k$ parameter given by $\underline\mu_k, \Sigma_k$:
$$
 f_k(\underline{y}| \underline\mu_k, \Sigma_k)=\dfrac{\exp\left \{ -\frac{1}{2}(\underline{y}-\underline{\mu_k})^T \Sigma_k^{-1} (\underline{y}-\underline{\mu_k}) \right \}}{(2 \pi)^{\frac{p}{2}} \sqrt{ |\Sigma_k|}}
$$

$\tau_k$ and $\theta_k$ (actually, $\underline{\mu}_k$ and $\Sigma_k$) are unknown parameters. 

The estimation process assumes that the complete data is, actually, given by two sets of observations for each data point ($i=1, \cdots,n$): $\underline{x_i}=(\underline{y}_i^T,\underline{z}_i^T)^T$.  
Here, $\underline{y}_i$ is the observed data for the $i$-th sample unit, and $\underline{z}_i$ is an unobserved $G$-vector of $0/1$ values that equal to 1 only when the obervation belongs to $k$-th component.  
Given the above definitions, one may write the log-likelihood of data as:
$$
\ell(\underline{\theta},\underline{\tau},\underline{z}_i|\underline{x})=\sum_{i=1}^n{\log \left[ \sum_{k=1}^G{z_{ik} \tau_k f_k(y_i|\theta_k)} \right]}
$$

Where $\underline{z}_i$ means that we have an unobserved $\underline{z}$ vector for each observation. Such values have to be estimated along with $\underline{\theta}$ (where $\theta_k$ in this case represents the "conjoint parameter" $(\underline\mu_k, \Sigma_k)$) and $\underline{\tau}_k$ ($k=1, \cdots, G$).

To estimate the unknown parameters and unobserved variables, an _EM_ algorithm is used.

The criterion used to select the number of components (clusters) of Gaussian mixture is the _Bayesian Information Criterion_ (BIC):
$$BIC = 2 \ell(\underline{\hat\theta},\underline{\hat\tau},\underline{\hat{z}}_i|\underline{x}) - (\# parameters) \cdot \log(n)$$
Where $\ell(\underline{\hat\theta},\underline{\hat\tau},\underline{\hat{z}}_i|\underline{x})$ is the maximized value of log-likelihood, $(\# parameters)$ is the number of estimated parameters, and $n$ is the sample size. Note that, generally, the BIC index is defined as the negative of this definition.

<!---
Exercises with iris, utilities, uscrimes
--->
