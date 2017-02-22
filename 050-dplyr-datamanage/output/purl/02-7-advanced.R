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
  summarise_at(vars(mean_mpg = mpg), funs(mean))

# with one group
mtcars %>% 
  group_by(cyl) %>% 
  summarise_at(vars(mean_mpg = mpg), funs(mean))

# with more than one group
mtcars %>% 
  group_by(cyl, carb) %>% 
  summarise_at(vars(mean_mpg = mpg), funs(mean))

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
  summarise_at(vars(mpg), funs(min_mpg = min, max_mpg = max))

# with one group
mtcars %>% 
  group_by(cyl) %>% 
  summarise_at(vars(mpg), funs(min_mpg = min, max_mpg = max))

# with more than one group
mtcars %>% 
  group_by(cyl, carb) %>% 
  summarise_at(vars(mpg), funs(min_mpg = min, max_mpg = max))

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
    summarise_at(vars (mean_mpg = mpg, mean_disp = disp), funs(mean))

# with one group
mtcars %>% 
  group_by(cyl) %>% 
  summarise_at(vars(mean_mpg = mpg, mean_disp = disp), funs(mean))

# with more than one group
mtcars %>% 
  group_by(cyl, carb) %>% 
  summarise_at(vars(mean_mpg = mpg, mean_disp = disp), funs(mean))

## ------------------------------------------------------------------------
# without groups
mtcars %>% 
  select_if(is.numeric) %>%
  summarise_all(mean)

# with one group
mtcars %>% 
  select_if(is.numeric) %>%
  group_by(cyl) %>% 
  summarise_all(mean)

# with more than one group
mtcars %>% 
  select_if(is.numeric) %>%
  group_by(cyl, carb) %>% 
  summarise_all(mean)

## ------------------------------------------------------------------------
# without groups
mtcars %>% 
  select_if(is.numeric) %>%
  summarise_all(mean) %>%
  setNames(c("mean_cyl", "mean_carb", "mean_mpg", "mean_disp"))

# with one group
mtcars %>% 
  select_if(is.numeric) %>%
  group_by(cyl) %>% 
  summarise_all(mean) %>%
  setNames(c("mean_cyl", "mean_carb", "mean_mpg", "mean_disp"))


# with more than one group
mtcars %>% 
  select_if(is.numeric) %>%
  group_by(cyl, carb) %>% 
  summarise_all(mean) %>%
  setNames(c("mean_cyl", "mean_carb", "mean_mpg", "mean_disp"))

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
# without groups
mtcars %>% 
  summarise_at(vars(mpg, disp), funs(min, max))

# with one group
mtcars %>% 
  group_by(cyl) %>% 
  summarise_at(vars(mpg, disp), funs(min, max))

# with more than one group
mtcars %>% 
  group_by(cyl, carb) %>% 
  summarise_at(vars(mpg, disp), funs(min, max))

## ------------------------------------------------------------------------
# without groups
mtcars %>% 
  summarise_at(vars(mpg, disp), funs(min, max)) %>%
  setNames(c("min_mpg", "min_disp", "max_mpg", "max_disp"))

# with one group
mtcars %>% 
  group_by(cyl) %>% 
  summarise_at(vars(mpg, disp), funs(min, max)) %>%
  setNames(c("cyl", "min_mpg", "min_disp", "max_mpg", "max_disp"))

# with more than one group
mtcars %>% 
  group_by(cyl, carb) %>% 
  summarise_at(vars(mpg, disp), funs(min, max)) %>%
  setNames(c("cyl", "carb", "min_mpg", "min_disp", "max_mpg", "max_disp"))

## ------------------------------------------------------------------------
# without groups
mtcars %>% 
  select_if(is.numeric) %>%
  summarise_all(c("mean","sd"))

# with one group
mtcars %>% 
  select_if(is.numeric) %>%
  group_by(cyl) %>% 
  summarise_all(c("mean","sd"))

# with more than one group
mtcars %>% 
  select_if(is.numeric) %>%
  group_by(cyl, carb) %>% 
  summarise_all(c("mean","sd"))

## ------------------------------------------------------------------------
# without groups
mtcars %>% 
  select_if(is.numeric) %>%
  summarise_all(c("mean","sd")) %>%
  setNames(c("mean_cyl", "mean_carb", "mean_mpg", "mean_disp", "sdev_cyl", "sdev_carb", "sdev_mpg", "sdev_disp"))


# with one group
mtcars %>% 
  select_if(is.numeric) %>%
  group_by(cyl) %>% 
  summarise_all(c("mean","sd")) %>%
setNames(c("cyl", "mean_carb", "mean_mpg", "mean_disp",  "sd_carb",  "sd_mpg",  "disp_sd"))

# with more than one group
mtcars %>% 
  select_if(is.numeric) %>%
  group_by(cyl, carb) %>% 
  summarise_all(c("mean","sd")) %>%
  setNames(c("cyl","carb","mean_mpg", "mean_disp", "sdev_mpg", "sdev_disp"))

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
  mutate_at(vars(rescale_mpg = mpg), funs(rescale))

# with one group
mtcars %>% 
  group_by(carb) %>% 
  mutate_at(vars(rescale_mpg = mpg), funs(rescale))

# with more than one group
mtcars %>% 
  group_by(carb, cyl) %>% 
  mutate_at(vars(rescale_mpg = mpg), funs(rescale))

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
  mutate_at(vars(mpg), funs(rescale, order))

# with one group
mtcars %>% 
  group_by(carb) %>% 
  mutate_at(vars(mpg), funs(rescale, order))

