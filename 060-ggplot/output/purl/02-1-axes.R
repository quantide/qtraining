## ---- include=FALSE------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, warning =FALSE, message = FALSE)

## ----setup, include=FALSE------------------------------------------------
require(ggplot2)
require(qdata)
require(scales)
require(xtable)
data(bands)
data(brainbod)

## ---- warning=FALSE, message=FALSE---------------------------------------
pl_1 <- ggplot(data=bands, aes(x=press_type, y=ink_pct)) + 
  geom_boxplot(fill="#74a9cf", colour="#034e7b")
pl_1

## ---- warning=FALSE, message=FALSE---------------------------------------
pl_1 + 
  coord_flip()

## ---- warning=FALSE, message=FALSE---------------------------------------
pl_1 + 
  coord_flip() + 
  scale_x_discrete(limits=rev(levels(bands$press_type)))

## ---- warning=FALSE, message=FALSE---------------------------------------
pl_1 + 
  coord_flip() + 
  scale_x_discrete(limits=c("MOTTER70","WOODHOE70","ALBERT70", "MOTTER94"))

## ---- warning=FALSE, message=FALSE---------------------------------------
pl_1 + 
  coord_flip() + 
  scale_x_discrete(limits=c("MOTTER70","WOODHOE70"))

## ---- warning=FALSE, message=FALSE---------------------------------------
pl_1 + 
  scale_y_continuous(limits=c(0, max(bands$ink_pct)))

## ---- eval =FALSE, warning=FALSE, message=FALSE--------------------------
## pl_1 +
##   ylim(0, max(bands$ink_pct))
## 
## pl_1 +
##   lims(y = c(0, max(bands$ink_pct)))

## ---- warning=FALSE, message=FALSE---------------------------------------
pl_1 + 
  ylim(limits=c(NA, 100))

## ---- warning=FALSE, message=FALSE---------------------------------------
pl_1 + 
  ylim(0, 100) + 
  scale_y_continuous(breaks=c(0, 50, 100))
pl_1 + 
  scale_y_continuous(breaks=c(0, 50, 100)) + 
  ylim(0, 100)

## ---- warning=FALSE, message=FALSE---------------------------------------
pl_1 + 
  scale_y_continuous(limits=c(0, 100), breaks=c(0, 50, 100))

## ---- warning=FALSE, message=FALSE---------------------------------------
# scale transformation method
pl_1 + 
  scale_y_continuous(limits = c(50, 60))
# coordinate transformation method
pl_1 + 
  coord_cartesian(ylim = c(50, 60))

## ---- warning=FALSE, message=FALSE---------------------------------------
pl_1 + 
  scale_y_reverse()

## ---- warning=FALSE, message=FALSE---------------------------------------
pl_1 + 
  ylim(70, 34)

## ---- warning=FALSE, message=FALSE---------------------------------------
pl_1 + 
  scale_y_reverse(limits=c(100, 0))

## ------------------------------------------------------------------------
pl_2 <- ggplot(data = bands, mapping = aes(y=ink_pct, x=solvent_pct)) +
  geom_point()

## ------------------------------------------------------------------------
pl_2  +
  coord_equal()

## ------------------------------------------------------------------------
pl_2  +
  coord_equal(ratio=1/2)

## ---- warning=FALSE, message=FALSE---------------------------------------
pl_3 <- ggplot(brainbod, aes(x=Body, y=Brain, label=Species)) +
geom_text(size=3)
pl_3

## ------------------------------------------------------------------------
pl_3 + 
  scale_x_log10() + 
  scale_y_log10()

## ------------------------------------------------------------------------
pl_3 + 
  scale_x_continuous(trans = log_trans()) +
  scale_y_continuous(trans = log2_trans())

## ---- warning=FALSE, message=FALSE---------------------------------------
pl_1 + 
  scale_y_continuous(breaks=c(41, 45, 51, 55, 60, 71, 77))

## ---- warning=FALSE, message=FALSE---------------------------------------
pl_1 + 
  scale_x_discrete(limits=c("MOTTER70","WOODHOE70", "MOTTER94", "ALBERT70"), breaks="WOODHOE70")

## ---- warning=FALSE, message=FALSE---------------------------------------
pl_1 + 
  theme(axis.text.y = element_blank())
pl_1 + 
  theme(axis.text = element_blank())

## ---- warning=FALSE, message=FALSE---------------------------------------
pl_1 + 
  theme(axis.ticks.y = element_blank(), axis.text.y = element_blank())
pl_1 + 
  theme(axis.ticks = element_blank(), axis.text = element_blank())

## ---- warning=FALSE, message=FALSE---------------------------------------
pl_1 + 
  scale_y_continuous(breaks=NULL)

## ---- warning=FALSE, message=FALSE---------------------------------------
pl_2

## ---- warning=FALSE, message=FALSE---------------------------------------
pl_2 +  
  scale_y_continuous(breaks=c(40, 50, 60, 70), labels=c("Less", "Medium-\nLess", "Medium-\nHigh", "High"))

## ---- warning=FALSE, message=FALSE---------------------------------------
pl_3

