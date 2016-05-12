lapply(X = wea,FUN = basicStats)
basicStats(wea)

set.seed(10)
x <- 1:10
y <- 1:10

comb <- expand.grid(x,y)
names(comb) <-c("x","y")
comb$z= 2 + 3 * comb$x - 2*comb$y + runif(n = 100,min = -2, max = 2)

require(rgl)
open3d()
with(comb,
     plot3d(x = x, y = y, z = z,
            xlab = "x", ylab = "y", zlab = "z", type = "h"
     ))

D <- dist(x = comb,method = "euclidean")

mds_1 <- cmdscale(d = D,k = 3,eig = TRUE)

mds_1

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
max(abs(dist(comb) - dist(cmdscale(D, k = 3))))

# Completely reproduced solution
reprod <- setNames(data.frame(mds_1$points), c("x","y","z"))
reprod$x <- (scale(reprod$x , scale = diff(range(reprod$x)))+.5)*10
reprod$y <- (scale(reprod$y, scale = diff(range(reprod$y)))+.5)*10
comb_3 <- rbind(comb, reprod)
comb_3$points <- rep(c("orig", "reprod"), each=100)

my_surface <- function(f, n=10, ...) { 
  ranges <- rgl:::.getRanges()
  x <- seq(ranges$xlim[1], ranges$xlim[2], length=n)
  y <- seq(ranges$ylim[1], ranges$ylim[2], length=n)
  z <- outer(x,y,f)
  surface3d(x, y, z, ...)
}

f <- function(x, y){
  return(2 + 3 * x - 2*y)
}

open3d()
with(comb,
     plot3d(x = x, y = y, z = z,
            xlab = "x", ylab = "y", zlab = "z", type = "p", col="red")
     )
my_surface(f, alpha=.4 )

snapshot3d("~/Desktop/plot1.png")

# 2-dims reproduced solution
comb_3 <- setNames(data.frame(mds_1$points), c("x","y","z"))
comb_3$z <- 0

f <- function(x, y){
  return(0)
}

open3d()
with(comb_3,
     plot3d(x = x, y = y, z = z,
            xlab = "c1", ylab = "c2", zlab = "c3", type = "p", col="red")
     )
snapshot3d("~/Desktop/plot1.png")

ggp <- ggplot(data = data.frame(x = as.numeric(D), y = as.numeric(dist(cmdscale(D, k = 2)))),
              mapping = aes(x = x, y = y)) +
  geom_point() +
  geom_abline(intercept = 0, slope = 1) +
  xlab("Original distances") +
  ylab("Fitted distances")
print(ggp)
max(abs(dist(mds_1) - dist(cmdscale(D, k = 2))))

