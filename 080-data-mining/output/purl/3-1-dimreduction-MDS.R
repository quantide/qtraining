## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples

## Datasets from packages
require(qdata)
data(wwiileaders, mds, life)
data(bread, package = "smacof")
data(skulls, package = "HSAUR2")

## Other datasets used
# none

################################################################################
## packages needed: GGally, ggplot2, MCMCpack, reshape2, MASS, smacof, HSAUR2 ##
################################################################################

## ----02a-loadfk----------------------------------------------------------
mds
pairs(x = mds, pch = as.character(as.numeric(rownames(mds))-1))

## ----require_GGally, message=FALSE---------------------------------------
require(GGally)

## ----02a-alternative_pairs-----------------------------------------------
ggpairs(data = mds)

## ----02a-distancefk------------------------------------------------------
D <- dist(mds, method = "euclidean")

## ----02a-cmdscalefk------------------------------------------------------
X_mds <- cmdscale(D, k = 9, eig = TRUE)

## ----require_ggplot2, message=FALSE--------------------------------------
require(ggplot2)

## ----02a-screefk---------------------------------------------------------
eig <- X_mds$eig
dims <- 1:attr(D, "Size")
eig <- data.frame(Dimensions = dims, Eigenvalue = eig)
ggp <- ggplot(eig, aes(x = Dimensions, y = Eigenvalue)) +
  geom_point() +
  geom_line() +
  scale_x_continuous("Dimensions", breaks = dims) +
  geom_hline(yintercept = 0, linetype = "dashed")
print(ggp)

## ----02a-coordsfk_alternative_plot---------------------------------------
ggp <- ggplot(data = data.frame(x = as.numeric(D), y = as.numeric(dist(cmdscale(D, k = 5)))),
            mapping = aes(x = x, y = y)) +
  geom_point() +
  geom_abline(intercept = 0, slope = 1) +
  xlab("Original distances") +
  ylab("Fitted distances")
print(ggp)
max(abs(dist(mds) - dist(cmdscale(D, k = 5))))

## ----02a-fittingfk, fig.width=plot_with_legend_fig_width_short-----------
X_eig <- X_mds$eig
P1 <- cumsum(abs(X_eig))/sum(abs(X_eig))
P2 <- cumsum(X_eig^2)/sum(X_eig^2)

mardia <- data.frame(Dimensions = rep(dims,2), P = c(P1, P2), 
                     Criterion=rep(c("P1", "P2"),each=attr(D, "Size")))
ggp <- ggplot(data = mardia, aes(x = Dimensions, y = P, colour=Criterion)) +
  geom_point() +
  geom_line() +
  scale_x_continuous("Dimensions", breaks = dims) +
  scale_y_continuous("Value", breaks = seq(0, 1, by = .1)) +
  geom_hline(yintercept = .8, linetype = "dashed", color = "darkgray")
print(ggp)


## ----02a-fittingfinalfk--------------------------------------------------
X_final <- X_mds$points[, 1:3]
D_hat <- dist(X_final, method = "euclidean")
D_all <- data.frame(Observed = as.numeric(D), Fitted = as.numeric(D_hat))
ggplot(data = D_all, mapping = aes(x = Observed, y = Fitted)) +
  geom_point() +
  scale_y_continuous(limits = c(0, 10)) + 
  scale_x_continuous(limits = c(0, 10)) +
  geom_abline(linetype = "dashed", color = "gray")

## ----02a-plotfinalfk-----------------------------------------------------
pairs(x = X_final, pch = as.character(as.numeric(rownames(mds))-1))

## ----02a-plotfinalfk_alternative_plot, echo=TRUE, eval=FALSE-------------
## require(rgl)
## open3d()
## with(data.frame(X_final),
##      plot3d(x = X1, y = X2, z = X3,
##             xlab = "X1", ylab = "X2", zlab = "X3", type = "p")
##      )

## ----02a-fakedata1-------------------------------------------------------
x <- 1:10
y <- 1:10

comb <- expand.grid(x,y)
names(comb) <-c("x","y")
comb$z= 2 + 3 * comb$x - 2 * comb$y + runif(n = 100,min = -2, max = 2)

