## ----intro_require_ggplot, message=FALSE---------------------------------
require(ggplot2)

## ---- fig.width= 8, echo=FALSE-------------------------------------------
# Load iris dataset
data(iris)

# Generate plot
ggplot(iris, aes(x = Sepal.Width, y = Sepal.Length, colour = Species)) +
  geom_point() +
  stat_smooth(method = "lm", se = F) +
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

## ------------------------------------------------------------------------
# iris dataset
head(iris)

## ------------------------------------------------------------------------
ggplot(iris, aes(x = Sepal.Width, y = Sepal.Length, colour = Species))

## ------------------------------------------------------------------------
# Scatterplot of the relationship between sepal length and sepal width with regression line
ggplot(iris, aes(x = Sepal.Width, y = Sepal.Length)) +
  geom_point() + # layer 1 
  stat_smooth(method = "lm", se = FALSE) # layer 2 

## ------------------------------------------------------------------------
# Add a scale scale (map Species to colour scale)
ggplot(iris, aes(x = Sepal.Width, y = Sepal.Length, colour = Species)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) 

## ----fig.height= 4-------------------------------------------------------
# Change coordinate system 
ggplot(iris, aes(x = Sepal.Width, y = Sepal.Length, colour = Species)) +
  geom_point() +
  stat_smooth(method = "lm", se = FALSE) +
  coord_equal()

## ------------------------------------------------------------------------
# Generate a plot for each iris species
ggplot(iris, aes(x = Sepal.Width, y = Sepal.Length, colour = Species)) +
  geom_point() +
  stat_smooth(method = "lm", se = FALSE) +
  coord_equal() +
  facet_grid(. ~ Species)

## ---- fig.width= 8-------------------------------------------------------
# Customize the appearance of the plot
ggplot(iris, aes(x = Sepal.Width, y = Sepal.Length, colour = Species)) +
  geom_point() +
  stat_smooth(method = "lm", se = FALSE) +
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

## ----intro_data_bands, message=FALSE-------------------------------------
require(qdata)
data(bands)
head(bands)

