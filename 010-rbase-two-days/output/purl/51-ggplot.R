## ----first, message=FALSE------------------------------------------------
require(dplyr)
require(ggplot2)
require(qdata)
data(bands)

## ----scatterplot_first, message=FALSE, warning=FALSE---------------------
ggplot(data=bands, mapping=aes(x=humidity, y=viscosity)) + geom_point()

## ----scatterplot_geompoint, message=FALSE, warning=FALSE-----------------
ggplot() + geom_point(data=bands, mapping=aes(x=humidity, y=viscosity))

## ----scatterplot_assignment1, message=FALSE, warning=FALSE---------------
gp1 <- ggplot(data=bands, mapping=aes(x=humidity, y=viscosity)) + geom_point() 

## ----scatterplot_assignment2, message=FALSE, warning=FALSE---------------
gp1

## ----scatterplot_assignment3, message=FALSE, warning=FALSE---------------
gp2 <- gp1 + geom_hline(yintercept = 50)
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

## ----scatterplot_map_four_variables, message=FALSE, warning=FALSE--------
ggplot(data=bands, mapping=aes(x=humidity, y=viscosity, size=ink_pct, colour=band_type)) +
  geom_point()

## ----linegraph_first, message=FALSE--------------------------------------
ggplot(data=(ChickWeight %>% filter(Chick==1)), mapping=aes(x=Time, y=weight)) + geom_line()

## ----linegraph_geompoint, message=FALSE----------------------------------
ggplot(data=(ChickWeight %>% filter(Chick==1)), mapping=aes(x=Time, y=weight)) + geom_line() + geom_point()

## ----linegraph_set, message=FALSE----------------------------------------
ggplot(data=(ChickWeight %>% filter(Chick==1)), mapping=aes(x=Time, y=weight)) +
  geom_line(colour="darkblue") + geom_point(shape=15, size=2)

## ----linegraph_linetype, message=FALSE-----------------------------------
ggplot(data=(ChickWeight %>% filter(Chick==1)), mapping=aes(x=Time, y=weight)) +
  geom_line(colour="darkblue", linetype=2)

## ----linegraph_ChickWeightMean, message=FALSE----------------------------
ChickWeightMean <- ChickWeight %>% group_by(Time, Diet) %>% summarize(weight=mean(weight))
ChickWeightMean

## ----linegraph__sawtooth, message=FALSE----------------------------------
ggplot(data=ChickWeightMean, mapping=aes(x=Time, y=weight)) +
  geom_line() + geom_point()

## ----linegraph_aes, message=FALSE----------------------------------------
ggplot(data=ChickWeightMean, mapping=aes(x=Time, y=weight, colour=Diet)) +
  geom_line() + geom_point()

## ----bargraph_first, message=FALSE---------------------------------------
ggplot(data=ChickWeight, mapping=aes(x=Diet)) + geom_bar()

## ----bargraph_coordflip, message=FALSE-----------------------------------
ggplot(data=ChickWeight, mapping=aes(x=Diet)) + geom_bar() + coord_flip()

## ----bargraph_width, message=FALSE---------------------------------------
ggplot(data=ChickWeight, mapping=aes(x=Diet)) + geom_bar(width=0.5)

## ----bargraph_setcolour, message=FALSE-----------------------------------
ggplot(data=ChickWeight, mapping=aes(x=Diet)) +
  geom_bar(fill=c("#74a9cf", "#3690c0", "#0570b0", "#034e7b"))

## ----bargraph_mapping, message=FALSE-------------------------------------
ggplot(data=ChickWeight, mapping=aes(x=Diet)) +
  geom_bar(mapping=aes(fill=Diet))

## ----bargraph_ChickWeightFreq, message=FALSE-----------------------------
ChickWeightFreq <- ChickWeight %>% group_by(Diet) %>% summarize(n=n())
ChickWeightFreq

## ----bargraph_error, message=FALSE---------------------------------------
ggplot(data=ChickWeightFreq, mapping=aes(x=Diet)) + geom_bar()

## ----bargraph_identity, message=FALSE------------------------------------
ggplot(data=ChickWeightFreq, mapping=aes(x=Diet, y=n)) + geom_bar(stat="identity")

## ----bargraph_stack, message=FALSE---------------------------------------
ggplot(data=bands, mapping=aes(x=press_type, fill=cylinder_size)) + geom_bar()

## ----bargraph_fill, message=FALSE----------------------------------------
ggplot(data=bands, mapping=aes(x=press_type, fill=cylinder_size)) + geom_bar(position="fill")

## ----bargraph_dodge, message=FALSE---------------------------------------
ggplot(data=bands, mapping=aes(x=press_type, fill=cylinder_size)) + geom_bar(position="dodge")

