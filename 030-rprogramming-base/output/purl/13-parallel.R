## ----parallel-001--------------------------------------------------------
f <- function(x) {
r <- sqrt(x[1]^2 + x[2]^2)
10 * sin(r) / r
}

## ----parallel-002--------------------------------------------------------
x <- seq(-10, 10, length.out=1000)
grid <- expand.grid(x=x, y=x)
head(grid, n = 3)

## ----parallel-003--------------------------------------------------------
system.time({z <- apply(grid, 1, f)})

## ----parallel-004--------------------------------------------------------
par(mfrow = c(1,1))
dim(z) <- c(length(x), length(x))
persp(x, x, z, theta=30, phi=30, expand=0.5, col='white', border=NA, shade=0.3, box=FALSE)

## ----parallel-005--------------------------------------------------------
grid_list <- split(grid, grid[,'y'] > 0)

## ----parallel-006--------------------------------------------------------
system.time({z_list <- lapply(grid_list, apply, 1, f)})

## ----parallel-007--------------------------------------------------------
library(parallel)
system.time({z_list <- mclapply(grid_list, apply, 1, f, mc.cores = 2L, mc.preschedule=TRUE)})

## ----parallel-008--------------------------------------------------------
par(mfrow=c(1,2))
# First half:
x1 <- x[x > 0]
z1 <- z_list[[1]]
dim(z1) <- c(length(x), length(x1))
persp(x, x1, z1, theta=90, phi=30, expand=0.5, col='white',border=NA, shade=0.3, box=FALSE)

# Second half:
x2 <- x[x <= 0]
z2 <- z_list[[2]]
dim(z2) <- c(length(x), length(x2))
persp(x, x2, z2, theta=90, phi=30, expand=0.5, col='white', border=NA, shade=0.3, box=FALSE)

## ----parallel-009--------------------------------------------------------
z <- Reduce(c, z_list)

## ----parallel-009, label="crossValFunction"------------------------------
cross_val <- function(i, fm){
  data <- fm$model
  formula <- formula(fm)
  response <- as.character(terms(fm)[[2]])
  fm <- lm(formula, data = data[-i,])
  newdata <- data[i,]
  predicted <- predict (fm, newdata)
  sqrt((predicted - data[i,response] )^2)
}

## ----parallel-010, label="dataframeDf"-----------------------------------
n <-5*10^3
df <-  data.frame(x = 1:n,y = 2+3*c(1:n)+rnorm(n, 0, 1500))
df$y[800] <-  2*10^4
plot(y~x , data = df, pch = 16, cex = .5)
fm <-  lm(y~x, data = df)

## ----parallel-012, label="crossValsingleCore"----------------------------
system.time({single <- lapply(1:n, cross_val, fm)})[3]
op <- par(mfrow = c(1, 2))
plot(y~x , df, pch = 16, col = "red", cex = .6)
plot(unlist(single), type = "s", ylab = "Cross Validation", col = "darkgreen")
par(op)

## ----parallel-013, label="parallel1"-------------------------------------
system.time({
  quad <- mclapply(1:n, cross_val, fm,
  mc.cores = 4L, mc.preschedule = TRUE)})[3]

## ----parallel-014, label="parallel12"------------------------------------
identical(single, quad)

## ----parallel-015--------------------------------------------------------
my_summary <- function(x, flist){
  f <- function(f,...)f(...)
  g <- function(x, flist){vapply(flist, f , x, FUN.VALUE = numeric(1))}
  df <- as.data.frame(lapply(x, g , flist))
  row.names(df) <- names(flist)
  df
}

## ----parallel-016--------------------------------------------------------
n <- 10^7
df <- data.frame(x1 = rnorm(n, 10, 1), x2 = rweibull(n, 1, 2), x3 = rpois(n, 100),
x4 = rnorm(n, 10, 1), x5 = rweibull(n, 1, 2), x6 = rpois(n, 100))
print(object.size(df), units = "Gb")

## ----parallel-017--------------------------------------------------------
system.time({
my_summary(df, 
  flist = list(mean = mean, stdev = sd, range =  function(x,...){sd(x,...)/mean(x,...)})
)})

