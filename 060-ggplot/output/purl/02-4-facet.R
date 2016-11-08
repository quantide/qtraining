## ----first, message=FALSE------------------------------------------------
require(ggplot2)
require(dplyr)
require(qdata)
data(bands)

## ----pl------------------------------------------------------------------
# ink_pct by presss_type
ggplot(data=bands, mapping=aes(x=ink_pct, fill=press_type)) +
  geom_histogram() 

## ----pl_facet_grid_horizontal--------------------------------------------
# base plot
pl <- ggplot(data=bands, mapping=aes(x=ink_pct)) +
  geom_histogram(fill="#2B4C6F")    

# Faceted by press_type, in horizontally arranged subpanels
pl + 
  facet_grid(. ~ press_type)

## ----pl_facet_grid_vertical----------------------------------------------
# Faceted by press_type, in vertically arranged subpanels
pl + 
  facet_grid(band_type ~ .)

## ----pl_facet_grid_horizontal_vertical-----------------------------------
# Faceted by press_type and band_type
pl + 
  facet_grid(band_type ~ press_type)

## ----pl_facet_wrap-------------------------------------------------------
pl + 
  facet_wrap(~ press_type)

## ----pl_multiple_combinations_facet_grid, fig.height=8, fig.width=8------
# by usign facet_grid()
pl + 
  facet_grid(band_type + ink_type ~ press_type)

## ----pl_multiple_combinations_facet_wrap, fig.height=9, fig.width=9------
# by using facet_wrap()
pl + 
  facet_wrap(~ band_type + ink_type + press_type)

## ----pl_change_plot_order_1----------------------------------------------
pl + 
  facet_wrap(~ press_type, nrow = 1)
pl + 
  facet_wrap(~ press_type, ncol = 1)

## ----pl_change_plot_order_2----------------------------------------------
pl + 
  facet_wrap(~ press_type, dir = "v")

## ----pl_change_axis_scales_1---------------------------------------------
# free x scale
pl + 
  facet_grid(band_type ~ press_type, scales = "free_x")
# free y scale
pl + 
  facet_grid(band_type ~ press_type, scales = "free_y")
# free x and y scales
pl + 
  facet_grid(band_type ~ press_type, scales = "free")

## ----pl_change_axis_scales_2---------------------------------------------
# free x scale
pl + 
  facet_wrap( ~ press_type, scales = "free_x")
# free y scale
pl + 
  facet_wrap( ~ press_type, scales = "free_y")
# free x and y scales
pl + 
  facet_wrap( ~ press_type, scales = "free")

## ----pl_change_axis_space, fig.height=7.5, fig.width=7.5-----------------
pl + 
  facet_grid(press_type ~ ., space  = "free", scales = "free")

## ----faceting_with_continuous_vars_1-------------------------------------
# Make a copy of the original data
bands2 <- bands
pl1 <- ggplot(data = bands2, mapping = aes(x = humidity, y = viscosity)) +
  geom_point()
pl1

## ----faceting_with_continuous_vars_2-------------------------------------
bands2 <- bands2 %>% mutate(
  # 4 interval with "equal" range
  press_i = cut_interval(x = press, n = 4),
  # intervals of width 10
  press_w = cut_width(x = press, width = 10),
  # 5 intervals with the "same" number of points
  press_n = cut_number(x = press, n = 5)
)

## ----faceting_with_continuous_vars_3-------------------------------------
# 4 interval with "equal" range
ggplot(data = bands2, mapping = aes(x = humidity, y = viscosity)) +
  geom_point() + 
  facet_wrap(~ press_i)
# intervals of width 10
ggplot(data = bands2, mapping = aes(x = humidity, y = viscosity)) +
  geom_point() + 
  facet_wrap(~ press_w)
# 5 intervals with the "same" number of points
ggplot(data = bands2, mapping = aes(x = humidity, y = viscosity)) +
  geom_point() + 
  facet_wrap(~ press_n)

## ----change_facets_text_1------------------------------------------------
# Make a copy of the original data
bands3 <- bands

# Rename "BAND" to "Band", "NOBAND" to "No Band"
levels(bands3$press_type)[levels(bands3$press_type)=="ALBERT70"] <- "Albert 70"
levels(bands3$press_type)[levels(bands3$press_type)=="MOTTER70"] <- "Motter 70"
levels(bands3$press_type)[levels(bands3$press_type)=="MOTTER94"] <- "Motter 94"
levels(bands3$press_type)[levels(bands3$press_type)=="WOODHOE70"] <- "Woodhoe 70"

## ----change_facets_text_2------------------------------------------------
ggplot(data=bands3, mapping=aes(x=ink_pct)) +
  geom_histogram(fill="#2B4C6F") +
  facet_grid(. ~ press_type)

## ----change_facets_text_3------------------------------------------------
pl + 
  facet_grid(band_type ~ press_type, labeller = label_value)

## ----change_facets_text_4, fig.width=7.5---------------------------------
pl + 
  facet_grid(band_type ~ press_type, labeller = label_both)

## ----change_facets_text_5------------------------------------------------
# modify the dataset
bands4 <- bands
levels(bands4$press_type)[levels(bands4$press_type)=="ALBERT70"] <- "alpha"
levels(bands4$press_type)[levels(bands4$press_type)=="MOTTER70"] <- "sum(x[i], i==1, n)"
levels(bands4$press_type)[levels(bands4$press_type)=="MOTTER94"] <- "sqrt(x)"
levels(bands4$press_type)[levels(bands4$press_type)=="WOODHOE70"] <- "pi"

ggplot(data=bands4, mapping=aes(x=ink_pct)) +
  geom_histogram(fill="#2B4C6F")  + 
  facet_grid(. ~ press_type, labeller = label_parsed)

## ----change_facets_text_6------------------------------------------------
label_wrap <- function(variable, value) {
  lapply(strwrap(as.character(value), width=25, simplify=FALSE), 
        paste, collapse="\n")
}  

## ----change_facets_text_7------------------------------------------------
# modify the dataset
bands5 <- bands
levels(bands5$press_type)[levels(bands5$press_type)=="ALBERT70"] <- "The pressure type for these obs is ALBERT70"
levels(bands5$press_type)[levels(bands5$press_type)=="MOTTER70"] <- "The pressure type for these obs is MOTTER70"
levels(bands5$press_type)[levels(bands5$press_type)=="MOTTER94"] <- "The pressure type for these obs is MOTTER94"
levels(bands5$press_type)[levels(bands5$press_type)=="WOODHOE70"] <- "The pressure type for these obs is WOODHOE70"

ggplot(data=bands5, mapping=aes(x=ink_pct)) +
  geom_histogram(fill="#2B4C6F") + 
  facet_grid(. ~ press_type, labeller = label_wrap)

## ----pl_change_facets_appearance_1---------------------------------------
pl + 
  facet_grid(. ~ press_type) + 
  theme(strip.text = element_text(face="bold",family = "Times", size=rel(1.2)), 
        strip.background = element_rect(fill="lightblue", colour="black", size=1))

## ----pl_change_facets_appearance_2---------------------------------------
pl + 
  facet_grid(band_type ~ press_type) + 
  theme(panel.margin = unit(2, "cm"))

