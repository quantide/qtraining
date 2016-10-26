## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, warning =FALSE, message = FALSE)

## ------------------------------------------------------------------------
require(ggplot2)
require(RColorBrewer)
require(dplyr)
require(qdata)
data(istat)

## ------------------------------------------------------------------------
ggplot(data=istat, mapping=aes(y=Weight, x=Area)) + 
  geom_boxplot(stat="boxplot", col="blue", fill ="dodger blue")

ggplot(data=istat, mapping=aes(y=Weight, x=Area)) + 
  stat_boxplot(geom="boxplot", col="blue", fill ="dodger blue")

## ------------------------------------------------------------------------
ggplot(data=istat, mapping=aes(x =Weight)) + 
  geom_bar(stat="bin", col="blue", fill ="dodger blue")

ggplot(data=istat, mapping=aes(x=Weight)) + 
  stat_bin(geom="bar", col="blue", fill ="dodger blue")

## ------------------------------------------------------------------------
ggplot(istat, aes(Weight, Height)) + 
         stat_density2d(aes(fill = ..level..), geom = "polygon", n = 100)

ggplot(istat, aes(Weight, Height)) + 
         geom_polygon(aes(fill = ..level..), stat = "density2d", n = 100)


## ------------------------------------------------------------------------
ggplot(data=istat, mapping=aes(x=Weight, y=Height)) +
  geom_point()

## ------------------------------------------------------------------------
ggplot(istat, aes(Weight, Height)) + 
  geom_point() +
  geom_smooth(method=lm)

ggplot(istat, aes(Weight, Height)) + 
  geom_point() +
  stat_smooth(method=lm)

## ------------------------------------------------------------------------
ggplot(istat, aes(Weight, Height)) + 
  geom_point() +
  stat_smooth(method=lm, se=FALSE)

## ------------------------------------------------------------------------
ggplot(istat, aes(Weight, Height)) + 
  geom_point(colour="grey60") +
  stat_smooth(method=lm, se=FALSE, colour="black")

## ------------------------------------------------------------------------
ggplot(istat, aes(Weight, Height)) + 
  geom_point() +
  stat_smooth()

## ---- eval=FALSE---------------------------------------------------------
## ggplot(istat, aes(Weight, Height)) +
##   geom_point() +
##   stat_smooth(method = loess)

## ------------------------------------------------------------------------
ggplot(istat, aes(Weight, Height)) + 
  geom_point() +
  stat_smooth(span = 0.7)

## ------------------------------------------------------------------------
ggplot(istat, aes(Weight, Height, col =Gender)) +
  geom_point() +
  scale_colour_brewer(palette="Set1") + 
  geom_smooth()

## ------------------------------------------------------------------------
ggplot(istat, aes(Weight, Height, col =Gender)) +
  geom_point() +
  scale_colour_brewer(palette="Set1") + 
  geom_smooth(method=lm, se=FALSE, fullrange=TRUE)

## ------------------------------------------------------------------------
ggplot(istat, aes(Weight, Height, col = Gender)) +
  geom_point() +
  scale_colour_brewer(palette="Set1") + 
  stat_smooth(method=lm, se=FALSE) +
  stat_smooth(mapping = aes(group = 1), method = "lm", se = F, col = "black")

## ------------------------------------------------------------------------
ggplot(istat, aes(Weight, Height, col =Gender)) +
  geom_point() +
  scale_colour_brewer(palette="Set1") + 
  stat_smooth(method=lm, se=FALSE) +
  stat_smooth(mapping = aes(group = 1, col = "All"), method = "lm", se = F)

## ------------------------------------------------------------------------
# colours definition
myColors <- c( "black", brewer.pal(2, "Set1"))

ggplot(istat, aes(Weight, Height, col =Gender)) + geom_point() + 
  stat_smooth(method = "lm", se = F) + 
  stat_smooth(method = "lm", aes(group = 1, col="All"), se = F) + 
  scale_color_manual("Gender" , values = myColors)

## ------------------------------------------------------------------------
ggplot(istat, aes(Weight, Height, col =Gender)) + 
  geom_point() + 
  stat_smooth(method = "lm", se = F) + 
  stat_smooth(method = "loess", aes(group = 1, col="All"), se = F) + 
  scale_color_manual("Gender", values = myColors)

## ------------------------------------------------------------------------
ggplot(istat, aes(Weight, Height, y, col = Gender, group = Gender)) + 
  geom_point() +
  geom_quantile(alpha = 0.8, size = 1.5)

