## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
require(ggplot2)
require(qdata)
require(grid)
data(bands)

## ----pl_1----------------------------------------------------------------
pl_1 <- ggplot(data=bands, aes(x=press_type, y=ink_pct, fill=press_type)) + 
  geom_boxplot()
pl_1

## ----pl_1_remove_legend, eval = FALSE------------------------------------
## pl_1 +
##   guides(fill=FALSE)
## pl_1 +
##   scale_fill_discrete(guide=FALSE)
## pl_1 +
##   theme(legend.position="none")

## ----pl_1_change_legend_position_1---------------------------------------
pl_1 + 
  theme(legend.position="top")

## ----pl_2----------------------------------------------------------------
pl_2 <- ggplot(data=bands, mapping=aes(x=humidity, y=viscosity, size=ink_pct, colour=band_type)) +
  geom_point()

## ----pl_2_change_multiple_legend_position_1------------------------------
pl_2 + 
  theme(legend.position="bottom")

## ----pl_2_change_multiple_legend_position_2------------------------------
pl_2 + 
  theme(legend.position="bottom", legend.box = "horizontal")

## ----pl_1_change_legend_position_2---------------------------------------
pl_1 + 
  theme(legend.position=c(0.15,0.80))

## ----pl_1_change_legend_position_3---------------------------------------
pl_1 + 
  theme(legend.position=c(0,1), legend.justification=c(0,1))

## ----pl_1_change_legend_order--------------------------------------------
pl_1 + 
  scale_fill_discrete(limits=c("MOTTER94", "MOTTER70", "WOODHEADE70", "ALBERT70"))

## ----pl_1_reverse_legend_order-------------------------------------------
pl_1 + 
  guides(fill=guide_legend(reverse=TRUE))

## ----pl_2_change_multiple_legends_order----------------------------------
pl_2 + 
  guides(color = guide_legend(order=2),
    size = guide_legend(order=1))

## ----pl_1_change_legend_title, eval=FALSE--------------------------------
## pl_1 +
##   labs(fill="Pressure Type")
## pl_1 +
##   scale_fill_discrete(name="Pressure Type")
## pl_1 +
##   guides(fill=guide_legend(title="Pressure Type"))

## ----pl_3----------------------------------------------------------------
pl_3 <- ggplot(data=bands, mapping=aes(x=humidity, y=viscosity, shape=band_type, colour=band_type)) +
  geom_point()
pl_3

## ----pl_3_change_multiple_legends_title----------------------------------
pl_3 + 
  labs(shape = "Band Type") # two separate legend
pl_3 + 
  labs(shape = "Band Type", colour = "Band Type") # one legend

## ----pl_1_change_legend_title_appearance---------------------------------
pl_1 + 
  theme(legend.title=element_text(face="bold", family="Times", colour="darkgreen", size=14))

## ----pl_1_remove_legend_title, eval=FALSE--------------------------------
## pl_1 +
##   guides(fill=guide_legend(title=NULL))
## pl_1 +
##   scale_fill_discrete(guide = guide_legend(title=NULL))

## ----pl_1_change_legend_labels_1-----------------------------------------
pl_1 + 
  scale_fill_discrete(labels=c("Albert 70", "Motter 70", "Motter 94", "Woodhoe 70"))

## ----pl_1_change_legend_labels_2-----------------------------------------
pl_1 + 
  scale_fill_discrete(limits=c("MOTTER70", "WOODHOE70", "ALBERT70", "MOTTER94"),
    labels=c("Motter 70", "Woodhoe 70", "Albert 70", "Motter 94"))

## ----pl_3_change_multiple_legends_labels---------------------------------
# Change the labels for one scale
pl_3 + 
  scale_shape_discrete(labels=c("Band", "No Band"))
# Change the labels for both scales
pl_3 + 
  scale_shape_discrete(labels=c("Band", "No Band")) +
  scale_colour_discrete(labels=c("Band", "No Band"))

## ----pl_1_change_legend_labels_appearance--------------------------------
pl_1 + 
  theme(legend.text=element_text(face="italic", family="Times", colour="red", size=14))

## ----pl_1_legend_labels_break_lines--------------------------------------
pl_1 + 
  scale_fill_discrete(labels=c("Albert 70 \n type", "Motter 70 \n type", "Motter 94 \n type", "Woodhoe 70 \n type"))

## ----pl_1_customize_legend_keys------------------------------------------
pl_1 + 
  scale_fill_discrete(labels=c("Albert 70 \n type", "Motter 70 \n type", "Motter 94 \n type", "Woodhoe 70 \n type")) +
  theme(legend.text=element_text(lineheight=.8),
    legend.key.height=unit(1, "cm"))

## ----pl_1_customize_legend_background_1----------------------------------
pl_1 + 
  theme(legend.position=c(0,1), legend.justification=c(0,1),
    legend.background=element_rect(fill="white", colour="black"))

## ----pl_1_remove_legend_border-------------------------------------------
pl_1 + 
  theme(legend.position=c(0,1), 
        legend.justification=c(0,1),
        legend.background=element_blank(),  # Remove overall border
        legend.key=element_blank()) # Remove border around each item

## ----pl_1_customize_legend_background_2----------------------------------
pl_1 + theme(
  legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid", colour ="darkblue"),
  legend.key  = element_rect(fill="lightblue", size=0.5, linetype="solid", colour ="lightblue"))

