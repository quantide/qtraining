## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples

## Datasets from packages
require(qdata)
data(banknotes, uscompanies, druguse, life)

## Other datasets used
# none

####################################################################
## packages needed: GGally, ggplot2, rgl, lattice, ellipse, psych ##
####################################################################

## ----02b-loadlifedata----------------------------------------------------
# Data fixing:
life[life$country=="Trinidad (62)", "m25"] <- 43
str(life)
summary(life)

## ----message=FALSE-------------------------------------------------------
require(GGally)

## ----02b-graphlifesummary1-----------------------------------------------
lf <- life[, -1]
class(life) <- "data.frame"
ggscatmat(life, columns = 2:9)

## ----02b-performancelife-------------------------------------------------
system.time(pca_princomp <- princomp(lf))
summary(pca_princomp)
system.time(pca_prcomp <- prcomp(lf))
summary(pca_prcomp)

## ----02b-summarylife-----------------------------------------------------
print(summary(pca_princomp, loadings = TRUE)) # (cutoff = .1)
print(summary(pca_princomp, loadings = TRUE), cutoff = .3)

## ----02b-correlationlife, fig.width=plot_with_legend_fig_width_medium,results='hold'----
require(ggplot2)
dl <- pca_princomp$loadings
class(dl) <- "matrix"
dl <- data.frame(dl)
dl$gender <- rep(c("male", "female"), each=4)
dl$age <- rep(as.character((0:3)*25), 2)
ggp <- ggplot(dl, mapping = aes(x=Comp.1, y=Comp.2, colour=gender, shape=age)) + geom_point() + scale_shape_manual(values = rep(0:3,2)) + ggtitle("PC1 Vs PC2 by gender and age")
print(ggp)
ggp <- ggplot(dl, mapping = aes(x=Comp.1, y=Comp.3, colour=gender, shape=age)) + geom_point() + scale_shape_manual(values = rep(0:3,2)) + ggtitle("PC1 Vs PC3 by gender and age")
print(ggp)
ggp <- ggplot(dl, mapping = aes(x=Comp.2, y=Comp.3, colour=gender, shape=age)) + geom_point() + scale_shape_manual(values = rep(0:3,2)) + ggtitle("PC2 Vs PC3 by gender and age")
print(ggp)

## ---- echo=FALSE, results='hold'-----------------------------------------
rm(dl)

## ----02b-pcsgraphlife, fig.width=plot_with_legend_fig_width_medium-------
cor(lf, pca_princomp$scores)
ggcorr(cbind(lf, pca_princomp$scores), label = TRUE, cex = 2.5)

## ----02b-scoreplotslife, fig.width=plot_with_legend_fig_width_big--------
pca_sc <- data.frame(pca_princomp$scores, country = life[, 1])
ggplot(pca_sc, aes(x = Comp.1, y = Comp.2, color = country)) + geom_point() + geom_text(mapping = aes(label = country), vjust=1) + theme(legend.position = "none") + ggtitle("Comp.1 Vs Comp.2 scores")
ggplot(pca_sc, aes(x = Comp.1, y = Comp.3, color = country)) + geom_point() + geom_text(mapping = aes(label = country), vjust=1) + theme(legend.position = "none") + ggtitle("Comp.1 Vs Comp.3 scores")
ggplot(pca_sc, aes(x = Comp.2, y = Comp.3, color = country)) + geom_point() + geom_text(mapping = aes(label = country), vjust=1) + theme(legend.position = "none") + ggtitle("Comp.2 Vs Comp.3 scores")

## ----02b-biplotlife, fig.width=plot_with_legend_fig_width_short----------
biplot(pca_princomp, choices = c(1,2), cex = c(.7, .7), col = c("gray", "red"))
biplot(pca_princomp, choices = c(1,3), cex = c(.7, .7), col = c("gray", "red"))
biplot(pca_princomp, choices = c(2,3), cex = c(.7, .7), col = c("gray", "red"))

## ----02b-plotprincomplife------------------------------------------------
plot(pca_princomp, type = "lines")

## ----eval=FALSE----------------------------------------------------------
## require(rgl)

## ----eval=FALSE----------------------------------------------------------
## plot3d(pca_princomp$scores[, 1:3], size = 5)
## texts3d(pca_princomp$scores[, 1:3], texts = life$country, adj = c(0.5,0))
## play3d(spin3d(axis = c(1, 1, 1), rpm = 15), duration = 10)

