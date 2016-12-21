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
  stat_smooth(method = "lm", se = FALSE) +
  scale_colour_brewer(palette="Set1") + 
  coord_equal() +
  facet_grid(. ~ Area) +
  ggtitle("Scatterplot of weight and height of \n italian people by geographical area") + # set title
    xlab("Weight (kg)") + # set x axis title
    ylab("Height (cm)") + # set y axis title
  theme(plot.background = element_blank(), # customize plot background
    axis.text = element_text(colour = "black"), # customize axes text
    axis.ticks = element_line(colour = "black"), # customize axes ticks
    axis.line.x = element_line(colour = "black"), # customize x axis line
    axis.line.y = element_line(colour = "black"), # customize y axis line
    axis.title = element_text(colour = "black", size = 14, face = "bold.italic"), # customize axes titles
    strip.background = element_rect(colour = "black"), # customize background of facet labels
    strip.text = element_text(colour = "black", face = "bold.italic", size = 12), # customize facet labels
    plot.title = element_text(colour = "black", size = 20, face = "bold.italic", hjust = 0.5), # customize plot title
    panel.spacing = unit(1, "lines"), # customize panels spacing
    legend.position = "none") # remove the legend

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

## ----coord, fig.width = 7------------------------------------------------
# Generate a plot for each geographical area
ggplot(people, aes(x = Weight, y = Height, colour = Area)) +
  geom_point() +
  stat_smooth(method = "lm", se = FALSE) + 
  scale_colour_brewer(palette="Set1") +
  coord_equal() 

## ----facets, fig.width = 7-----------------------------------------------
# Generate a plot for each geographical area
ggplot(people, aes(x = Weight, y = Height, colour = Area)) +
  geom_point() +
  stat_smooth(method = "lm", se = FALSE) + 
  scale_colour_brewer(palette="Set1") +
  coord_equal() +
  facet_grid(. ~ Area)

## ----theme, fig.width = 8------------------------------------------------
# Customize the appearance of the plot
ggplot(people, aes(x = Weight, y = Height, colour = Area)) +
  geom_point() +
  stat_smooth(method = "lm", se = FALSE) +
  scale_colour_brewer(palette="Set1") + 
  coord_equal() +
  facet_grid(. ~ Area) +
  ggtitle("Scatterplot of weight and height of \n italian people by geographical area") + # set title
    xlab("Weight (kg)") + # set x axis title
    ylab("Height (cm)") + # set y axis title
  theme(plot.background = element_blank(), # customize plot background
    axis.text = element_text(colour = "black"), # customize axes text
    axis.ticks = element_line(colour = "black"), # customize axes ticks
    axis.line.x = element_line(colour = "black"), # customize x axis line
    axis.line.y = element_line(colour = "black"), # customize y axis line
    axis.title = element_text(colour = "black", size = 14, face = "bold.italic"), # customize axes titles
    strip.background = element_rect(colour = "black"), # customize background of facet labels
    strip.text = element_text(colour = "black", face = "bold.italic", size = 12), # customize facet labels
    plot.title = element_text(colour = "black", size = 20, face = "bold.italic", hjust = 0.5), # customize plot title
    panel.spacing = unit(1, "lines"), # customize panels spacing
    legend.position = "none") # remove the legend

## ----barplot_1-----------------------------------------------------------
# base plot: key building blocks (data, aes, layer)
ggplot(data = people, mapping = aes(x = Area)) + 
  geom_bar(fill = "royalblue", colour = "black", width = 0.5)

## ----barplot_2-----------------------------------------------------------
# customized plot: key building blocks + scales + theme
ggplot(data = people, mapping = aes(x = Area, fill = Gender)) + # map Gender to fill scale
  geom_bar(position = "dodge", width = 0.8, colour="black") + # customize bar positions
       scale_fill_brewer(palette = "Accent") + # customize fill scale 
       ggtitle("Barplot of Area by Gender") + # set title
       theme(axis.title.y = element_text(size = rel(1.5), angle = 90), # customize y axis title
             axis.title.x = element_text(size = rel(1.5)), # customize x axis title
             axis.text.x = element_text(colour="black"), # customize x axis text
             plot.title = element_text(size = rel(2)), # customize plot title
             legend.title = element_text(size = rel(1.5)))  # customize legend title

