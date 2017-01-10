## ---- plot, fig=T--------------------------------------------------------
f = factor(c("M", "M", "M", "M", "M", "F", "F","F"))
y = rnorm(8)
x = c(0, 2, 4, 8, 16, 32, 64, 128)
par(mfrow = c(2, 2))
plot(y)
plot(f)
plot(x, y)
plot(f, x)

## ---- scatterplot1, fig=T------------------------------------------------
load("states.Rda")
str(states, vec.len = 2)
with(states, plot (x = Income, y = Murder))

## ---- formula, fig=T-----------------------------------------------------
plot(Murder ~ Income, data = states)

## ---- type, fig=TRUE, echo = FALSE---------------------------------------
type = c ("p" , "l" , "o" , "b" , "c" , "s" , "h" , "n")
y = c (1 , 2, 5 , 8, 9, 9, 7 , 5, 3, 1)
x = 1:10
par (mfrow = c (4 ,2))
par (mar = c (3 , 3, 3 , 1))
for (i in 1:8) {
  plot(x, y, type = type [i], xlab = "", ylab = "")
  title = paste ("type = " , '"', type[i], '"', sep = "")
  mtext (title, side = 3, line = 1)
}

## ---- symbols, fig=TRUE--------------------------------------------------
plot(Murder ~ Income, data = states, pch = 16, cex = 2.5)

## ---- echo = F, fig=T----------------------------------------------------
 # Make an empty chart
 plot(1, 1, xlim = c(1, 5.5), ylim=c(0.5, 5.5), type = "n", axes = FALSE, ann = FALSE, frame.plot = TRUE)
 # Plot symbols 0-4 with increasing size
 points(1:5, rep(5, 5), cex = 2, pch = 0:4)
 text((1:5) + 0.4, rep(5, 5), cex = 1, (0:4))
 # Plot symbols 5-9 with labels
 points(1:5, rep(4, 5), cex = 2, pch = (5:9))
 text((1:5) + 0.4, rep(4, 5), cex = 1, (5:9))
 # Plot symbols 10-14 with labels
 points(1:5, rep(3, 5), cex = 2, pch = (10:14))
 text((1:5) + 0.4, rep(3, 5), cex = 1, (10:14))
 # Plot symbols 15-19 with labels
 points(1:5, rep(2, 5), cex = 2, pch = (15:19))
 text((1:5) + 0.4, rep(2, 5), cex = 1, (15:19))
 # Plot symbols 20-25 with labels
 points((1:6) * 0.8 + 0.2, rep(1, 6), cex = 2, pch = (20:25))
 text((1:6) * 0.8 + 0.5, rep(1, 6), cex = 1, (20:25))

## ---- custom, fig=TRUE---------------------------------------------------
plot(Murder ~ Income, data = states, pch = "R", cex = 2.5)

## ---- titles, fig=TRUE---------------------------------------------------
plot(Murder ~ Income, data = states, pch = 16, col = "blue",
  cex = 2.5, main = "Murder vs Income", sub="USA (1976)",
  xlab = "Per capita income",
  ylab = "Murder per 100,000 population")

## ---- axes, fig=TRUE-----------------------------------------------------
plot(Murder ~ Income, data = states, pch = 16, col = "blue",
  cex = 2.5, main = "Murder vs Income", sub="USA (1976)",
  xlab = "Per capita income",
  ylab = "Murder per 100,000 population",
  xlim = c(3000, 7000), ylim = c(1, 16))

## ---- logaxes, echo=F, fig=TRUE------------------------------------------
op = par(mfrow = c(1, 2))
plot(Murder ~ Income, data = states, pch = 16, cex = 2, col ="lightseagreen", ylab = "Illiteracy")
plot(Murder ~ Income, data = states, pch = 16, cex = 2, col ="lightseagreen", ylab = "Illiteracy (log scale)", log = "y")
par(op)

## ---- text, fig=TRUE-----------------------------------------------------
plot(Illiteracy ~ Murder, data = states, type = "n")
text(Illiteracy ~ Murder, data = states,
  labels = states$states.region.abb, col = "royalblue", cex = 0.8)

## ---- adj, fig=TRUE------------------------------------------------------
plot(Illiteracy ~ Murder, data = states, type = "n")
text(Illiteracy ~ Murder, data = states, labels = states$states.region.abb,
  col = "green", cex = 0.8)