## ----histogram_first, message=FALSE, warning=FALSE-----------------------
ggplot(data=bands, mapping=aes(x=ink_pct)) + geom_histogram()

## ----histogram_aes, message=FALSE, warning=FALSE-------------------------
ggplot(data=bands, mapping=aes(x=ink_pct)) + geom_histogram(fill="#2B4C6F", colour="#3690c0")

## ----histogram_bins, message=FALSE, warning=FALSE------------------------
ggplot(data=bands, mapping=aes(x=ink_pct)) + geom_histogram(fill="#2B4C6F", colour="#3690c0", bins=6)

## ----histogram_binwidth, message=FALSE, warning=FALSE--------------------
ggplot(data=bands, mapping=aes(x=ink_pct)) + geom_histogram(fill="#2B4C6F", colour="#3690c0", binwidth=7)

## ----histogram_mapping, message=FALSE, warning=FALSE---------------------
ggplot(data=bands, mapping=aes(x=ink_pct)) +
  geom_histogram(mapping=aes(fill=proof_on_ctd_ink))

## ----histogram_mapping_hide, message=FALSE, warning=FALSE----------------
ggplot(data=bands, mapping=aes(x=ink_pct)) +
  geom_histogram(mapping=aes(fill=press_type))

## ----histogram_facetgrid_col, message=FALSE, warning=FALSE---------------
ggplot(data=bands, mapping=aes(x=ink_pct)) +
  geom_histogram(fill="#2B4C6F") +
  facet_grid(. ~ press_type)

## ----histogram_facetgrid_row, message=FALSE, warning=FALSE---------------
ggplot(data=bands, mapping=aes(x=ink_pct)) +
  geom_histogram(fill="#2B4C6F") +
  facet_grid(type_on_cylinder ~ .)

## ----histogram_facetgrid_row_col, message=FALSE, warning=FALSE-----------
ggplot(data=bands, mapping=aes(x=ink_pct)) +
  geom_histogram(fill="#2B4C6F") +
  facet_grid(type_on_cylinder ~ press_type)

## ----boxplot_first, message=FALSE, warning=FALSE-------------------------
ggplot(data=bands, aes(x=press_type, y=ink_pct)) + 
  geom_boxplot(fill="#3690c0")

## ----boxplot_colour, message=FALSE, warning=FALSE------------------------
ggplot(data=bands, aes(x=press_type, y=ink_pct)) + 
  geom_boxplot(fill="#74a9cf", colour="#034e7b")

## ----boxplot_outlines, message=FALSE, warning=FALSE----------------------
ggplot(data=bands, aes(x=press_type, y=ink_pct)) + 
  geom_boxplot(fill="#74a9cf", colour="#034e7b", outlier.colour="red", outlier.shape=18, outlier.size=3)

## ----boxplot_ylab, message=FALSE, warning=FALSE--------------------------
ggplot(data=bands, aes(x=press_type, y=ink_pct)) + 
  geom_boxplot(fill="#74a9cf", colour="#034e7b") +
  xlab("Press type") + ylab ("Ink %") + ggtitle("Distribution\n(bands data set)")

## ----boxplot_axis_ticks, message=FALSE, warning=FALSE--------------------
ggplot(data=bands, aes(x="0", y=ink_pct)) + 
  geom_boxplot(fill="#74a9cf", colour="#034e7b") +
  xlab("Press type") + ylab ("Ink %") + ggtitle("Distribution\n(bands data set)") +
  theme(axis.ticks.x = element_line(colour="green", size=4), axis.ticks.y=element_line(colour="red"))

## ----boxplot_axis_text, message=FALSE, warning=FALSE---------------------
ggplot(data=bands, aes(x=press_type, y=ink_pct)) + 
  geom_boxplot(fill="#74a9cf", colour="#034e7b") +
  xlab("Press type") + ylab ("Ink %") + ggtitle("Distribution\n(bands data set)") +
  theme(axis.text = element_text(face="bold", colour="#034e7b"))

## ----boxplot_axis_title, message=FALSE, warning=FALSE--------------------
ggplot(data=bands, aes(x=press_type, y=ink_pct)) + 
  geom_boxplot(fill="#74a9cf", colour="#034e7b") +
  xlab("Press type") + ylab ("Ink %") + ggtitle("Distribution\n(bands data set)") +
  theme(axis.title = element_text(face="italic", colour="#034e7b"))

## ----boxplot_plot_title, message=FALSE, warning=FALSE--------------------
ggplot(data=bands, aes(x=press_type, y=ink_pct)) + 
  geom_boxplot(fill="#74a9cf", colour="#034e7b") +
  xlab("Press type") + ylab ("Ink %") + ggtitle("Distribution\n(bands data set)") +
  theme(plot.title = element_text(face="bold", size=18))

