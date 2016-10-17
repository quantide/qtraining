## ----intro_require_ggplot, message=FALSE---------------------------------
require(ggplot2)

## ---- fig.width= 8-------------------------------------------------------
# Load iris dataset
data(iris)
levels(iris$Species) <- c("Setosa", "Versicolor", "Virginica")

# Generate plot
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, colour = Species)) +
  geom_point() +
  facet_grid(. ~ Species) +
  stat_smooth(method = "lm", se = F, col = "darkslateblue") +
  scale_y_continuous(name = "Sepal Width (cm)", limits = c(2,5), expand = c(0,0)) +
  scale_x_continuous(name = "Sepal Length (cm)", limits = c(4,8), expand = c(0,0)) +
  scale_colour_brewer(palette = "Set1") + 
  coord_equal() + ggtitle("Scatterplot of lenght and width of iris sepal by species") +
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
# Scatterplot of the realtionship between sepal length and sepal width by iris species 
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, colour = Species)) +
  geom_point() 

## ------------------------------------------------------------------------
# Add a regression line to the plot
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, colour = Species)) +
  geom_point() +
  stat_smooth(method = "lm", se = F, col = "darkslateblue")

## ------------------------------------------------------------------------
# Change scale attributes 
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, colour = Species)) +
  geom_point() +
  stat_smooth(method = "lm", se = F, col = "darkslateblue") +
  scale_y_continuous(name = "Sepal Width (cm)", limits = c(2,5), expand = c(0,0)) +
  scale_x_continuous(name = "Sepal Length (cm)", limits = c(4,8), expand = c(0,0)) +
  scale_colour_brewer(palette = "Set1")

## ------------------------------------------------------------------------
# Generate a plot for each iris species
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, colour = Species)) +
  geom_point(alpha = 0.8) +
  stat_smooth(method = "lm", se = F, col = "darkslateblue") +
  scale_y_continuous(name = "Sepal Width (cm)", limits = c(2,5), expand = c(0,0)) +
  scale_x_continuous(name = "Sepal Length (cm)", limits = c(4,8), expand = c(0,0)) +
  scale_colour_brewer(palette = "Set1") + 
  facet_grid(. ~ Species)

## ------------------------------------------------------------------------
# change the cartesian coordinates of the plot axes
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, colour = Species)) +
  geom_point(alpha = 0.8) +
  stat_smooth(method = "lm", se = F, col = "darkslateblue") +
  scale_y_continuous(name = "Sepal Width (cm)", limits = c(2,5), expand = c(0,0)) +
  scale_x_continuous(name = "Sepal Length (cm)", limits = c(4,8), expand = c(0,0)) +
  scale_colour_brewer(palette = "Set1") +
  stat_smooth(method = "lm", se = F, col = "darkslateblue") + 
  facet_grid(. ~ Species) +
  coord_equal()

## ---- fig.width= 8-------------------------------------------------------
# Customize the appearance of the plot
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, colour = Species)) +
  geom_point(alpha = 0.8) +
  stat_smooth(method = "lm", se = F, col = "darkslateblue") +
  scale_y_continuous(name = "Sepal Width (cm)", limits = c(2,5), expand = c(0,0)) +
  scale_x_continuous(name = "Sepal Length (cm)", limits = c(4,8), expand = c(0,0)) +
  scale_colour_brewer(palette = "Set1") + 
  facet_grid(. ~ Species) +
  coord_equal() + 
  ggtitle("Scatterplot of lenght and width of iris sepal by species") +
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

