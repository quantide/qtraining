## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
require(dplyr)
require(ggplot2)

## ----linegraph_first, message=FALSE--------------------------------------
ggplot(data=(ChickWeight %>% filter(Chick==1)), mapping=aes(x=Time, y=weight)) + 
  geom_line()

## ----linegraph_set, message=FALSE----------------------------------------
ggplot(data=(ChickWeight %>% filter(Chick==1)), mapping=aes(x=Time, y=weight)) +
  geom_line(colour="darkblue", size = 2) 

## ----linegraph_linetype, message=FALSE-----------------------------------
ggplot(data=(ChickWeight %>% filter(Chick==1)), mapping=aes(x=Time, y=weight)) +
  geom_line(colour="darkblue", size = 2, linetype=2)

## ----linegraph_geompoint, message=FALSE----------------------------------
ggplot(data=(ChickWeight %>% filter(Chick==1)), mapping=aes(x=Time, y=weight)) + 
  geom_line() + 
  geom_point()

## ----linegraph_ChickWeightMean, message=FALSE----------------------------
ChickWeightMean <- ChickWeight %>% 
  group_by(Time, Diet) %>% 
  summarize(weight=mean(weight))
ChickWeightMean

## ----linegraph__sawtooth, message=FALSE----------------------------------
ggplot(data=ChickWeightMean, mapping=aes(x=Time, y=weight)) +
  geom_line() + 
  geom_point()

## ----linegraph_aes, message=FALSE----------------------------------------
ggplot(data=ChickWeightMean, mapping=aes(x=Time, y=weight, colour=Diet)) +
  geom_line() + 
  geom_point()

## ----linegraph_tg, message=FALSE-----------------------------------------
tg <- ToothGrowth %>% 
  group_by(supp, dose) %>% 
  summarize(length=mean(len))
tg

## ----linegraph_numericx, message=FALSE-----------------------------------
ggplot(data=tg, mapping=aes(x=dose, y=length, colour=supp)) +
  geom_line() + 
  geom_point()

## ----linegraph_factorx, message=TRUE-------------------------------------
ggplot(data=tg, mapping=aes(x=factor(dose), y=length, colour=supp)) +
  geom_line() + 
  geom_point()

## ---- message=FALSE------------------------------------------------------
ggplot(data=tg, mapping=aes(x=factor(dose), y=length, colour=supp, group=supp)) +
  geom_line() + 
  geom_point()

## ----linegraph_group1, message=FALSE-------------------------------------
ggplot(data=(tg%>%filter(supp=="OJ")), mapping=aes(x=factor(dose), y=length, group=1)) +
  geom_line() + 
  geom_point()

## ----linegraph_dodge, message=FALSE--------------------------------------
ggplot(data=tg, mapping=aes(x=factor(dose), y=length, colour=supp, group=supp)) +
  geom_line(position=position_dodge(0.15)) + 
  geom_point(position=position_dodge(0.15))

## ----linegraph_labels, message=FALSE-------------------------------------
ChickWeightMean <- ChickWeightMean %>%
  mutate(Diet = factor(Diet, levels=1:4, labels=c("A","B","C","D")))

## ----linegraph_setcolourmanual, message=FALSE----------------------------
ggplot(data=ChickWeightMean, mapping=aes(x=Time, y=weight, colour=Diet)) +
  geom_line() + 
  geom_point() + 
  scale_color_manual(values=c("red", "blue", "green", "orange"))

## ----linegraph_setcolourmanual_order, message=FALSE----------------------
ggplot(data=ChickWeightMean, mapping=aes(x=Time, y=weight, colour=Diet)) +
  geom_line() + 
  geom_point() + 
  scale_color_manual(values=c("D"="orange", "B"="blue", "A"="red", "C"="green"))

## ----linegraph_setshape_order, message=FALSE-----------------------------
ggplot(data=ChickWeightMean, mapping=aes(x=Time, y=weight, colour=Diet)) +
  geom_line(mapping=aes(linetype=Diet)) + 
  geom_point(mapping=aes(shape=Diet)) + 
  scale_color_manual(values=c("D"="orange", "B"="blue", "A"="red", "C"="green")) +
  scale_shape_manual(values=c(16,18,20,22)) + 
  scale_linetype_manual(values=c(1,3,5,6))

## ----linegraph_ChickWeightGrowthMean, message=FALSE----------------------
ChickWeightGrowth <- ChickWeight %>% 
  group_by(Chick) %>%
  mutate(growth=c(0,diff(weight))) %>% 
  filter(growth != 0)
  
ChickWeightGrowthMean <- ChickWeightGrowth %>% 
  group_by(Time, Diet) %>%
  summarize(growth=mean(growth)) 

ggp <- ggplot(data=ChickWeightGrowthMean, mapping=aes(x=Time, y=growth, colour=Diet)) +
  geom_line(mapping=aes(linetype=Diet)) + 
  geom_point(mapping=aes(shape=Diet))

ggp

## ----linegraph_hline, message=FALSE--------------------------------------
growth_avg <- ChickWeightGrowth %>%
  magrittr::use_series(growth) %>% 
  mean

ggp1 <- ggp + 
  geom_hline(yintercept = growth_avg, colour="grey20")

ggp1

## ----linegraph_vline, message=FALSE--------------------------------------
ggp1 + 
  geom_vline(xintercept = c(7,14,21), colour="grey40", linetype=3)

