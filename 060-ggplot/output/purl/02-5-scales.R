## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, warning =FALSE, message =FALSE)

## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
require(ggplot2)
require(qdata)
data(bands)

## ------------------------------------------------------------------------
ggplot(data=bands, mapping=aes(x=humidity, y=viscosity)) +
  geom_point(mapping = aes(colour=band_type))

## ------------------------------------------------------------------------
ggplot(data=bands, mapping=aes(x=humidity, y=viscosity)) +
  geom_point(mapping = aes(colour=band_type)) +
  scale_x_continuous() +
  scale_y_continuous() +
  scale_color_discrete()

## ------------------------------------------------------------------------
ggplot(data=bands, mapping=aes(x=humidity, y=viscosity)) +
  geom_point(mapping = aes(colour=band_type)) +
  scale_color_discrete(l = 90)