ggplot(istat, aes(Weight, Height, y, col = Gender, group = Gender)) + 
  geom_point() +
  stat_quantile(alpha = 0.8, size = 1.5)

## ------------------------------------------------------------------------
ggplot(istat, aes(Weight, Height, col = Gender, group = Gender)) + geom_point() +
  stat_quantile(alpha = 0.8, size = 1.5, quantiles = 0.5)

## ------------------------------------------------------------------------
ggplot(istat, aes(Weight, Height, y, col = Gender, group = Gender)) + geom_point() +
  stat_quantile(method = "rqss", alpha = 0.6, size = 2, quantiles =0.5)

## ------------------------------------------------------------------------
ggplot(istat, aes(Gender, Area)) + 
  stat_sum()

ggplot(istat, aes(Gender, Area)) + 
  geom_count()

## ------------------------------------------------------------------------
ggplot(istat, aes(Gender, Area)) + 
  stat_sum(aes(size = ..prop..)) 

## ------------------------------------------------------------------------
ggplot(istat, aes(Gender, Area)) + 
  stat_sum(aes(size = ..prop.., group = 1)) 

## ------------------------------------------------------------------------
ggplot(istat, aes(Gender, Area)) + 
  stat_sum(aes(size = ..prop.., group = Gender)) 

## ------------------------------------------------------------------------
# istat sample
istat_sample <- istat %>% sample_n(200)

ggplot(istat_sample, aes(Weight, Height)) + 
  stat_sum()

ggplot(istat_sample, aes(Weight, Height)) + 
   geom_count()

## ------------------------------------------------------------------------
ggplot(istat_sample, aes(Weight, Height)) + 
  stat_sum() + 
  scale_size(range = c(1,10))

## ------------------------------------------------------------------------
df <- data.frame(x=seq(from = -3, to = 3, length.out = 100))

## ------------------------------------------------------------------------
ggplot(df, aes(x=x)) + 
  stat_function(fun = dnorm)

## ------------------------------------------------------------------------
ggplot(df, aes(x=x)) +
  stat_function(fun=dt, args=list(df=2))

## ------------------------------------------------------------------------
# Function definition
myfun <- function(xvar) {
  1/(1 + exp(-xvar + 10))
}

df <- data.frame(x=c(0, 20))
# Plotting function
ggplot(df, aes(x=x)) + 
  stat_function(fun=myfun)

## ----boxplot_first, message=FALSE, warning=FALSE-------------------------
ggplot(data=istat, aes(x=Area, y=Weight)) + 
  geom_boxplot() + 
  stat_summary(fun.y="mean", geom="point", shape=23, size=3, fill="red")

## ------------------------------------------------------------------------
ggplot(data = istat, mapping=aes(x=Area, y=Weight, colour=Gender, fill=Gender, group=Gender)) + 
  stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1))

## ------------------------------------------------------------------------
ggplot(data = istat, mapping=aes(x=Area, y=Weight, colour=Gender, fill=Gender, group=Gender)) + 
  stat_summary(fun.data = mean_cl_normal)

## ------------------------------------------------------------------------
ggplot(data = istat, mapping=aes(x=Area, y=Weight, colour=Gender, fill=Gender, group=Gender)) + 
  stat_summary(fun.y = mean, geom = "point") + 
  stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), geom = "errorbar", width = 0.1)

## ------------------------------------------------------------------------
# Function definition: range of obs
pl_range <- function(x) {data.frame(ymin = min(x), ymax = max(x))}
# Function definition: median and interquartile range
med_iqr <- function(x) {data.frame(y = median(x), ymin = quantile(x, 0.25), ymax = quantile(x, 0.75))}

## ------------------------------------------------------------------------
ggplot(data = istat, mapping=aes(x=Area, y=Weight)) + 
  stat_summary(fun.data = med_iqr, geom = "linerange", size = 2, col = "blue") + 
  stat_summary(fun.data = pl_range, geom = "linerange", size = 3, alpha = 0.2, col = "dodgerblue") + 
  stat_summary(fun.y = median, geom = "point", size = 3, col = "red", shape = "X")

## ------------------------------------------------------------------------
ggplot(data = istat, mapping = aes(sample = Height)) + 
  stat_qq() +
  geom_abline(mapping = aes(intercept=mean(Height),slope=sd(Height)), color="red", linetype=2)

## ------------------------------------------------------------------------
ggplot(istat, aes(x=Weight)) + 
  stat_ecdf()