## ----02a-fakedata_plot, echo=TRUE, eval=FALSE----------------------------
## open3d()
## with(comb,
##      plot3d(x = x, y = y, z = z,
##             xlab = "x", ylab = "y", zlab = "z", type = "p"
##      ))

## ----02a-fakedataanalysis1-----------------------------------------------
D <- dist(x = comb,method = "euclidean")
mds_1 <- cmdscale(d = D,k = 3,eig = TRUE)
mds_1

## ----02a-fakedataanalysis2-----------------------------------------------
eig <- mds_1$eig
dims <- 1:attr(D, "Size")
eig <- data.frame(Dimensions = dims, Eigenvalue = eig)
ggp <- ggplot(eig, aes(x = Dimensions, y = Eigenvalue)) +
  geom_point() +
  geom_line() +
  scale_x_continuous("Dimensions", breaks = 1:attr(D, "Size")) +
  geom_hline(yintercept = 0, linetype = "dashed")
print(ggp)

ggp <- ggplot(data = data.frame(x = as.numeric(D), y = as.numeric(dist(cmdscale(D, k = 3)))),
              mapping = aes(x = x, y = y)) +
  geom_point() +
  geom_abline(intercept = 0, slope = 1) +
  xlab("Original distances") +
  ylab("Fitted distances")
print(ggp)
max(abs(D - dist(cmdscale(D, k = 3))))

## ----02a-fakedata_plot_1, echo=TRUE, eval=FALSE--------------------------
## my_surface <- function(f, n=10, ...) {
##   ranges <- rgl:::.getRanges()
##   x <- seq(ranges$xlim[1], ranges$xlim[2], length=n)
##   y <- seq(ranges$ylim[1], ranges$ylim[2], length=n)
##   z <- outer(x,y,f)
##   surface3d(x, y, z, ...)
## }
## 
## f <- function(x, y){
##   return(2 + 3 * x - 2*y)
## }
## 
## open3d()
## with(comb,
##      plot3d(x = x, y = y, z = z,
##             xlab = "x", ylab = "y", zlab = "z", type = "p", col="red")
##      )
## my_surface(f, alpha=.7 )

## ----02a-fakedataanalysis4-----------------------------------------------
# 2-dims reproduced solution
comb_3 <- setNames(data.frame(mds_1$points), c("x","y","z"))
comb_3$z <- 0

## ----graph_3d_final, eval=FALSE------------------------------------------
## open3d()
## with(comb_3,
##      plot3d(x = x, y = y, z = z,
##             xlab = "x", ylab = "y", zlab = "z", type = "p", col="red")
##      )

## ----02a-fakedataanalysis5-----------------------------------------------
ggp <- ggplot(data = data.frame(x = as.numeric(D), y = as.numeric(dist(cmdscale(D, k = 2)))),
              mapping = aes(x = x, y = y)) +
  geom_point() +
  geom_abline(intercept = 0, slope = 1) +
  xlab("Original distances") +
  ylab("Fitted distances")
print(ggp)
max(abs(D - dist(cmdscale(D, k = 2))))

## ----02a-loades, fig.width=plot_with_legend_fig_width_large--------------
# Summarize the data
by(data = skulls[, -1], INDICES = skulls$epoch, FUN = summary)
ggscatmat(data = skulls, columns = 2:5, color = "epoch")

## ----02a-mahales---------------------------------------------------------
skulls_var <- tapply(X = 1:nrow(skulls), INDEX = skulls$epoch,
                     FUN = function(i) var(skulls[i, -1]))

S <- 0
for (v in skulls_var) {
  S <- S + 29 * v
}
S <- S / 145  # estimate of the common covariance matrix in the different epochs

skulls_cen <- tapply(X = 1:nrow(skulls), INDEX = skulls$epoch,
                     FUN = function(i) apply(skulls[i, -1], 2, mean))
skulls_cen <- matrix(data = unlist(skulls_cen),
                     nrow = length(skulls_cen), byrow = TRUE)
skulls_mah <- as.dist(m = apply(X = skulls_cen, MARGIN = 1,
                                FUN = function(cen) mahalanobis(skulls_cen, cen, S)))
