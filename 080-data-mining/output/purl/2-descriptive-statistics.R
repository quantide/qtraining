## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples

## Datasets from packages
require(qdata)
data(wea, forbes94, volcano3d)

## Other datasets used
# iris

#########################################################
## packages needed: Hmisc, fBasics, mice, ggplot2, rgl ##
#########################################################

## ----summary-weather-----------------------------------------------------
summary(wea[,7:9])

## ----require-Hmisc, message=FALSE----------------------------------------
require(Hmisc)

## ----describe-cont-example-----------------------------------------------
describe(wea$Sunshine)

## ----describe-cat-example------------------------------------------------
describe(wea$WindDir9am)

## ----require-fBasics, message=FALSE--------------------------------------
require(fBasics)

## ----basicStats-fBasics--------------------------------------------------
basicStats(wea$Sunshine)

## ----require-mice, message=FALSE-----------------------------------------
require(mice)

## ----md_pattern----------------------------------------------------------
md.pattern(wea[,7:10])

## ----summarycompletecases,warning=FALSE,message=FALSE--------------------
summary(wea[, 7:10])                              # NAs still in the data
summary(wea[complete.cases(wea[,7:10]), 7:10])    # NAs removed

## ----tapply, warning=FALSE, message=FALSE--------------------------------
tapply(X = wea$Sunshine, INDEX = wea$WindGustDir, FUN = mean, na.rm = TRUE)
tapply(X = wea$Sunshine, INDEX = wea$WindGustDir, FUN = length)
table(wea$WindGustDir, useNA = "ifany")
tapply(X = wea$Sunshine, INDEX = wea$WindGustDir, FUN = summary)

## ----aggregate, warning=FALSE, message=FALSE-----------------------------
aggregate(x = wea$Pressure9am, by = list(wgd=wea$WindGustDir), FUN = summary)
(res <- aggregate(x = wea$Pressure9am, by = list(wgd=wea$WindGustDir, rt=wea$RainToday), FUN = summary))
str(res)
(res <- cbind(res[,1:2], res$x))
str(res)
(res <- aggregate(x = wea[,c("Pressure9am","Pressure3pm")],
                  by = list(wgd=wea$WindGustDir, rt=wea$RainToday), FUN = summary))

## ----by, warning=FALSE, message=FALSE------------------------------------
by(data = wea[,c("Sunshine","Pressure9am","Pressure3pm")],
   INDICES = list(wgd=wea$WindGustDir, rt=wea$RainToday), 
   FUN = summary)

## ----dplyr_examples, warning=FALSE, message=FALSE------------------------
require(dplyr)

(res1 <- wea %>% 
  group_by(WindGustDir, RainToday) %>% 
  summarise(count = n(),
            mean_pressure9am = mean(Pressure9am),
            mean_pressure3pm =mean(Pressure3pm)))

## ----prop.table, warning=FALSE, message=FALSE----------------------------
(tbl <- table(wea$WindGustDir, wea$RainToday))
prop.table(tbl)
prop.table(tbl, margin = 2)
prop.table(tbl, margin = 1)

## ----loadiris, message=FALSE---------------------------------------------
require(ggplot2)

## ----iris----------------------------------------------------------------
head(iris)
str(iris)

## ----tsplot, fig.width=plot_with_legend_fig_width_medium-----------------
iris$datetime <- seq.POSIXt(from = as.POSIXct("2012-10-10 08:00:00"), by = "1 min", length.out = nrow(iris))
iris$labels <- ifelse(iris$Sepal.Width < 2.8 | iris$Sepal.Width > 3.3, as.character(iris$Sepal.Length), "")

ggp <- ggplot(data = iris, aes(x = datetime, y = Sepal.Length)) +
  geom_point(aes(col = Sepal.Length))+
  geom_line(col = "blue") +
  ggtitle("Time series plot of Sepal.Length") +
  xlab("Date/time") + ylab("Sepal Length") +
  geom_text(aes(label = labels))
print(ggp)

