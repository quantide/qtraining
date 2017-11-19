## ----ggplot-spark--------------------------------------------------------
 ## Collect some data
delay <-
    spark_table %>% 
    group_by(TailNum) %>%
    summarise(count = n(), dist = mean(Distance), delay = mean(ArrDelay)) %>%
    filter(count > 20, dist < 2000, !is.na(delay)) %>%
    collect()

 ## Plot delays
library(ggplot2)
ggplot(delay, aes(dist, delay)) +
  geom_point(aes(size = count), alpha = 1/2) 

