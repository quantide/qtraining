## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
require(dplyr)
require(ggplot2)
require(qdata)
data(bands)

## ----presenting_gridArrange, message=FALSE, warning=FALSE----------------
gp0 <- ggplot(data=bands, aes(x=press_type, y=ink_pct)) + 
  geom_boxplot(fill="#3690c0") +
  ylab("Continuos variable") + xlab("Grouping variable") + 
  theme(
    axis.text.x = element_blank(), axis.text.y = element_blank()
  )

gp1 <- gp0 + theme(axis.ticks.x = element_blank())
  
gp2 <- gp0 + theme(axis.ticks.y = element_blank()) + coord_flip()

gp <- gridExtra::grid.arrange(gp1, gp2, ncol=2)

## ----presenting_recall, message=FALSE, warning=FALSE---------------------
gp

plot(gp)

## ----presenting_save_pdf, message=FALSE, warning=FALSE, results='hide'----
pdf("gp1.pdf")
plot(gp)
dev.off()

## ----presenting_save_cairopdf, message=FALSE, warning=FALSE, results='hide'----
cairo_pdf("gp2.pdf")
plot(gp)
dev.off()

## ----presenting_save_svg, message=FALSE, warning=FALSE, results='hide'----
svg("gp.svg")
plot(gp)
dev.off()

## ----presenting_save_pdf_width, message=FALSE, warning=FALSE, results='hide'----
cairo_pdf("gp3.pdf", width=12, height=8)
plot(gp)
dev.off()

## ----presenting_ggsave1, message=FALSE, warning=FALSE, results='hide'----
ggsave("boxplot1.pdf", width = 20, height = 20, units = "cm")

## ----presenting_ggsave2, message=FALSE, warning=FALSE, results='hide'----
ggsave("boxplot2.pdf", plot=gp1, width = 20, height = 20, units = "cm")

## ----presenting_save_png, message=FALSE, warning=FALSE, results='hide'----
png("gp.png", width=1200, height=800, res=300)
plot(gp)
dev.off()

## ----presenting_ggsave_png, message=FALSE, warning=FALSE, results='hide'----
ggsave("boxplot.png", width = 4, height = 3, dpi = 300)