## ----02b-performancelife2------------------------------------------------
system.time(pca_princomp <- princomp(lf, cor = TRUE))
summary(pca_princomp)
system.time(pca_prcomp <- prcomp(lf, center = TRUE, scale. = TRUE))
summary(pca_prcomp)

## ----02b-summarylife2----------------------------------------------------
print(summary(pca_princomp, loadings = TRUE)) # (cutoff = .1)
print(summary(pca_princomp, loadings = TRUE), cutoff = .3)

## ----02b-correlationlife2, fig.width=plot_with_legend_fig_width_medium,results='hold'----
require(ggplot2)
dl <- pca_princomp$loadings
class(dl) <- "matrix"
dl <- data.frame(dl)
dl$gender <- rep(c("male", "female"), each=4)
dl$age <- rep(as.character((0:3)*25), 2)
ggp <- ggplot(dl, mapping = aes(x=Comp.1, y=Comp.2, colour=gender, shape=age)) + geom_point() + scale_shape_manual(values = rep(0:3,2)) + ggtitle("PC1 Vs PC2 by gender and age")
print(ggp)
ggp <- ggplot(dl, mapping = aes(x=Comp.1, y=Comp.3, colour=gender, shape=age)) + geom_point() + scale_shape_manual(values = rep(0:3,2)) + ggtitle("PC1 Vs PC3 by gender and age")
print(ggp)
ggp <- ggplot(dl, mapping = aes(x=Comp.2, y=Comp.3, colour=gender, shape=age)) + geom_point() + scale_shape_manual(values = rep(0:3,2)) + ggtitle("PC2 Vs PC3 by gender and age")
print(ggp)

## ---- echo=FALSE, results='hold'-----------------------------------------
rm(dl)

## ----02b-pcsgraphlife2, fig.width=plot_with_legend_fig_width_medium------
cor(lf, pca_princomp$scores)
ggcorr(cbind(lf, pca_princomp$scores), label = TRUE, cex = 2.5)

## ----02b-scoreplotslife2, fig.width=plot_with_legend_fig_width_big-------
pca_sc <- data.frame(pca_princomp$scores, country = life[, 1])
ggplot(pca_sc, aes(x = Comp.1, y = Comp.2, color = country)) + geom_point() + geom_text(mapping = aes(label = country), vjust=1) + theme(legend.position = "none") + ggtitle("Comp.1 Vs Comp.2 scores")
ggplot(pca_sc, aes(x = Comp.1, y = Comp.3, color = country)) + geom_point() + geom_text(mapping = aes(label = country), vjust=1) + theme(legend.position = "none") + ggtitle("Comp.1 Vs Comp.3 scores")
ggplot(pca_sc, aes(x = Comp.2, y = Comp.3, color = country)) + geom_point() + geom_text(mapping = aes(label = country), vjust=1) + theme(legend.position = "none") + ggtitle("Comp.2 Vs Comp.3 scores")

## ----02b-biplotlife2, fig.width=plot_with_legend_fig_width_short---------
biplot(pca_princomp, choices = c(1,2), cex = c(.7, .7), col = c("gray", "red"))
biplot(pca_princomp, choices = c(1,3), cex = c(.7, .7), col = c("gray", "red"))
biplot(pca_princomp, choices = c(2,3), cex = c(.7, .7), col = c("gray", "red"))

## ----02b-plotprincomplife2-----------------------------------------------
plot(pca_princomp, type = "lines")

## ----eval=FALSE----------------------------------------------------------
## require(rgl)

## ----eval=FALSE----------------------------------------------------------
## plot3d(pca_princomp$scores[, 1:3], size = 5)
## texts3d(pca_princomp$scores[, 1:3], texts = life$country, adj = c(0.5,0))
## play3d(spin3d(axis = c(1, 1, 1), rpm = 15), duration = 10)

## ----02b-loaddata--------------------------------------------------------
str(banknotes)
summary(banknotes)

## ----message=FALSE-------------------------------------------------------
require(GGally)

## ----02b-graphsummary1---------------------------------------------------
bn <- banknotes[, -7]
class(banknotes) <- "data.frame"
ggscatmat(banknotes, columns = 1:6)

