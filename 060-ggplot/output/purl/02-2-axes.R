## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
require(ggplot2)
require(qdata)
require(scales)
data(bands)
data(brainbod)

## ----pl_1----------------------------------------------------------------
pl_1 <- ggplot(data=bands, aes(x=press_type, y=ink_pct)) + 
  geom_boxplot(fill="#74a9cf", colour="#034e7b")
pl_1

## ----pl_1_swapped_axes---------------------------------------------------
pl_1 + 
  coord_flip()

## ----pl_1_reverse_discrete_axis_order------------------------------------
pl_1 + 
  coord_flip() + 
  scale_x_discrete(limits=rev(levels(bands$press_type)))

## ----pl_1_change_discrete_axis_order-------------------------------------
pl_1 + 
  coord_flip() + 
  scale_x_discrete(limits=c("MOTTER70","WOODHOE70","ALBERT70", "MOTTER94"))

## ----pl_1_remove_discrete_axis_level-------------------------------------
pl_1 + 
  coord_flip() + 
  scale_x_discrete(limits=c("MOTTER70","WOODHOE70"))

## ----pl_1_change_continuous_axis_limits_1--------------------------------
pl_1 + 
  scale_y_continuous(limits=c(0, max(bands$ink_pct)))

## ----pl_1_change_continuous_axis_limits_2, eval = FALSE------------------
## pl_1 +
##   ylim(0, max(bands$ink_pct))
## 
## pl_1 +
##   lims(y = c(0, max(bands$ink_pct)))

## ----pl_1_change_continuous_axis_limits_3--------------------------------
pl_1 + 
  ylim(limits=c(NA, 100))

## ----pl_1_limits_setting_conflict----------------------------------------
pl_1 + 
  ylim(0, 100) + 
  scale_y_continuous(breaks=c(0, 50, 100))
pl_1 + 
  scale_y_continuous(breaks=c(0, 50, 100)) + 
  ylim(0, 100)

## ----pl_1_limits_setting_conflict_solve----------------------------------
pl_1 + 
  scale_y_continuous(limits=c(0, 100), breaks=c(0, 50, 100))

## ----pl_1_limits_setting_coord-------------------------------------------
# scale transformation method
pl_1 + 
  scale_y_continuous(limits = c(50, 60))
# coordinate transformation method
pl_1 + 
  coord_cartesian(ylim = c(50, 60))

## ----pl_1_reverse_continuous_axis_order_1--------------------------------
pl_1 + 
  scale_y_reverse()

## ----pl_1_reverse_continuous_axis_order_2--------------------------------
pl_1 + 
  ylim(70, 34)

## ----pl_1_reverse_continuous_axis_order_3--------------------------------
pl_1 + 
  scale_y_reverse(limits=c(100, 0))

## ----pl_2----------------------------------------------------------------
pl_2 <- ggplot(data = bands, mapping = aes(y=ink_pct, x=solvent_pct)) +
  geom_point()

## ----pl_2_same_scale-----------------------------------------------------
pl_2  +
  coord_equal()

## ----pl_2_resize_scale---------------------------------------------------
pl_2  +
  coord_equal(ratio=1/2)

## ----pl_3----------------------------------------------------------------
pl_3 <- ggplot(brainbod, aes(x=Body, y=Brain, label=Species)) +
geom_text(size=3)
pl_3

## ----pl_3_log_scale_1----------------------------------------------------
pl_3 + 
  scale_x_log10() + 
  scale_y_log10()

## ----pl_3_log_scale_2----------------------------------------------------
pl_3 + 
  scale_x_continuous(trans = log_trans()) +
  scale_y_continuous(trans = log2_trans())

## ----pl_1_change_tick_marks_position_continuous--------------------------
pl_1 + 
  scale_y_continuous(breaks=c(41, 45, 51, 55, 60, 71, 77))

## ---- pl_1_change_tick_marks_position_discrete---------------------------
pl_1 + 
  scale_x_discrete(limits=c("MOTTER70","WOODHOE70", "MOTTER94", "ALBERT70"), breaks="WOODHOE70")

## ----pl_1_remove_tick_labels---------------------------------------------
pl_1 + 
  theme(axis.text.y = element_blank())
pl_1 + 
  theme(axis.text = element_blank())

## ----pl_1_remove_tick_marks_labels_1-------------------------------------
pl_1 + 
  theme(axis.ticks.y = element_blank(), axis.text.y = element_blank())
