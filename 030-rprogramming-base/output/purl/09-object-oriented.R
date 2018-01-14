## ----s4-000, echo = FALSE------------------------------------------------
require(methods)

## ----s4-001--------------------------------------------------------------
head(cars)

## ----s4-002--------------------------------------------------------------
methods("head")

## ----s4-003--------------------------------------------------------------
utils:::head.data.frame

## ----s4-004--------------------------------------------------------------
head(lm)

## ----s4-005--------------------------------------------------------------
showMethods("lm")

## ----s4-006--------------------------------------------------------------
f <- function(x) {
  x <- list(x)
  class(x) <- "lm"
  x
}

f(x ="Mickey Mouse")

## ----s4-007--------------------------------------------------------------
setClass("rectangle", 
  representation (x= "numeric", y = "numeric"),
  prototype(x = 1, y = 1) 
)

## ----s4-008--------------------------------------------------------------
new("rectangle")
new("rectangle", x = 2, y = 4)
new("rectangle", x = -3, y = 5)

## ----s4-009--------------------------------------------------------------
rectangle <- function (x, y) {
  if (!"x" %in% names(match.call()) & !"y" %in% names(match.call())) {
  rectangle <- new("rectangle")}
  else if (!"x" %in% names(match.call())) {rectangle <- new("rectangle", y = y)}
  else if (!"y" %in% names(match.call())) {rectangle <- new("rectangle", x = x)}
  else rectangle <- new("rectangle", x = x, y = y)
  rectangle
}

## ----s4-010--------------------------------------------------------------
rectangle(x = 2, y = 7)
rectangle(x = 2)
rectangle(y = 2)
rectangle()
rectangle(x = -2, y = 0)

## ----s4-011--------------------------------------------------------------
new("rectangle", x = 3, y = 2)

## ----s4-012--------------------------------------------------------------
setValidity("rectangle", 
  function(object) {object@x > 0 & object@y > 0}
)

## ----s4-013, error=TRUE--------------------------------------------------
new("rectangle", x = -3 , y = 2)
rectangle(x = -2, y = 1)

## ----s4-014--------------------------------------------------------------
new("rectangle", x = 3, y = 2)
rectangle(x = 3, y = 2)

## ----s4-015--------------------------------------------------------------
setMethod(f = "show", signature = "rectangle", 
  definition <-  function(object) {
    x <- object@x ; y <- object@y
    cat(class(object), "of side x =", x , "and side y =",
      y , "\n")
   invisible(NULL)
})
r42 <- rectangle(4,2)
show(r42)
r42

## ----s4-016--------------------------------------------------------------
setMethod(f = "print", signature = "rectangle", 
  definition = function(x) {
    object <- x
    x <- object@x ; y <- object@y
    cat(class(object), "of side x =", x , "and side y =",
      y , "\n")
    invisible(NULL)
})
r27 <- rectangle(2,7)
print(r27)

## ----s4-017--------------------------------------------------------------
setMethod(f = "summary", signature = "rectangle", 
  definition = function(object) {
    x <- object@x ; y <- object@y
    perimeter <- 2*x+2*y
    area <- x*y
    print(object)
    cat("Perimeter =" , perimeter , "\n")
    cat("Area =" , area, "\n")
    invisible(list (sides = c(x, y), 
      perimeter = perimeter, area = area))
})

r42 <- rectangle(4, 2)
summary(r42)
r42_area_perimeter <- summary(r42) 
r42_area_perimeter 

## ----s4-018--------------------------------------------------------------
setMethod(f = "plot", signature = "rectangle", 
  definition =  function(x, y, col = "lightgray" ,
  border = "black", xlab = "x", ylab = "y", ...) {
    object <- x
    x <- object@x ; y <- object@y
    d <- max(c(x, y))
    plot(c(0, d, d, 0), c(0, 0, d , d ), 
      type = "n", asp = 1,
      xlab = xlab , ylab = ylab, ...)
    polygon (c(0, x, x, 0), c(0, 0, y, y), 
     col = col, border = border)
    grid()
    invisible(NULL)
})
r42 <- rectangle(4, 2)
plot(r42)

## ----s4-019--------------------------------------------------------------
setGeneric("rotate",
  function(object, ...)  standardGeneric("rotate")
)

## ----s4-020--------------------------------------------------------------
setMethod(f = "rotate", signature = "rectangle", 
  definition = function(object) {
    xx <- object@x
    object@x <- object@y
    object@y <- xx
    object
})
r12 <- rectangle(1,2)
r21 <- rotate(r12)
par(mfrow = c(1,2))
plot(r12, col = "darkred")
plot(r21 , col = "darkblue")
par(mfrow = c(1,1))

## ----s4-021--------------------------------------------------------------
setClass("parallelepiped",
  representation (z = "numeric"),
  prototype(z = 1),
  contains = "rectangle"
)

