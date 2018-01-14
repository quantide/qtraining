## ----functions-create----------------------------------------------------
f <- function(x, y = 0) {
  z <- x + y
  z
}

## ----functions-002-------------------------------------------------------
formals(f)
body(f)
environment(f)

## ----functions-formals-pairlist------------------------------------------
is.null(pairlist())
is.null(list())

## ----functions-formals-argument------------------------------------------

mean(x = 1:5, trim = 0.1)
mean(1:5, trim = 0.1)
mean(x = 1:5, 0.1)
mean(1:5, 0.1)
mean(trim = 0.1, x = 1:5)

## ----functions-formals-argument2-----------------------------------------
mean(1:5, tr = 0.1)
mean(tr = 0.1, x = 1:5)

## ----functions-formals-arguments3----------------------------------------
mean(c(1, 2, NA))

## ----functions-formals-arguments4----------------------------------------
mean(c(1, 2, NA), na.rm = TRUE)

## ----functions-formals-f-------------------------------------------------
formals(f)

## ----functions-formals-args----------------------------------------------
args(f)

## ----functions-formals-list----------------------------------------------
is.list(formals(mean))

## ----functions-dots------------------------------------------------------
h <- function (x, ...) {0}
formals(h)

## ----functions-dots2-----------------------------------------------------
count_rows <- function(...) {
  list <- list(...)
  lapply(list, nrow)
}

count_rows(airquality, cars)

## ----functions-dots3, fig.height=7, fig.width=7, message=FALSE-----------
require(ggplot2)

# Function
plot_depth <-  function(df, time_var_name, depth_var_name, ...){
  df[,`depth_var_name`] <- -df[,`depth_var_name`]
  ggp <- ggplot(data=df, mapping=aes_string(x=time_var_name, y= depth_var_name)) +
          geom_line(...)
  return(ggp)
}

# Example
time <-  1:13
depth <-  c(0, 9, 18, 21, 21, 21, 21, 18, 9, 3, 3, 3,0)
df <- data.frame(time=time, depth=depth)

ggp1 <- plot_depth(df, time_var_name = "time", depth_var_name = "depth", linetype = 2)
ggp2 <- plot_depth(df, time_var_name = "time", depth_var_name = "depth", size = 4, col = "red")

gridExtra::grid.arrange(ggp1, ggp2, ncol=2)

## ----functions-body-wrong, eval=FALSE------------------------------------
## wrong <- function(x) {x =}

## ----functions-body-right------------------------------------------------
right <- function(x){x+y}

## ----functions-body-right-error, error=TRUE------------------------------
right(x = 2)

