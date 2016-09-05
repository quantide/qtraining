# courses-material
Repository del materiale dei corsi

## General information

Data for all courses is provided with the qdata package. This are the instructions to use them:

```{r}
install.packages("~/dev/qtraining/00-qdata/pkgs/qdata_0.24.tar.gz", repo = NULL )
require(qdata)
data("bank")
```

## Single-course folder

Each course has its own folder which should containt at least:

1. `input/` folder
2. `output/` folder, which contains materials that will be provided to students. Htmls with the full content of the class, pdf and purl (which is R code extracted from html)
3. `exercises/` folder contains sources of exercises 
4. `Makefile` contains instructions for the building of `output` folder