# with more than one group
mtcars %>% 
  group_by(carb, cyl) %>% 
  mutate_at(vars(mpg), funs(rescale, order))

## ------------------------------------------------------------------------
# without groups
mtcars %>% 
  mutate_at(vars(mpg), funs(rescale_mpg = rescale, order_mpg = order))

# with one group
mtcars %>% 
  group_by(carb) %>% 
  mutate_at(vars(mpg), funs(rescale_mpg = rescale, order_mpg = order))

# with more than one group
mtcars %>% 
  group_by(carb, cyl) %>% 
  mutate_at(vars(mpg), funs(rescale_mpg = rescale, order_mpg = order))

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
# without groups
mtcars %>% 
  mutate_at(vars(mpg, disp), funs(rescale))

# with one group
mtcars %>% 
  group_by(carb) %>% 
  mutate_at(vars(mpg, disp), funs(rescale))

# with more than one group
mtcars %>% 
  group_by(carb, cyl) %>% 
  mutate_at(vars(mpg, disp), funs(rescale))

## ------------------------------------------------------------------------
# without groups
mtcars %>% 
  mutate_at(vars(rescale_mpg = mpg, rescale_disp = disp), funs(rescale))

# with one group
mtcars %>% 
  group_by(carb) %>% 
  mutate_at(vars(rescale_mpg = mpg, rescale_disp = disp), funs(rescale))

# with more than one group
mtcars %>% 
  group_by(carb, cyl) %>% 
  mutate_at(vars(rescale_mpg = mpg, rescale_disp = disp), funs(rescale))

## ------------------------------------------------------------------------
# without groups
mtcars %>%
  select_if(is.numeric) %>%
  mutate_all(rescale)

# with one group
mtcars %>% 
  select_if(is.numeric) %>%
  group_by(carb) %>% 
  mutate_all(rescale)

# with more than one group
mtcars %>% 
  select_if(is.numeric) %>%
  group_by(carb, cyl) %>% 
  mutate_all(rescale)

## ------------------------------------------------------------------------
# without groups
mtcars %>%
  select_if(is.numeric) %>%
  mutate_all(rescale) %>%
  setNames(c("rescaled_cyl", "rescaled_carb", "rescaled_mpg", "rescaled_disp"))

# with one group
mtcars %>% 
  select_if(is.numeric) %>%
  group_by(carb) %>% 
  mutate_all(rescale) %>%  
  setNames(c("rescaled_cyl", "rescaled_carb", "rescaled_mpg", "rescaled_disp"))

# with more than one group
mtcars %>% 
  select_if(is.numeric) %>%
  group_by(carb, cyl) %>% 
  mutate_all(rescale) %>%
    setNames(c("rescaled_cyl", "rescaled_carb", "rescaled_mpg", "rescaled_disp"))

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

## ------------------------------------------------------------------------
# without groups
mtcars %>% 
  mutate_at(vars(mpg,  disp), funs(rescale, order))

# with one group
mtcars %>% 
  group_by(carb) %>% 
  mutate_at(vars(mpg,  disp), funs(rescale, order))

# with more than one group
mtcars %>% 
  group_by(carb, cyl) %>% 
  mutate_at(vars(mpg,  disp), funs(rescale, order))

## ------------------------------------------------------------------------
# without groups
mtcars %>% 
  mutate_at(vars(mpg,  disp), funs(rescale, order)) %>% 
  rename(rescale_mpg = mpg_rescale, rescale_disp = disp_rescale, order_mpg = mpg_order, order_disp = disp_order)

# with one group
mtcars %>% 
  group_by(carb) %>% 
  mutate_at(vars(mpg,  disp), funs(rescale, order)) %>% 
  rename(rescale_mpg = mpg_rescale, rescale_disp = disp_rescale, order_mpg = mpg_order, order_disp = disp_order)

# with more than one group
mtcars %>% 
  group_by(carb, cyl) %>% 
  mutate_at(vars(mpg,  disp), funs(rescale, order)) %>%
  rename(rescale_mpg = mpg_rescale, rescale_disp = disp_rescale, order_mpg = mpg_order, order_disp = disp_order)

## ------------------------------------------------------------------------
# without groups
mtcars %>%
  select_if(is.numeric) %>%
  mutate_all(c("rescale", "order")) 

# with one group
mtcars %>% 
  select_if(is.numeric) %>%
  group_by(carb) %>% 
  mutate_all(c("rescale", "order"))

# with more than one group
mtcars %>% 
  select_if(is.numeric) %>%
  group_by(carb, cyl) %>% 
  mutate_all(c("rescale", "order"))

## ------------------------------------------------------------------------
# without groups
mtcars %>%
  select_if(is.numeric) %>%
  mutate_all(c("rescale", "order"))  %>%
  rename(rescale_carb = carb_rescale, rescale_cyl = cyl_rescale, rescale_mpg = mpg_rescale, rescale_disp = disp_rescale, order_carb = carb_order, order_cyl = cyl_order, order_mpg = mpg_order, order_disp = disp_order)

# with one group
mtcars %>% 
  select_if(is.numeric) %>%
  group_by(carb) %>% 
  mutate_all(c("rescale", "order")) %>%
  rename(rescale_cyl = cyl_rescale, rescale_mpg = mpg_rescale, rescale_disp = disp_rescale, order_cyl = cyl_order, order_mpg = mpg_order, order_disp = disp_order)

# with more than one group
mtcars %>% 
  select_if(is.numeric) %>%
  group_by(carb, cyl) %>% 
  mutate_all(c("rescale", "order")) %>%
  rename(rescale_mpg = mpg_rescale, rescale_disp = disp_rescale, order_mpg = mpg_order, order_disp = disp_order)

