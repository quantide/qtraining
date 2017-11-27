## ---- eval = FALSE-------------------------------------------------------
## fit_models.R
## utility_functions.R
## 
## # Bad
## foo.r
## stuff.r

## ---- eval = FALSE-------------------------------------------------------
## # Good
## day_one
## day_1
## 
## # Bad
## first_day_of_the_month
## DayOne
## dayone
## djm1

## ---- eval = FALSE-------------------------------------------------------
## # Bad
## T <- FALSE
## c <- 10
## mean <- function(x) sum(x)

## ---- eval = TRUE--------------------------------------------------------
# Good
x <- c(1, 2)

# Bad
x = c(1, 2)


## ---- eval = FALSE-------------------------------------------------------
## # Good
## average <- mean(feet / 12 + inches, na.rm = TRUE)
## dplyr::select()
## 
## # Bad
## average<-mean(feet/12+inches,na.rm=TRUE)
## dplyr :: select()

## ---- eval = FALSE-------------------------------------------------------
## list(
##   total = a + b + c,
##   mean  = (a + b + c) / n
## )
## 

## ---- eval = FALSE-------------------------------------------------------
## # Good
## if (debug) do(x)
## diamonds[5, ]
## 
## # Bad
## if ( debug ) do(x)  # No spaces around debug
## x[1,]   # Needs a space after the comma
## x[1 ,]  # Space goes after comma not before

## ---- eval = FALSE-------------------------------------------------------
## # Good
## if (y < 0 && debug) {
##   message("y is negative")
## }
## 
## if (y == 0) {
##   if (x > 0) {
##     log(x)
##   } else {
##     message("x is negative or zero")
##   }
## } else {
##   y ^ x
## }
## 
## # Bad
## if (y < 0 && debug)
## message("Y is negative")
## 
## if (y == 0)
## {
##     if (x > 0) {
## ⇥       log(x)
##     } else {
## ⇥       message("x is negative or zero")
##     }
## }
## else { y ^ x }

## ---- eval = FALSE-------------------------------------------------------
## # Good
## iris %>%
##   group_by(Species) %>%
##   summarize_all(mean) %>%
##   ungroup %>%
##   gather(measure, value, -Species) %>%
##   arrange(value)
## 
## iris %>% arrange(Petal.Width)
## 
## # Bad
## iris %>% group_by(Species) %>% summarize_all(mean) %>%
##   ungroup %>% gather(measure, value, -Species) %>%
##   arrange(value)

## ---- eval = FALSE-------------------------------------------------------
## # Good
## long_function_name <- function(a = "a long argument",
##                                b = "another argument",
##                                c = "another long argument") {
## }
## 
## # Bad
## long_function_name <- function(a = "a long argument",
##   b = "another argument",
##   c = "another long argument") {
## }

## ---- eval = FALSE-------------------------------------------------------
## # Good
## do_something_very_complicated(
##   "that",
##   requires = many,
##   arguments = "some of which may be long"
## )
## 
## paste0(
##   "Requirement: ", requires, "\n",
##   "Result: ", result, "\n"
## )
## 
## # Bad
## do_something_very_complicated("that", requires, many, arguments,
##                               "some of which may be long"
##                               )
## 
## paste0(
##   "Requirement: ", requires,
##   "\n", "Result: ",
##   result, "\n")
## 

## ---- eval = FALSE-------------------------------------------------------
## 
## # Load data ---------------------------
## 
## # Plot data ---------------------------
## 

