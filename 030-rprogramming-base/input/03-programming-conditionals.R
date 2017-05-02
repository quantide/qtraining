## ----if0, eval = FALSE---------------------------------------------------
## if(condition) code to be executed

## ----if------------------------------------------------------------------
x <- 2
if (x > 0) print("x greater than zero")

## ----iffalse-------------------------------------------------------------
x <- -4
if (x > 0) print("x greater than zero")

## ----ifline--------------------------------------------------------------
x <- 2
if (x > 0) {
  print("x greater than zero")
  return(x)
}

## ----else0, eval = FALSE-------------------------------------------------
## if(condition) code-when-true else code-when-false

## ----ifelse--------------------------------------------------------------
x = -4
if (x > 0) print("x greater than zero") else print("x is not greater than zero")

## ----ifelsebraces--------------------------------------------------------
x <- -4
if (x > 0) {
  print("x greater than zero")
} else {
  print("x is not greater than zero")
}

## ----ifassignement-------------------------------------------------------
x <- -4
if (x > 0) {
  y <- 1
} else {
  y <- -1
}
y

## ----structures-008------------------------------------------------------
if(x < 5){"LESS"} else {"GREATER"}

## ----structures-009------------------------------------------------------
x = 1:10
ifelse(x < 5, "LESS", "GREATER")

## ----ifelsefunction------------------------------------------------------
x <- -4
y <- ifelse(x > 0, 1, -1)
y

## ----switch, tidy=FALSE--------------------------------------------------
centre <- function(x, type) {
  switch(type,
    mean = mean(x),
    median = median(x),
    trimmed = mean(x, trim = .1)
  )
}

## ----centre, echo=2:100--------------------------------------------------
set.seed(355)
x <- rcauchy(10)
centre(x, "mean")
centre(x, "median")
centre(x, "trimmed")

