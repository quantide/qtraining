## Width of the R output
options(width = 108) # 108 (characters) fit the web page width

## Modify the str() function to:
#  - fit one line for each element;
#  - show only the first child objects
str <- function(...){utils::str(strict.width = "cut", max.level = 1, give.attr = FALSE, ...)}

## Width of plots
require(knitr)
opts_chunk$set(fig.width = 5, fig.height = 5)
# for plots with legends
plot_with_legend_fig_width_short <- 1.2 * opts_chunk$get()$fig.width
plot_with_legend_fig_width_medium <- 1.25 * opts_chunk$get()$fig.width
plot_with_legend_fig_width_large <- 1.3 * opts_chunk$get()$fig.width
plot_with_legend_fig_width_big <- 2 * opts_chunk$get()$fig.width
