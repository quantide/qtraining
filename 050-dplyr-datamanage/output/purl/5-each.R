## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
require(dplyr)
require(qdata)
data(mtcars)

## ------------------------------------------------------------------------
# without groups
mtcars %>% 
  summarise(mean_mpg = mean(mpg))

# with one group
mtcars %>% 
  group_by(cyl) %>% 
  summarise(mean_mpg = mean(mpg))

# with more than one group
mtcars %>% 
  group_by(cyl, carb) %>% 
  summarise(mean_mpg = mean(mpg))

## ------------------------------------------------------------------------
# without groups
mtcars %>% 
  summarise_each(funs(mean), mean_mpg = mpg)

# with one group
mtcars %>% 
  group_by(cyl) %>% 
  summarise_each(funs(mean), mean_mpg = mpg)

# with more than one group
mtcars %>% 
  group_by(cyl, carb) %>% 
  summarise_each(funs(mean), mean_mpg = mpg)

## ------------------------------------------------------------------------
# without groups
mtcars %>% 
  summarise(min_mpg = min(mpg), max_mpg = max(mpg))

# with one group
mtcars %>% 
  group_by(cyl) %>% 
  summarise(min_mpg = min(mpg), max_mpg = max(mpg))

# with more than one group
mtcars %>% 
  group_by(cyl, carb) %>% 
  summarise(min_mpg = min(mpg), max_mpg = max(mpg))

## ------------------------------------------------------------------------
# without groups
mtcars %>% 
  summarise_each(funs(min, max), mpg)

# with one group
mtcars %>% 
  group_by(cyl) %>% 
  summarise_each(funs(min, max), mpg)

# with more than one group
mtcars %>% 
  group_by(cyl, carb) %>% 
  summarise_each(funs(min, max), mpg)

## ------------------------------------------------------------------------
# without groups
mtcars %>% 
  summarise_each(funs(min_mpg = min, max_mpg = max), mpg)

# with one group
mtcars %>% 
  group_by(cyl) %>% 
  summarise_each(funs(min_mpg = min, max_mpg = max), mpg)

# with more than one group
mtcars %>% 
  group_by(cyl, carb) %>% 
  summarise_each(funs(min_mpg = min, max_mpg = max), mpg)

## ------------------------------------------------------------------------
# without groups
mtcars %>% 
  summarise(mean_mpg = mean(mpg), mean_disp = mean(disp))

# with one group
mtcars %>% 
  group_by(cyl) %>% 
  summarise(mean_mpg = mean(mpg), mean_disp = mean(disp))

# with more than one group
mtcars %>% 
  group_by(cyl, carb) %>% 
  summarise(mean_mpg = mean(mpg), mean_disp = mean(disp))

## ------------------------------------------------------------------------
# without groups
mtcars %>% 
  summarise_each(funs(mean), mpg, disp)

# with one group
mtcars %>% 
  group_by(cyl) %>% 
  summarise_each(funs(mean), mpg, disp)

# with  more than group
mtcars %>% 
  group_by(cyl, carb) %>% 
  summarise_each(funs(mean), mpg, disp)

## ------------------------------------------------------------------------
# without groups
mtcars %>% 
  summarise_each(funs(mean), mean_mpg = mpg, mean_disp = disp)

# with one group
mtcars %>% 
  group_by(cyl) %>% 
  summarise_each(funs(mean), mean_mpg = mpg, mean_disp = disp)

# with more than one group
mtcars %>% 
  group_by(cyl, carb) %>% 
  summarise_each(funs(mean), mean_mpg = mpg, mean_disp = disp)

## ------------------------------------------------------------------------
# without groups
mtcars %>% 
  summarise(min_mpg = min(mpg), min_disp = min(disp), max_mpg = max(mpg), max_disp = max(disp))

# with one group
mtcars %>% 
  group_by(cyl) %>% 
  summarise(min_mpg = min(mpg), min_disp = min(disp), max_mpg = max(mpg), max_disp = max(disp))

# with more than one group
mtcars %>% 
  group_by(cyl, carb) %>% 
  summarise(min_mpg = min(mpg), min_disp = min(disp), max_mpg = max(mpg), max_disp = max(disp))

## ------------------------------------------------------------------------
# without groups
mtcars %>% 
  summarise_each(funs(min, max), mpg, disp)

# with one group
mtcars %>% 
  group_by(cyl) %>% 
  summarise_each(funs(min, max), mpg, disp)

# with more than one group
mtcars %>% 
  group_by(cyl, carb) %>% 
  summarise_each(funs(min, max), mpg, disp)

## ------------------------------------------------------------------------
# without groups
mtcars %>% 
  summarise_each(funs(min, max), mpg, disp) %>%
  setNames(c("min_mpg", "min_disp", "max_mpg", "max_disp"))

# with one group
mtcars %>% 
  group_by(cyl) %>% 
  summarise_each(funs(min, max), mpg, disp) %>%
  setNames(c("cyl", "min_mpg", "min_disp", "max_mpg", "max_disp"))

# with more than one group
mtcars %>% 
  group_by(cyl, carb) %>% 
  summarise_each(funs(min, max), mpg, disp) %>%
  setNames(c("cyl", "carb", "min_mpg", "min_disp", "max_mpg", "max_disp"))

## ------------------------------------------------------------------------
mtcars %>% summarise(n = n())

## ------------------------------------------------------------------------
mtcars %>% group_by(carb) %>% summarise(n = n())

## ------------------------------------------------------------------------
mtcars %>% group_by(carb, cyl) %>% summarise(n = n())

