## ---- message=FALSE------------------------------------------------------
require(ggplot2)
require(ggthemes)
require(xtable)
require(qdata)
data(bands)

## ---- warning=FALSE, message=FALSE---------------------------------------
pl <- ggplot(data = bands, mapping = aes(x= humidity, y = viscosity, colour =press_type)) +
  geom_point()
pl

## ---- warning=FALSE, message=FALSE---------------------------------------
pl + 
  theme(axis.line.x = element_line(colour = "black"),
           axis.line.y = element_line(colour = "black"))

## ---- warning=FALSE, message=FALSE---------------------------------------
pl + 
  theme_bw()

## ---- echo=FALSE, results='asis'-----------------------------------------
dt_format_table <- data.frame(Argument = c("family", "face", "colour", "size", "hjust", "vjust", "angle", "lineheight"),
                              Description = c("font family", "font face", "font color", "font size (pts)", "horizontal justification", "vertical justification", "text angle", "line height"),
                              Value = c("''", "'plain'", "'black'", "10", "0.5", "0.5", "0", "	1.1"),
                              stringsAsFactors = FALSE)
names(dt_format_table) <- c("Argument", "Description", "Default Value")
dt_format_table <- xtable(dt_format_table, align = c("c", "c", "c", "c"))
tab.attributes <- 'border="0" align="left" rules="all" style=" border-collapse: collapse;  font-size: 12pt; padding: 50px; width: 70%;"'
print(dt_format_table, include.rownames=FALSE, type='html', NA.string=NA, html.table.attributes=tab.attributes)

## ---- echo=FALSE, results='asis'-----------------------------------------
dt_format_table <- data.frame(Argument = c("colour", "size", "linetype"),
                              Description = c("line color", "line thickness", "type of line"),
                              Value = c("'black'", "0.5", "1"),
                              stringsAsFactors = FALSE)
names(dt_format_table) <- c("Argument", "Description", "Default Value")
dt_format_table <- xtable(dt_format_table, align = c("c", "c", "c", "c"))
tab.attributes <- 'border="0" align="left" rules="all" style=" border-collapse: collapse;  font-size: 12pt; padding: 50px; width: 70%;"'
print(dt_format_table, include.rownames=FALSE, type='html', NA.string=NA, html.table.attributes=tab.attributes)

## ---- echo=FALSE, results='asis'-----------------------------------------
dt_format_table <- data.frame(Argument = c("fill", "colour", "size", "linetype"),
                              Description = c("fill color", "border color", "	thickness of border line", "type of border line"),
                              Value = c("NA (none)", "'black'", "0.5", "1 (solid)"),
                              stringsAsFactors = FALSE)
names(dt_format_table) <- c("Argument", "Description", "Default Value")
dt_format_table <- xtable(dt_format_table, align = c("c", "c", "c", "c"))
tab.attributes <- 'border="0" align="left" rules="all" style=" border-collapse: collapse;  font-size: 12pt; padding: 50px; width: 70%;"'
print(dt_format_table, include.rownames=FALSE, type='html', NA.string=NA, html.table.attributes=tab.attributes)

## ---- echo=FALSE, results='asis'-----------------------------------------
dt_format_table <- data.frame(Element = c("plot.background", "plot.title", "plot.margin"),
                              Setter = c("element_rect()", "element_text()", "unit()"),
                              Description = c("plot background", "plot title", "margins around plot"),
                              stringsAsFactors = FALSE)

dt_format_table <- xtable(dt_format_table, align = c("c", "c", "c", "c"))
tab.attributes <- 'border="0" align="left" rules="all" style=" border-collapse: collapse;  font-size: 12pt; padding: 50px; width: 70%;"'
print(dt_format_table, include.rownames=FALSE, type='html', NA.string=NA, html.table.attributes=tab.attributes)

## ---- warning=FALSE, message=FALSE---------------------------------------
pl + 
  labs(title = "Plot title") +
  theme(plot.title = element_text(size = 20, vjust = 2),
        plot.background = element_rect(
          fill = "lightblue",
          colour = "black",
          size = 2,
          linetype = "longdash"),
        plot.margin = unit(c(1, 1, 1, 1), "in"))

## ---- echo=FALSE, results='asis'-----------------------------------------
dt_format_table <- data.frame(Element = c("axis.line", "axis.text", "axis.text.x", "axis.text.y", "axis.title", "axis.title.x", 
                                          "axis.title.y", "axis.ticks", "axis.ticks.length", "axis.ticks.margin"),
                              Setter = c("element_line()", "element_text()", "element_text()", "element_text()", "element_text()", "element_text()", "element_text()", "element_line()", "unit()", "unit()"),
                              Description = c("line parallel to axis (hidden in default theme)", "tick labels", "x-axis tick labels", 
                                              "y-axis tick labels", "axis titles", "x-axis title", "y-axis title", "axis tick marks", 
                                              "length of tick marks", "width of axis tick margin"),
                              stringsAsFactors = FALSE)

