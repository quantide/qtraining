## ---- message=FALSE------------------------------------------------------
require(dplyr)
require(ggplot2)
require(BSDA)
require(tidyr)
require(qdata)

## ------------------------------------------------------------------------
data(cerealbx)
head(cerealbx)

## ------------------------------------------------------------------------
summary_stat <- cerealbx %>% 
  summarise(n=n(),
    min=min(BoxWeigh),
    first_qu=quantile(BoxWeigh, 0.25),
    mean=mean(BoxWeigh),
    median=median(BoxWeigh),
    third_qu=quantile(BoxWeigh, 0.75),
    max=max(BoxWeigh),
    sd=sd(BoxWeigh))

print(summary_stat)

ggp <- ggplot(data = cerealbx, mapping = aes(x="0", y=BoxWeigh)) +
  geom_boxplot(fill="darkgoldenrod1") + xlab("") + 
  theme(axis.text.x= element_blank(), axis.ticks.x = element_blank()) 

print(ggp)

## ------------------------------------------------------------------------
z.test(x = cerealbx$BoxWeigh, mu = 365, sigma.x = 2.4)

## ------------------------------------------------------------------------
data(cerealbx)
head(cerealbx)

## ------------------------------------------------------------------------
t.test(x = cerealbx$BoxWeigh, mu=365)

## ------------------------------------------------------------------------
data(plastic)
head(plastic)

## ------------------------------------------------------------------------
plastic_2 <- plastic %>% gather(supplier, resistance, SupplrA, SupplrB)

summary_stat <- plastic_2 %>% 
  group_by(supplier) %>% 
  summarise(n=n(),
    min=min(resistance),
    first_qu=quantile(resistance, 0.25),
    mean=mean(resistance),
    median=median(resistance),
    third_qu=quantile(resistance, 0.75),
    max=max(resistance),
    sd=sd(resistance))

print(summary_stat)

ggp <- ggplot(data = plastic_2, mapping = aes(x=supplier, y=resistance, fill=supplier)) +
  geom_boxplot()   

print(ggp)

## ------------------------------------------------------------------------
t.test(x=plastic$SupplrA, y=plastic$SupplrB, alternative = "two.sided")

## ------------------------------------------------------------------------
t.test(x=plastic$SupplrA, y=plastic$SupplrB, alternative = "less")

## ------------------------------------------------------------------------
data(carctl)
head(carctl)

## ------------------------------------------------------------------------
carctl2 <- carctl %>% gather(car, value, Car_A, Car_B)

summary_stat <- carctl2 %>% 
  group_by(car) %>% 
  summarise(n=n(),
    min=min(value),
    first_qu=quantile(value, 0.25),
    mean=mean(value),
    median=median(value),
    third_qu=quantile(value, 0.75),
    max=max(value),
    sd=sd(value))

print(summary_stat)

ggp <- ggplot(data = carctl2, mapping = aes(x=car, y=value, fill=car)) +
  geom_boxplot()

print(ggp)

## ------------------------------------------------------------------------
ggp <- ggplot(data = carctl, mapping = aes(x=Car_A, y=Car_B)) + 
  geom_point(col="darkblue")

print(ggp)

## ------------------------------------------------------------------------
carctl <- carctl %>% mutate(car_diff = Car_A - Car_B)
t.test(x=carctl$car_diff, mu=0)

## ------------------------------------------------------------------------
t.test(x=carctl$Car_A, y=carctl$Car_B, paired=TRUE)

## ------------------------------------------------------------------------
data(sturdy)
head(sturdy)

## ------------------------------------------------------------------------
summary_stat <- sturdy %>% 
  group_by(Group) %>%
  summarise(n=n(),
    min=min(Time),
    first_qu=quantile(Time, 0.25),
    mean=mean(Time),
    median=median(Time),
    third_qu=quantile(Time, 0.75),
    max=max(Time),
    sd=sd(Time))

print(summary_stat)

ggp <- ggplot(data = sturdy, mapping = aes(x=Group, y=Time, fill=Group)) +
  geom_boxplot()

print(ggp)

## ------------------------------------------------------------------------
anova <- aov(formula = Time~Group, data = sturdy)
summary(anova)

## ------------------------------------------------------------------------
data(rats)
head(rats)

## ------------------------------------------------------------------------
summary_stat <- rats %>% 
  group_by(Poison, Treatment) %>%
  summarise(n=n(),
    min=min(Time),
    first_qu=quantile(Time, 0.25),
    mean=mean(Time),
    median=median(Time),
    third_qu=quantile(Time, 0.75),
    max=max(Time),
    sd=sd(Time))

print(summary_stat)

ggp <- ggplot(data = rats, mapping = aes(x=Poison, y=Time, fill=Poison)) +
  geom_boxplot()

print(ggp)

ggp <- ggplot(data = rats, mapping = aes(x=Treatment, y=Time, fill=Treatment)) +
  geom_boxplot()

print(ggp)

## ------------------------------------------------------------------------
mod <- aov(formula = Time ~ Poison * Treatment, data=rats)
summary(mod)

## ------------------------------------------------------------------------
mod <- aov(formula = Time ~ Poison + Treatment, data=rats)
summary(mod)

## ------------------------------------------------------------------------
binom.test(x = 2, n = 100, p = 0.01)

## ------------------------------------------------------------------------
two_sample_prop_test <- function(x1,x2,n1,n2){
  p1 <- x1/n1
  p2 <- x2/n2
  numerator <- p1 - p2
  denominator <- (p1*(1-p1)/n1) + (p2*(1-p2)/n2)
  prop_test = numerator / sqrt(denominator)
  return(prop_test)
}

res <-two_sample_prop_test(x1=3,x2=4,n1=200,n2=500)
res

## ------------------------------------------------------------------------
p_value <- 2*(1 - pnorm(q = res))
p_value

## ------------------------------------------------------------------------
data(titanic)
head(titanic)

## ------------------------------------------------------------------------
 titanic %>% count(Class, Status)
rel_prop <- titanic %>%
  group_by(Class, Status) %>%
  summarise (n = n()) %>%
  mutate(freq = n / sum(n))
rel_prop

tot_prop <- titanic %>%
  group_by(Class) %>%
  summarise (n = n())
tot_prop

## ------------------------------------------------------------------------
prop.test(x = c(122, 1368), n = c(325, 1876))

