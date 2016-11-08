## ---- message=FALSE------------------------------------------------------
require(ggplot2)
require(GGally)
require(ggmap)
require(qdata)
require(survival)
data(lung)
data(italy)
data(bottlecap)
data(istat)

## ----load_GGally, eval= FALSE--------------------------------------------
## require(GGally)

## ----ggcorr--------------------------------------------------------------
ggcorr(data = bottlecap, palette = "RdBu", label = TRUE)

## ----ggpairs_1, message=FALSE, warning=FALSE-----------------------------
ggpairs(data=istat, # dataframe with variables
        columns = 2:4, # columns to be used to make plots
        title="Matrix Plot of istat data") # title of the plot

## ----ggpairs_2, message=FALSE, warning=FALSE-----------------------------
ggpairs(data=istat, # data.frame with variables
        mapping = aes(colour=Area), # esthetic mapping (besides x and y)
        columns = 2:4, # columns to be used to make plots
        title="Matrix Plot of istat data") # title of the plot

## ----ggpairs_3, message=FALSE, warning=FALSE-----------------------------
ggpairs(data=istat,
        mapping = aes(colour=Area), 
        columns=2:4, 
        upper=list(continuous = 'cor', discrete = 'facetbar', combo ='facethist'),
        lower=list(continuous = 'smooth', discrete = 'facetbar', combo ='dot'),
        diag=list(continuous = 'barDiag', discrete = 'barDiag'),
        title="Matrix Plot of istat data")

## ---- eval=FALSE---------------------------------------------------------
## lung <- lung[, c(2,3,5)]

## ----ggsurv, message=FALSE, warning=FALSE--------------------------------
# Fit survival functions
surv <- survfit(Surv(time, status) ~ sex, data = lung)
# Plot survival curves
ggsurv(surv) + 
  guides(linetype = FALSE) +
  scale_colour_discrete(name   = 'Sex', breaks = c(1,2), 
                      labels = c('Male', 'Female'))

## ----italy_map-----------------------------------------------------------
# get italy map
italy_map <- get_map(location="Italy", zoom = 6, maptype = "satellite")

## ----ggmap_italy---------------------------------------------------------
ggmap(italy_map)

## ----italy_dataset-------------------------------------------------------
head(italy)

## ----add_cities_information, fig.width=9, fig.height=9-------------------
ggmap(italy_map) + 
  geom_point(aes(colour = region), data = italy)+
  geom_text(aes(label = city, colour = region), data = italy, size = 4, check_overlap = T,
            hjust = 0, nudge_x = 0.05) +
  ggtitle("Map of most the important italian cities")+
  labs(colour="Region", label ="Region") + 
  theme(axis.title=element_blank(),
        plot.title=element_text(size = 22, face = "bold"),
        legend.title=element_text(size = 16))