## ----tssplot, fig.width=plot_with_legend_fig_width_large-----------------
dt <- data.frame(measure = c(iris$Sepal.Length,iris$Sepal.Width),
                 type = c(rep("Sepal Lentgh",150), rep("Sepal Width",150)), datetime=rep(iris$datetime,2))
ggp <- ggplot(data = dt, aes(x = datetime, y = measure, col = type)) +
  geom_line() +
  ggtitle("Time series plot of Sepal.Length and Sepal.Width") +
  xlab("Date/time") + ylab("Measures")
print(ggp)

## ----tss2plot------------------------------------------------------------
ggp <- ggplot(data = iris, aes(x = datetime, y = Sepal.Length)) +
  geom_line(colour = "blue") +
  geom_line(aes(y = Sepal.Width), colour = "red") +
  ggtitle("Time series plot of Sepal.Length and Sepal.Width") +
  xlab("Date/time") + ylab("Measures")
print(ggp)

## ----histplot------------------------------------------------------------
(ggp <- ggplot(iris, aes(x = Sepal.Length)) + geom_histogram(binwidth = .3))

## ----hist2plot-----------------------------------------------------------
(ggp <- ggplot(iris, aes(x = Sepal.Length)) +
   geom_histogram(binwidth = .3, colour = "black", fill = "white"))

## ----densityplot---------------------------------------------------------
(ggp <- ggplot(iris, aes(x = Sepal.Length)) + geom_density())

## ----densityhistplot-----------------------------------------------------
ggp <- ggplot(iris, aes(x = Sepal.Length)) +
  geom_histogram(aes(y = ..density..),      # Histogram with density instead of count on y-axis
                 binwidth = .3, colour = "black", fill = "white") +
  geom_density(alpha = .2, fill = "#FF6666")  # Overlay with transparent density plot
print(ggp)

## ----densityhistplot_colouredbars----------------------------------------
ggp <- ggplot(iris, aes(x = Sepal.Length)) +
  geom_histogram(aes(y = ..density.., fill = ..density..), # Histogram with density instead of count on y-axis
                 binwidth = .3, colour = "black") +
  geom_density(alpha = .2, fill = "#FF6666")  # Overlay with transparent density plot
print(ggp)

## ----histwithmeanplot----------------------------------------------------
ggp <- ggplot(iris, aes(x = Sepal.Length)) +
  geom_histogram(binwidth = .5, colour = "black", fill = "white") +
  geom_vline(aes(xintercept = mean(Sepal.Length, na.rm = TRUE)),   # Ignore NA values for mean
                        color = "red", linetype = "dashed", size = 1)
print(ggp)

## ----densityplots, fig.width=plot_with_legend_fig_width_large, warning=FALSE, message=FALSE----
(ggp <- ggplot(dt, aes(x = measure, fill = type)) + geom_density(alpha = .3))
(ggp <- ggplot(dt, aes(x = measure, fill = type)) + geom_histogram(alpha = 0.3, position = "identity")) # position="identity" is used to avoid stacked histograms
rm(dt)

## ----boxplot-------------------------------------------------------------
ggp <- ggplot(iris, aes(x = "", y = Sepal.Length)) +
  geom_boxplot() +
  xlab("Values")
print(ggp)

## ----horizboxplot--------------------------------------------------------
(ggp <- ggp + coord_flip())  ## What happens if we use coord_flip(), e.g., with histgrams?

## ----stdboxplot----------------------------------------------------------
nums <- tapply(iris$Sepal.Length, INDEX = iris$Species, FUN = length)
dt <- data.frame(pos = 1:length(nums), Species = names(nums), Count = nums)
ggp <- ggplot(iris, aes(x = Species, y = Sepal.Length)) +
  geom_boxplot() +
  geom_text(data=dt,aes(x = pos,
                        y = tapply(X = iris$Sepal.Length+1, INDEX = iris$Species, FUN = median),
                        label = Count)) +
  ggtitle("Sepal Length Vs Iris Type")
print(ggp)

ggp <- ggplot(iris, aes(x = "", y = Sepal.Length)) +
  geom_boxplot(aes(facet = Species)) + 
  facet_grid(facets = ~Species, as.table = TRUE)
