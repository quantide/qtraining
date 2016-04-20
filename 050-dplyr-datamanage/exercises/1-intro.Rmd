---
title: "Exercises with `dplyr` and `tidyr`"
author:
- email: enrico.tonini\@quantide.com
  name: Enrico Tonini
date: ''
output:
  html_document:
    self_contained: no
  pdf_document: default
---



Introduction
===========================================

In this document you will find some exercises with R packages `dplyr` and `tidyr`. They are mainly based on the `nycflights13` data, taken from the `nycflights13` package.


## Introduction to `nycflights13` data

The `nycflights13` package contains information about all flights that departed from NYC (e.g. EWR, JFK and LGA) in 2013: 336,776 flights in total.


```r
require(nycflights13)
ls(pos = "package:nycflights13")
```

```
## [1] "airlines" "airports" "flights"  "planes"   "weather"
```

To help understand what causes delays, it includes a number of useful datasets:

* `flights`: information about all flights that departed from NYC
* `weather`: hourly meterological data for each airport;
* `planes`: construction information about each plane;
* `airports`: airport names and locations;
* `airlines`: translation between two letter carrier codes and names.


### `flights`

This dataset contains on-time data for all flights that departed from NYC (i.e. JFK, LGA or EWR) in 2013. The data frame has 16 variables and 336776 observations. The variables are organised as follow: 

* Date of departure: `year`, `month`, `day`;
* Departure and arrival times (local tz): `dep_time`, `arr_time`;
* Departure and arrival delays, in minutes: `dep_delay`, `arr_delay` (negative times represent early departures/arrivals);
* Time of departure broken in to hour and minutes: `hour`, `minute`;
* Two letter carrier abbreviation: `carrier`;
* Plane tail number: `tailnum`;
* Flight number: `flight`;
* Origin and destination: `origin`, `dest`;
* Amount of time spent in the air: `air_time`;
* Distance flown: `distance`.


```r
dim(flights)
```

```
## [1] 336776     16
```

```r
head(flights)
```

```
##   year month day dep_time dep_delay arr_time arr_delay carrier tailnum flight
## 1 2013     1   1      517         2      830        11      UA  N14228   1545
## 2 2013     1   1      533         4      850        20      UA  N24211   1714
## 3 2013     1   1      542         2      923        33      AA  N619AA   1141
## 4 2013     1   1      544        -1     1004       -18      B6  N804JB    725
## 5 2013     1   1      554        -6      812       -25      DL  N668DN    461
## 6 2013     1   1      554        -4      740        12      UA  N39463   1696
##   origin dest air_time distance hour minute
## 1    EWR  IAH      227     1400    5     17
## 2    LGA  IAH      227     1416    5     33
## 3    JFK  MIA      160     1089    5     42
## 4    JFK  BQN      183     1576    5     44
## 5    LGA  ATL      116      762    5     54
## 6    EWR  ORD      150      719    5     54
```

```r
str(flights)
```

```
## Classes 'tbl_df', 'tbl' and 'data.frame':	336776 obs. of  16 variables:
##  $ year     : int  2013 2013 2013 2013 2013 2013 2013 2013 2013 2013 ...
##  $ month    : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ day      : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ dep_time : int  517 533 542 544 554 554 555 557 557 558 ...
##  $ dep_delay: num  2 4 2 -1 -6 -4 -5 -3 -3 -2 ...
##  $ arr_time : int  830 850 923 1004 812 740 913 709 838 753 ...
##  $ arr_delay: num  11 20 33 -18 -25 12 19 -14 -8 8 ...
##  $ carrier  : chr  "UA" "UA" "AA" "B6" ...
##  $ tailnum  : chr  "N14228" "N24211" "N619AA" "N804JB" ...
##  $ flight   : int  1545 1714 1141 725 461 1696 507 5708 79 301 ...
##  $ origin   : chr  "EWR" "LGA" "JFK" "JFK" ...
##  $ dest     : chr  "IAH" "IAH" "MIA" "BQN" ...
##  $ air_time : num  227 227 160 183 116 150 158 53 140 138 ...
##  $ distance : num  1400 1416 1089 1576 762 ...
##  $ hour     : num  5 5 5 5 5 5 5 5 5 5 ...
##  $ minute   : num  17 33 42 44 54 54 55 57 57 58 ...
```


