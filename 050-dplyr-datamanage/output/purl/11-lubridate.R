## ----lubridate_require, message=FALSE------------------------------------
require(lubridate)

## ----lubridate_str-------------------------------------------------------
chr <- "01-02-12"
class(chr)

## ----lubridate_ymd-------------------------------------------------------
dmy(chr)
mdy(chr)
ymd(chr)

## ----lubridate_class-----------------------------------------------------
class(dmy(chr))

## ----lubridate_posix-----------------------------------------------------
as.numeric(dmy(chr))

## ----lubridate_myd-------------------------------------------------------
myd(chr)
dym(chr)
ydm(chr)

## ----lubridate_all-------------------------------------------------------
x <- c(20160101, "2016-01-02", "2016 01 03", "2016-1-4", "2016-1, 5", "Created on 2016 1 6", "201601 !!! 07")
ymd(x)

## ----lubridate_IBM, message=FALSE, warning=FALSE-------------------------
quantmod::getSymbols("IBM", return.class = 'data.frame')
head(IBM)

## ----lubridate_row_names-------------------------------------------------
IBM <- IBM %>% mutate(date = row.names(.)) %>% tbl_df 
IBM

## ----lubridate_IBM_mutate------------------------------------------------
IBM <- IBM %>% mutate(date = ymd(date))
IBM

## ----lubridate_extract---------------------------------------------------
IBM <- IBM %>% mutate(month = month(date), day = day(date), year = year(date))
IBM

## ----lubridate_ggp_facets------------------------------------------------
ggplot(data=IBM, mapping=aes(x=date)) +
  geom_line(aes(y=IBM.Adjusted)) + 
  facet_wrap(~ year, scales="free_x")

## ----lubridate_ggp_boxplot-----------------------------------------------
ggplot(data=IBM, mapping=aes(x=factor(month), y=IBM.Adjusted, group=month)) +
  geom_boxplot() +
  facet_wrap(~ year)

## ----lubridate_IBM_weekday-----------------------------------------------
IBM <- IBM %>% mutate(weekday = wday(date))
IBM

## ----lubridate_ggp_weekday-----------------------------------------------
ggplot(data=IBM, mapping=aes(
    x=factor(weekday, labels=c("Mon", "Tue", "Wed", "Thu", "Fri")), y=IBM.Volume, group=weekday)
  ) + geom_boxplot() + xlab("Week day")

## ----lubridate_leap------------------------------------------------------
ymd("2016-03-17") - ymd("2015-03-17")

## ----lubridate_years-----------------------------------------------------
ymd("2015-03-17") + years(1)

## ----lubridate_dyears----------------------------------------------------
ymd("2015-03-17") + dyears(1)

## ----lubridate_months----------------------------------------------------
ymd("2016-06-01") + months(1)
ymd("2016-06-01") - months(6)

## ----lubridate_months_na-------------------------------------------------
ymd("2016-01-31") + months(1)

## ----lubridate_days_30---------------------------------------------------
ymd("2016-01-31") + days(30)

## ----lubridate_months_m--------------------------------------------------
ymd("2016-01-31") %m+% months(1)

## ----lubridate_days------------------------------------------------------
ymd("2016-01-31") + days(7)
ymd("2016-03-26") - days(360)

## ----lubridate_diabetes, message=FALSE-----------------------------------
data(diabetes)
names(diabetes)
diabetes <- diabetes %>% unite(datetime, date, time)
diabetes

## ----lubridate_diabetes_ymd----------------------------------------------
diabetes <- diabetes %>% mutate(datetime = mdy_hm(datetime))
diabetes

## ----lubridate_h_hm_hms--------------------------------------------------
ymd_h("2016-03-10 08")
ymd_hm("2016-03-10 08:15")
ymd_hms("2016-03-10 08:15:40")
ymd_hms("16+03/10*08.15,40")
ymd_hms("160310:081540")

## ----lubridate_now-------------------------------------------------------
now()

## ----lubridate_tz--------------------------------------------------------
ymd_hms("2016-03-01 14:00:00", tz="CET")

## ----lubridate_tz_cest---------------------------------------------------
ymd_hms("2016-04-01 14:00:00", tz="CET")

## ----lubridate_dat-------------------------------------------------------
d <- ymd_hms("2016-03-01 14.00.00")
d
force_tz(d, tz="CET")
with_tz(d, tz="CET")

## ----lubridate_times-----------------------------------------------------
ymd_hms("2016-10-30 02:00:00", tz="CET") - hours(1)
ymd_hms("2016-10-30 02:00:00", tz="CET") - dhours(1)

## ----lubridate_crazy-----------------------------------------------------
ymd_hms("2016-03-27 01:30:00", tz="CET") + hours(1)
ymd_hms("2016-03-27 01:30:00", tz="CET") + dhours(1)

## ----lubridate_round-----------------------------------------------------
dttm <- c(ymd_hms("2016-03-27 14:15:00"), ymd_hms("2016-03-27 14:30:00"), ymd_hms("2016-03-27 14:45:00"))
dttm
ceiling_date(dttm, unit="hour")
floor_date(dttm, unit="hour")
round_date(dttm, unit="hour")

