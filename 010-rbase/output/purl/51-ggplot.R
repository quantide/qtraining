## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples
if(! "dplyr" %in% installed.packages()) {install.packages("dplyr")}
require(dplyr)
if(! "ggplot2" %in% installed.packages()) {install.packages("ggplot2")}
require(ggplot2)
if(! "qdata" %in% installed.packages()) {install.packages("~/gdrive/quantide/int/corsi/corsiR/00-qdata/pkgs/qdata_0.16.tar.gz", repos = NULL, type = "source")}
require(qdata)
data(bands)
if(! "gridExtra" %in% installed.packages()) {install.packages("gridExtra")}

## ---- eval=FALSE---------------------------------------------------------
## require(ggplot2)

## ----scatterplot_first, message=FALSE, warning=FALSE---------------------
ggplot(data=bands, mapping=aes(x=humidity, y=viscosity)) + geom_point()

## ----scatterplot_geompoint, message=FALSE, warning=FALSE-----------------
ggplot() + geom_point(data=bands, mapping=aes(x=humidity, y=viscosity))

## ----scatterplot_geomsmooth, message=FALSE, warning=FALSE----------------
ggplot(data=bands, mapping=aes(x=humidity, y=viscosity)) + geom_point() +  geom_smooth(method="loess")

## ----scatterplot_noinherit, message=FALSE, warning=FALSE-----------------
ggplot() + geom_point(data=bands, mapping=aes(x=humidity, y=viscosity)) + geom_smooth(method="loess")

## ----scatterplot_settinggeoms, message=FALSE, warning=FALSE--------------
ggplot() + 
  geom_point(data=bands, mapping=aes(x=humidity, y=viscosity)) +
  geom_smooth(data=bands, mapping=aes(x=humidity, y=viscosity), method="loess")

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

## ----linegraph_tg, message=FALSE-----------------------------------------
tg <- ToothGrowth %>% group_by(supp, dose) %>% summarize(length=mean(len))
tg

## ----linegraph_numericx, message=FALSE-----------------------------------
ggplot(data=tg, mapping=aes(x=dose, y=length, colour=supp)) +
  geom_line() + geom_point()

## ----linegraph_factorx, message=FALSE------------------------------------
ggplot(data=tg, mapping=aes(x=factor(dose), y=length, colour=supp, group=supp)) +
  geom_line() + geom_point()

## ----linegraph_group1, message=FALSE-------------------------------------
ggplot(data=(tg%>%filter(supp=="OJ")), mapping=aes(x=factor(dose), y=length, group=1)) +
  geom_line() + geom_point()

## ----linegraph_dodge, message=FALSE--------------------------------------
ggplot(data=tg, mapping=aes(x=factor(dose), y=length, colour=supp, group=supp)) +
  geom_line(position=position_dodge(0.15)) + geom_point(position=position_dodge(0.15))

## ----linegraph_labels, message=FALSE-------------------------------------
ChickWeightMean <- ChickWeightMean %>% mutate(Diet = factor(Diet, levels=1:4, labels=c("A","B","C","D")))

## ----linegraph_setcolourmanual, message=FALSE----------------------------
ggplot(data=ChickWeightMean, mapping=aes(x=Time, y=weight, colour=Diet)) +
  geom_line() + geom_point() + scale_color_manual(values=c("red", "blue", "green", "orange"))

## ----linegraph_setcolourmanual_order, message=FALSE----------------------
ggplot(data=ChickWeightMean, mapping=aes(x=Time, y=weight, colour=Diet)) +
  geom_line() + geom_point() + 
  scale_color_manual(values=c("D"="orange", "B"="blue", "A"="red", "C"="green"))

## ----linegraph_setshape_order, message=FALSE-----------------------------
ggplot(data=ChickWeightMean, mapping=aes(x=Time, y=weight, colour=Diet)) +
  geom_line(mapping=aes(linetype=Diet)) + geom_point(mapping=aes(shape=Diet)) + 
  scale_color_manual(values=c("D"="orange", "B"="blue", "A"="red", "C"="green")) +
  scale_shape_manual(values=c(16,18,20,22)) + 
  scale_linetype_manual(values=c(1,3,5,6))

## ----linegraph_ChickWeightGrowthMean, message=FALSE----------------------
ChickWeightGrowth <- ChickWeight %>% group_by(Chick) %>%
  mutate(growth=c(0,diff(weight))) %>% filter(growth != 0)
  
ChickWeightGrowthMean <- ChickWeightGrowth %>% group_by(Time, Diet) %>%
  summarize(growth=mean(growth)) 

ggp <- ggplot(data=ChickWeightGrowthMean, mapping=aes(x=Time, y=growth, colour=Diet)) +
  geom_line(mapping=aes(linetype=Diet)) + geom_point(mapping=aes(shape=Diet))

ggp

## ----linegraph_hline, message=FALSE--------------------------------------
growth_avg <- ChickWeightGrowth %>% magrittr::use_series(growth) %>% mean
ggp1 <- ggp + geom_hline(yintercept = growth_avg, colour="grey20")
ggp1

## ----linegraph_vline, message=FALSE--------------------------------------
ggp1 + geom_vline(xintercept = c(7,14,21), colour="grey40", linetype=3)

## ----bargraph_first, message=FALSE---------------------------------------
ggplot(data=ChickWeight, mapping=aes(x=Diet)) + geom_bar()

