---
output:
  pdf_document: default
  html_document: default
---

# Data Visualization with R





\includegraphics[width=3.33in]{images/flow-dtvisual} 


Visualizing data is crucial in today's world. Without powerful visualizations, it is almost impossible to create and narrate stories on data. These stories help us build strategies and make intelligent business decisions. 

`ggplot2` is a data visualization package which has become a synonym for data visualization in R. 


```r
require(ggplot2)
```

Created by Hadley Wickham in 2005, `ggplot2` is an implementation of Leland Wilkinson's Grammar of Graphics, a general scheme for data visualization which breaks up graphs into semantic independent components, such as scales and layers, that can be composed in many different ways. This makes `ggplot2` very powerful, because there are no limitations due to a set of pre-specified graphics, so it is possible to create new graphics that are precisely tailored for the problem in analysis. 

## An overview of `ggplot2` grammar 

Let us consider `people` dataset, included in `qdata` package. `people` dataset contains informations about weight, height, gender and geographical area of 300 italian people.  


```r
require(qdata)
```

Suppose we want to visualize the relationship between weight and height of italian people according to the different geographical area, by using a **scatterplot**: 

![](09-data-visualization_files/figure-latex/complete_plot-1.pdf)<!-- --> 

The previous plot is composed of building blocks that are added to the plot one after the other.   

The complete scheme of the most important building blocks of `ggplot2` grammar is displayed in the following figure:


\includegraphics[width=4.63in]{images/schema-layer-ggplot2-mod} 



The scheme must be read from bottom to top. Starting from bottom, the first three building blocks (<b> <span style="color:#FFBF00">Data</span> </b>, <b> <span style="color:#FF8000">Aestethic Mappings</span> </b> and <b> <span style="color:#FF0000">Layers</span> </b>) are fundamental to build a simple plot, indeed they are called 
__"key"__ building blocks. The remaining building blocks (<b> <span style="color:#9A2EFE">Scales</span> </b>, <b> <span style="color:#08298A">Coordinates</span> </b>, <b> <span style="color:#2E9AFE">Facets</span> </b> and <b> <span style="color:#01DF01">Themes</span> </b>) allow us to build a complex plot and to customize it; their use and order is not compulsory. 


Let us briefly describe the task of each element of the scheme and how it helps build the previous plot: 

1. <b> <span style="color:#FFBF00">Data</span> </b>: the dataset that we want to visualize


\includegraphics[width=3.43in]{images/schema-layer-ggplot2-data} 



```r
# people dataset
data(people)
```


```r
head(people)
```

```
## # A tibble: 6 × 4
##   Gender   Area Weight Height
##   <fctr> <fctr>  <int>  <int>
## 1 Female  Isole     54    168
## 2 Female   Nord     61    171
## 3   Male    Sud     68    170
## 4 Female   Nord     52    164
## 5   Male   Nord     75    181
## 6   Male   Nord     77    178
```


2. <b> <span style="color:#FF8000">Aestethic Mappings</span> </b>: describes how variables in the data are mapped to aestethic attributes that you can perceive 


\includegraphics[width=4.83in]{images/schema-layer-ggplot2-aes} 



| Gender | Area | Weight | Height | 
|--------|--------|:--------:|:--------:|
|  |  | x | y |



```r
ggplot(data = people, aes(x = Weight, y = Height))
```

![](09-data-visualization_files/figure-latex/aes-1.pdf)<!-- --> 

3. <b> <span style="color:#FF0000">Layers</span> </b>: are made up by geometric elements and statistical transformations. In details, geometric objects (`geom`s) represent what we actually see on the plot: points, lines, polygons, etc. Statistical transformations (`stat`s) summarise data in many useful ways. For example, binning and counting observations to create an histogram, or summarising a 2d relationship with a linear model.       


\includegraphics[width=4.72in]{images/schema-layer-ggplot2-layer} 



```r
# Scatterplot of the relationship between weight and height with regression line
ggplot(people, aes(x = Weight, y = Height)) +
  geom_point() + # layer 1 (draw points)
  stat_smooth(method = "lm", se = FALSE) # layer 2 (draw regression line) 
```