## ----histogram_1---------------------------------------------------------
# base plot: key building blocks (data, aes, layer)
ggplot(data=people, mapping=aes(x=Weight)) +
  geom_histogram(fill="#00cc66", colour= "#000000", binwidth=5) 

## ----histogram_2---------------------------------------------------------
# customized plot: key building blocks + scales + facet + theme
ggplot(data=people, mapping=aes(x=Weight)) +
  geom_histogram(mapping=aes(fill=Area), binwidth=5, colour="black") + # map Area to fill scale 
  scale_fill_manual(values = c("#70D6FF", "#FF70A6", "#FF9770", "#E9FF70")) + # customize fill scale 
  facet_wrap( ~ Area) + # generate a panel for each Area level
  theme(axis.text = element_text(colour = "black"), # customize axes text
    axis.ticks = element_line(colour = "black"), # customize axes
    axis.title = element_text(colour = "black", size = 14, face = "bold.italic"), # customize axes title
    strip.background = element_rect(colour = "black", fill=), # customize background of facet labels
    strip.text = element_text(colour = "black", face = "bold.italic", size = 12), # customize facet labels
    plot.title = element_text(colour = "black", size = 20, face = "bold.italic"), # customize plot title
    legend.position = "none") # remove legend

## ----boxplot_1-----------------------------------------------------------
# base plot: key building blocks (data, aes, layer)
ggplot(data=people, aes(x=Area, y=Weight)) + 
  geom_boxplot(fill="gold", colour="darkorange") 

## ----boxplot_2-----------------------------------------------------------
# customized plot: key building blocks + scale + layer (stat) + theme 
ggplot(data=people, aes(x=Area, y=Weight, fill=Gender)) + # map Gender to fill 
  geom_boxplot(outlier.size = 1.5, outlier.shape = 21, width = .5) + 
  stat_summary(fun.y = "mean", geom = "point", shape = 23, size = 2, fill = "red") + # compute and plot distributions means  
  ggtitle("Boxplot of Weight by Area and Gender") + # set title
  theme_classic() # change theme

## ----load_orange_dataset-------------------------------------------------
data(orange)
head(orange)

## ----lineplot_1, message=FALSE-------------------------------------------
require(dplyr)
# base plot of 1 tree: key components(data, aes, layer)
ggplot(data=orange %>% filter(Tree==1), mapping=aes(x=age, y=circumference)) + 
  geom_line(colour= "#990033", size=1.3)

## ----lineplot_2, message=FALSE-------------------------------------------
# customized plot of 5 trees: key components(data, aes, layer) + scales + theme
ggplot(data=Orange, mapping=aes(x=age, y=circumference, colour=Tree)) + # Map Tree to colour scale
  geom_line(mapping=aes(linetype=Tree)) + # Map Tree to linetype scale
  scale_colour_manual(values = c("palegreen", "green", "mediumseagreen", "forestgreen" ,"darkgreen")) + # customize colours
  ylim(0,250) + xlim(0,1600) + # set axis limits 
  ggtitle("Lineplot of Orange Tree Growth") + # set title
  xlab("Age") + ylab("Circumference") + # set axes titles
  theme(axis.text = element_text(colour = "black"), # customize axis text
  axis.ticks = element_line(colour = "black"), # customize axis ticks
  axis.title = element_text(colour = "black", size = 14, face = "bold"), # customize axes title
  plot.title = element_text(colour = "black", size = 20, face = "bold"), # customize plot title
  legend.text = element_text(colour="black", size=10), # customize legend text
  legend.title = element_text(colour = "black", size = 14, face = "bold")) # customize legend title