dt_format_table <- xtable(dt_format_table, align = c("c", "c", "c", "c"))
tab.attributes <- 'border="0" align="left" rules="all" style=" border-collapse: collapse;  font-size: 12pt; padding: 50px; width: 70%;"'
print(dt_format_table, include.rownames=FALSE, type='html', NA.string=NA, html.table.attributes=tab.attributes)

## ---- warning=FALSE, message=FALSE---------------------------------------
pl + 
  theme(
    axis.line.x = element_line(colour = "red", size = 2),
    axis.line.y = element_line(colour = "orange", linetype = "dashed"),
    axis.text = element_text(color = "blue", size = 15, face = "italic"),
    axis.text.y = element_text(angle = 90, size = rel(0.7), hjust = 0),
    axis.ticks = element_line(colour = "violet"),
    axis.ticks.x = element_line(size = rel(2)),
    axis.title = element_text(size = 20, color = "orangered")
)

## ---- echo=FALSE, results='asis'-----------------------------------------
dt_format_table <- data.frame(Element = c("legend.background", "legend.key", "legend.key.size", "legend.key.height", "legend.key.width", 
                                          "legend.margin", "legend.text", "legend.text.align", "legend.title", "legend.title.align",
                                          "legend.position", "legend.direction", "legend.justification", "legend.box"),
                              Setter = c("element_rect()", "element_rect()", "unit()", "unit()", "unit()", "unit()", "element_text()",
                                         "numeric", "element_text()", "numeric", "'left', 'right', 'bottom' ', 'top'", "numeric", 
                                         "numeric", "numeric"),
                              Description = c("legend background", "background of legend keys", "", "legend key height", 
                                              "legend key width", "legend margin", "legend labels", "legend label alignment",
                                              "legend name", "legend name alignment", "position of legend", "direction of legend keys", 
                                              "justification of legend", "position of multiple legend boxes"),
                              stringsAsFactors = FALSE)

dt_format_table <- xtable(dt_format_table, align = c("c", "c", "c", "c"))
tab.attributes <- 'border="0" align="left" rules="all" style=" border-collapse: collapse;  font-size: 12pt; padding: 50px; width: 70%;"'
print(dt_format_table, include.rownames=FALSE, type='html', NA.string=NA, html.table.attributes=tab.attributes)

## ---- warning=FALSE, message=FALSE---------------------------------------
pl + 
  theme(
    legend.position = "top",
    legend.box = "horizontal",
    legend.background = element_rect(
      fill = "lemonchiffon",
      color = "black",
      size = 1,
      linetype = "longdash"
    ),
    legend.key = element_rect(fill = "lemonchiffon", color = "magenta"),
    legend.key.width = unit(0.5, "in"),
    legend.key.height = unit(0.2, "in"),
    legend.text = element_text(size = 8),
    legend.title = element_text(face = "bold", size = 10, colour = "magenta"))

## ---- echo=FALSE, results='asis'-----------------------------------------
dt_format_table <- data.frame(Element = c("panel.background", "panel.border", "panel.grid.major", "panel.grid.major.x", "panel.grid.major.y", 
                                          "panel.grid.minor", "panel.grid.minor.x", "panel.grid.minor.y", "panel.margin", "aspect.ratio"),
                              Setter = c("element_rect()", "element_rect()", "element_line()", "element_line()", "element_line()",
                                         "element_line()", "element_text()", "element_line", "numeric", "numeric"),
                              Description = c("background of graphics region", "border of graphics region", "major grid lines", 
                                              "vertical major grid lines height", "horizontal major grid lines", "minor grid lines", 
                                              "vertical minor grid lines", "horizontal minor grid lines",
                                              "margin between facets", "plot aspect ratio"),
                              stringsAsFactors = FALSE)

dt_format_table <- xtable(dt_format_table, align = c("c", "c", "c", "c"))
tab.attributes <- 'border="0" align="left" rules="all" style=" border-collapse: collapse;  font-size: 12pt; padding: 50px; width: 70%;"'
print(dt_format_table, include.rownames=FALSE, type='html', NA.string=NA, html.table.attributes=tab.attributes)

## ---- warning=FALSE, message=FALSE---------------------------------------
pl + 
  theme(
    panel.background = element_rect(fill = "navy", color = "orange", size = 2),
    panel.border = element_rect(fill = NA, colour = "orange", size = 2),
    panel.grid.major = element_line(color = "gray60", size = 0.8),
    panel.grid.major.x = element_blank())

## ---- echo=FALSE, results='asis'-----------------------------------------
dt_format_table <- data.frame(Element = c("strip.background", "strip.text", "strip.text.x", "strip.text.y"),
                              Setter = c("element_rect()", "element_text()", "element_text()", "element_text()"),
                              Description = c("background of panel strips", "strip text", "horizontal strip text", 
                                              "vertical strip text"),
                              stringsAsFactors = FALSE)