![](09-data-visualization_files/figure-latex/layers-1.pdf)<!-- --> 


4. <b> <span style="color:#9A2EFE">Scales</span> </b>: map values in the data space to values in an aesthetic space, whether it be colour, or size or shape. Scales draw a legend on axes, which provide an inverse mapping to make it possible to read the original data values from the graph. Scales are closely related to aestethics mapped.


\includegraphics[width=4.61in]{images/schema-layer-ggplot2-scales} 



```r
# map Area to colour in aes() and change the default colours of colour scale  
ggplot(people, aes(x = Weight, y = Height, colour = Area)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  scale_colour_brewer(palette="Set1")
```

![](09-data-visualization_files/figure-latex/scales-1.pdf)<!-- --> 


5. <b> <span style="color:#2E9AFE">Facets</span> </b>: describes how to break up the data into subset and how to display those subsets as small multiples. 


\includegraphics[width=4.61in]{images/schema-layer-ggplot2-facet} 



```r
# Generate a plot for each geographical area
ggplot(people, aes(x = Weight, y = Height, colour = Area)) +
  geom_point() +
  stat_smooth(method = "lm", se = FALSE) + 
  scale_colour_brewer(palette="Set1") +
  facet_grid(. ~ Area)
```

![](09-data-visualization_files/figure-latex/facets-1.pdf)<!-- --> 

6. <b> <span style="color:#01DF01">Themes</span> </b>: controls all non-data elements of the plot, like the font size, background colour, etc.


\includegraphics[width=4.63in]{images/schema-layer-ggplot2-mod} 



```r
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
```

![](09-data-visualization_files/figure-latex/theme-1.pdf)<!-- --> 

\clearpage

## Other plot types

The building block scheme previously seen can help us understanding how to build other plot types. We will focus on the first three building blocks of the scheme (data, aestethic mappings and layers).

* __Barplot__, which is used to show the count of each case of a categorial variable. Suppose we want to analyze the count of people by geographical area: 


```r
# base plot: key building blocks (data, aes, layer)
ggplot(data = people, mapping = aes(x = Area)) + 
  geom_bar(fill = "royalblue", colour = "black", width = 0.5)
```

![](09-data-visualization_files/figure-latex/barplot-1.pdf)<!-- --> 

* __Histogram__, which is used to summarize a continuous variable into classes. Suppose we want to analyze the distribution of people weight: 


```r
# base plot: key building blocks (data, aes, layer)
ggplot(data=people, mapping=aes(x=Weight)) +
  geom_histogram(fill="#00cc66", colour= "#000000", binwidth=5) 
```

![](09-data-visualization_files/figure-latex/histogram-1.pdf)<!-- --> 

\clearpage

* __Boxplot__, which is used to draw a data distribution. Supposing you are interested in the differences of weight accordingly to geographical area:


```r
# base plot: key building blocks (data, aes, layer)
ggplot(data=people, aes(x=Area, y=Weight)) + 
  geom_boxplot(fill="#74a9cf", colour="#034e7b") 
```

![](09-data-visualization_files/figure-latex/boxplot-1.pdf)<!-- --> 

* __Lineplot__, used to display how one continuous variable, on the y-axis, changes in relation to another continuous variable, on the x-axis. 
    For this example we consider `orange` data, included in `qdata` package. `orange` contains information about the growth of 5 Orange Trees, according to their trunk circumferences. 


```r
data(orange)
head(orange)
```

```
##   Tree  age circumference
## 1    1  118            30
## 2    1  484            58
## 3    1  664            87
## 4    1 1004           115
## 5    1 1231           120
## 6    1 1372           142
```
  
  Suppose we want to represent the growth of one tree:
  

```r
require(dplyr)
# base plot of 1 tree: key components(data, aes, layer)
ggplot(data=orange %>% filter(Tree==1), mapping=aes(x=age, y=circumference)) + 
  geom_line(colour= "#990033", size=1.3)
```

![](09-data-visualization_files/figure-latex/lineplot-1.pdf)<!-- --> 
