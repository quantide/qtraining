## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, warning =FALSE, message =FALSE)

## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
require(dplyr)
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
  scale_color_discrete(l = 45)

## ------------------------------------------------------------------------
ggplot(data = bands, mapping = aes(x = humidity, y = viscosity, colour = press_type)) +
  geom_point()

## ------------------------------------------------------------------------
ggplot(data = bands, mapping = aes(x = humidity, y = viscosity, colour = press_type)) +
  geom_point() +
  scale_color_hue()

## ------------------------------------------------------------------------
ggplot(data = bands, mapping = aes(x = humidity, y = viscosity, colour = press_type)) +
  geom_point() +
  scale_colour_hue(l=45)

## ------------------------------------------------------------------------
ggplot(data = bands, mapping = aes(x = humidity, y = viscosity, colour = press_type)) +
  geom_point() +
  scale_colour_brewer(palette="Set1")

## ------------------------------------------------------------------------
ggplot(data = bands, mapping = aes(x = humidity, y = viscosity, colour = press_type)) +
  geom_point() +
  scale_colour_grey()

## ------------------------------------------------------------------------
ggplot(data = bands, mapping = aes(x = humidity, y = viscosity, colour = press_type)) +
  geom_point() +
  scale_colour_grey(start=0.7, end=0)

## ------------------------------------------------------------------------
# named colours
ggplot(data = bands, mapping = aes(x = humidity, y = viscosity, colour = press_type)) +
  geom_point() +
  scale_colour_manual(values = c("magenta", "dark turquoise", "dodger blue", "lime green"))

# RGB colour code
ggplot(data = bands, mapping = aes(x = humidity, y = viscosity, colour = press_type)) +
  geom_point() +
  scale_colour_manual(values = c("#FF00FF", "#00CED1", "#1E90FF", "#32CD32"))

## ------------------------------------------------------------------------
levels(bands$press_type)

## ------------------------------------------------------------------------
ggplot(data = bands, mapping = aes(x = humidity, y = viscosity, colour = press_type)) +
  geom_point() +
  scale_colour_manual(values = c(ALBERT70 = "lime green", MOTTER70 = "dark turquoise", MOTTER94 = "magenta", WOODHOE70 = "dodger blue"))

## ------------------------------------------------------------------------
ggplot(data = bands, mapping = aes(x = humidity, y = viscosity, colour = solvent_pct)) +
  geom_point()

## ------------------------------------------------------------------------
# scale_colour_gradient()
ggplot(data = bands, mapping = aes(x = humidity, y = viscosity, colour = solvent_pct)) +
  geom_point() + 
  scale_colour_gradient(low="black", high="white")

## ------------------------------------------------------------------------
# scale_colour_gradient2()
ggplot(data = bands, mapping = aes(x = humidity, y = viscosity, colour = solvent_pct)) +
  geom_point() + 
  scale_colour_gradient2(low="red", mid="white", high="blue")

## ------------------------------------------------------------------------
require(scales)
ggplot(data = bands, mapping = aes(x = humidity, y = viscosity, colour = solvent_pct)) +
  geom_point() + scale_colour_gradient2(low=muted("red"), mid="white", high=muted("blue"))


## ------------------------------------------------------------------------
# scale_colour_gradientn()
ggplot(data = bands, mapping = aes(x = humidity, y = viscosity, colour = solvent_pct)) +
  geom_point() + 
  scale_colour_gradientn(colours = c("darkred", "orange", "yellow", "white"))

## ------------------------------------------------------------------------
ggplot(data = bands, mapping = aes(x = humidity, y = viscosity, colour = solvent_pct)) +
  geom_point() + 
  scale_colour_gradientn(colours = terrain.colors(n=8))

## ------------------------------------------------------------------------
# data
ChickWeightMean <- ChickWeight %>% 
  group_by(Time, Diet) %>% 
  summarize(weight=mean(weight)) %>%
  mutate(Diet = factor(Diet, levels=1:4, labels=c("A","B","C","D")))

## ------------------------------------------------------------------------
ggplot(data=ChickWeightMean, mapping=aes(x=Time, y=weight)) +
  geom_line(mapping=aes(linetype=Diet)) 

## ------------------------------------------------------------------------
ggplot(data=ChickWeightMean, mapping=aes(x=Time, y=weight)) +
  geom_line(mapping=aes(linetype=Diet)) +  
  scale_linetype_manual(values=c(3,4,5,6))

## ------------------------------------------------------------------------
ggplot(data=bands, mapping=aes(x=humidity, y=viscosity, shape=press_type)) +
  geom_point() +
  scale_shape_manual(values = c(12, 13, 8, 3))

## ------------------------------------------------------------------------
ggplot(data=bands, mapping=aes(x=humidity, y=viscosity, size=ink_pct)) +
  geom_point()

## ------------------------------------------------------------------------
ggplot(data=bands, mapping=aes(x=humidity, y=viscosity, size=ink_pct)) +
  geom_point() +
  scale_size(range=c(2, 4))

## ------------------------------------------------------------------------
ggplot(data=bands, mapping=aes(x=humidity, y=viscosity, size=ink_pct)) +
  geom_point() +
  scale_size_area()

## ------------------------------------------------------------------------
ggplot(data=bands, mapping=aes(x=humidity, y=viscosity, size=ink_pct)) +
  geom_point() +
  scale_size_area(max_size = 3)

## ------------------------------------------------------------------------
ggplot(data=bands, mapping=aes(x=humidity, y=viscosity, size=ink_pct)) +
  geom_point() +
  scale_radius()

