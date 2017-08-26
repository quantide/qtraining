## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
# load packages
require(tidyverse)
require(stringr)
require(qdata)

## ------------------------------------------------------------------------
# character vector
char_vector <- c("Hello", "world", "!")

## ------------------------------------------------------------------------
# character vector
str_length(char_vector)

## ------------------------------------------------------------------------
# character vector
str_c("Hello", "World", sep = " ")

## ------------------------------------------------------------------------
# character vector
str_c("Hello", "world", "!", sep = " ")
str_length(str_c("Hello", "world", "!", sep = " "))

## ------------------------------------------------------------------------
str_c(char_vector, collapse = " ")

## ----setwd, eval=FALSE---------------------------------------------------
## setwd("./data")

## ------------------------------------------------------------------------
tennis <- read_table("tennis.txt", col_names = TRUE)
head(tennis)

## ------------------------------------------------------------------------
tennis %>% 
  mutate_at(vars(Name), funs(str_c(First.Name, Name, sep = " "))) %>%
  select(-First.Name)   # drop the column "First.Name"

## ------------------------------------------------------------------------
char_vector <- c("Hello world !")
str_split(char_vector, " " )

## ------------------------------------------------------------------------
tennis_new <- tennis %>% 
  mutate_at(vars(Name), funs(str_c(First.Name, Name, sep = " "))) %>%
  select(-First.Name)   # drop the column "First.Name"

## ------------------------------------------------------------------------
str_split(tennis_new$Name, " ")

## ------------------------------------------------------------------------
str_split(tennis_new$Name, " ", simplify = TRUE)

## ------------------------------------------------------------------------
df <- tibble(comune = c('Legnano', 'Parabiago', 'Alpette', 'Andezano'),
                 provincia = c('Milano', 'Mi', 'Torino', 'To'))

## ------------------------------------------------------------------------
df %>% distinct(provincia) # 4 different values

## ------------------------------------------------------------------------
df %>% 
  mutate_at(vars(provincia), funs(str_sub(provincia, 1, 2)))

## ------------------------------------------------------------------------
"hello" == "hello"
"hello" == "HELLO"

## ------------------------------------------------------------------------
str_to_upper(c("hello"))
str_to_lower(c("HELLO"))

## ------------------------------------------------------------------------
df %>% 
  mutate_at(vars(provincia), funs(str_sub(provincia, 1, 2))) %>%
  mutate_at(vars(provincia), funs(str_to_upper(provincia)))

## ------------------------------------------------------------------------
province <- c("milano", "milan", "mi", "milano", "torino", "to", "agrigento")
str_detect(province, c("to"))

## ------------------------------------------------------------------------
province <- c("milano", "milan", "mi", "milano", "torino", "to", "agrigento")
str_detect(province, c("^to"))

## ------------------------------------------------------------------------
province <- c("milano", "milan", "mi", "milano", "torino", "to", "agrigento")
str_detect(province, c("to$"))

## ------------------------------------------------------------------------
province <- c("milano", "milan", "mi", "milano", "torino", "to", "agrigento")
str_extract(province, c("to$"))

## ------------------------------------------------------------------------
colors <- c("gray", "gray", "grey", "white", "white", "white")
str_replace(colors, c("gray"), "grey")

## ------------------------------------------------------------------------
colors <- c("gray", "gray", "grey", "white", "white", "white")
colors_levels <- c("gray", "white")
factor(colors, levels = colors_levels)