skulls_mah   # Mahalanobis distance between each pair of epochs

## ----02a-screees---------------------------------------------------------
eig <- cmdscale(skulls_mah, k = attr(skulls_mah, "Size") - 1, eig = TRUE)$eig
eig <- data.frame(Dimensions = 1:attr(skulls_mah, "Size"), Eigenvalue = eig)
ggp <- ggplot(data = eig, mapping = aes(x = Dimensions, y = Eigenvalue)) +
  geom_point() +
  geom_line() +
  geom_hline(yintercept = 0, linetype = "dashed")
print(ggp)

skulls_mds <- cmdscale(skulls_mah)

## ----02a-plotmdses-------------------------------------------------------
ds <- data.frame(V1=skulls_mds[,1],V2= skulls_mds[,2], label = levels(skulls[, 1]))
ggp <- ggplot(data = ds, mapping = aes(x=V1, y = V2, label=label)) + 
  geom_point() +
  geom_text(hjust = 0.5, vjust = -0.5) +
  xlab("1st dimension") + ylab("2nd dimension") +
  coord_fixed(ratio = 1, xlim = c(-2, 2), ylim = c(-2, 2)) 
print(ggp)
rm(ds)

## ---- message=FALSE------------------------------------------------------
require(MASS)

## ----02a-requirepi-------------------------------------------------------
WWII_mds <- isoMDS(wwiileaders)
WWII_mds$stress

## ----02a-plotpi----------------------------------------------------------
ds <- data.frame(V1=WWII_mds$points[, 1],V2= WWII_mds$points[, 2], label = attr(wwiileaders, "Labels"))
ggp <- ggplot(data = ds, mapping = aes(x=V1, y = V2, label=label)) + 
  geom_point() +
  geom_text(hjust = 0.5, vjust = -0.5) +
  xlab("1st dimension") + ylab("2nd dimension") +
  coord_fixed(ratio = 1, xlim = c(-6, 6), ylim = c(-6, 6)) 
print(ggp)
rm(ds)


## ----02a-shepardpi-------------------------------------------------------
WWII_shep <- as.data.frame(Shepard(wwiileaders, WWII_mds$points))
ggp <- ggplot(WWII_shep, aes(x = WWII_shep[, 1], y = WWII_shep[, 2])) +
  geom_point(size = 1) + 
  geom_step(aes(y = WWII_shep[, 3])) +
  xlab("Observed") + ylab("Fitted") +
  ggtitle("Shepard diagram") 
print(ggp)

## ----02a-shepartrydpi----------------------------------------------------
ndim <- 1:7
stress_mds <- sapply(ndim, function(i) isoMDS(wwiileaders, k = i,
                     trace = FALSE)$stress/100)
WWII_stress <- data.frame(Dimensions = ndim, Stress = stress_mds)
ggp <- ggplot(WWII_stress, aes(x = Dimensions, y = Stress)) +
  geom_point() +
  geom_line() +
  scale_y_continuous(limits = c(0, max(stress_mds)),
		                    breaks = seq(0, max(stress_mds), by = .05)) +
  scale_x_continuous(limits = c(0, max(ndim)), breaks = ndim)
print(ggp)

## ----02a-finaldpi--------------------------------------------------------
WWII_final <- as.data.frame(isoMDS(wwiileaders, k = 3)$points)
panel.txt <- function(x, y, ...) {
  points(x, y, ...)
  text(x, y, labels = rownames(WWII_final), pos = 1, cex = .8, offset = .5)
}
pairs(x = WWII_final, panel = panel.txt, xlim = c(-5, 5), ylim = c(-5, 5))

## ----3dplot, eval=FALSE--------------------------------------------------
## WWII_final$Leader <- row.names(WWII_final)
## open3d()
## with(WWII_final,
##      plot3d(x = V1, y = V2, z = V3,
##             xlab = "1st dimension", ylab = "2nd dimension", zlab = "3rd dimension", type = "p",
##             col = "blue")
##      )
## with(WWII_final,
##      text3d(x = V1, y = V2, z = V3,texts = Leader)
##      )

