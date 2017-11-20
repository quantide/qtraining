## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(eval = FALSE)

## ----sparklyr installation-----------------------------------------------
install.packages("devtools")
devtools::install_github("rstudio/sparklyr")

## ----require-sparklyr----------------------------------------------------
require(sparklyr)

## ------------------------------------------------------------------------
spark_install(version = "2.0.0")

## ------------------------------------------------------------------------
sc <- spark_connect( master = "local", version = "2.0.0" )

## ------------------------------------------------------------------------
spark_version(sc)

## ------------------------------------------------------------------------
spark_disconnect(sc)

