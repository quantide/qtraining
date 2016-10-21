## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
require(dplyr)
require(ggplot2)
require(qdata)
data(bands)

## ----bargraph_first, message=FALSE---------------------------------------
ggplot(data=ChickWeight, mapping=aes(x=Diet)) + 
  geom_bar()

## ----bargraph_coordflip, message=FALSE-----------------------------------
ggplot(data=ChickWeight, mapping=aes(x=Diet)) + 
  geom_bar() + 
  coord_flip()

## ----bargraph_width, message=FALSE---------------------------------------
ggplot(data=ChickWeight, mapping=aes(x=Diet)) + 
  geom_bar(width=0.5)

## ----bargraph_setcolour, message=FALSE-----------------------------------
ggplot(data=ChickWeight, mapping=aes(x=Diet)) +
  geom_bar(fill=c("#74a9cf", "#3690c0", "#0570b0", "#034e7b"))

## ----bargraph_scalefill, message=FALSE-----------------------------------
ggplot(data=ChickWeight, mapping=aes(x=Diet)) +
  geom_bar(mapping=aes(fill=Diet)) +
  scale_fill_manual(values=c("#74a9cf", "#3690c0", "#0570b0", "#034e7b"))

## ----bargraph_mapping, message=FALSE-------------------------------------
ggplot(data=ChickWeight, mapping=aes(x=Diet)) +
  geom_bar(mapping=aes(fill=Diet))

## ----bargraph_nolegend_scale, message=FALSE------------------------------
ggplot(data=ChickWeight, mapping=aes(x=Diet)) +
  geom_bar(mapping=aes(fill=Diet)) +
  scale_fill_manual(values=c("#74a9cf", "#3690c0", "#0570b0", "#034e7b"), guide=FALSE)

## ----bargraph_nolegend_guides, message=FALSE-----------------------------
ggplot(data=ChickWeight, mapping=aes(x=Diet)) +
  geom_bar(mapping=aes(fill=Diet)) +
  scale_fill_manual(values=c("#74a9cf", "#3690c0", "#0570b0", "#034e7b")) +
  guides(fill=FALSE)

## ----bargraph_ChickWeightFreq, message=FALSE-----------------------------
ChickWeightFreq <- ChickWeight %>% 
  group_by(Diet) %>% 
  summarize(n=n())

ChickWeightFreq

## ----bargraph_error, message=FALSE---------------------------------------
ggplot(data=ChickWeightFreq, mapping=aes(x=Diet)) + 
  geom_bar()

## ----bargraph_identity, message=FALSE------------------------------------
ggplot(data=ChickWeightFreq, mapping=aes(x=Diet, y=n)) + 
  geom_bar(stat="identity")

## ----bargraph_stack, message=FALSE---------------------------------------
ggplot(data=bands, mapping=aes(x=press_type, fill=cylinder_size)) + 
  geom_bar()

## ----bargraph_fill, message=FALSE----------------------------------------
ggplot(data=bands, mapping=aes(x=press_type, fill=cylinder_size)) + 
  geom_bar(position="fill")

## ----bargraph_dodge, message=FALSE---------------------------------------
ggplot(data=bands, mapping=aes(x=press_type, fill=cylinder_size)) + 
  geom_bar(position="dodge")

## ----bargraph_manualdodge, message=FALSE---------------------------------
ggplot(data=bands, mapping=aes(x=press_type, fill=cylinder_size)) +
  geom_bar(position=position_dodge(0.85), width=0.6)

## ----bargraph_bands_freq_na, message=FALSE-------------------------------
bands_freq_na <- bands %>% group_by(press_type, cylinder_size) %>% summarise(n = n()) %>%
  right_join(
    expand.grid(
      press_type = bands %>% magrittr::use_series(press_type) %>% levels,
      cylinder_size = c(bands %>% magrittr::use_series(cylinder_size) %>% levels, NA)
    )
  )
bands_freq_na

## ----bargraph_stack_na, message=FALSE------------------------------------
ggplot(data=bands_freq_na, mapping=aes(x=press_type, y=n, fill=cylinder_size)) +
  geom_bar(stat="identity", position="dodge")

## ----bargraph_na_as_level, message=FALSE---------------------------------
bands <- bands %>% 
  mutate(cylinder_size = as.character(cylinder_size), 
         cylinder_size =ifelse(is.na(cylinder_size),"NA",cylinder_size), 
         cylinder_size = factor(cylinder_size, 
                                levels= c("CATALOG", "SPIEGEL", "TABLOID", "NA"), 
                                labels = c("CATALOG", "SPIEGEL", "TABLOID", "NA")))

ggplot(data=bands, mapping=aes(x=press_type, fill=cylinder_size)) +
  geom_bar() 

## ----bargraph_geomtext, message=FALSE------------------------------------
bands_freq <- bands %>% group_by(press_type) %>% summarize(n=n())
  
ggplot(data=bands, mapping=aes(x=press_type)) +
  geom_bar() +
  geom_text(data=bands_freq, mapping=aes(y=n, label=n), vjust=1.5, colour="white")

