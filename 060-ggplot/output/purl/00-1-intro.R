## ----intro_require_ggplot, message=FALSE---------------------------------
require(ggplot2)

## ----complete_plot, fig.width= 8, echo=FALSE-----------------------------
# Load iris dataset
data(iris)

# Generate plot
ggplot(iris, aes(x = Sepal.Width, y = Sepal.Length, colour = Species)) +
  geom_point() +
  stat_smooth(method = "lm", se = F) +
  scale_colour_brewer(palette="Set1") +
  coord_equal() +
  facet_grid(. ~ Species) +
  ggtitle("Scatterplot of lenght and width of iris sepal by species") + 
    xlab("Sepal Length (cm)") +
    ylab("Sepal Width (cm)") +
  theme(plot.background = element_blank(),
    axis.text = element_text(colour = "black"),
    axis.ticks = element_line(colour = "black"),
    axis.line.x = element_line(colour = "black"),
    axis.line.y = element_line(colour = "black"),
    axis.title = element_text(colour = "black", size = 14, face = "bold.italic"),
    strip.background = element_rect(colour = "black"),
    strip.text = element_text(colour = "black", face = "bold.italic", size = 12),
    plot.title = element_text(colour = "black", size = 20, face = "bold.italic"),
    panel.margin = unit(1, "lines"),
    legend.position="none"
)

## ----data_1, eval=FALSE--------------------------------------------------
## # iris dataset
## data(iris)

## ----data_2--------------------------------------------------------------
head(iris)

## ----aes-----------------------------------------------------------------
ggplot(iris, aes(x = Sepal.Width, y = Sepal.Length))

## ----layers--------------------------------------------------------------
# Scatterplot of the relationship between sepal length and sepal width with regression line
ggplot(iris, aes(x = Sepal.Width, y = Sepal.Length)) +
  geom_point() + # layer 1 
  stat_smooth(method = "lm", se = FALSE) # layer 2 

## ----scales--------------------------------------------------------------
# Map Species to colour in aes() and change the default colours of colour scale  
ggplot(iris, aes(x = Sepal.Width, y = Sepal.Length, colour = Species)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  scale_colour_brewer(palette="Set1")

## ----coord, fig.height= 4------------------------------------------------
# Change coordinate system 
ggplot(iris, aes(x = Sepal.Width, y = Sepal.Length, colour = Species)) +
  geom_point() +
  stat_smooth(method = "lm", se = FALSE) +
  scale_colour_brewer(palette="Set1") + 
  coord_equal()

## ----facets--------------------------------------------------------------
# Generate a plot for each iris species
ggplot(iris, aes(x = Sepal.Width, y = Sepal.Length, colour = Species)) +
  geom_point() +
  stat_smooth(method = "lm", se = FALSE) + 
  scale_colour_brewer(palette="Set1") +
  coord_equal() +
  facet_grid(. ~ Species)

## ----theme, fig.width= 8-------------------------------------------------
# Customize the appearance of the plot
ggplot(iris, aes(x = Sepal.Width, y = Sepal.Length, colour = Species)) +
  geom_point() +
  stat_smooth(method = "lm", se = FALSE) +
  scale_colour_brewer(palette="Set1") + 
  coord_equal() +
  facet_grid(. ~ Species) +
  ggtitle("Scatterplot of lenght and width of iris sepal by species") + 
  xlab("Sepal Length (cm)") +
  ylab("Sepal Width (cm)") +
  theme(plot.background = element_blank(),
    axis.text = element_text(colour = "black"),
    axis.ticks = element_line(colour = "black"),
    axis.line.x = element_line(colour = "black"),
    axis.line.y = element_line(colour = "black"),
    axis.title = element_text(colour = "black", size = 14, face = "bold.italic"),
    strip.background = element_rect(colour = "black"),
    strip.text = element_text(colour = "black", face = "bold.italic", size = 12),
    plot.title = element_text(colour = "black", size = 20, face = "bold.italic"),
    panel.margin = unit(1, "lines"),
    legend.position="none"
)