print(ggp)

## ----violinplot----------------------------------------------------------
ggp <- ggplot(iris, aes(x = "", y = Sepal.Length)) +
  geom_violin() +
  xlab("Values")
print(ggp)

## ----addpointstoviolinplot-----------------------------------------------
ggp <- ggp + geom_jitter()
print(ggp)

## ----violin2plot---------------------------------------------------------
ggp <- ggplot(iris, aes(x = Species, y = Sepal.Length)) +
  geom_violin() +
  ggtitle("Sepal Length Vs Iris Type")
print(ggp)

## ----addboxtoviolinplot--------------------------------------------------
ggp <- ggp + geom_boxplot()
print(ggp)

## ----addpointstoviolin2plot----------------------------------------------
ggp <- ggp + geom_jitter()
print(ggp)

## ----loadfandplotfb------------------------------------------------------
str(forbes94)

ggp <- ggplot(forbes94, aes(x = WideIndustry, y = Salary)) +
  geom_boxplot(outlier.shape = 19, outlier.colour = "red", outlier.size = 2) +
  ggtitle("Salary vs. Industry")
print(ggp)

## ----3dplot--------------------------------------------------------------
head(volcano3d)
ggp <- ggplot(volcano3d, aes(x = x, y = y, z = z)) +
  stat_contour()
print(ggp)

## ----3dplot1, fig.width=plot_with_legend_fig_width_short-----------------
ggp <- ggplot(volcano3d, aes(x = x, y = y, z = z)) +
  stat_contour(geom = "polygon", aes(fill = ..level..))
print(ggp)

## ----3dplot2, fig.width=plot_with_legend_fig_width_short-----------------
ggp <- ggplot(volcano3d, aes(x = x, y = y, z = z)) +
  geom_tile(aes(fill = z)) +
  stat_contour()
print(ggp)

## ----3dplot3, fig.width=plot_with_legend_fig_width_short, message=FALSE----
ggp <- ggplot(forbes94, aes(x = Sales, y = Profits)) +
  stat_density2d(aes(fill = ..level..), geom = "polygon")
print(ggp)

## ----require_rgl, eval=FALSE---------------------------------------------
## require(rgl)

## ----3dplot4, eval=FALSE-------------------------------------------------
## open3d()
## with(forbes94,
## plot3d(x = StockOwned, y = Sales, z = Profits,
##        xlab = "StockOwned", ylab = "Sales", zlab = "Profits", type = "p"#), #col=,
## #        size, lwd, radius,
## #        add = FALSE, aspect = !add, ...)
## ))

## ----3dplot5, eval=FALSE-------------------------------------------------
## open3d()
## with(forbes94,
##      plot3d(x = log(StockOwned), y = log(Sales), z = Profits,
##             xlab = "StockOwned", ylab = "Sales", zlab = "Profits", type = "s",
##             col = as.numeric(as.factor(WideIndustry))
##             #        size, lwd, radius,
##             #        add = FALSE, aspect = !add, ...)
##      ))

## ----3dplot6, eval=FALSE-------------------------------------------------
## open3d()
## with(forbes94,
##      plot3d(x = log(StockOwned), y = log(Sales), z = Profits,
##             xlab = "StockOwned", ylab = "Sales", zlab = "Profits", type = "p",
##             col = as.numeric(as.factor(WideIndustry))
##             #        size, lwd, radius,
##             #        add = FALSE, aspect = !add, ...)
##      ))

## ----3dplot7, eval=FALSE-------------------------------------------------
## z <- 2 * volcano        # Exaggerate the relief
## x <- 10 * (1:nrow(z))   # 10 meter spacing (S to N)
## y <- 10 * (1:ncol(z))   # 10 meter spacing (E to W)
## zlim <- range(z)
## zlen <- zlim[2] - zlim[1] + 1
## colorlut <- terrain.colors(zlen) # height color lookup table
## col <- colorlut[ z - zlim[1] + 1 ] # assign colors to heights for each point
## open3d()
## surface3d(x, y, z, color = col, back = "lines")