text(2, 2.5, labels = "By Quantide", adj = c(0, 1), col = "blue", cex = 2)

## ---- points0, eval=FALSE------------------------------------------------
## plot(Murder  Income, data = states, pch = 16, cex = 2.5, col = "red")

## ---- points, fig=TRUE---------------------------------------------------
plot(Murder ~ Income, data = states, type = "n")
points(Murder ~ Income, data = states, pch = 16, cex = 2.5, col = "red")

## ---- threevariables, fig=TRUE-------------------------------------------
myCol = as.character(factor(states$states.region.abb, labels = rainbow(4)))
plot(Murder ~ Income, data = states, type = "n")
points(Murder ~ Income, data = states, pch = 16, cex = 2.5, col = myCol)

## ---- fourvariables, fig=TRUE--------------------------------------------
myCol = as.character(factor(states$states.region.abb, labels = rainbow(4)))
myCex = 3 * states$Illiteracy/max(states$Illiteracy)
plot(Murder ~ Income, data = states, type = "n")
points(Murder ~ Income, data = states, pch = 16, cex = myCex, col = myCol)

## ---- lines, fig=TRUE----------------------------------------------------
plot(Life.Exp ~ Illiteracy, data = states, type = "n")
abline(h = mean(states$Life.Exp), v = mean(states$Illiteracy),
  col = "gray80", lwd = 2)
abline(lsfit(states$Illiteracy, states$Life.Exp), col = "red", lwd = 2)
lines(lowess(states$Illiteracy, states$Life.Exp), col = "green3", lwd = 3)
points(Life.Exp ~ Illiteracy, data = states, pch = 16, col = "darkblue")
grid()

## ---- legend, fig=TRUE---------------------------------------------------
myCol = as.character(factor(states$states.region.abb,
  labels = rainbow(4, start = 0.3, end = 0.8)))
myCex = 4*states$Income/max(states$Income)
plot(Murder ~ Illiteracy, data = states, type = "n") 
grid(col = "gray80", lwd = 1, lty = 3)
abline(reg = lsfit(states$Illiteracy, states$Murder),
  col = "red", lwd = 2)
lines(lowess(states$Illiteracy, states$Murder),
  col = "blue", lwd = 3)
points(Murder ~ Illiteracy, data = states, pch = 16,
  cex = myCex, col = myCol)
legend(x = "topleft", legend = levels(states$states.region.abb),
  col = rainbow(4, start = 0.3, end = 0.8), pch = 16, ncol = 4,
  title = "State Region", inset = c(0.02, 0.02), bg = "white")
legend(x = "bottomright", legend = c("Linear Regression", "Lowess"),
  col = c("red", "blue"), ncol = 1, lty = 1, lwd = 3,
  inset = c(0.01, 0.02), bg = "white")

## ---- title0, eval=FALSE-------------------------------------------------
## title(main = "Murder vs Illiteracy \n Usa (1974)", cex = 1.2)
## title(sub = "Bouble size proportional to Income level", cex = 1)

## ---- title, echo=F, fig=TRUE--------------------------------------------
myCol = as.character(factor(states$states.region.abb, labels = rainbow(4, start = 0.3, end = 0.8)))
myCex = 4*states$Income/max(states$Income)
plot(Murder ~ Illiteracy, data = states, type = "n") 
grid(col = "gray80", lwd = 1, lty = 3)
abline(reg = lsfit(states$Illiteracy, states$Murder), col = "red", lwd = 2)
lines(lowess(states$Illiteracy, states$Murder), col = "blue", lwd = 3)
points(Murder ~ Illiteracy, data = states, pch = 16, cex = myCex, col = myCol)
legend(x = "topleft", legend = levels(states$states.region.abb), col = rainbow(4, start = 0.3, end = 0.8), pch = 16, ncol = 4, title = "State Region", inset = c(0.02, 0.02), bg = "white")
legend(x = "bottomright", legend = c("Linear Regression", "Lowess"), col = c("red", "blue"), ncol = 1, lty = 1, lwd = 3, inset = c(0.01, 0.02), bg = "white")
title(main = "Murder vs Illiteracy \n Usa (1974)", cex = 1.2)
title(sub = "Bouble size proportional to Income level", cex = 1)