pl_1 + 
  theme(axis.ticks = element_blank(), axis.text = element_blank())

## ----pl_1_remove_tick_marks_labels_2-------------------------------------
pl_1 + 
  scale_y_continuous(breaks=NULL)

## ----pl_2_show-----------------------------------------------------------
pl_2

## ----pl_2_change_tick_labels_text----------------------------------------
pl_2 +  
  scale_y_continuous(breaks=c(40, 50, 60, 70), labels=c("Less", "Medium-\nLess", "Medium-\nHigh", "High"))

## ----pl_3_show-----------------------------------------------------------
pl_3

## ----pl_3_log_scale_show-------------------------------------------------
pl_3 +
  scale_x_log10()+
  scale_y_log10()

## ----pl_3_change_tick_labels_text----------------------------------------
pl_3 + 
  scale_x_log10(breaks=10^(-1:5)) + 
  scale_y_log10(breaks=10^(0:3))

## ----load_scales, eval=FALSE---------------------------------------------
## require(scales)

## ----pl_3_change_tick_labels_text_math_format_1--------------------------
pl_3 + 
  scale_x_log10(breaks=10^(-1:5), labels=trans_format("log10", math_format(10^.x))) +
  scale_y_log10(breaks=10^(0:3), labels=trans_format("log10", math_format(10^.x)))

## ----pl_3_transformed_scales---------------------------------------------
pl_3 + 
  scale_x_continuous(trans = log_trans()) +
  scale_y_continuous(trans = log2_trans())

## ----pl_3_change_tick_labels_text_math_format_2--------------------------
pl_3 + 
  scale_x_continuous(trans = log_trans(), breaks = trans_breaks("log", function(x) exp(x)),
    labels = trans_format("log", math_format(e^.x))) + 
  scale_y_continuous(trans = log2_trans(), breaks = trans_breaks("log2", function(x) 2^x),
    labels = trans_format("log2", math_format(2^.x)))

## ----pl_1_change_tick_labels_text_discrete-------------------------------
pl_1 + 
  scale_x_discrete(labels=c("Albert70", "Motter70", "Motter94", "Woodhoe70"))

## ----pl_1_change_tick_labels_appearance_1--------------------------------
# To rotate the text 90 degrees counterclockwise
pl_1 + 
  theme(axis.text.x = element_text(angle=90, hjust=1, vjust=0.5))
# Rotating the text 30 degrees
pl_1 + 
  theme(axis.text.x = element_text(angle=30, hjust=1, vjust=1))

## ----pl_1_change_tick_labels_appearance_2--------------------------------
pl_1 + 
  theme(axis.text.x = element_text(family="Times", face="bold", colour="darkgreen", size=rel(0.8)))

## ----pl_1_change_tick_marks_appearance-----------------------------------
pl_1 + 
  theme(axis.ticks.x = element_line(colour="green", size=4), axis.ticks.y=element_line(colour="red"))

## ----pl_1_change_axis_labels, eval=FALSE---------------------------------
## pl_1 +
##   xlab("Pressure type") +
##   ylab("Ink percentage")
## pl_1 +
##   labs(x = "Pressure type", y = "Ink percentage")
## pl_1 +
##   scale_y_continuous(name="Ink percentage") +
##   scale_x_discrete(name="Pressure type")

## ----pl_1_remove_axis_labels_1-------------------------------------------
pl_1 + 
  xlab("")

## ----pl_1_remove_axis_labels_2-------------------------------------------
pl_1 + 
  theme(axis.title.x=element_blank())

## ----pl_1_change_axis_labels_appearance----------------------------------
pl_1 + 
  theme(axis.title.y=element_text(angle=0, face="italic", size=14, colour = "green"))

## ----economics_sample----------------------------------------------------
econ <- subset(economics, date >= as.Date("1992-05-01") & date < as.Date("1993-06-01"))

## ----pl_4----------------------------------------------------------------
pl_4 <- ggplot(econ, aes(x=date, y=psavert)) + 
  geom_line(colour = "orangered")
pl_4

## ----pl_4_change_axis_labels_1-------------------------------------------
# Use breaks, and rotate text labels
pl_4 + 
  scale_x_date(date_breaks= "2 month") + 
  theme(axis.text.x = element_text(angle=30, hjust=1))

## ----pl_4_change_axis_labels_2-------------------------------------------
pl_4 + 
  scale_x_date(date_breaks= "2 month", labels=date_format("%Y %b")) +
  theme(axis.text.x = element_text(angle=30, hjust=1))

