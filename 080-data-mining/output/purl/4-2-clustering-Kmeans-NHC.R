## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples

## Datasets from packages
require(qdata)
require(dplyr)
data(utilities)
## Other datasets used
# iris

##################################################
## packages needed: ggplot2, GGally, clusterSim ##
##################################################

## ----message=FALSE-------------------------------------------------------
require(ggplot2)
require(GGally)

## ----02e-loadandsummaryuc------------------------------------------------
set.seed(10)
utilities_tmp <- utilities[, 1:8]
ggpairs(utilities_tmp)

## ----02e-sapplyuc--------------------------------------------------------
sapply(utilities_tmp, var)

## ----02e-applyandsweepuc-------------------------------------------------
rge <- sapply(utilities_tmp, function(x) diff(range(x)))
utilities_s <- sweep(x = utilities_tmp, MARGIN = 2, STATS = rge, FUN = "/")
sapply(utilities_s, var)

## ----02e-scree1uc--------------------------------------------------------
k_max <- 8
wss <- rep(0, k_max)
for (k in 1:k_max) {
	wss[k] <- kmeans(utilities_s, centers = k)$tot.withinss
}
ggp <- ggplot(data = data.frame(x=1:k_max, y=wss), mapping = aes(x=x,y=y)) +
  geom_point() +
  geom_line() +
  xlab("Number of groups") + 
  ylab("Within groups sum of squares")
print(ggp)


## ----02e-plotsuc1--------------------------------------------------------
km_4 <- kmeans(utilities_s, centers = 4)
km_4$centers * rge

utilities_pca <- princomp(utilities_tmp, cor = TRUE)
summary(utilities_pca, loadings=TRUE)
plot(utilities_pca, type = "l")
abline(h = 1, lty = 2)

## ----02e-plotsuc1a-------------------------------------------------------
biplot(utilities_pca)
ggcorr(cbind(utilities_s, utilities_pca$scores), label = TRUE, cex = 2.5)

## ----02d-chfuncut,warning=FALSE, message=FALSE---------------------------
require(clusterSim)
minC <- 2
maxC <- 10
res <- numeric(maxC - minC)
for (nc in minC:maxC) {
	res[nc - minC + 1] <- index.G1(utilities_s, kmeans(utilities_s,centers = nc)$cluster)
}
ggp <- ggplot(data=data.frame(x=2:(length(res)+1), y= res), mapping = aes(x=x,y=y)) + 
  geom_point() + 
  geom_line() +
  xlab("Number of clusters") +
  ylab("Calinski-Harabasz pseudo F-statistic")
print(ggp)

## ----02e-plotsuc2, fig.width=plot_with_legend_fig_width_short------------
Cluster <- as.character(km_4$cluster)
utilities_scores <- cbind(data.frame(utilities_pca$scores[, c("Comp.1", "Comp.2")]), company=utilities$comp_short, Cluster=Cluster)
ggp <- ggplot(data= utilities_scores, mapping = aes(x = Comp.1, y=Comp.2, label=company, colour=Cluster)) +
  geom_point() +
  xlab("1st PCA dimension") +
  ylab("2nd PCA dimension") +
  geom_text(hjust=0.5, vjust=-0.5, size=3)
print(ggp)

## ----02e-plotsuc3--------------------------------------------------------
pairs(utilities_tmp, col = Cluster, pch = Cluster, cex = .75)

## ----02d-membsplotut3, fig.width=7---------------------------------------
utilities$member <-  Cluster
util.summ <- summarise(group_by(utilities, member),
                       coverage = mean(coverage),
                       return   = mean(return),
                       cost     = mean(cost),
                       load     = mean(load),
                       peak     = mean(peak),
                       sales    = mean(sales),
                       nuclear  = mean(nuclear),
                       fuel     = mean(fuel))
palette(rainbow(8))
to.draw <- apply(util.summ[, -1], 2, function(x) x/max(x))
stars(to.draw, draw.segments = TRUE, scale = FALSE, key.loc = c(4.6,2.0), nrow=3, ncol=2,
      labels = c("CLUSTER 1", "CLUSTER 2","CLUSTER 3", "CLUSTER 4"),
      main = "Utilities data (cluster profiling)", cex = .75, ylim=c(0,8),
      flip.labels = TRUE)
palette("default")