## ------------------------------------------------------------------------
rescale <- function(x){
  x <- x - min(x, na.rm = TRUE)
  x/max(x)
}

## ------------------------------------------------------------------------
# without groups
mtcars %>% 
  mutate(rescale_mpg = rescale(mpg))

# with one group
mtcars %>% 
  group_by(carb) %>% 
  mutate(rescale_mpg = rescale(mpg)) 

# with more than one group
mtcars %>% 
  group_by(carb, cyl) %>% 
  mutate(rescale_mpg = rescale(mpg))

## ------------------------------------------------------------------------
# without groups
mtcars %>% 
  mutate_each(funs(rescale), rescale_mpg = mpg)

# with one group
mtcars %>% 
  group_by(carb) %>% 
  mutate_each(funs(rescale), rescale_mpg = mpg)

# with more than one group
mtcars %>% 
  group_by(carb, cyl) %>% 
  mutate_each(funs(rescale), rescale_mpg = mpg)

## ------------------------------------------------------------------------
# without groups
mtcars %>% 
  mutate(rescale_mpg = rescale(mpg), order_mpg = order(mpg))

# with one group
mtcars %>% 
  group_by(carb) %>% 
  mutate(rescale_mpg = rescale(mpg), order_mpg = order(mpg)) 

# with more than one group
mtcars %>% 
  group_by(carb, cyl) %>% 
  mutate(rescale_mpg = rescale(mpg), order_mpg = order(mpg))

## ------------------------------------------------------------------------
# without groups
mtcars %>% 
  mutate_each(funs(rescale, order), mpg)

# with one group
mtcars %>% 
  group_by(carb) %>% 
  mutate_each(funs(rescale, order), mpg) 

# with more than one group
mtcars %>% 
  group_by(carb, cyl) %>% 
  mutate_each(funs(rescale, order), mpg)

## ------------------------------------------------------------------------
# without groups
mtcars %>% 
  mutate_each(funs(rescale_mpg = rescale, order_mpg = order), mpg)

# with one group
mtcars %>% 
  group_by(carb) %>% 
  mutate_each(funs(rescale_mpg = rescale, order_mpg = order), mpg)

# with more than one group
mtcars %>% 
  group_by(carb, cyl) %>% 
  mutate_each(funs(rescale_mpg = rescale, order_mpg = order), mpg)

## ------------------------------------------------------------------------
# without groups
mtcars %>% 
  mutate(rescale_mpg = rescale(mpg), rescale_disp = rescale(disp))

# with one group
mtcars %>% 
  group_by(carb) %>% 
  mutate(rescale_mpg = rescale(mpg), rescale_disp = rescale(disp))

# with more than one group
mtcars %>% 
  group_by(carb, cyl) %>% 
  mutate(rescale_mpg = rescale(mpg), rescale_disp = rescale(disp))

## ------------------------------------------------------------------------
# without groups
mtcars %>% 
  mutate_each(funs(rescale), mpg, disp)

# with one group
mtcars %>% 
  group_by(carb) %>% 
  mutate_each(funs(rescale), mpg, disp)

# with more than one group
mtcars %>% 
  group_by(carb, cyl) %>% 
  mutate_each(funs(rescale), mpg, disp)

## ------------------------------------------------------------------------
# without groups
mtcars %>% 
  mutate_each(funs(rescale), rescale_mpg = mpg, rescale_disp = disp)

# with one group
mtcars %>% 
  group_by(carb) %>% 
  mutate_each(funs(rescale), rescale_mpg = mpg, rescale_disp = disp)

# with more than one group
mtcars %>% 
  group_by(carb, cyl) %>% 
  mutate_each(funs(rescale), rescale_mpg = mpg, rescale_disp = disp)

## ------------------------------------------------------------------------
#  without groups
mtcars %>% 
  mutate(rescale_mpg = rescale(mpg),  order_disp = order(disp))

# with one group
mtcars %>% 
  group_by(carb) %>% 
  mutate(rescale_mpg = rescale(mpg),  order_disp = order(disp))

# with more than one group
mtcars %>% 
  group_by(carb, cyl) %>% 
  mutate(rescale_mpg = rescale(mpg),  order_disp = order(disp))

## ------------------------------------------------------------------------
# without groups
mtcars %>% 
  mutate_each(funs(rescale, order), mpg,  disp)

# with one group
mtcars %>% 
  group_by(carb) %>% 
  mutate_each(funs(rescale, order), mpg,  disp)

# with more than one group
mtcars %>% 
  group_by(carb, cyl) %>% 
  mutate_each(funs(rescale, order), mpg,  disp)

## ------------------------------------------------------------------------
# without groups
mtcars %>% 
  mutate_each(funs(rescale, order), mpg,  disp) %>% 
  rename(rescale_mpg = mpg_rescale, rescale_disp = disp_rescale, order_mpg = mpg_order, order_disp = disp_order)

# with one group
mtcars %>% 
  group_by(carb) %>% 
  mutate_each(funs(rescale, order), mpg, disp) %>% 
  rename(rescale_mpg = mpg_rescale, rescale_disp = disp_rescale, order_mpg = mpg_order, order_disp = disp_order)

# with more than one group
mtcars %>% 
  group_by(carb, cyl) %>% 
  mutate_each(funs(rescale, order), mpg, disp) %>%
  rename(rescale_mpg = mpg_rescale, rescale_disp = disp_rescale, order_mpg = mpg_order, order_disp = disp_order)