### `airlines`

This dataset contains airlines names and their respective carrier codes, it has 2 variables and 16 observations. Data structure shows that both variables involved are categorical.


```r
dim(airlines)
```

```
## [1] 16  2
```

```r
head(airlines)
```

```
##   carrier                     name
## 1      9E        Endeavor Air Inc.
## 2      AA   American Airlines Inc.
## 3      AS     Alaska Airlines Inc.
## 4      B6          JetBlue Airways
## 5      DL     Delta Air Lines Inc.
## 6      EV ExpressJet Airlines Inc.
```

```r
str(airlines)
```

```
## Classes 'tbl_df', 'tbl' and 'data.frame':	16 obs. of  2 variables:
##  $ carrier: Factor w/ 1570 levels "02Q","04Q","05Q",..: 127 143 265 305 485 551 564 584 668 903 ...
##  $ name   : Factor w/ 1571 levels "40-Mile Air",..: 604 268 236 837 554 635 678 229 751 606 ...
```


### `airports`

This dataset contains useful metadata about airports, that is:

* FAA airport code: `faa`;
* Usual name of the aiport: `name`;
* Location of airport: `lat`, `lon`;
* Altitude (in feet): `alt`;
* Timezone offset from GMT: `tz`;
* Daylight savings time zone: `dst` 
    A = Standard US 
    DST: starts on the second Sunday of March, ends on the first Sunday of November
    U = unknown
    N = no dst

The data frame has 7 variables and 1397 observations.


```r
dim(airports)
```

```
## [1] 1397    7
```

```r
head(airports)
```

```
##   faa                           name      lat       lon  alt tz dst
## 1 04G              Lansdowne Airport 41.13047 -80.61958 1044 -5   A
## 2 06A  Moton Field Municipal Airport 32.46057 -85.68003  264 -5   A
## 3 06C            Schaumburg Regional 41.98934 -88.10124  801 -6   A
## 4 06N                Randall Airport 41.43191 -74.39156  523 -5   A
## 5 09J          Jekyll Island Airport 31.07447 -81.42778   11 -4   A
## 6 0A9 Elizabethton Municipal Airport 36.37122 -82.17342 1593 -4   A
```

```r
str(airports)
```

```
## Classes 'tbl_df', 'tbl' and 'data.frame':	1397 obs. of  7 variables:
##  $ faa : chr  "04G" "06A" "06C" "06N" ...
##  $ name: chr  "Lansdowne Airport" "Moton Field Municipal Airport" "Schaumburg Regional" "Randall Airport" ...
##  $ lat : num  41.1 32.5 42 41.4 31.1 ...
##  $ lon : num  -80.6 -85.7 -88.1 -74.4 -81.4 ...
##  $ alt : int  1044 264 801 523 11 1593 730 492 1000 108 ...
##  $ tz  : num  -5 -5 -6 -5 -4 -4 -5 -5 -5 -8 ...
##  $ dst : chr  "A" "A" "A" "A" ...
```


### `planes`

This dataset contains plane metadata for all plane tailnumbers found in the FAA aircraft registry (American Airways (AA) and Envoy Air (MQ) report fleet numbers rather than tail numbers). The data frame has 9 variables and 3322 observations. The variables are organised as follow: 

* Tail number: `tailnum`;
* Year manufactured: `year`;
* Type of plane: `type`;
* Manufacturer and model: `manufacturer`, `model`;
* Number of engines and seats:  `engines`, `seats`;
* Average cruising speed in mph: `speed`;
* Type of engine: `engine`.


```r
dim(planes)
```

```
## [1] 3322    9
```

```r
head(planes)
```

