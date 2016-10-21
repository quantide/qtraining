## ---- message=FALSE------------------------------------------------------
require(ggplot2)
require(dplyr)
require(qdata)
data(bands)

## ---- warning=FALSE, message=FALSE---------------------------------------
# ink_pct by presss_type
ggplot(data=bands, mapping=aes(x=ink_pct, fill=press_type)) +
  geom_histogram() 

## ---- warning=FALSE, message=FALSE---------------------------------------
# base plot 
pl <- ggplot(data=bands, mapping=aes(x=ink_pct)) +
  geom_histogram(fill="#2B4C6F") 

# Faceted by press_type, in horizontally arranged subpanels
pl + 
  facet_grid(. ~ press_type)

## ---- warning=FALSE, message=FALSE---------------------------------------
# Faceted by press_type, in vertically arranged subpanels
pl + 
  facet_grid(band_type ~ .)

## ---- warning=FALSE, message=FALSE---------------------------------------
# Faceted by press_type and band_type
pl + 
  facet_grid(band_type ~ press_type)

## ---- warning=FALSE, message=FALSE---------------------------------------
pl + 
  facet_wrap(~ press_type)

## ---- warning=FALSE, message=FALSE, fig.height=8, fig.width=8------------
# by usign facet_grid()
pl + 
  facet_grid(band_type + ink_type ~ press_type)

## ---- warning=FALSE, message=FALSE---------------------------------------
pl + facet_grid(band_type  + paper_type ~ press_type, drop=FALSE)

## ---- warning=FALSE, message=FALSE, fig.height=9, fig.width=9------------
# by using facet_wrap()
pl + 
  facet_wrap(~ band_type + ink_type + press_type)

## ---- warning=FALSE, message=FALSE---------------------------------------
pl + 
  facet_wrap(~ press_type, nrow = 1)
pl + 
  facet_wrap(~ press_type, ncol = 3)

## ---- warning=FALSE, message=FALSE---------------------------------------
pl + 
  facet_wrap(~ press_type, dir = "v")

## ---- warning=FALSE, message=FALSE---------------------------------------
pl + facet_wrap(~ press_type, as.table = TRUE)
pl + facet_wrap(~ press_type, as.table = FALSE)

## ---- warning=FALSE, message=FALSE---------------------------------------
# free x scale
pl + 
  facet_grid(band_type ~ press_type, scales = "free_x")
# free y scale
pl + 
  facet_grid(band_type ~ press_type, scales = "free_y")
# free x and y scales
pl + 
  facet_grid(band_type ~ press_type, scales = "free")

## ---- warning=FALSE, message=FALSE---------------------------------------
# free x scale
pl + 
  facet_wrap( ~ press_type, scales = "free_x")
# free y scale
pl + 
  facet_wrap( ~ press_type, scales = "free_y")
# free x and y scales
pl + 
  facet_wrap( ~ press_type, scales = "free")

## ---- warning=FALSE, message=FALSE, fig.height=7.5, fig.width=7.5--------
pl + 
  facet_grid(press_type ~ ., space  = "free", scales = "free")

## ---- warning=FALSE, message=FALSE---------------------------------------
# Make a copy of the original data
bands2 <- bands
pl1 <- ggplot(data = bands2, mapping = aes(x = humidity, y = viscosity)) +
  geom_point()
pl1

## ---- warning=FALSE, message=FALSE---------------------------------------
bands2 <- bands2 %>% mutate(
  # 4 interval with "equal" range
  press_i = cut_interval(x = press, n = 4),
  # intervals of width 10
  press_w = cut_width(x = press, width = 10),
  # 5 intervals with the "same" number of points
  press_n = cut_number(x = press, n = 5)
)

## ---- warning=FALSE, message=FALSE---------------------------------------
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

## ---- warning=FALSE, message=FALSE---------------------------------------
# Make a copy of the original data
bands3 <- bands

# Rename "BAND" to "Band", "NOBAND" to "No Band"
levels(bands3$press_type)[levels(bands3$press_type)=="ALBERT70"] <- "Albert 70"
levels(bands3$press_type)[levels(bands3$press_type)=="MOTTER70"] <- "Motter 70"
levels(bands3$press_type)[levels(bands3$press_type)=="MOTTER94"] <- "Motter 94"
levels(bands3$press_type)[levels(bands3$press_type)=="WOODHOE70"] <- "Woodhoe 70"

## ---- warning=FALSE, message=FALSE---------------------------------------
ggplot(data=bands3, mapping=aes(x=ink_pct)) +
  geom_histogram(fill="#2B4C6F") +
  facet_grid(. ~ press_type)

## ---- warning=FALSE, message=FALSE---------------------------------------
pl + 
  facet_grid(band_type ~ press_type, labeller = label_value)

## ---- warning=FALSE, message=FALSE---------------------------------------
pl + 
  facet_grid(band_type ~ press_type, labeller = label_both)

## ---- warning=FALSE, message=FALSE---------------------------------------
# modify the dataset
bands4 <- bands
levels(bands4$press_type)[levels(bands4$press_type)=="ALBERT70"] <- "alpha"
levels(bands4$press_type)[levels(bands4$press_type)=="MOTTER70"] <- "sum(x[i], i==1, n)"
levels(bands4$press_type)[levels(bands4$press_type)=="MOTTER94"] <- "sqrt(x)"
levels(bands4$press_type)[levels(bands4$press_type)=="WOODHOE70"] <- "pi"

ggplot(data=bands4, mapping=aes(x=ink_pct)) +
  geom_histogram(fill="#2B4C6F")  + 
  facet_grid(. ~ press_type, labeller = label_parsed)

## ---- warning=FALSE, message=FALSE---------------------------------------
label_wrap <- function(variable, value) {
  lapply(strwrap(as.character(value), width=25, simplify=FALSE), 
        paste, collapse="\n")
}  

## ---- warning=FALSE, message=FALSE---------------------------------------
# modify the dataset
bands5 <- bands
levels(bands5$press_type)[levels(bands5$press_type)=="ALBERT70"] <- "The pressure type for these obs is ALBERT70"
levels(bands5$press_type)[levels(bands5$press_type)=="MOTTER70"] <- "The pressure type for these obs is MOTTER70"
levels(bands5$press_type)[levels(bands5$press_type)=="MOTTER94"] <- "The pressure type for these obs is MOTTER94"
levels(bands5$press_type)[levels(bands5$press_type)=="WOODHOE70"] <- "The pressure type for these obs is WOODHOE70"

ggplot(data=bands5, mapping=aes(x=ink_pct)) +
  geom_histogram(fill="#2B4C6F") + 
  facet_grid(. ~ press_type, labeller = label_wrap)

## ---- warning=FALSE, message=FALSE---------------------------------------
pl + 
  facet_grid(. ~ press_type) + 
  theme(strip.text = element_text(face="bold",family = "Times", size=rel(1.2)), 
        strip.background = element_rect(fill="lightblue", colour="black", size=1))

## ---- warning=FALSE, message=FALSE---------------------------------------
pl + 
  facet_grid(band_type ~ press_type) + 
  theme(panel.margin = unit(2, "cm"))