## ----bargraph_coordflip, message=FALSE-----------------------------------
ggplot(data=ChickWeight, mapping=aes(x=Diet)) + geom_bar() + coord_flip()

## ----bargraph_width, message=FALSE---------------------------------------
ggplot(data=ChickWeight, mapping=aes(x=Diet)) + geom_bar(width=0.5)

## ----bargraph_setcolour, message=FALSE-----------------------------------
ggplot(data=ChickWeight, mapping=aes(x=Diet)) +
  geom_bar(fill=c("#74a9cf", "#3690c0", "#0570b0", "#034e7b"))

## ----bargraph_scalefill, message=FALSE-----------------------------------
ggplot(data=ChickWeight, mapping=aes(x=Diet)) +
  geom_bar(mapping=aes(fill=Diet)) +
  scale_fill_manual(values=c("#74a9cf", "#3690c0", "#0570b0", "#034e7b"))

## ----bargraph_mapping, message=FALSE-------------------------------------
ggplot(data=ChickWeight, mapping=aes(x=Diet)) +
  geom_bar(mapping=aes(fill=Diet))

## ----bargraph_nolegend_scale, message=FALSE------------------------------
ggplot(data=ChickWeight, mapping=aes(x=Diet)) +
  geom_bar(mapping=aes(fill=Diet)) +
  scale_fill_manual(values=c("#74a9cf", "#3690c0", "#0570b0", "#034e7b"), guide=FALSE)

## ----bargraph_nolegend_guides, message=FALSE-----------------------------
ggplot(data=ChickWeight, mapping=aes(x=Diet)) +
  geom_bar(mapping=aes(fill=Diet)) +
  scale_fill_manual(values=c("#74a9cf", "#3690c0", "#0570b0", "#034e7b")) +
  guides(fill=FALSE)

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

## ----bargraph_manualdodge, message=FALSE---------------------------------
ggplot(data=bands, mapping=aes(x=press_type, fill=cylinder_size)) +
  geom_bar(position=position_dodge(0.85), width=0.6)

## ----bargraph_bands_freq_na, message=FALSE-------------------------------
bands_freq_na <- bands %>% group_by(press_type, cylinder_size) %>% summarise(n = n()) %>%
  right_join(
    expand.grid(
      press_type = bands %>% magrittr::use_series(press_type) %>% levels,
      cylinder_size = c(bands %>% magrittr::use_series(cylinder_size) %>% levels, NA)
    )
  )
bands_freq_na

## ----bargraph_stack_na, message=FALSE------------------------------------
ggplot(data=bands_freq_na, mapping=aes(x=press_type, y=n, fill=cylinder_size)) +
  geom_bar(stat="identity", position="dodge")

## ----bargraph_geomtext, message=FALSE------------------------------------
bands_freq <- bands %>% group_by(press_type) %>% summarize(n=n())
  
ggplot(data=bands, mapping=aes(x=press_type)) +
  geom_bar() +
  geom_text(data=bands_freq, mapping=aes(y=n, label=n), vjust=1.5, colour="white")

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

## ----histogram_facetwrap, message=FALSE, warning=FALSE-------------------
ggplot(data=bands, mapping=aes(x=ink_pct)) +
  geom_histogram(fill="#2B4C6F") +
  facet_wrap(~ press_type)

## ----histogram_facetwrap_fill, message=FALSE, warning=FALSE--------------
ggplot(data=bands, mapping=aes(x=ink_pct)) +
  geom_histogram(mapping=aes(fill=press_type)) +
  guides(fill=FALSE) +
  facet_wrap(~ press_type)

## ----histogram_density, message=FALSE, warning=FALSE---------------------
ggplot(data=bands, mapping=aes(x=ink_pct, y=..density..)) +
  geom_histogram(fill="#74a9cf")

## ----histogram_geomdensity, message=FALSE, warning=FALSE-----------------
ggplot(data=bands, mapping=aes(x=ink_pct, y=..density..)) +
  geom_histogram(fill="#74a9cf") + geom_density(colour="#034e7b")

## ----histogram_geomline_density, message=FALSE, warning=FALSE------------
ggplot(data=bands, mapping=aes(x=ink_pct, y=..density..)) +
  geom_histogram(fill="#74a9cf") + geom_line(stat="density", colour="#034e7b")

## ----boxplot_first, message=FALSE, warning=FALSE-------------------------
ggplot(data=bands, aes(x=press_type, y=ink_pct)) + 
  geom_boxplot(fill="#3690c0")

## ----boxplot_colour, message=FALSE, warning=FALSE------------------------
ggplot(data=bands, aes(x=press_type, y=ink_pct)) + 
  geom_boxplot(fill="#74a9cf", colour="#034e7b")

## ----boxplot_outlines, message=FALSE, warning=FALSE----------------------
ggplot(data=bands, aes(x=press_type, y=ink_pct)) + 
  geom_boxplot(fill="#74a9cf", colour="#034e7b", outlier.colour="red", outlier.shape=18, outlier.size=3)

## ----boxplot_group0, message=FALSE, warning=FALSE------------------------
ggplot(data=bands, aes(x="0", y=ink_pct)) + 
  geom_boxplot(fill="#74a9cf", colour="#034e7b")

## ----boxplot_xlab, message=FALSE, warning=FALSE--------------------------
ggplot(data=bands, aes(x="0", y=ink_pct)) + 
  geom_boxplot(fill="#74a9cf", colour="#034e7b") +
  xlab("") +
  theme(axis.ticks.x = element_blank(), axis.text.x = element_blank())

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