## ----parallel-018--------------------------------------------------------
my_mc_summary <- function(x, flist, mc.cores = 1L){
  f <- function(f,...)f(...)
  g <- function(x, flist){vapply(flist, f , x, FUN.VALUE = numeric(1))}
  df <- as.data.frame(mclapply(x, g , flist, mc.cores = mc.cores))
  row.names(df) <- names(flist)
  df
}

## ----parallel-019--------------------------------------------------------
system.time({
my_mc_summary(df, 
  flist = list(mean = mean, stdev = sd, range =  function(x,...){sd(x,...)/mean(x,...)}),
  mc.cores = 2L
)})

## ----parallel-020, tidy = FALSE------------------------------------------
# mc.preschedule = TRUE
lambda <- 1000
n <- 10^4

f <- function(i, np, lambda, meanlog, sdlog){
  sum(rlnorm(np[i], meanlog, sdlog))
}

# mc.preschedule = FALSE
system.time({
  np <- rpois(n, lambda)
  out <- mclapply(X = 1:n, FUN = f,
    np = np, meanlog = 9,  sdlog = 2, 
    mc.preschedule = FALSE)
}) 


## ----parallel-021, label="clusterCall1"----------------------------------
library(parallel)
nc <- detectCores()
cluster <- makeCluster(nc)
cbind(clusterCall(cluster, function() {Sys.info()["nodename"]}))
stopCluster(cluster)

## ----parallel-022, label="clusterCall2"----------------------------------
fx <- function(x){x+1}
cluster <- makeCluster(2)
clusterCall(cluster, fx, x = 5)
stopCluster(cluster)

## ----parallel-023, label="fxx1"------------------------------------------
fxx <- function(x){x + xx}
xx <- 3
fxx(1)

## ----parallel-024, label="fxx2", eval = FALSE----------------------------
## cluster <-  makeCluster(2)
## clusterCall(cluster, fxx, x = 2)
## stopCluster(cluster)

## ----parallel-025, label="fxx2a"-----------------------------------------
xx <-  1
cluster = makeCluster(2)
clusterExport(cluster, "xx")
clusterCall(cluster, fxx, x = 2)
stopCluster(cluster)

## ----parallel-026, label="MASS"------------------------------------------
cluster <-  makeCluster(2)
clusterEvalQ(cluster, library(MASS))
stopCluster(cluster)

## ----parallel-027--------------------------------------------------------
lambda <- 1000
n <- 10^5

f <- function(i, np, lambda, meanlog, sdlog){
  sum(rlnorm(np[i], meanlog, sdlog))
}

system.time({
  np <- rpois(n, lambda)
  out <- sapply(X = 1:n, FUN = f,
    np = np, meanlog = 9,  sdlog = 2)
  cat ("95th quantile = " , quantile(out , .95), "\n")
}) 

## ----parallel-028, label="conv1"-----------------------------------------
nc <- detectCores()
cluster  <- makeCluster(nc)

f <- function(i, np, lambda, meanlog, sdlog){
  sum(rlnorm(np[i], meanlog, sdlog))
}

system.time({
  np <- rpois(n, lambda)
  out <- parSapply(cl = cluster , X = 1:n, FUN = f,
    np = np, meanlog = 9,  sdlog = 2)
  cat ("95th quantile = " , quantile(out , .95), "\n")
}) 

stopCluster(cluster)

## ----parallel-029--------------------------------------------------------
ip_master <- "localhost"
ip_slave <- "localhost"

biCluster  <- makeCluster(spec = c(rep(ip_master, 2) , rep(ip_slave, 2)), port = 11001)
cbind(clusterCall(biCluster, function() {Sys.info()["nodename"]}))
stopCluster(biCluster)

## ----parallel-030, label="localVaio", tidy=TRUE--------------------------
biCluster  <- makeCluster(spec = c(rep(ip_master, 2) , rep(ip_slave, 2)))

lambda <- 1000
n <- 10^6

f <- function(i , np , lambda, meanlog, sdlog){
  sum(rlnorm(np[i], meanlog, sdlog))
}

system.time({
  np <- rpois(n, lambda)
  out <- parSapply(cl = biCluster , X = 1:n, FUN = f,
    np = np, meanlog = 9,  sdlog = 2)
  cat ("95th quantile = " , quantile(out , .95), "\n")
}) 

stopCluster(biCluster)