```
##   tailnum year                    type     manufacturer     model engines seats
## 1  N10156 2004 Fixed wing multi engine          EMBRAER EMB-145XR       2    55
## 2  N102UW 1998 Fixed wing multi engine AIRBUS INDUSTRIE  A320-214       2   182
## 3  N103US 1999 Fixed wing multi engine AIRBUS INDUSTRIE  A320-214       2   182
## 4  N104UW 1999 Fixed wing multi engine AIRBUS INDUSTRIE  A320-214       2   182
## 5  N10575 2002 Fixed wing multi engine          EMBRAER EMB-145LR       2    55
## 6  N105UW 1999 Fixed wing multi engine AIRBUS INDUSTRIE  A320-214       2   182
##   speed    engine
## 1    NA Turbo-fan
## 2    NA Turbo-fan
## 3    NA Turbo-fan
## 4    NA Turbo-fan
## 5    NA Turbo-fan
## 6    NA Turbo-fan
```

```r
str(planes)
```

```
## Classes 'tbl_df', 'tbl' and 'data.frame':	3322 obs. of  9 variables:
##  $ tailnum     : chr  "N10156" "N102UW" "N103US" "N104UW" ...
##  $ year        : int  2004 1998 1999 1999 2002 1999 1999 1999 1999 1999 ...
##  $ type        : chr  "Fixed wing multi engine" "Fixed wing multi engine" "Fixed wing multi engine" "Fixed wing multi engine" ...
##  $ manufacturer: chr  "EMBRAER" "AIRBUS INDUSTRIE" "AIRBUS INDUSTRIE" "AIRBUS INDUSTRIE" ...
##  $ model       : chr  "EMB-145XR" "A320-214" "A320-214" "A320-214" ...
##  $ engines     : int  2 2 2 2 2 2 2 2 2 2 ...
##  $ seats       : int  55 182 182 182 55 182 182 182 182 182 ...
##  $ speed       : int  NA NA NA NA NA NA NA NA NA NA ...
##  $ engine      : chr  "Turbo-fan" "Turbo-fan" "Turbo-fan" "Turbo-fan" ...
```


### `weather`

This dataset is about hourly meterological data for LGA, JFK and EWR. The data frame has 14 variables and 8719 observations. The variables are organised as follow: 

* Weather station: `origin` (named `origin` to faciliate merging with `flights` data);
* Time of recording: `year`, `month`, `day`, `hour`;
* Temperature and dewpoint in F: `temp`, `dewp`;
* Relative humidity: `humid`;
* Wind direction (in degrees), speed and gust speed (in mph): `wind_dir`, `wind_speed`, `wind_gust`;
* Preciptation, in inches: `precip`;
* Sea level pressure in millibars: `pressure`;
* Visibility in miles: `visib`.


```r
dim(weather)
```

```
## [1] 8719   14
```

```r
head(weather)
```

```
##   origin year month day hour  temp  dewp humid wind_dir wind_speed wind_gust
## 1    EWR 2013     1   1    0 37.04 21.92 53.97      230   10.35702  11.91865
## 2    EWR 2013     1   1    1 37.04 21.92 53.97      230   13.80936  15.89154
## 3    EWR 2013     1   1    2 37.94 21.92 52.09      230   12.65858  14.56724
## 4    EWR 2013     1   1    3 37.94 23.00 54.51      230   13.80936  15.89154
## 5    EWR 2013     1   1    4 37.94 24.08 57.04      240   14.96014  17.21583
## 6    EWR 2013     1   1    6 39.02 26.06 59.37      270   10.35702  11.91865
##   precip pressure visib
## 1      0   1013.9    10
## 2      0   1013.0    10
## 3      0   1012.6    10
## 4      0   1012.7    10
## 5      0   1012.8    10
## 6      0   1012.0    10
```

```r
str(weather)
```