dt_format_table <- xtable(dt_format_table, align = c("c", "c", "c", "c"))
tab.attributes <- 'border="0" align="left" rules="all" style=" border-collapse: collapse;  font-size: 12pt; padding: 50px; width: 70%;"'
print(dt_format_table, include.rownames=FALSE, type='html', NA.string=NA, html.table.attributes=tab.attributes)

## ---- warning=FALSE, message=FALSE---------------------------------------
ggplot(data = bands, mapping = aes(x= humidity, y = viscosity)) +
  geom_point() + facet_grid(band_type ~ press_type) +
  theme(
    strip.background = element_rect(fill = "#4bb8b6", color = "#265665", size = 2),
    strip.text = element_text(face = "italic", size = 15, colour = "#CC1800"),
  strip.text.y = element_text(face = "bold")
  )

## ---- eval =FALSE--------------------------------------------------------
## pl +
##   ggtitle("Scatterplot of humidity vs viscosity \n by Pressure type")
## pl +
##   labs(title = "Scatterplot of humidity vs viscosity \n by Pressure type")

## ---- echo=FALSE, warning=FALSE, message=FALSE---------------------------
pl + 
  ggtitle("Scatterplot of humidity vs viscosity \n by Pressure type")

## ---- warning=FALSE, message=FALSE---------------------------------------
pl + 
  ggtitle("Scatterplot of humidity vs viscosity \n by Pressure type") +
  theme(plot.title=element_text(size=rel(2), lineheight=.9, family="Times", face="bold.italic", colour="red"))

## ---- warning=FALSE, message=FALSE---------------------------------------
pl + 
  theme(
    panel.background = element_rect(fill="lightblue"),
    panel.border = element_rect(colour="blue", fill=NA, size=2)
)

## ---- warning=FALSE, message=FALSE---------------------------------------
pl + 
  theme(
    panel.grid.major = element_line(colour="red"),
    panel.grid.minor = element_line(colour="red", linetype="dashed", size=0.2)
)

## ---- warning=FALSE, message=FALSE---------------------------------------
pl + 
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
)

## ---- warning=FALSE, message=FALSE---------------------------------------
pl + 
  theme(
    panel.grid.major.x = element_blank(), # remove horizontal grid major lines 
    panel.grid.minor.y = element_blank()  # remove vertical grid minor lines
)

## ---- warning=FALSE, message=FALSE---------------------------------------
pl + 
  theme(
    plot.background = element_rect(fill = "green")
)

## ---- warning=FALSE, message=FALSE---------------------------------------
pl + 
  theme(
    plot.margin = unit(c(2,2,2,2), "cm")
)

## ---- warning=FALSE, message=FALSE, fig.width=10, fig.height=10----------
pl1 <- pl + theme_bw() + ggtitle("theme_bw()")
pl2 <- pl + theme_linedraw() + ggtitle("theme_linedraw()")
pl3 <- pl + theme_light() + ggtitle("theme_light()")
pl4 <- pl + theme_dark() + ggtitle("theme_dark()")
pl5 <- pl + theme_minimal() + ggtitle("theme_minimal()")
pl6 <- pl + theme_classic() + ggtitle("theme_classic()")
pl7 <- pl + theme_void() + ggtitle("theme_void()")

gridExtra::grid.arrange(pl1, pl2, pl3, pl4, pl5, pl6, pl7, ncol=2)

## ---- warning=FALSE, message=FALSE, fig.width=10, fig.height=7-----------
pl8 <- pl + theme_tufte() + ggtitle("theme_tufte()") #  a minimal ink theme based on Tufte’s The Visual Display of Quantitative Information
pl9 <- pl + theme_solarized() + ggtitle("theme_solarized()") # a theme using the solarized color palette
pl10 <- pl + theme_excel() + ggtitle("theme_excel()") # a theme replicating the classic gray charts in Excel
pl11 <- pl + theme_few() + ggtitle("theme_few()") # theme from Stephen Few’s “Practical Rules for Using Color in Charts”
pl12 <- pl + theme_economist() + ggtitle("theme_economist()") # a theme based on the plots in the The Economist magazine
pl13 <- pl + theme_stata() + ggtitle("theme_stata()") # themes based on Stata graph schemes
pl14 <- pl + theme_wsj() + ggtitle("theme_wsj()") # a theme based on the plots in the The Wall Street Journa

gridExtra::grid.arrange(pl8, pl9, pl10, pl11, ncol=2)

## ---- warning=FALSE, message=FALSE, fig.width=6.5, fig.height=3.5--------
pl12
pl13
pl14

## ---- eval =FALSE--------------------------------------------------------
## theme_set(theme_bw())

## ---- warning=FALSE, message=FALSE---------------------------------------
mytheme <- theme_bw() +
theme(text = element_text(colour="red"),
      axis.title = element_text(size = rel(1.25)))

## ---- warning=FALSE, message=FALSE---------------------------------------
pl + 
  mytheme

