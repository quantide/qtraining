## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples
require(dplyr)
require(tidyr)
require(qdata)

## ------------------------------------------------------------------------
data(people)
head(people)

## ----message=FALSE-------------------------------------------------------
require(ggplot2)

## ------------------------------------------------------------------------
ggplot(people, aes(x = Height, y = Weight, colour = Gender)) + geom_point()

## ------------------------------------------------------------------------
female <- people[people$Gender == 'Female',]
male <- people[people$Gender == 'Male',]

## ------------------------------------------------------------------------
with(people, plot(Height, Weight, type = "n"))
with(female, points(Height, Weight, col = "red"))
with(male, points(Height, Weight, col = "blue"))    

## ------------------------------------------------------------------------
df <- setNames(data.frame(c("EU", "US"), c(7,5), c(6,2), c(6,5)),
               c("country","0-17" , "18-65", "66+"))

df

## ------------------------------------------------------------------------
gather(df, key = "age", value = "freq" , 2:4)

## ------------------------------------------------------------------------
df <- data.frame(
  country = c("EU", "EU", "EU", "EU", "US", "US", "US", "US"),
  gnd_cls = c("M-C", "M-A", "F-C", "F-A", "M-C", "M-A", "F-C", "F-A"),
  freq = c(7,6,6,0,5,2,5,2))

df

## ------------------------------------------------------------------------
separate(df, col = "gnd_cls", into = c("gender", "class"), sep = "-")

## ------------------------------------------------------------------------
df <- data.frame(country = c("EU", "EU", "US", "US"),
                 stat = c("min", "max", "min", "max"),
                 value = c(3, 8 , 2, 9)
                 )
df

## ------------------------------------------------------------------------
spread(df, key = stat, value = value)

## ------------------------------------------------------------------------
df <- data.frame(
  country =  c("EU", "EU", "EU", "US", "US", "EU", "EU", "EU", "US", "US"),
  state	= c("UK", "FR", "CH", "WA",	"CA",	"UK",	"FR",	"CH",	"WA",	"CA"),
  km3 = c(244820, 643801, 41290,	184665,	403933,	244820,	643801,	41290, 184665, 403933),
  year = c(2015,	2015,	2015,	2016,	2016,	2015,	2015,	2015,	2016,	2016),
  event	= c(0, 4,	5, 6, 3, 4, 5, 3,	2, 1))

df

## ------------------------------------------------------------------------
df1 <-  df %>% 
  select(country, state, km3) %>% 
  distinct()
df1 

## ------------------------------------------------------------------------
df2 <- df %>%  select(state, year, event)

## ------------------------------------------------------------------------
EU <- data.frame(state = c("UK", "FR", "CH"), km3 = c(244820, 643801, 41290))
US <- data.frame(state = c("WA", "CA"), km3 = c(184664, 403933))

EU
US

## ------------------------------------------------------------------------
EU <- EU %>% mutate(country = "EU")
US <- US %>% mutate(country = "US")

## ------------------------------------------------------------------------
all <- Reduce(rbind , list(EU, US))
all

## ------------------------------------------------------------------------
messy <- data.frame(
  id = 1:4,
  trt = rep(c('control', 'treatment'), each = 2),
  work.T1 = c(7, 6, 4, 3),
  home.T1 = c(5, 4, 1, 3),
  work.T2 = c(22, 27, 20, 16),
  home.T2 = c(11, 7, 10, 6)
)
messy

## ------------------------------------------------------------------------
tidier <- gather(messy, key, time, -id, -trt)
tidier

## ------------------------------------------------------------------------
tidy <- separate(tidier, col = key, into = c("location", "time"), sep = "\\.")
tidy

## ---- message=FALSE------------------------------------------------------
require(quantmod)
require(lubridate)

## ------------------------------------------------------------------------
invisible(Sys.setlocale("LC_MESSAGES", "C"))
invisible(Sys.setlocale("LC_TIME", "C"))
getSymbols.google(Symbols = "IBM",
                  env = globalenv(),
                  return.class = 'data.frame',
                  from = "2015-01-01",
                  to = Sys.Date())
head(IBM)

## ------------------------------------------------------------------------
df  <- IBM  %>% 
  transmute(time = ymd(row.names(.)), open = IBM.Open, high = IBM.High, low = IBM.Low, close = IBM.Close) %>%
  gather(key = hloc, value = price, -time) %>%
  mutate(hloc = factor(hloc)) %>%
  tbl_df()
head(df)

## ------------------------------------------------------------------------
ggplot(data = df, aes(x = time, y = price, colour = hloc)) + geom_line() 

## ------------------------------------------------------------------------
df <- df %>% group_by(hloc) %>% mutate(returns = (price - lag(price))/lag(price))
head(df)

## ------------------------------------------------------------------------
df %>%
  group_by(hloc) %>%
  summarise(n = n(), avg = mean(returns, na.rm = TRUE), sd = sd(returns, na.rm = TRUE))