## ---- polygon0, eval=FALSE-----------------------------------------------
## poly.x = c(sort(x), sort(x, dec = T))
## poly.y = c(y1, sort(y2, dec = T))

## ---- polygon, fig=TRUE--------------------------------------------------
fm = lm(Murder ~ Illiteracy, data = states)
newdata = data.frame(Illiteracy = sort(states$Illiteracy))
pred = as.data.frame(predict(object = fm, newdata = newdata,
  interval = "confidence"))
poly.x = c(sort(states$Illiteracy), sort(states$Illiteracy, dec = T))
poly.y = c(pred$upr, sort(pred$lwr, dec = T))
ylim = c(0.95, 1.05) * range(c(states$Murder, pred$lwr, pred$upr))
plot(Murder ~ Illiteracy, data = states, type = "n" ,ylim = ylim)
polygon(poly.x, poly.y, col = "gray80", border = "grey80")
grid(col = "gray80", lwd = 1, lty = 3)
lines(x = sort(states$Illiteracy), y = pred$fit, col = "red", lwd = 2)
points(Murder ~ Illiteracy, data = states, pch = 16, col = "darkblue")

## ---- axes2, fig=TRUE----------------------------------------------------
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

## ---- axis3, fig=TRUE----------------------------------------------------
plot(Population ~ Area, data = states, log = "x", pch = "+",
  cex = 1.5,xaxt = "n", yaxt = "n",
  xlab = "Area: Square Miles /1000", ylab = "", col = "red")
axis(1, at = atx.mg, labels = label.mg)
axis(2, col = "red", lty = 2, las = 2)
axis(3, at = atx.mg, labels = label.km, las = 2, col ="blue")
axis(4, col = "violet", col.axis = "dark violet", lwd = 2)

## ---- hist, fig=TRUE-----------------------------------------------------
op = par(mfrow = c(1, 2))
with (cars, {
  hist(speed, main = "Frequency Histogram")
  hist(speed, freq = F, main = "Density Histogram")
})

## ---- nclass, fig=TRUE, width=8, height=8--------------------------------
par(mfrow = c(1, 2))
with (cars, {
  hist(dist, nclass = 12,
    main = "Specifying Number of Classes", col = "gray")
  hist(dist, nclass = seq(0, 120, by = 20), freq = F,
    main = "Specifying Break Points", col = "lightgray")
})

## ---- barplot, fig=TRUE--------------------------------------------------
load("bwt.Rda")
with (bwt , {
  tb = table (smoke)
  barplot(tb, col = c("orange", "darkgreen"))
})

## ---- barplotlegend, fig=TRUE--------------------------------------------
with (bwt , {
  tb = table (smoke, low)
  par(mfrow = c(1,2))
  barplot(tb, col = c("pink", "gray"), main = "Stacked bars",
    legend = T)
  barplot(tb, col = c("darkgreen", "brown"), main = "Beside bars",
    beside = T, legend = T)
})

## ---- boxplot, fig = TRUE------------------------------------------------
load("carseat.Rda")
boxplot(Strength ~ Operator, data = carseat)

## ---- 3d, fig=TRUE-------------------------------------------------------
library(mnormt)               
mu = c(0,0)
sigma = matrix(c(1, 0, 0, 1), 2, 2)                                
x = seq(-3, 3, 0.1)
y = seq(-3, 3, 0.1)
f = function(x, y){dmnorm(cbind(x, y), mu, sigma)}
z = outer(x, y, f)

par(mfrow = c(2, 2))
persp(x, y ,z, theta = 30)
image(x, y, z)
contour(x, y, z)
image(x, y, z)
contour(x, y, z, add = T)

## ---- lattice, fig=TRUE--------------------------------------------------
library(lattice)
pl = wireframe(z, shade = TRUE, aspect = c(61/87, 0.4),
  light.source = c(10,0,10))
print(pl)

## ---- xyplot, fig=TRUE---------------------------------------------------
library(lattice)
load("istat.Rda")
p = xyplot(Weight ~ Height | Gender, data = istat,
  panel = function(x, y , ...){
    panel.xyplot(x, y, pch = 16, ...)
    panel.lmline(x, y, col = "red", lwd = 2, ...)
    panel.loess(x, y, degree = 2, span = .5, col = "green", lwd = 2, ...)
  }
)
print(p)

