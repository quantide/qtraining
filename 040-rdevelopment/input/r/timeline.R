install.packages('timeline',repos='http://cran.r-project.org')
require(timeline)


t <- read.table("r/timeline.txt", header=TRUE)
t$eventi <- paste0("(",t$date,") ", t$eventi)
t <- t[,c(2,1,3)]
t$end <- c(t$date[2:length(t$date)], 2024)
t$end[5] <- 2002
t$end[8] <- 2010
t

source("r/timeline-function.R")

png(filename = "images/timeline.png", width = 970, height = 540, units = "px", pointsize = 12, res = 72)
timeline(t, label.col.hand="software", num.label.steps = 1) + scale_x_continuous(limits=c(1978,2024), breaks=seq(1976,2016,2))
dev.off()
