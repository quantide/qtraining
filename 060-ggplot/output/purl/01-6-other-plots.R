## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
require(ggplot2)
require(qdata)
data(bands)

## ----histogram_geomdensity, message=FALSE, warning=FALSE-----------------
ggplot(data=bands, mapping=aes(x=ink_pct)) + 
  geom_density()

## ---- message=FALSE, warning=FALSE---------------------------------------
ggplot(data=bands, mapping=aes(x=ink_pct)) + 
  geom_line(stat="density")

## ---- message=FALSE, warning=FALSE---------------------------------------
ggplot(data=bands, mapping=aes(x=ink_pct)) + 
  geom_density(adjust = 0.5)

## ---- message=FALSE, warning=FALSE---------------------------------------
ggplot(data=bands, mapping=aes(x=ink_pct, colour = band_type)) + 
  geom_density(adjust = 0.5)

## ------------------------------------------------------------------------
ggplot(data=bands, mapping=aes(x=ink_pct, colour = press_type)) + 
  geom_density()

## ------------------------------------------------------------------------
ggplot(data=bands, mapping=aes(x = press_type, y=ink_pct)) + 
  geom_violin()

## ------------------------------------------------------------------------
ggplot(data=bands, mapping=aes(x = press_type, y=ink_pct)) + 
  geom_violin(trim=FALSE)

## ------------------------------------------------------------------------
ggplot(data=bands, mapping=aes(x = press_type, y=ink_pct)) + 
   geom_violin(scale="count")

## ------------------------------------------------------------------------
ggplot(data=bands, mapping=aes(x = press_type, y=ink_pct)) + 
   geom_violin(adjust=0.5)

## ------------------------------------------------------------------------
ggplot(data=bands, mapping=aes(x = humidity, y=viscosity)) + 
  geom_density2d()

## ------------------------------------------------------------------------
ggplot(data=bands, mapping=aes(x = humidity, y=viscosity)) + 
  geom_point() +
  geom_density2d()

## ------------------------------------------------------------------------
ggplot(data=bands, mapping=aes(x = humidity, y=viscosity)) + 
  stat_density2d(aes(colour=..level..))

## ------------------------------------------------------------------------
ggplot(data=bands, mapping=aes(x = humidity, y=viscosity)) + 
  stat_density2d(aes(fill=..density..), geom="raster", contour=FALSE)

## ------------------------------------------------------------------------
ggplot(data=bands, mapping=aes(x = humidity, y=viscosity)) + 
  geom_point() +
  stat_density2d(aes(alpha=..density..), geom="tile", contour=FALSE)

## ------------------------------------------------------------------------
ggplot(data=bands, mapping=aes(x = humidity, y=viscosity)) + 
  stat_density2d(aes(fill=..density..), geom="raster", contour=FALSE, h=c(.5,5))

