## ---- first, include=TRUE, purl=TRUE, message=FALSE----------------------
require(ggplot2)
require(dplyr)
require(qdata)
require(MASS)
data(bands)

## ---- eval=FALSE---------------------------------------------------------
## # remove NA from bands dataset
## bands_na_rm <- bands %>% na.omit()
## 
## # Compute bivariate density estimate
## f2d <- kde2d(bands_na_rm$humidity, bands_na_rm$viscosity, n =100)
## 
## # Generate a new dataset including also the newly created variable
## bands_d <- expand.grid(humidity = f2d$x, viscosity = f2d$y) %>%
##   tbl_df() %>%
##   mutate(density = as.vector(f2d$z))

## ------------------------------------------------------------------------
ggplot(bands_d, aes(humidity, viscosity, z = density)) + 
  geom_contour()

## ---- echo=FALSE---------------------------------------------------------
data("faithfuld")
ggplot(faithfuld, aes(waiting, eruptions, z = density)) + 
  geom_contour()

## ------------------------------------------------------------------------
ggplot(bands, aes(humidity, viscosity)) +
  geom_density_2d()

## ------------------------------------------------------------------------
ggplot(faithful, aes(waiting, eruptions)) +
  geom_density_2d()

## ------------------------------------------------------------------------
ggplot(bands_d, aes(humidity, viscosity, z = density)) + 
  geom_contour(bins = 2)

ggplot(bands_d, aes(humidity, viscosity, z = density)) + 
  geom_contour(bins = 10)

## ------------------------------------------------------------------------
ggplot(faithfuld, aes(waiting, eruptions, z = density)) + 
  geom_contour(bins = 2)

ggplot(faithfuld, aes(waiting, eruptions, z = density)) + 
 geom_contour(bins = 10)

## ------------------------------------------------------------------------
ggplot(bands_d, aes(humidity, viscosity, z = density)) + 
  geom_contour(binwidth = 0.0001)

## ------------------------------------------------------------------------
ggplot(faithfuld, aes(waiting, eruptions, z = density)) + 
  geom_contour(binwidth = 0.01)

## ------------------------------------------------------------------------
ggplot(bands_d, aes(humidity, viscosity, z = density)) + 
  geom_contour(aes(colour = ..level..))

## ------------------------------------------------------------------------
ggplot(faithfuld, aes(waiting, eruptions, z = density)) + 
  geom_contour(aes(colour = ..level..))

## ------------------------------------------------------------------------
ggplot(bands_d, aes(humidity, viscosity, z = density)) + 
  geom_contour(colour = "darkgreen", linetype = 6, size = 1)

## ------------------------------------------------------------------------
ggplot(faithfuld, aes(waiting, eruptions, z = density)) + 
  geom_contour(colour = "green", linetype = 4, size = 1)

## ------------------------------------------------------------------------
ggplot(bands_d, aes(humidity, viscosity, z = density)) + 
  geom_raster(aes(fill = density)) +
  geom_contour(colour = "white")

## ------------------------------------------------------------------------
# Customize
ggplot(faithfuld, aes(waiting, eruptions, z = density)) + 
  geom_raster(aes(fill = density)) +
  geom_contour(colour = "white")

## ------------------------------------------------------------------------
ggplot(bands_d, aes(humidity, viscosity, z = density)) + 
   geom_raster(aes(fill = density))

## ------------------------------------------------------------------------
ggplot(faithfuld, aes(waiting, eruptions)) +
 geom_raster(aes(fill = density))

## ------------------------------------------------------------------------
ggplot(bands_d, aes(humidity, viscosity, z = density)) + 
   geom_raster(aes(fill = density), interpolate = TRUE)

## ------------------------------------------------------------------------
ggplot(faithfuld, aes(waiting, eruptions)) +
 geom_raster(aes(fill = density), interpolate = TRUE)

## ------------------------------------------------------------------------
ggplot(bands_d, aes(humidity, viscosity, z = density)) + 
   geom_tile(aes(fill = density))

## ------------------------------------------------------------------------
ggplot(faithfuld, aes(waiting, eruptions)) +
 geom_tile(aes(fill = density))

## ------------------------------------------------------------------------
small <- bands_d %>% sample_n(size = 500)

## ------------------------------------------------------------------------
ggplot(small, aes(humidity, viscosity)) +
  geom_point(aes(size = density)) +
  scale_size_area()

## ---- eval=FALSE---------------------------------------------------------
## small <- faithfuld[seq(1, nrow(faithfuld), by = 10), ]

## ---- eval=FALSE---------------------------------------------------------
## ggplot(small, aes(eruptions, waiting)) +
##   geom_point(aes(size = density)) +
##   scale_size_area()

## ------------------------------------------------------------------------
ggplot(small, aes(humidity, viscosity)) +
  geom_point(aes(size = density), alpha =1/3, colour = "blue", fill = "lightblue") +
  scale_size_area()

## ---- eval=FALSE---------------------------------------------------------
## ggplot(small, aes(eruptions, waiting)) +
##   geom_point(aes(size = density), alpha =1/3, colour = "blue", fill = "lightblue") +
##   scale_size_area()

