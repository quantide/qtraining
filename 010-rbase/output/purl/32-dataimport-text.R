## ----read.table, error=TRUE----------------------------------------------
df <- read.table("C:/Users/UserName/Documents/dati/tennis.txt", header = TRUE, sep = "", dec = ".")

## ---- getwd--------------------------------------------------------------
getwd() 

## ---- setwd, eval=FALSE--------------------------------------------------
## setwd("C:/Users/UserName/Documents/dati")

## ---- read.table2--------------------------------------------------------
df <- read.table("tennis.txt", header = TRUE)

## ---- head---------------------------------------------------------------
head(df)

## ---- nrows1-------------------------------------------------------------
read.table("tennis.txt", header = TRUE, sep = "", dec = ".", nrows = 3)

## ---- nrows2-------------------------------------------------------------
read.table("tennis.txt", header = FALSE, sep = "", dec = ".", skip = 2)

## ---- nrows3-------------------------------------------------------------
read.table("tennis.txt", header = FALSE, sep = "", dec = ".", nrows = 2, skip = 2)

## ---- stringsAsFactors---------------------------------------------------
df <- read.table("tennis.txt", header = TRUE, sep = "", dec = ".", stringsAsFactors = FALSE)
head(df)

## ---- na.strings---------------------------------------------------------
# Data frame imported without na.strings parameter 
df <- read.table("tennis.NA.txt", header = TRUE, sep = "", dec = ".", stringsAsFactors = FALSE)
head(df)
# Data frame imported considering also na.strings parameter
df <- read.table("tennis.NA.txt", header = TRUE, sep = "", dec = ".", na.strings = c("MC", "ND"), stringsAsFactors = FALSE)
head(df)

## ---- write.table, eval = FALSE------------------------------------------
## # It creates a df_write.txt file in the current directory containing df data frame
## df <- data.frame(a1 = rnorm(10), a2 = rnorm(10), a3 = rnorm(10))
## write.table(df, file = "df_write.txt")