## ----02b-graphsummary2, fig.width=plot_with_legend_fig_width_medium------
ggscatmat(banknotes, columns = 1:6, color = "type")

## ----02b-performance-----------------------------------------------------
system.time(pca_princomp <- princomp(bn, cor = TRUE))
summary(pca_princomp)
system.time(pca_prcomp <- prcomp(bn, center = TRUE, scale = TRUE))
summary(pca_prcomp)

## ----02b-summary---------------------------------------------------------
print(summary(pca_princomp, loadings = TRUE)) # (cutoff = .1)

## ----02b-correlation, fig.width=plot_with_legend_fig_width_medium--------
cor(bn, pca_princomp$scores)
ggcorr(cbind(bn, pca_princomp$scores), label = TRUE, cex = 2.5)

## ----02b-scoreplots, fig.width=plot_with_legend_fig_width_medium---------
pca_sc <- data.frame(pca_princomp$scores, type = banknotes[, 7])
ggplot(pca_sc, aes(x = Comp.1, y = Comp.2, color = type)) + geom_point()

## ----02b-biplot, fig.width=plot_with_legend_fig_width_short--------------
biplot(pca_princomp, cex = c(.7, .7), col = c("gray", "red"))

## ----02b-plotprincomp----------------------------------------------------
plot(pca_princomp, type = "lines")

## ----02b-biplotprincomp, fig.width=plot_with_legend_fig_width_short------
biplot(pca_princomp, cex = c(.7, .7), col = c("gray", "red"), choices = c("Comp.1","Comp.2"))

## ----eval=FALSE----------------------------------------------------------
## plot3d(pca_princomp$scores[, 1:3], col = as.integer(banknotes[, 7]) + 2, size = 5)
## play3d(spin3d(axis = c(1, 1, 1), rpm = 15), duration = 10)

## ----02b-banknotes_altro1------------------------------------------------
unique(banknotes$type)

# Splits the two datasets
bn_list <- split(x = banknotes,f = banknotes$type)
bn_list <- lapply(X = bn_list, FUN = function(x){x[,-7]})

# Produces the scatterplot matrix for each data frame
lapply(X = bn_list,FUN = function(x){ggscatmat(x, columns = 1:6)})

## ----02b-banknotes_altro3, fig.width=plot_with_legend_fig_width_medium----
# Produce a list with the two principal components results
pca_princomp <- lapply(X = bn_list, FUN = function(x){princomp(x, cor = TRUE)})
# Produce the summary for either results
lapply(X = pca_princomp, FUN = summary)
# Show the loadings with cutoff=0.1
invisible(lapply(X = pca_princomp, FUN = function(x){print(summary(x, loadings = TRUE), cutoff = .1)}))
# Produce the table of correlations between variables and principal components scores
lapply(X = 1:2, FUN = function(x, bn, pca_princomp){cor(bn[[x]], pca_princomp[[x]]$scores)}, bn_list, pca_princomp)
# Produce the graph of correlations between variables and principal components scores
lapply(X = 1:2, FUN = function(x, bn, pca_princomp){ggcorr(cbind(bn[[x]], pca_princomp[[x]]$scores), label = TRUE, cex = 2.5)}, bn_list, pca_princomp)

## ----02b-banknotes_altro4------------------------------------------------
lapply(X = pca_princomp, FUN = function(x){plot(x, type = "lines")})

## ----02b-banknotes_altro5, fig.width=plot_with_legend_fig_width_short----
lapply(X = pca_princomp, FUN = function(x){biplot(x, cex = c(.7, .7), col = c("black", "red"), choices = c("Comp.1","Comp.2"))})

## ----02b-loaduc----------------------------------------------------------
summary(uscompanies)
class(uscompanies) <- "data.frame"
ggscatmat(uscompanies, columns = 2:7)

## ----02b-princompuc------------------------------------------------------
uscompanies.pca <- princomp(uscompanies[, 2:7], cor = TRUE)
summary(uscompanies.pca, loadings=TRUE)

## ----02b-plotuc----------------------------------------------------------
plot(uscompanies.pca, type = "lines")

## ----02b-coruc-----------------------------------------------------------
cor(uscompanies[, 2:7], uscompanies.pca$scores)

