## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(eval = FALSE)

## ----set spark-home------------------------------------------------------
Sys.setenv( SPARK_HOME = "/usr/local/spark")
Sys.getenv("SPARK_HOME")

## ------------------------------------------------------------------------
spark_install(version = "2.0.0", hadoop_version = "2.6")


## ------------------------------------------------------------------------
Sys.setenv( SPARK_HOME = "~/.cache/spark/spark-2.0.0-bin-hadoop2.6/")
sc <- spark_connect(master = "yarn", version = "2.0.0" )

## ------------------------------------------------------------------------
spark_web(sc)
spark_log(sc)

## ------------------------------------------------------------------------
spark_config(file = "config.yml", use_default = TRUE)

