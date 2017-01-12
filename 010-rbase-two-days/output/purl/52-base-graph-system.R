## ----require, message=FALSE----------------------------------------------
require(lattice)
require(mnormt)
require(qdata)

## ----plot, fig.width=8, fig.height=8-------------------------------------
f <- factor(c("M", "M", "M", "M", "M", "F", "F","F"))
y <- rnorm(8)
x <- c(0, 2, 4, 8, 16, 32, 64, 128)
par(mfrow = c(2, 2))
plot(y)
plot(f)
plot(x, y)
plot(f, x)

## ----scatterplot1--------------------------------------------------------
data(states)
str(states)
with(states, plot (x = Income, y = Murder))

## ----formula-------------------------------------------------------------
plot(Murder ~ Income, data = states)

## ----type, fig.width=8, fig.height=8-------------------------------------
y <- c (1 , 2, 5 , 8, 9, 9, 7 , 5, 3, 1)
x <- 1:10

par(mfrow = c (4 ,2))
par(mar = c (3 , 3, 3 , 1))

plot(x, y, type = "p", xlab = "", ylab = "", main="type = p")
plot(x, y, type = "l", xlab = "", ylab = "", main="type = l")
plot(x, y, type = "o", xlab = "", ylab = "", main="type = o")
plot(x, y, type = "b", xlab = "", ylab = "", main="type = b")
plot(x, y, type = "c", xlab = "", ylab = "", main="type = c")
plot(x, y, type = "s", xlab = "", ylab = "", main="type = s")
plot(x, y, type = "h", xlab = "", ylab = "", main="type = h")
plot(x, y, type = "n", xlab = "", ylab = "", main="type = n")

## ----symbols-------------------------------------------------------------
plot(Murder ~ Income, data = states, pch = 16, cex = 2.5)

## ----custom--------------------------------------------------------------
plot(Murder ~ Income, data = states, pch = "R", cex = 2.5)

## ----colour_spec, eval=FALSE---------------------------------------------
## plot(Murder ~ Income, data = states, col = "red")
## plot(Murder ~ Income, data = states, col = "#ff0000")
## plot(Murder ~ Income, data = states, col = 2)

## ----colour, echo=FALSE--------------------------------------------------
plot(Murder ~ Income, data = states, col = "red")

## ----titles--------------------------------------------------------------
plot(Murder ~ Income, data = states, pch = 16, col = "blue",
  cex = 2.5, main = "Murder vs Income", sub="USA (1976)",
  xlab = "Per capita income",
  ylab = "Murder per 100,000 population")

## ----axes----------------------------------------------------------------
plot(Murder ~ Income, data = states, pch = 16, col = "blue",
  cex = 2.5, main = "Murder vs Income", sub="USA (1976)",
  xlab = "Per capita income",
  ylab = "Murder per 100,000 population",
  xlim = c(3000, 7000), ylim = c(1, 16))

## ----text----------------------------------------------------------------
plot(Illiteracy ~ Murder, data = states, type = "n")
text(Illiteracy ~ Murder, data = states,
  labels = states$states.region.abb, col = "royalblue", cex = 0.8)

## ----adj-----------------------------------------------------------------
plot(Illiteracy ~ Murder, data = states, type = "n")
text(Illiteracy ~ Murder, data = states, labels = states$states.region.abb,
  col = "green", cex = 0.8)
text(2, 2.5, labels = "By Quantide", adj = c(0, 1), col = "blue", cex = 2)

## ----points0, eval=FALSE-------------------------------------------------
## plot(Murder  Income, data = states, pch = 16, cex = 2.5, col = "red")

## ----points--------------------------------------------------------------
plot(Murder ~ Income, data = states, type = "n")
points(Murder ~ Income, data = states, pch = 16, cex = 2.5, col = "red")

## ----threevariables------------------------------------------------------
myCol <- as.character(factor(states$states.region.abb, labels = rainbow(4)))
plot(Murder ~ Income, data = states, type = "n")
points(Murder ~ Income, data = states, pch = 16, cex = 2.5, col = myCol)

## ----fourvariables-------------------------------------------------------
myCol <- as.character(factor(states$states.region.abb, labels = rainbow(4)))
myCex <- 3 * states$Illiteracy/max(states$Illiteracy)
plot(Murder ~ Income, data = states, type = "n")
points(Murder ~ Income, data = states, pch = 16, cex = myCex, col = myCol)

## ----lines---------------------------------------------------------------
plot(Life.Exp ~ Illiteracy, data = states, type = "n")
abline(h = mean(states$Life.Exp), v = mean(states$Illiteracy),
  col = "gray80", lwd = 2)
