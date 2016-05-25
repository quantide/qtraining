
# The following parameter set the width of the R output
options(width = 108) # 108 (characters) fit the web page width

# Modify the str() function to:
#  - fit one line for each element;
#  - show only the first child objects
str <- function(...){utils::str(strict.width = "cut", max.level = 1, give.attr = FALSE, ...)}