new("parallelepiped")

## ----s4-022--------------------------------------------------------------
getClass("parallelepiped")
getClass("rectangle")

## ----s4-023--------------------------------------------------------------
prl <- new("parallelepiped")
print(prl)

## ----s4-024--------------------------------------------------------------
setMethod(f = "print", signature = "parallelepiped", 
  definition = function(x) {
    object <- x
    x <- object@x ; y <- object@y ; z <- object@z
    cat(class(object), "of sides x =", x ," y =",y , " z =" , z, "\n")
    invisible(NULL)
})
print(prl)

## ----s4-025--------------------------------------------------------------
setClass("square",
  contains = "rectangle"
)

square <- function(x) {
  y <- x
  new("square", x = x, y = y)
}

s4 <- square(4)
print(s4)
summary(s4)
plot(s4)

## ----s4-026--------------------------------------------------------------
setAs(from = "rectangle", to = "square", 
  def = function(from) {
    square = square(x = from@x)
    square
})

r35 <- rectangle(3, 5)
s33 <- as(r35, "square")
s33

## ----s4-027--------------------------------------------------------------
rolygon <- function(n){
    
    # Define rolygon class    
    setClass("rolygon", representation(n = "numeric", s = "numeric"))
    
    # Define a plot method for object of class rolygon
    setMethod(f = "plot", signature = "rolygon", 
              definition = function(x, y){
                object <-  x
                s <-  object@s ; n = object@n
                pi <- base::pi
                rho <-  (2*pi)/n
                h <-  .5*s*tan((pi/2)-(pi/n))
                r <-  sqrt(h^2+(s/2)^2)
                sRho <-  ifelse( n %% 2 == 0 , (pi/2- rho/2)  , pi/2)
                cumRho <-  cumsum(c(sRho, rep(rho, n)))
                cumRho <-  ifelse(cumRho > 2*pi, cumRho-2*pi, cumRho)
                x <-  r*cos(cumRho)
                y <-  r*sin(cumRho)
                par(pty = "s")
                plot(x, y, type = "n", xlab = "", ylab = "") 
                lines(x, y, col = "red", lwd = 2)
                points(0,0, pch = 16, col = "red")
                grid()
                invisible(NULL)      
              })
    
    # Define a function that returns an object of class rolygon
    f <- function(s){new("rolygon", n = n, s = s)}
    
    # Return the newly created function
    return(f)  
  }

## ----s4-028--------------------------------------------------------------
heptagon <- rolygon(n = 7)

## ----s4-029--------------------------------------------------------------
e1 <- heptagon(1)

## ----s4-030--------------------------------------------------------------
plot(e1)  

## ----s4-031--------------------------------------------------------------
circumference <- rolygon(n = 10^4)

## ----s4-032--------------------------------------------------------------
plot(circumference(s = base::pi/10^4))

## ----s4-033--------------------------------------------------------------
showClass("rectangle")
getClass("rectangle")

## ----s4-034--------------------------------------------------------------
getValidity(getClass("rectangle"))

## ----s4-035--------------------------------------------------------------
showMethods(f = c("show", "print"), classes = "rectangle")

## ----s4-036--------------------------------------------------------------
showMethods(classes = "rectangle")

## ----s4-037--------------------------------------------------------------
getMethod("print", "rectangle")

## ----RC_01, tidy = FALSE-------------------------------------------------
zero_one  <- setRefClass("zero_one",
                      fields = list( x = "numeric"),
                      methods = list(
                        set_to_zero = function(x){
                          x <<- 0
                        },
                        set_to_one = function(x){
                          x <<- 1
                        }
                      )  
)

## ----RC_02---------------------------------------------------------------
zero_one_test <- zero_one$new(x = 33)
zero_one_test

## ----RC_03---------------------------------------------------------------
zero_one_test$set_to_zero()

## ----RC_04---------------------------------------------------------------
zero_one_test

## ----RC_05, tidy=FALSE---------------------------------------------------
stack  <- setRefClass("stack",
                      fields = list( stack = "numeric"),
                      methods = list(
                        put_in = function(x){
                          stack <<- c(stack, x)
                        },
                        get_out = function(n = 1 , method = "fifo"){
                          stopifnot(method %in% c("fifo", "lilo"))
                          if(method == "fifo"){
                            first <- 1:n
                            stack <<- stack[-first]
                          }
                          if(method == "lilo"){
                            N <- length(stack)
                            last <- c((N-n+1):N)
                            stack <<- stack[-last]
                            
                          }
                        }  
                      )
)

## ----RC_06---------------------------------------------------------------
stack_test <-stack$new(stack = 0)
stack_test$put_in(1:10) 
stack_test$get_out(method = "fifo", n = 2) 
stack_test
stack_test$get_out(method = "lilo", n = 2) 
stack_test

