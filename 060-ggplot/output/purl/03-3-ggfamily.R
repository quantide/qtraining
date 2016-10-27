## ----setup, include=FALSE, warning=FALSE, message=FALSE------------------
knitr::opts_chunk$set(echo = TRUE)

## ---- message=FALSE------------------------------------------------------
require(ggplot2)
require(GGally)
require(ggmap)
require(qdata)
require(survival)
data(italy)
data(bottlecap)
data(istat)

## ------------------------------------------------------------------------
require(GGally)

## ------------------------------------------------------------------------
ggcorr(data = bottlecap, palette = "RdBu", label = TRUE)

## ---- message=FALSE, warning=FALSE---------------------------------------
ggpairs(data=istat, # dataframe with variables
        columns = 2:4, # columns to be used to make plots
        title="Matrix Plot of istat data") # title of the plot

## ---- message=FALSE, warning=FALSE---------------------------------------
ggpairs(data=istat, # data.frame with variables
        mapping = aes(colour=Area), # esthetic mapping (besides x and y)
        columns = 2:4, # columns to be used to make plots
        title="Matrix Plot of istat data") # title of the plot

## ---- message=FALSE, warning=FALSE---------------------------------------
ggpairs(data=istat,
        mapping = aes(colour=Area), 
        columns=2:4, 
        upper=list(continuous = 'cor', discrete = 'facetbar', combo ='facethist'),
        lower=list(continuous = 'smooth', discrete = 'facetbar', combo ='dot'),
        diag=list(continuous = 'barDiag', discrete = 'barDiag'),
        title="Matrix Plot of istat data")

## ------------------------------------------------------------------------
data(lung, package = "survival")

## ---- eval=FALSE---------------------------------------------------------
## lung <- lung[, c(2,3,5)]

## ---- message=FALSE, warning=FALSE---------------------------------------
# Fit survival functions
surv <- survfit(Surv(time, status) ~ sex, data = lung)
# Plot survival curves
ggsurv(surv) + 
  guides(linetype = FALSE) +
  scale_colour_discrete(name   = 'Sex', breaks = c(1,2), 
                      labels = c('Male', 'Female'))

## ------------------------------------------------------------------------
# get italy map
italy_map <- get_map(location="Italy", zoom = 6, maptype = "satellite")

## ---- eval=FALSE---------------------------------------------------------
## italy_map <- get_map(location="Italy", zoom = 6, maptype = "terrain")
## italy_map <- get_map(location="Italy", zoom = 6, maptype = "toner")
## italy_map <- get_map(location="Italy", zoom = 6, maptype = "satellite")
## italy_map <- get_map(location="Italy", zoom = 6, maptype = "hybrid")

## ------------------------------------------------------------------------
ggmap(italy_map)

## ------------------------------------------------------------------------
head(italy)

## ---- fig.width=9, fig.height=9------------------------------------------
ggmap(italy_map) + 
  geom_point(aes(colour = region), data = italy)+
  geom_text(aes(label = city, colour = region), data = italy, size = 4, check_overlap = T,
            hjust = 0, nudge_x = 0.05) +
  ggtitle("Map of most the important italian cities")+
  labs(colour="Region", label ="Region") + 
  theme(axis.title=element_blank(),
        plot.title=element_text(size = 22, face = "bold"),
        legend.title=element_text(size = 16))

