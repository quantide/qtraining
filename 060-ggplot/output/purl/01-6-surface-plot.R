## ---- first, include=TRUE, purl=TRUE, message=FALSE----------------------
require(ggplot2)
require(dplyr)
require(qdata)
require(MASS)
data(bands)

## ----bivariate_density_computation, eval=FALSE---------------------------
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

## ----contour_first-------------------------------------------------------
ggplot(bands_d, aes(humidity, viscosity, z = density)) + 
  geom_contour()

## ----contour_bins--------------------------------------------------------
ggplot(bands_d, aes(humidity, viscosity, z = density)) + 
  geom_contour(bins = 2)

ggplot(bands_d, aes(humidity, viscosity, z = density)) + 
  geom_contour(bins = 10)

## ----contour_bindwidth---------------------------------------------------
ggplot(bands_d, aes(humidity, viscosity, z = density)) + 
  geom_contour(binwidth = 0.0001)

## ---- contour_settings---------------------------------------------------
ggplot(bands_d, aes(humidity, viscosity, z = density)) + 
  geom_contour(colour = "darkgreen", linetype = 6, size = 1)

## ---- contour_colour_mapped----------------------------------------------
ggplot(bands_d, aes(humidity, viscosity, z = density)) + 
  geom_contour(aes(colour = ..level..))

## ----contour_raster_plot-------------------------------------------------
ggplot(bands_d, aes(humidity, viscosity, z = density)) + 
  geom_raster(aes(fill = density)) +
  geom_contour(colour = "white")

## ----rasterplot_first----------------------------------------------------
ggplot(bands_d, aes(humidity, viscosity)) + 
   geom_raster(aes(fill = density))

## ----rasterplot_interpolate----------------------------------------------
ggplot(bands_d, aes(humidity, viscosity)) + 
   geom_raster(aes(fill = density), interpolate = TRUE)

## ----tileplot------------------------------------------------------------
ggplot(bands_d, aes(humidity, viscosity)) + 
   geom_tile(aes(fill = density))

## ----sample_dataset, eval = FALSE----------------------------------------
## bands_d_sample <- bands_d %>% sample_n(size = 500)

## ----bubbleplot_first----------------------------------------------------
ggplot(bands_d_sample, aes(humidity, viscosity)) +
  geom_point(aes(size = density)) +
  scale_size_area()

## ----bubbleplot_settings-------------------------------------------------
ggplot(bands_d_sample, aes(humidity, viscosity)) +
  geom_point(aes(size = density), alpha = 0.4, colour = "blue", fill = "lightblue") +
  scale_size_area()

