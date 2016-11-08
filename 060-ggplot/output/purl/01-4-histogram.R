## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
require(dplyr)
require(ggplot2)
require(qdata)
data(bands)

## ----histogram_first, message=FALSE, warning=FALSE-----------------------
ggplot(data=bands, mapping=aes(x=ink_pct)) + 
  geom_histogram()

## ----histogram_aes, message=FALSE, warning=FALSE-------------------------
ggplot(data=bands, mapping=aes(x=ink_pct)) + 
  geom_histogram(fill="#2B4C6F", colour="#3690c0")

## ----histogram_bins, message=FALSE, warning=FALSE------------------------
ggplot(data=bands, mapping=aes(x=ink_pct)) + 
  geom_histogram(fill="#2B4C6F", colour="#3690c0", bins=6)

## ----histogram_binwidth, message=FALSE, warning=FALSE--------------------
ggplot(data=bands, mapping=aes(x=ink_pct)) + 
  geom_histogram(fill="#2B4C6F", colour="#3690c0", binwidth=7)

## ----histogram_mapping, message=FALSE, warning=FALSE---------------------
ggplot(data=bands, mapping=aes(x=ink_pct)) +
  geom_histogram(mapping=aes(fill=band_type))

## ----histogram_mapping_hide, message=FALSE, warning=FALSE----------------
ggplot(data=bands, mapping=aes(x=ink_pct)) +
  geom_histogram(mapping=aes(fill=press_type))

## ----histogram_facetgrid_col, message=FALSE, warning=FALSE---------------
ggplot(data=bands, mapping=aes(x=ink_pct)) +
  geom_histogram(fill="#2B4C6F") +
  facet_grid(. ~ press_type)

## ----histogram_facetgrid_row, message=FALSE, warning=FALSE---------------
ggplot(data=bands, mapping=aes(x=ink_pct)) +
  geom_histogram(fill="#2B4C6F") +
  facet_grid(band_type ~ .)

## ----histogram_facetgrid_row_col, message=FALSE, warning=FALSE-----------
ggplot(data=bands, mapping=aes(x=ink_pct)) +
  geom_histogram(fill="#2B4C6F") +
  facet_grid(band_type ~ press_type)

## ----histogram_facetwrap, message=FALSE, warning=FALSE-------------------
ggplot(data=bands, mapping=aes(x=ink_pct)) +
  geom_histogram(fill="#2B4C6F") +
  facet_wrap(~ press_type)

## ----histogram_density, message=FALSE, warning=FALSE---------------------
ggplot(data=bands, mapping=aes(x=ink_pct, y=..density..)) +
  geom_histogram(fill="#74a9cf")

## ----density_curve, message=FALSE, warning=FALSE-------------------------
ggplot(data=bands, mapping=aes(x=ink_pct, y=..density..)) +
  geom_histogram(fill="#74a9cf") + 
  geom_density(colour="#034e7b")

## ----density_line, message=FALSE, warning=FALSE--------------------------
ggplot(data=bands, mapping=aes(x=ink_pct, y=..density..)) +
  geom_histogram(fill="#74a9cf") + 
  geom_line(stat="density", colour="#034e7b")

## ----density_curve_fill, message=FALSE, warning=FALSE--------------------
ggplot(data=bands, mapping=aes(x=ink_pct)) + 
  geom_density(fill = "red", alpha = 0.6)

## ----density_curve_smooth, message=FALSE, warning=FALSE------------------
ggplot(data=bands, mapping=aes(x=ink_pct)) + 
  geom_density(adjust = 0.5)

## ----density_curve_groups, message=FALSE, warning=FALSE------------------
ggplot(data=bands, mapping=aes(x=ink_pct, colour = band_type)) + 
  geom_density()

## ----frequency_polygon, message=FALSE, warning=FALSE---------------------
ggplot(data=bands, mapping=aes(x=ink_pct)) +
  geom_freqpoly(col = "darkgreen")

## ----frequency_polygon_binwidth, message=FALSE, warning=FALSE------------
ggplot(data=bands, mapping=aes(x=ink_pct)) +
  geom_freqpoly(col = "darkgreen", binwidth=10)

## ----frequency_polygon_breaks, message=FALSE, warning=FALSE--------------
ggplot(data=bands, mapping=aes(x=ink_pct)) +
  geom_freqpoly(col = "darkgreen", breaks=c(30, 32, 36, 41, 45, 53, 59, 64, 72, 77, 81, 87, 91))