abline(lsfit(states$Illiteracy, states$Life.Exp), col = "red", lwd = 2)
points(Life.Exp ~ Illiteracy, data = states, pch = 16, col = "darkblue")
grid()

## ----legend--------------------------------------------------------------
myCol <- as.character(factor(states$states.region.abb,
  labels = rainbow(4, start = 0.3, end = 0.8)))
myCex <- 4*states$Income/max(states$Income)
plot(Murder ~ Illiteracy, data = states, type = "n") 
grid(col = "gray80", lwd = 1, lty = 3)
abline(reg = lsfit(states$Illiteracy, states$Murder),
  col = "red", lwd = 2)
points(Murder ~ Illiteracy, data = states, pch = 16,
  cex = myCex, col = myCol)
legend(x = "bottomright", legend = levels(states$states.region.abb),
  col = rainbow(4, start = 0.3, end = 0.8), pch = 16, ncol = 4,
  title = "State Region", inset = c(0.02, 0.02), bg = "white")

## ----title---------------------------------------------------------------
myCol <- as.character(factor(states$states.region.abb, labels = rainbow(4, start = 0.3, end = 0.8)))
myCex <- 4*states$Income/max(states$Income)
plot(Murder ~ Illiteracy, data = states, type = "n") 
grid(col = "gray80", lwd = 1, lty = 3)
abline(reg = lsfit(states$Illiteracy, states$Murder), col = "red", lwd = 2)
points(Murder ~ Illiteracy, data = states, pch = 16, cex = myCex, col = myCol)
legend(x = "bottomright", legend = levels(states$states.region.abb), col = rainbow(4, start = 0.3, end = 0.8), pch = 16, ncol = 4, title = "State Region", inset = c(0.02, 0.02), bg = "white")
title(main = "Murder vs Illiteracy \n Usa (1974)", cex = 1.2)
title(sub = "Bouble size proportional to Income level", cex = 1)

## ----axes2---------------------------------------------------------------
plot(Population ~ Area, data = states, log = "x", pch = "+", cex = 1.5,
  xaxt = "n", xlab = "Area: Square Miles /1000", col = "red")
atx.mg = c(1, 2, 5, 10, 20, 50, 100, 200, 500) * 1000
label.mg = c(1, 2, 5, 10, 20, 50, 100, 200, 500)
label.km = round(label.mg * 1.61^2, 0)
aty = seq(0, 20, by = 2.5) * 1000
axis(1, at = atx.mg, labels = label.mg)
axis(3, at = atx.mg, labels = label.km)
abline(h = aty, v = atx.mg, col = "gray80", lty = 3)
mtext("Area: Square Km / 1000", 3, line = 3)

## ----axis3, fig.width=7--------------------------------------------------
plot(Population ~ Area, data = states, log = "x", pch = "+",
  cex = 1.5,xaxt = "n", yaxt = "n",
  xlab = "Area: Square Miles /1000", ylab = "", col = "red")
axis(1, at = atx.mg, labels = label.mg)
axis(2, col = "red", lty = 2, las = 2)
axis(3, at = atx.mg, labels = label.km, las = 2, col ="blue")
axis(4, col = "violet", col.axis = "dark violet", lwd = 2)

## ----hist----------------------------------------------------------------
op = par(mfrow = c(1, 2))
with (cars, {
  hist(speed, main = "Frequency Histogram")
  hist(speed, freq = F, main = "Density Histogram")
})

## ----nclass, fig.width=8-------------------------------------------------
par(mfrow = c(1, 2))
with (cars, {
  hist(dist, nclass = 12,
    main = "Specifying Number of Classes", col = "gray")
  hist(dist, nclass = seq(0, 120, by = 20), freq = F,
    main = "Specifying Break Points", col = "lightgray")
})

## ----barplot-------------------------------------------------------------
data(bwt)
with (bwt , {
  tb = table (smoke)
  barplot(tb, col = c("orange", "darkgreen"))
})

## ----barplotlegend, fig.width=8------------------------------------------
with (bwt , {
  tb = table (smoke, low)
  par(mfrow = c(1,2))
  barplot(tb, col = c("pink", "gray"), main = "Stacked bars",
    legend = T)
  barplot(tb, col = c("darkgreen", "brown"), main = "Beside bars",
    beside = T, legend = T)
})

## ----boxplot-------------------------------------------------------------
data(carseat)
boxplot(Strength ~ Operator, data = carseat)

