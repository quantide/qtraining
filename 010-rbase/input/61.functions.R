## ---- operations---------------------------------------------------------
x = 1:10
y = 11:20
z = -4:5
x + y + z
exp(x)
log(z)
abs(z)
sqrt(x)

## ---- sum----------------------------------------------------------------
sum(x)

## ---- round--------------------------------------------------------------
floor(3.14)
floor(3.67)
ceiling(3.14)
ceiling(3.67)
trunc(3.14)
trunc(3.67)
round(3.14, digits = 1)
round(3.19, digits = 1)

## ---- random-------------------------------------------------------------
rnorm(n = 10)
rnorm(n = 20, mean = 3, sd = 5)
rbinom(n = 50, size = 20, prob = 0.8)
rweibull(n = 30, shape = 5, scale = 3)

## ---- density------------------------------------------------------------
dbinom(x = 20, size = 20, prob = 0.8)
dnorm(x = -5:5, mean = 0, sd = 1)

## ---- cdf----------------------------------------------------------------
pnorm(q = 0, mean = 0, sd = 1)
pbinom(q = 20, size = 20, prob = 0.8)

## ---- quantiles----------------------------------------------------------
qnorm(p = 0.5, mean = 0, sd = 1)
qbinom(p = 0.5, size = 20, prob = 0.8)

## ---- stats--------------------------------------------------------------
x = mtcars$mpg
mean(x)
median(x)
sd(x)  
var(x)

## ---- quantile-----------------------------------------------------------
quantile(x, .9,) 
quantile(x, c(.3, .84))
quantile(x, c(.25, .50, .75))

## ---- minmax-------------------------------------------------------------
min(x)
max(x)

## ---- summary------------------------------------------------------------
summary(x)

## ---- corcov-------------------------------------------------------------
data = mtcars[, c(1, 3, 4, 5, 6)]
cor(data)
cov(data)

## ---- carnames-----------------------------------------------------------
load("../data/charmanip.Rda")
carnames

## ---- nchar--------------------------------------------------------------
nchar("My auto is dark grey")
nchar(carnames)

## ---- tolowertoupper-----------------------------------------------------
tolower(carnames)
toupper(carnames)

## ---- paste--------------------------------------------------------------
ret = 4 + 2 + 1 + 5 + 4 + 1 + 5 + 7 + 8 + 4
paste("Scuderia Toro Rosso Ferrari scored", ret, "points in 2011")
paste("Scuderia Toro Rosso score (2011)", ret, sep = ": ")

## ---- substring----------------------------------------------------------
substring(carnames, first = 1, last = 3)

## ---- strsplit-----------------------------------------------------------
carlist = strsplit(carnames, " ")
head(carlist)
unlist(carlist)

## ---- sub----------------------------------------------------------------
x = "basic statistics course"
sub(pattern = "basic", replacement = "advanced", x = x)

## ---- gsub---------------------------------------------------------------
x = "Basic Statistics Course With R"
sub(pattern = " ", replacement = "", x = x)
gsub(pattern = " ", replacement = "", x = x)

## ---- match--------------------------------------------------------------
match(x = "McLaren Mercedes", table = carnames)
match(x = carnames, table = "McLaren Mercedes")
match(x = carnames, table = "McLaren Mercedes", nomatch = 0)

## ---- pmatch-------------------------------------------------------------
match(x = "Scuderia Toro", table = carnames)
pmatch(x = "Scuderia Toro", table = carnames)
pmatch(x = "Toro Rosso", table = carnames)

## ---- pmatch.na----------------------------------------------------------
pmatch(x = "Re", table = carnames)
pmatch(x = "Red", table = carnames)

## ---- grep---------------------------------------------------------------
pos = grep(pattern = "Mercedes", x = carnames)
pos
carnames[pos]

