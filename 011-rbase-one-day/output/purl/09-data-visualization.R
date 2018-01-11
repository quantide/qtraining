## ----load_ggplot2, message=FALSE-----------------------------------------
require(ggplot2)

## ----load_qdata, message=FALSE-------------------------------------------
require(qdata)

## ----complete_plot, echo=FALSE,fig.width = 7-----------------------------
# Load people dataset
data(people)

# Generate plot
ggplot(people, aes(x = Weight, y = Height, colour = Area)) +
  geom_point() +
  stat_smooth(method = "lm", se = F) +
  scale_colour_brewer(palette="Set1") +
  facet_grid(. ~ Area) +
  ggtitle("Scatterplot of weight and height of \n italian people by geographical area") + 
    xlab("Weight (kg)") +
    ylab("Height (cm)") +
  theme(plot.background = element_blank(),
    axis.line.x = element_line(colour = "black"),
    axis.line.y = element_line(colour = "black"),
    axis.title = element_text(colour = "black", size = 14, face = "bold.italic"),
    strip.background = element_rect(colour = "black"),
    strip.text = element_text(colour = "black", face = "bold.italic", size = 12),
    plot.title = element_text(colour = "black", size = 20, face = "bold.italic", hjust = 0.5),
    panel.spacing = unit(1, "lines"),
    legend.position="none")

## ----data_1, eval=FALSE--------------------------------------------------
## # people dataset
## data(people)

## ----data_2--------------------------------------------------------------
head(people)

## ----aes-----------------------------------------------------------------
ggplot(data = people, aes(x = Weight, y = Height))

## ----layers--------------------------------------------------------------
# Scatterplot of the relationship between weight and height with regression line
ggplot(people, aes(x = Weight, y = Height)) +
  geom_point() + # layer 1 (draw points)
  stat_smooth(method = "lm", se = FALSE) # layer 2 (draw regression line) 

## ----scales--------------------------------------------------------------
# map Area to colour in aes() and change the default colours of colour scale  
ggplot(people, aes(x = Weight, y = Height, colour = Area)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  scale_colour_brewer(palette="Set1")

## ----facets, fig.width = 7-----------------------------------------------
# Generate a plot for each geographical area
ggplot(people, aes(x = Weight, y = Height, colour = Area)) +
  geom_point() +
  stat_smooth(method = "lm", se = FALSE) + 
  scale_colour_brewer(palette="Set1") +
  facet_grid(. ~ Area)

## ----theme, fig.width = 8------------------------------------------------
# Customize the appearance of the plot
ggplot(people, aes(x = Weight, y = Height, colour = Area)) +
  geom_point() +
  stat_smooth(method = "lm", se = F) +
  scale_colour_brewer(palette="Set1") +
  facet_grid(. ~ Area) +
  ggtitle("Scatterplot of weight and height of \n italian people by geographical area") + 
    xlab("Weight (kg)") +
    ylab("Height (cm)") +
  theme(plot.background = element_blank(),
    axis.line.x = element_line(colour = "black"),
    axis.line.y = element_line(colour = "black"),
    axis.title = element_text(colour = "black", size = 14, face = "bold.italic"),
    strip.background = element_rect(colour = "black"),
    strip.text = element_text(colour = "black", face = "bold.italic", size = 12),
    plot.title = element_text(colour = "black", size = 20, face = "bold.italic", hjust = 0.5),
    panel.spacing = unit(1, "lines"),
    legend.position="none")

## ----barplot-------------------------------------------------------------
# base plot: key building blocks (data, aes, layer)
ggplot(data = people, mapping = aes(x = Area)) + 
  geom_bar(fill = "royalblue", colour = "black", width = 0.5)

## ----histogram-----------------------------------------------------------
# base plot: key building blocks (data, aes, layer)
ggplot(data=people, mapping=aes(x=Weight)) +
  geom_histogram(fill="#00cc66", colour= "#000000", binwidth=5) 

## ----boxplot-------------------------------------------------------------
# base plot: key building blocks (data, aes, layer)
ggplot(data=people, aes(x=Area, y=Weight)) + 
  geom_boxplot(fill="gold", colour="darkorange") 

## ----load_orange_dataset-------------------------------------------------
data(orange)
head(orange)

## ----lineplot, message=FALSE---------------------------------------------
require(dplyr)
# base plot of 1 tree: key components(data, aes, layer)
ggplot(data=orange %>% filter(Tree==1), mapping=aes(x=age, y=circumference)) + 
  geom_line(colour= "#990033", size=1.3)

