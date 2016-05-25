## ----first, include=FALSE, purl=TRUE-------------------------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples

require(dplyr)

require(ggplot2)

require(qdata)
data(bands)

## ----scatterplot_first, message=FALSE------------------------------------
ggplot(data=bands, mapping=aes(x=humidity, y=viscosity)) + geom_point()

## ----scatterplot_geompoint, message=FALSE, warning=FALSE-----------------
ggplot() + geom_point(data=bands, mapping=aes(x=humidity, y=viscosity))

## ----scatterplot_geomsmooth, message=FALSE, warning=FALSE----------------
ggplot(data=bands, mapping=aes(x=humidity, y=viscosity)) + geom_point() + geom_smooth(method="lm")

## ----scatterplot_noinherit, message=FALSE, warning=FALSE-----------------
ggplot() + geom_point(data=bands, mapping=aes(x=humidity, y=viscosity)) + geom_smooth(method="lm")

## ----scatterplot_settinggeoms, message=FALSE, warning=FALSE--------------
ggplot() + 
  geom_point(data=bands, mapping=aes(x=humidity, y=viscosity)) +
  geom_smooth(data=bands, mapping=aes(x=humidity, y=viscosity), method="lm")

## ----scatterplot_assignment1, message=FALSE, warning=FALSE---------------
gp1 <- ggplot(data=bands, mapping=aes(x=humidity, y=viscosity)) + geom_point() 

## ----scatterplot_assignment2, message=FALSE, warning=FALSE---------------
gp1

## ----scatterplot_assignment3, message=FALSE, warning=FALSE---------------
gp2 <- gp1 + geom_smooth(method="lm")
gp2

## ----scatterplot_shape, message=FALSE, warning=FALSE---------------------
ggplot(data=bands, mapping=aes(x=humidity, y=viscosity)) + 
  geom_point(shape=2)

## ----scatterplot_shape_char, message=FALSE, warning=FALSE----------------
ggplot(data=bands, mapping=aes(x=humidity, y=viscosity)) + 
  geom_point(shape="$", size=3)

## ----scatterplot_size, message=FALSE, warning=FALSE----------------------
ggplot(data=bands, mapping=aes(x=humidity, y=viscosity)) + 
  geom_point(size=5)

## ----scatterplot_shape_size, message=FALSE, warning=FALSE----------------
ggplot(data=bands, mapping=aes(x=humidity, y=viscosity)) + 
  geom_point(shape=3, size=1)

## ----scatterplot_colour, message=FALSE, warning=FALSE--------------------
ggplot(data=bands, mapping=aes(x=humidity, y=viscosity)) + 
  geom_point(colour="red")

## ----scatterplot_fill, message=FALSE, warning=FALSE----------------------
ggplot(data=bands, mapping=aes(x=humidity, y=viscosity)) + 
  geom_point(shape=21, colour="red", fill="#FF0000")

## ----scatterplot_alpha, message=FALSE, warning=FALSE---------------------
ggplot(data=bands, mapping=aes(x=humidity, y=viscosity)) +
  geom_point(alpha=0.25)

## ----scatterplot_map_colour, message=FALSE, warning=FALSE----------------
ggplot(data=bands, mapping=aes(x=humidity, y=viscosity, colour=band_type)) +
  geom_point()

## ----scatterplot_map_shape, message=FALSE, warning=FALSE-----------------
ggplot(data=bands, mapping=aes(x=humidity, y=viscosity, shape=band_type)) +
  geom_point()

## ----scatterplot_map_colour_shape, message=FALSE, warning=FALSE----------
ggplot(data=bands, mapping=aes(x=humidity, y=viscosity, colour=band_type, shape=band_type)) +
  geom_point()

## ----scatterplot_map_size, message=FALSE, warning=FALSE------------------
ggplot(data=bands, mapping=aes(x=humidity, y=viscosity, size=band_type)) +
  geom_point()

## ----scatterplot_map_colour_continuous, message=FALSE, warning=FALSE-----
ggplot(data=bands, mapping=aes(x=humidity, y=viscosity, colour=ink_pct)) +
  geom_point()

## ----scatterplot_map_size_continuous, message=FALSE, warning=FALSE-------
ggplot(data=bands, mapping=aes(x=humidity, y=viscosity, size=ink_pct)) +
  geom_point()

## ----scatterplot_map_colour_smooth, message=FALSE, warning=FALSE---------
ggplot(data=bands, mapping=aes(x=humidity, y=viscosity, colour=band_type)) +
  geom_point() + geom_smooth(method="lm")

## ----scatterplot_map_colour_onesmooth, message=FALSE, warning=FALSE------
ggplot(data=bands, mapping=aes(x=humidity, y=viscosity)) +
  geom_point(mapping=aes(colour=band_type)) + geom_smooth(method="lm")

## ----scatterplot_map_colour_threesmooth, message=FALSE, warning=FALSE----
ggplot(data=bands, mapping=aes(x=humidity, y=viscosity)) +
  geom_point(mapping=aes(colour=band_type)) + 
  geom_smooth(mapping=aes(colour=band_type), method="lm") +
  geom_smooth(method="lm")

## ----scatterplot_map_four_variables, message=FALSE, warning=FALSE--------
ggplot(data=bands, mapping=aes(x=humidity, y=viscosity, size=ink_pct, colour=band_type)) +
  geom_point()

