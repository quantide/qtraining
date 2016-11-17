## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples

## Datasets from packages
require(qdata)
data(utilities)

## Other datasets used
# iris

################################################
## packages needed: GGally, dplyr, clusterSim ##
################################################

## ----message=FALSE-------------------------------------------------------
require(GGally)

## ----02d-loadandsummaryut------------------------------------------------
str(utilities)
ggpairs(utilities[, -c(9, 10)])

## ----02d-clusttryut------------------------------------------------------
utilities.std <- scale(utilities[, -c(9, 10)])
d <- dist(utilities.std)
util.SL <- hclust(d, method = "single")
util.CL <- hclust(d, method = "complete")
util.AL <- hclust(d, method = "average")
util.Ward <- hclust(d, method = "ward.D2")

## ----02d-clusttryplotut--------------------------------------------------
op <- par(mfrow = c(2, 2))
plot(util.SL, labels = utilities$comp_short, cex = .7,
		main = "Utilities data (single linkage)", xlab = "Utilities")
plot(util.CL, labels = utilities$comp_short, cex = .7,
		main = "Utilities data (complete linkage)", xlab = "Utilities")
plot(util.AL, labels = utilities$comp_short, cex = .7,
		main = "Utilities data (average linkage)", xlab = "Utilities")
plot(util.Ward, labels = utilities$comp_short, cex = .7,
		main = "Utilities data (Ward)", xlab = "Utilities")
par(op)

## ----02d-cuttreeut-------------------------------------------------------
util.CL.m <- cutree(util.CL, k = 3)
util.CL.m

## ----message=FALSE-------------------------------------------------------
require(dplyr)

## ----02d-profilesut------------------------------------------------------
utilities <- cbind(utilities, member = util.CL.m)
table(utilities$member)
by(data = utilities[, -(9:11)], INDICES = utilities$member, FUN = summary)
util.summ <- group_by(utilities, member) %>%
  summarise(coverage = mean(coverage),
            return	 = mean(return),
            cost     = mean(cost),
            load     = mean(load),
            peak     = mean(peak),
            sales    = mean(sales),
            nuclear  = mean(nuclear),
            fuel     = mean(fuel))
palette(rainbow(8))
to.draw <- apply(util.summ[, -1], 2, function(x) x/max(x))
stars(to.draw, draw.segments = TRUE, scale = FALSE, key.loc = c(4.6, 2.3),
		labels = c("CLUSTER 1", "CLUSTER 2", "CLUSTER 3"),
		main = "Utilities data (cluster profiling)", cex = .75,
		flip.labels = TRUE)
palette("default")

## ----02d-cuttree2ut------------------------------------------------------
util.CL.g234 <- cutree(util.CL, k = 2:4)
table(clus2 = util.CL.g234[, "2"], clus4 = util.CL.g234[, "4"])

## ----02d-rectclusut------------------------------------------------------
plot(util.CL)
rect.hclust(util.CL, k = 5)

## ----02d-rectclusut-identify, eval=FALSE---------------------------------
## plot(util.CL)
## r <- identify(util.CL)

## ----message=FALSE-------------------------------------------------------
require(clusterSim)
require(ggplot2)

## ----02d-chfuncut,warning=FALSE------------------------------------------
minC <- 2
maxC <- 10
res <- numeric(maxC - minC)
for (nc in minC:maxC) {
	res[nc - minC + 1] <- index.G1(utilities.std, cutree(util.Ward, k = nc))
}
ggp <- ggplot(data=data.frame(x=2:(length(res)+1), y= res), mapping = aes(x=x,y=y)) + 
  geom_point() + 
  geom_line() +
  xlab("Number of clusters") +
  ylab("Calinski-Harabasz pseudo F-statistic")
print(ggp)

## ----02d-membsplotut2, warning=FALSE-------------------------------------
Cluster <- as.character(cutree(util.CL, k = (minC:maxC)[which.max(res)]))
ggscatmat(data = cbind(utilities[, -(9:11)], Cluster=Cluster), color = "Cluster")

## ----02d-membsplotut3, fig.width=7---------------------------------------
utilities$member <-  Cluster
table(utilities$member)
by(utilities[, -(9:11)], utilities$member, summary)
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

