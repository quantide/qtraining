## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
require(ggplot2)
require(ggthemes)
require(xtable)
require(qdata)
data(bands)

## ----pl------------------------------------------------------------------
pl <- ggplot(data = bands, mapping = aes(x= humidity, y = viscosity, colour =press_type)) +
  geom_point()
pl

## ----pl_axes_lines-------------------------------------------------------
pl + 
  theme(axis.line.x = element_line(colour = "black"),
        axis.line.y = element_line(colour = "black"))

## ----pl_theme_bw---------------------------------------------------------
pl + 
  theme_bw()

## ----plot_theme_el_example-----------------------------------------------
pl + 
  labs(title = "Plot title") +
  theme(plot.title = element_text(size = 36, hjust = 0, colour = "lightslateblue", 
                                  face = "italic"),
        plot.background = element_rect(fill = "lightsteelblue1", colour = "black", 
                                       size = 2, linetype = "solid"),
        plot.margin = unit(c(2, 2, 2, 2), "cm"))

## ----axes_theme_el_example-----------------------------------------------
pl + 
  theme(
    axis.line.x = element_line(colour = "green4", size = 1.5),
    axis.line.y = element_line(colour = "green4", linetype = "dashed", size = 1.5),
    axis.text = element_text(color = "springgreen4", size = 15, face = "bold"),
    axis.text.y = element_text(angle = 90, size = rel(0.7), hjust = 0),
    axis.ticks = element_line(colour = "green4", size = 2),
    axis.ticks.x = element_line(size = rel(1.5)),
    axis.title = element_text(size = 20, color = "forestgreen", face = "bold.italic")
)

## ----legend_theme_el_example---------------------------------------------
pl + 
  theme(
    legend.position = "top",
    legend.box = "horizontal",
    legend.background = element_rect(fill = "lemonchiffon", color = "black", 
                                     size = 1, linetype = "longdash" ),
    legend.key = element_rect(fill = "lemonchiffon", color = "magenta"),
    legend.key.width = unit(0.8, "cm"),
    legend.key.height = unit(0.8, "cm"),
    legend.text = element_text(face = "bold", size = 10),
    legend.title = element_text(face = "bold", size = 12, colour = "magenta")
    )

## ----panel_theme_el_example----------------------------------------------
pl + 
  theme(
    panel.background = element_rect(fill = "navy", color = "orange", size = 2),
    panel.border = element_rect(fill = NA, colour = "darkorange", size = 2),
    panel.grid.major = element_line(color = "orange", size = 0.3),
    panel.grid.minor = element_blank()
    )

## ----facet_theme_el_example----------------------------------------------
ggplot(data = bands, mapping = aes(x= humidity, y = viscosity)) +
  geom_point() + 
  facet_grid(band_type ~ press_type) +
  theme(
    strip.background = element_rect(fill = "#4bb8b6", color = "#265665", size = 2),
    strip.text = element_text(face = "italic", size = 15, colour = "#CC1800"),
    strip.text.y = element_text(face = "bold")
  )

## ----pl_change_background------------------------------------------------
pl + 
  theme(
    panel.background = element_rect(fill="lightblue"),
    panel.border = element_rect(colour="blue", fill=NA, size=2)
)

## ----pl_customize_grid_lines_1-------------------------------------------
pl + 
  theme(
    panel.grid.major = element_line(colour="red"),
    panel.grid.minor = element_line(colour="red", linetype="dashed", size=0.2)
)

## ----pl_remove_grid_lines------------------------------------------------
pl + 
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
)

## ----pl_customize_grid_lines_2-------------------------------------------
pl + 
  theme(
    panel.grid.major.x = element_blank(), # remove horizontal grid major lines 
    panel.grid.minor.y = element_blank()  # remove vertical grid minor lines
)

## ----pl_add_title, eval =FALSE-------------------------------------------
## pl +
##   ggtitle("Scatterplot of humidity vs viscosity \n by Pressure type")
## pl +
##   labs(title = "Scatterplot of humidity vs viscosity \n by Pressure type")

## ----pl_customize_title--------------------------------------------------
pl + 
  ggtitle("Scatterplot of humidity vs viscosity \n by Pressure type") +
  theme(
    plot.title=element_text(size=rel(2), lineheight=0.9, family="Times", 
                            face="bold.italic", colour="red")
        )

## ----pl_customize_background---------------------------------------------
pl + 
  theme(
    plot.background = element_rect(fill = "springgreen2",linetype = "solid",
                                   colour = "black", size = 2)
)

## ----pl_customize_margins------------------------------------------------
pl + 
  theme(
    plot.margin = unit(x = c(2, 2, 2, 2), units = "cm")
)

## ----change_theme, fig.width=10, fig.height=10---------------------------
pl1 <- pl + theme_bw() + ggtitle("theme_bw()")
pl2 <- pl + theme_linedraw() + ggtitle("theme_linedraw()")
pl3 <- pl + theme_light() + ggtitle("theme_light()")
pl4 <- pl + theme_dark() + ggtitle("theme_dark()")
pl5 <- pl + theme_minimal() + ggtitle("theme_minimal()")
pl6 <- pl + theme_classic() + ggtitle("theme_classic()")
pl7 <- pl + theme_void() + ggtitle("theme_void()")

gridExtra::grid.arrange(pl1, pl2, pl3, pl4, pl5, pl6, pl7, ncol=2)

## ----change_theme_ggtheme, fig.width=12, fig.height=11-------------------
pl8 <- pl + theme_tufte() + ggtitle("theme_tufte()") 
pl9 <- pl + theme_solarized() + ggtitle("theme_solarized()") 
pl10 <- pl + theme_excel() + ggtitle("theme_excel()") 
pl11 <- pl + theme_few() + ggtitle("theme_few()") 
pl12 <- pl + theme_economist() + ggtitle("theme_economist()")  
pl13 <- pl + theme_stata() + ggtitle("theme_stata()") 
pl14 <- pl + theme_wsj() + ggtitle("theme_wsj()") 

gridExtra::grid.arrange(pl8, pl9, pl10, pl11, pl12, pl13, pl14, ncol=2)

## ----set_theme, eval =FALSE----------------------------------------------
## theme_set(theme_bw())

## ----create_theme_1------------------------------------------------------
mytheme <- theme_bw() +
theme(text = element_text(colour="slateblue4"),
      axis.title = element_text(size = rel(1.25), face = "bold"),
      legend.title = element_text(size = rel(1.25), face = "bold"),
      plot.background = element_rect(colour ="black")
      )

## ----create_theme_2------------------------------------------------------
pl + 
  mytheme