```
## Classes 'grouped_df', 'tbl_df', 'tbl' and 'data.frame':	8719 obs. of  14 variables:
##  $ origin    : chr  "EWR" "EWR" "EWR" "EWR" ...
##  $ year      : num  2013 2013 2013 2013 2013 ...
##  $ month     : num  1 1 1 1 1 1 1 1 1 1 ...
##  $ day       : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ hour      : int  0 1 2 3 4 6 7 8 9 10 ...
##  $ temp      : num  37 37 37.9 37.9 37.9 ...
##  $ dewp      : num  21.9 21.9 21.9 23 24.1 ...
##  $ humid     : num  54 54 52.1 54.5 57 ...
##  $ wind_dir  : num  230 230 230 230 240 270 250 240 250 260 ...
##  $ wind_speed: num  10.4 13.8 12.7 13.8 15 ...
##  $ wind_gust : num  11.9 15.9 14.6 15.9 17.2 ...
##  $ precip    : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ pressure  : num  1014 1013 1013 1013 1013 ...
##  $ visib     : num  10 10 10 10 10 10 10 10 10 10 ...
##  - attr(*, "vars")=List of 3
##   ..$ : symbol month
##   ..$ : symbol day
##   ..$ : symbol hour
##  - attr(*, "indices")=List of 8719
##   ..$ : int 0
##   ..$ : int 1
##   ..$ : int 2
##   ..$ : int 3
##   ..$ : int 4
##   ..$ : int 5
##   ..$ : int 6
##   ..$ : int 7
##   ..$ : int 8
##   ..$ : int 9
##   ..$ : int 10
##   ..$ : int 11
##   ..$ : int 12
##   ..$ : int 13
##   ..$ : int 14
##   ..$ : int 15
##   ..$ : int 16
##   ..$ : int 17
##   ..$ : int 18
##   ..$ : int 19
##   ..$ : int 20
##   ..$ : int 21
##   ..$ : int 22
##   ..$ : int 23
##   ..$ : int 24
##   ..$ : int 25
##   ..$ : int 26
##   ..$ : int 27
##   ..$ : int 28
##   ..$ : int 29
##   ..$ : int 30
##   ..$ : int 31
##   ..$ : int 32
##   ..$ : int 33
##   ..$ : int 34
##   ..$ : int 35
##   ..$ : int 36
##   ..$ : int 37
##   ..$ : int 38
##   ..$ : int 39
##   ..$ : int 40
##   ..$ : int 41
##   ..$ : int 42
##   ..$ : int 43
##   ..$ : int 44
##   ..$ : int 45
##   ..$ : int 46
##   ..$ : int 47
##   ..$ : int 48
##   ..$ : int 49
##   ..$ : int 50
##   ..$ : int 51
##   ..$ : int 52
##   ..$ : int 53
##   ..$ : int 54
##   ..$ : int 55
##   ..$ : int 56
##   ..$ : int 57
##   ..$ : int 58
##   ..$ : int 59
##   ..$ : int 60
##   ..$ : int 61
##   ..$ : int 62
##   ..$ : int 63
##   ..$ : int 64
##   ..$ : int 65
##   ..$ : int 66
##   ..$ : int 67
##   ..$ : int 68
##   ..$ : int 69
##   ..$ : int 70
##   ..$ : int 71
##   ..$ : int 72
##   ..$ : int 73
##   ..$ : int 74
##   ..$ : int 75
##   ..$ : int 76
##   ..$ : int 77
##   ..$ : int 78
##   ..$ : int 79
##   ..$ : int 80
##   ..$ : int 81
##   ..$ : int 82
##   ..$ : int 83
##   ..$ : int 84
##   ..$ : int 85
##   ..$ : int 86
##   ..$ : int 87
##   ..$ : int 88
##   ..$ : int 89
##   ..$ : int 90
##   ..$ : int 91
##   ..$ : int 92
##   ..$ : int 93
##   ..$ : int 94
##   ..$ : int 95
##   ..$ : int 96
##   ..$ : int 97
##   ..$ : int 98
##   .. [list output truncated]
##  - attr(*, "group_sizes")= int  1 1 1 1 1 1 1 1 1 1 ...
##  - attr(*, "biggest_group_size")= int 1
##  - attr(*, "labels")='data.frame':	8719 obs. of  3 variables:
##   ..$ month: num  1 1 1 1 1 1 1 1 1 1 ...
##   ..$ day  : int  1 1 1 1 1 1 1 1 1 1 ...
##   ..$ hour : int  0 1 2 3 4 6 7 8 9 10 ...
##   ..- attr(*, "vars")=List of 3
##   .. ..$ : symbol month
##   .. ..$ : symbol day
##   .. ..$ : symbol hour
```
