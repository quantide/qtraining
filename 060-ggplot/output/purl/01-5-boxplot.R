## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
require(dplyr)
require(ggplot2)
require(qdata)
data(bands)

## ----boxplot_first, message=FALSE, warning=FALSE-------------------------
ggplot(data=bands, aes(x=press_type, y=ink_pct)) + 
  geom_boxplot(fill="#3690c0")

## ----boxplot_colour, message=FALSE, warning=FALSE------------------------
ggplot(data=bands, aes(x=press_type, y=ink_pct)) + 
  geom_boxplot(fill="#74a9cf", colour="#034e7b") 

## ----boxplot_outlines, message=FALSE, warning=FALSE----------------------
ggplot(data=bands, aes(x=press_type, y=ink_pct)) + 
  geom_boxplot(fill="#74a9cf", colour="#034e7b", outlier.colour="red", outlier.shape=18, outlier.size=3)

## ----boxplot_jitter, message=FALSE, warning=FALSE------------------------
ggplot(data=bands, aes(x=press_type, y=ink_pct)) + 
  geom_boxplot(fill="#74a9cf", colour="#034e7b", outlier.colour="red", outlier.shape=18, outlier.size=3) +
  geom_jitter()

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
  xlab("Press type") + 
  ylab ("Ink %") + 
  ggtitle("Distribution\n(bands data set)")

## ----violinplot_first, message=FALSE, warning=FALSE----------------------
ggplot(data=bands, mapping=aes(x = press_type, y=ink_pct)) + 
  geom_violin(fill ="lightgreen", colour = "mediumseagreen")

## ----violinplot_with_tails, message=FALSE, warning=FALSE-----------------
ggplot(data=bands, mapping=aes(x = press_type, y=ink_pct)) + 
  geom_violin(fill ="lightgreen", colour = "mediumseagreen", trim=FALSE)

## ----violinplot_scaled_area, message=FALSE, warning=FALSE----------------
ggplot(data=bands, mapping=aes(x = press_type, y=ink_pct)) + 
   geom_violin(fill ="lightgreen", colour = "mediumseagreen", scale="count")

## ----violinplot_smooth, message=FALSE, warning=FALSE---------------------
ggplot(data=bands, mapping=aes(x = press_type, y=ink_pct)) + 
   geom_violin(fill ="lightgreen", colour = "mediumseagreen", adjust=0.5)

## ----violinplot_boxplot, message=FALSE, warning=FALSE--------------------
ggplot(data=bands, mapping=aes(x = press_type, y=ink_pct)) +
geom_violin(aes(fill = press_type), width=0.9, bw=1.5) +
geom_boxplot(width=0.4, outlier.shape = NA)