## ----02b-plotscoresuc----------------------------------------------------
ggp <- ggplot(data = data.frame(uscompanies.pca$scores), mapping = aes(x = Comp.1, y = Comp.2)) +
  xlab("Component 1") + ylab("Component 2") +
  geom_text(label = uscompanies[, 9], size = 4)
print(ggp)

## ----02b-plots2uc--------------------------------------------------------
id <- match(c("IBM", "GeneralElectric"), uscompanies[, 1])
uscompanies_new <- uscompanies[-id, ]
uscompanies_new.pca <- princomp(uscompanies_new[, 2:7], cor = TRUE)
summary(uscompanies_new.pca, loadings=TRUE)
plot(uscompanies_new.pca, type = "lines")
cor(uscompanies_new[, 2:7], uscompanies_new.pca$scores)

## ----2b-plots2uc_biplot, fig.width=plot_with_legend_fig_width_short------
biplot(uscompanies_new.pca)

## ----pca_on_transformed_vars---------------------------------------------
uscompanies_sq9 <- sign(uscompanies[,2:7])*abs(uscompanies[,2:7])^(1/9)
uscompanies_sq9 <- cbind(uscompanies[,1], uscompanies_sq9, uscompanies[,8:9])
ggscatmat(uscompanies_sq9, columns = 2:7)
uscompanies_sq9.pca <- princomp(uscompanies_sq9[, 2:7], cor = TRUE)
summary(uscompanies_sq9.pca, loadings=TRUE)
plot(uscompanies_sq9.pca, type = "lines")
cor(uscompanies_sq9[, 2:7], uscompanies_sq9.pca$scores)

## ----pca_on_transformed_vars_2-------------------------------------------
ggp <- ggplot(data = data.frame(uscompanies_sq9.pca$scores), mapping = aes(x = Comp.1, y = Comp.2)) +
  xlab("Component 1") + ylab("Component 2") +
  geom_text(label = uscompanies[, 9], size = 4)
print(ggp)

biplot(uscompanies_sq9.pca)

## ----message=FALSE-------------------------------------------------------
require(lattice)
require(ellipse)

## ----02b-loaddu, fig.width=plot_with_legend_fig_width_short--------------
panel.corrgram <- function(x, y, z, subscripts, at, level = 0.9, label = FALSE, ...) {
	#require("ellipse", quietly = TRUE)
	x <- as.numeric(x)[subscripts]
	y <- as.numeric(y)[subscripts]
	z <- as.numeric(z)[subscripts]
	zcol <- level.colors(z, at = at, ...)
	for (i in seq(along = z)) {
		ell <- ellipse(z[i], level = level, npoints = 50, scale = c(.2, .2),
					   centre = c(x[i], y[i]))
		panel.polygon(ell, col = zcol[i], border = zcol[i], ...)
	}
	if (label) {
		panel.text(x = x, y = y, lab = 100 * round(z, 2), cex = 0.8,
				   col = ifelse(z < 0, "white", "black"))
	}
}
print(levelplot(druguse, at = do.breaks(c(-1.01, 1.01), 20), 
	  xlab = NULL, ylab = NULL, colorkey = list(space = "top"), 
	  scales = list(x = list(rot = 90)), panel = panel.corrgram, label = TRUE))

## ----message=FALSE-------------------------------------------------------
require(psych)

## ----02b-testsdu---------------------------------------------------------
KMO(druguse)
cortest.bartlett(druguse, n = 1634)

## ----02b-factandu--------------------------------------------------------
du_fa2 <- factanal(covmat = druguse, n.obs = 1634, factors = 2,
                   rotation = "none")
du_fa2

## ----02b-tests2du--------------------------------------------------------
pval <- sapply(1:6, function(nf)
		factanal(covmat = druguse, factors = nf, n.obs = 1634)$PVAL)
names(pval) <- sapply(1:6, function(nf) paste0("nf = ", nf))
pval

## ----02b-factan6du-------------------------------------------------------
du_fa6 <- factanal(covmat = druguse, n.obs = 1634, factors = 6,
				   rotation = "none")
du_fa6

## ----02b-factan6rotdu----------------------------------------------------
du_fa6_rot <- factanal(covmat = druguse, n.obs = 1634, factors = 6,
					   rotation = "varimax")
du_fa6_rot