## ---- warning=FALSE, message=FALSE---------------------------------------
pl_3 +
  scale_x_log10()+
  scale_y_log10()

## ---- warning=FALSE, message=FALSE---------------------------------------
pl_3 + 
  scale_x_log10(breaks=10^(-1:5)) + 
  scale_y_log10(breaks=10^(0:3))

## ---- eval=FALSE---------------------------------------------------------
## require(scales)

## ---- warning=FALSE, message=FALSE---------------------------------------
pl_3 + 
  scale_x_log10(breaks=10^(-1:5), labels=trans_format("log10", math_format(10^.x))) +
  scale_y_log10(breaks=10^(0:3), labels=trans_format("log10", math_format(10^.x)))

## ---- warning=FALSE, message=FALSE---------------------------------------
pl_3 + 
  scale_x_continuous(trans = log_trans()) +
  scale_y_continuous(trans = log2_trans())

## ---- warning=FALSE, message=FALSE---------------------------------------
pl_3 + 
  scale_x_continuous(trans = log_trans(), breaks = trans_breaks("log", function(x) exp(x)),
    labels = trans_format("log", math_format(e^.x))) + 
  scale_y_continuous(trans = log2_trans(), breaks = trans_breaks("log2", function(x) 2^x),
    labels = trans_format("log2", math_format(2^.x)))

## ---- warning=FALSE, message=FALSE---------------------------------------
pl_1 + 
  scale_x_discrete(labels=c("Albert70", "Motter70", "Motter94", "Woodhoe70"))

## ---- warning=FALSE, message=FALSE---------------------------------------
# To rotate the text 90 degrees counterclockwise
pl_1 + 
  theme(axis.text.x = element_text(angle=90, hjust=1, vjust=0.5))
# Rotating the text 30 degrees
pl_1 + 
  theme(axis.text.x = element_text(angle=30, hjust=1, vjust=1))

## ---- warning=FALSE, message=FALSE---------------------------------------
pl_1 + 
  theme(axis.text.x = element_text(family="Times", face="bold", colour="darkgreen", size=rel(0.8)))

## ---- warning=FALSE, message=FALSE---------------------------------------
pl_1 + 
  theme(axis.ticks.x = element_line(colour="green", size=4), axis.ticks.y=element_line(colour="red"))

## ---- eval=FALSE, warning=FALSE, message=FALSE---------------------------
## pl_1 +
##   xlab("Pressure type") +
##   ylab("Ink percentage")
## pl_1 +
##   labs(x = "Pressure type", y = "Ink percentage")
## pl_1 +
##   scale_y_continuous(name="Ink percentage") +
##   scale_x_discrete(name="Pressure type")

## ---- echo=FALSE, warning=FALSE, message=FALSE---------------------------
pl_1 + 
  labs(x = "Pressure type", y = "Ink percentage")

## ---- warning=FALSE, message=FALSE---------------------------------------
pl_1 + 
  xlab("")

## ---- warning=FALSE, message=FALSE---------------------------------------
pl_1 + 
  theme(axis.title.x=element_blank())

## ---- warning=FALSE, message=FALSE---------------------------------------
pl_1 + 
  theme(axis.title.y=element_text(angle=0, face="italic", size=14, colour = "green"))

## ---- warning=FALSE, message=FALSE---------------------------------------
econ <- subset(economics, date >= as.Date("1992-05-01") & date < as.Date("1993-06-01"))

## ------------------------------------------------------------------------
pl_4 <- ggplot(econ, aes(x=date, y=psavert)) + 
  geom_line(colour = "orangered")
pl_4

## ---- warning=FALSE, message=FALSE---------------------------------------
# Use breaks, and rotate text labels
pl_4 + 
  scale_x_date(date_breaks= "2 month") + 
  theme(axis.text.x = element_text(angle=30, hjust=1))

## ---- warning=FALSE, message=FALSE---------------------------------------
pl_4 + 
  scale_x_date(date_breaks= "2 month", labels=date_format("%Y %b")) +
  theme(axis.text.x = element_text(angle=30, hjust=1))

## ---- echo=FALSE, results='asis'-----------------------------------------
dt_format_table <- data.frame(Option = c("%Y", "%y", "%m", "%b", "%B", "%d", "%U", "%W", "%w", "%a", "%A"), 
  Description = c("Year with century (2012)", "Year without century (12)", "Month as a decimal number (08)",
                  "Abbreviated month name in current locale (Aug)", "Full month name in current locale (August)",
                  "Day of month as a decimal number (04)", "Week of the year as a decimal number, with Sunday as the first day of the week (00–53)", "Week of the year as a decimal number, with Monday as the first day of the week (00–53)", "Day of week (0–6, Sunday is 0)", "Abbreviated weekday name (Thu)", "Full weekday name (Thursday)" ),
                              stringsAsFactors = FALSE)

dt_format_table <- xtable(dt_format_table, align = c("l", "l", "l"))
tab.attributes <- 'border="0" align="left" rules="all" style=" border-collapse: collapse;  font-size: 12pt; padding: 50px; width: 60%;"'
print(dt_format_table, include.rownames=FALSE, type='html', NA.string=NA, html.table.attributes=tab.attributes)

