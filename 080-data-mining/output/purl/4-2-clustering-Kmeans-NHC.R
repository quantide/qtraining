## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples

## Datasets from packages
require(qdata)
data(uscrime)

## Other datasets used
# iris

##################################################
## packages needed: ggplot2, GGally, clusterSim ##
##################################################

## ----message=FALSE-------------------------------------------------------
require(ggplot2)
require(GGally)

## ----02e-loadandsummaryuc------------------------------------------------
uscrime_tmp <- uscrime[, 4:10]
ggpairs(uscrime_tmp)

## ----02e-sapplyuc--------------------------------------------------------
sapply(uscrime_tmp, var)

## ----02e-applyandsweepuc-------------------------------------------------
rge <- sapply(uscrime_tmp, function(x) diff(range(x)))
uscrime_s <- sweep(x = uscrime_tmp, MARGIN = 2, STATS = rge, FUN = "/")
sapply(uscrime_s, var)

## ----02e-scree1uc--------------------------------------------------------
k_max <- 6
wss <- rep(0, k_max)
for (k in 1:k_max) {
	wss[k] <- kmeans(uscrime_s, centers = k)$tot.withinss
}
ggp <- ggplot(data = data.frame(x=1:6, y=wss), mapping = aes(x=x,y=y)) +
  geom_point() +
  geom_line() +
  xlab("Number of groups") + 
  ylab("Within groups sum of squares")
print(ggp)

## ----02e-plotsuc1--------------------------------------------------------
km_2 <- kmeans(uscrime_s, centers = 2)
km_2$centers * rge
km_4 <- kmeans(uscrime_s, centers = 4)
km_4$centers * rge

uscrime_pca <- princomp(uscrime[, 4:10], cor = TRUE)
summary(uscrime_pca)
plot(uscrime_pca, type = "l")
abline(h = 1, lty = 2)

## ----02e-plotsuc1a-------------------------------------------------------
biplot(uscrime_pca)
ggcorr(cbind(uscrime_s, uscrime_pca$scores), label = TRUE, cex = 2.5)

## ----02d-chfuncut,warning=FALSE------------------------------------------
require(clusterSim)
minC <- 2
maxC <- 10
res <- numeric(maxC - minC)
for (nc in minC:maxC) {
	res[nc - minC + 1] <- index.G1(uscrime_s, kmeans(uscrime_s,centers = nc)$cluster)
}
ggp <- ggplot(data=data.frame(x=2:(length(res)+1), y= res), mapping = aes(x=x,y=y)) + 
  geom_point() + 
  geom_line() +
  xlab("Number of clusters") +
  ylab("Calinski-Harabasz pseudo F-statistic")
print(ggp)

## ----02e-plotsuc2, fig.width=plot_with_legend_fig_width_short------------
Cluster <- as.character(km_2$cluster)
uscrime_scores <- cbind(data.frame(uscrime_pca$scores[, c("Comp.1", "Comp.2")]), state=uscrime$state, Cluster=Cluster)
ggp <- ggplot(data= uscrime_scores, mapping = aes(x = Comp.1, y=Comp.2, label=state, colour=Cluster)) +
  geom_point() +
  xlab("1st PCA dimension") +
  ylab("2nd PCA dimension") +
  geom_text(hjust=0.5, vjust=-0.5, size=3)
print(ggp)

## ----02e-plotsuc3--------------------------------------------------------
pairs(uscrime[, 4:10], col = Cluster, pch = Cluster, cex = .75)

## ----02e-plotsuc4, fig.width=plot_with_legend_fig_width_short------------
Cluster <- as.character(km_4$cluster)
ggp <- ggplot(data=data.frame(x = uscrime_scores[, 1], y = uscrime_scores[, 2], Cluster=Cluster, state=uscrime$state), mapping = aes(x=x,y=y, colour=Cluster))+
  geom_point() +
  xlab("1st PCA dimension") +
  ylab("2nd PCA dimension") +
  geom_text(mapping = aes(label=state), hjust = 0.5, vjust = -0.5, size = 3)
print(ggp)

## ----02e-plotsuc5--------------------------------------------------------
pairs(uscrime[, 4:10], col = Cluster, pch = Cluster, cex = .75)

## ----02e-levelplotsuc----------------------------------------------------
uscrime$reg <- as.factor(uscrime$reg)
levels(uscrime$reg) <- c("Northeast", "Midwest", "South", "West")

plot(table(uscrime$reg, km_2$cluster), main = "Clusters vs. US States region",
			xlab = "Region of US", ylab = "2 groups solution")

plot(table(uscrime$reg, km_4$cluster), main = "Clusters vs. US States region",
			xlab = "Region of US", ylab = "4 groups solution")

