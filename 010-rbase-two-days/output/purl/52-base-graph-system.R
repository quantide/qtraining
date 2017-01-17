## ----require, message=FALSE----------------------------------------------
require(qdata)

## ----plot, fig.width=8, fig.height=8-------------------------------------
f <- factor(c("M", "M", "M", "M", "M", "F", "F","F"))
y <- rnorm(8)
x <- c(0, 2, 4, 8, 16, 32, 64, 128)
op <- par(mfrow = c(2, 2))
plot(y)
plot(f)
plot(x, y)
plot(f, x)
par(op)

## ----scatterplot1--------------------------------------------------------
data(states)
str(states)

plot(x = states$Illiteracy, y = states$Murder)

## ----formula-------------------------------------------------------------
plot(Murder ~ Illiteracy, data = states)

## ----type, fig.width=8, fig.height=9-------------------------------------
y <- c (1 , 2, 5 , 8, 9, 9, 7 , 5, 3, 1)
x <- 1:10

op <- par(mfrow = c (4 ,2))
plot(x, y, type = "p", xlab = "", ylab = "", main="type = p") # points (empty circles)
plot(x, y, type = "l", xlab = "", ylab = "", main="type = l") # lines
plot(x, y, type = "o", xlab = "", ylab = "", main="type = o") # overplotted points and lines
plot(x, y, type = "b", xlab = "", ylab = "", main="type = b") # both points and lines
plot(x, y, type = "c", xlab = "", ylab = "", main="type = c") # lines parte alone of "b"
plot(x, y, type = "s", xlab = "", ylab = "", main="type = s") # stair steps
plot(x, y, type = "h", xlab = "", ylab = "", main="type = h") # histogram-like vertical lines
plot(x, y, type = "n", xlab = "", ylab = "", main="type = n") # empty plot
par(op)

## ----symbols-------------------------------------------------------------
plot(Murder ~ Illiteracy, data = states, pch = 16, cex = 2.5)

## ----custom--------------------------------------------------------------
plot(Murder ~ Illiteracy, data = states, pch = "R", cex = 2.5)

## ----colour_spec, eval=FALSE---------------------------------------------
## plot(Murder ~ Illiteracy, data = states, col = 2)
## plot(Murder ~ Illiteracy, data = states, col = "red")
## plot(Murder ~ Illiteracy, data = states, col = "#ff0000")

## ----colour, echo=FALSE--------------------------------------------------
plot(Murder ~ Illiteracy, data = states, col = "red")

## ----titles--------------------------------------------------------------
plot(Murder ~ Illiteracy, data = states, 
     pch = 16, cex = 2.5, col = "blue",  
     main = "Murder vs Illiteracy", 
     sub="USA (1976)", 
     xlab = "Illiteracy rate",
     ylab = "Murder per 100,000 population")

## ----axes----------------------------------------------------------------
plot(Murder ~ Illiteracy, data = states, 
     pch = 16, col = "blue", cex = 2.5, 
     main = "Murder vs Illiteracy", 
     sub="USA (1976)", 
     xlab = "Illiteracy rate", 
     ylab = "Murder per 100,000 population",
     xlim = c(0, 3), ylim = c(0, 18))

## ----points0, eval=FALSE-------------------------------------------------
## # High level plot function
## plot(Murder ~ Illiteracy, data = states, pch = 16, cex = 2.5, col = "red")

## ----points--------------------------------------------------------------
plot(Murder ~ Illiteracy, data = states, type = "n")
# Low level plot function
points(Murder ~ Illiteracy, data = states, pch = 16, cex = 2.5, col = "red")

## ----threevariables------------------------------------------------------
# vector of colours to be used in the plot according to states.region.abb levels 
my_col <- as.character(factor(states$states.region.abb, labels = rainbow(4)))

plot(Murder ~ Illiteracy, data = states, type = "n")
points(Murder ~ Illiteracy, data = states, pch = 16, cex = 2.5, col = my_col)

## ----legend--------------------------------------------------------------
# vector of colours to be used in the plot according to states.region.abb levels 
my_col <- as.character(factor(states$states.region.abb, labels = rainbow(4)))

plot(Murder ~ Illiteracy, data = states, type = "n")
points(Murder ~ Illiteracy, data = states, pch = 16, cex = 2.5, col = my_col)
legend(x = "bottomright", legend = levels(states$states.region.abb),
  col = rainbow(4, start = 0.3, end = 0.8), pch = 16, ncol = 4,
  title = "State Region")

## ----lines---------------------------------------------------------------
plot(Murder ~ Illiteracy, data = states, type = "n")
abline(h = mean(states$Murder), v = mean(states$Illiteracy), col = "gray80", lwd = 2)
abline(reg = lm(states$Murder~states$Illiteracy), col = "red", lwd = 2)
points(Murder ~ Illiteracy, data = states, pch = 16, col = "darkblue")
grid()

## ----title---------------------------------------------------------------
plot(Murder ~ Illiteracy, data = states, type = "n")
abline(h = mean(states$Murder), v = mean(states$Illiteracy), col = "gray80", lwd = 2)
abline(reg = lm(states$Murder~states$Illiteracy), col = "red", lwd = 2)
points(Murder ~ Illiteracy, data = states, pch = 16, col = "darkblue")
grid()
title(main = "Murder vs Illiteracy \n Usa (1974)", cex = 1.2)
title(sub = "Plot with Regression Line", cex = 1)

## ----cars, message=FALSE-------------------------------------------------
data(cars)
str(cars)

## ----hist----------------------------------------------------------------
op <- par(mfrow = c(1, 2))
  hist(cars$speed, main = "Frequency Histogram")
  hist(cars$speed, freq = F, main = "Density Histogram")
par(op)

## ----nclass, fig.width=8-------------------------------------------------
op <- par(mfrow = c(1, 2))
  hist(cars$dist, nclass = 12, main = "Specifying Number of Classes", col = "gray")
  hist(cars$dist, nclass = seq(0, 120, by = 20), freq = F, main = "Specifying Break Points", col = "lightgray")
par(op)

## ----bwt, message=FALSE--------------------------------------------------
data(bwt)
str(bwt)

## ----barplot-------------------------------------------------------------
tb <- table(bwt$smoke)
barplot(tb, col = c("orange", "darkgreen"))

## ----barplotlegend, fig.width=8------------------------------------------
tb2 <- table (bwt$smoke, bwt$low)
op <-  par(mfrow = c(1,2))
barplot(tb2, col = c("pink", "gray"), main = "Stacked bars", legend = T)
barplot(tb2, col = c("darkgreen", "brown"), main = "Beside bars", beside = T, legend = T)
par(op)

## ----boxplot-------------------------------------------------------------
data(carseat)
boxplot(Strength ~ Operator, data = carseat)

