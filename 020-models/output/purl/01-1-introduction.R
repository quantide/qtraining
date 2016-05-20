## ---- message=FALSE------------------------------------------------------
require(ggplot2)
require(qdata)
require(dplyr)

## ------------------------------------------------------------------------
data(sample)
str(ds)
head(ds)

## ----fig.cap="Relation between Weight and Height of 200 young people",fig.show='hold'----
ggp <- ggplot(data=ds,mapping = aes(x=height, y=weight)) +
  geom_point(colour="darkblue") +
  xlab("Height") + ylab("Weight") + 
  ggtitle("Plot of Weight Vs. Height in 200 young people")

print(ggp)

## ----fig.cap="Relation between Weight and Height in 200 young people with 'best constant model'", fig.show='hold'----
ds2 <- ds %>% slice(c(1,1:20*10))
ds2 <- ds2 %>% mutate(x1=height, x0=height, y0=weight, y1=mean(weight))

ggp <- ggplot(data=ds,mapping = aes(x=height, y=weight)) +
  geom_point(colour="darkblue") +
  geom_hline(yintercept = mean(ds$weight), colour="red") +
  geom_segment(data=ds2,mapping = aes(x=x0, xend=x1, y=y0, yend=y1), colour="green", linetype=2) +
  xlab("Height") + ylab("Weight") + 
  ggtitle("Plot of Weight Vs. Height in 200 young people")

print(ggp)

## ----fig.cap="Relation between Weight and Height in 200 young people with best straight line model", fig.show='hold'----
ds1 <- ds %>% arrange(height)
md <- lm(weight~height*gender,data=ds1)
ds2 <- ds2 %>% mutate(y1=predict(md,newdata=ds2))

ggp <- ggplot(data=ds,mapping = aes(x=height, y=weight)) +
  geom_point(colour="darkblue") +
  geom_smooth(method = "lm",se = FALSE, colour="red") + 
  geom_segment(data=ds2,mapping = aes(x=x0, xend=x1, y=y0, yend=y1), colour="green", linetype=2) +
  xlab("Height") + ylab("Weight") + 
  ggtitle("Plot of Weight Vs. Height in 200 young people")

print(ggp)

## ----fig.cap="Relation between Weight and Height in 100 male and 100 female young people"----
ggp <- ggplot(data=ds,mapping = aes(x=height, y=weight, colour=gender)) +
  geom_point() +
  geom_smooth(mapping = aes(colour=gender), method = "lm",se = FALSE ) + 
  geom_segment(data=ds2,mapping = aes(x=x0, xend=x1, y=y0, yend=y1), colour="green", linetype=2) +
  xlab("Height") + ylab("Weight") + 
  ggtitle("Plot of Weight Vs. Height in 200 young people")+
  theme(legend.position="top")

print(ggp)

