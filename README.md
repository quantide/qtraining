---
title: '`qtraining` repository'
output:
  pdf_document: default
  html_document: default
---

Date of documentation update: 20161220  
Documentation updated by: Veronica

# Introduction

`qtraining` repository contains Quantide training courses material. 

The courses included are:

* __R for Beginners__ (two days course)
* __R for Beginners__ (one day course)
* __Statistical Models with R__
* __Base R programming__
* __Data Manipulation with R__
* __Data Visualization with R__ in english and in italian (under development) 
* __Data Mining with R__
* __Big Data__ (under development)


# `qtraining` Structure

`qtraining` repository contains both courses development material and courses manuals.  
The structure is organized in the following folders:  

* _00-qdata_: containing courses data organized as an R package, named `qdata`
* _010-rbase-two-days_: containing "R for Beginners" (two days) course
* _011-rbase-one-days_: containing "R for Beginners" (one day) course
* _020-models_: containing "Statistical Models with R" course 
* _030-rprogramming-base_: containing "Base R programming" course
* _050-dplyr-datamanage_: containing "Data Manipulation with R" course
* _060-ggplot_: containing "Data Visualization with R" course 
* _061-ggplot-ita_: containing "Data Visualization with R" course in italian (under development)
* _080-data-mining_: containing "Data Mining with R" course
* _100-bigdata-spark_: contanis "Big Data" course 
* _courses-index_: containing courses index
* _include_: containing files for output structure building

All previous folders includes courses material, apart from _00-qdata_, _courses-index_ and _include_ folders.  

# An overview on courses material folders

Each course material folder name must be identified by a __number__ and by the __course name__, in the following format: "number-course name".  
The __number__ to be assigned to the course name must consist of three digits and the __course name__ must describe the course name in short. If the __course name__ consists in more than one word, the words must be separated by `-`.  

The courses material folders have the same base structure:

1. _input_ folder, which contains source files of course material
2. _output_ folder, which contains built course material files
3. _exercises_ folder, which contains source files of exercises 
4. _docs_ folder, which contains documents useful for course development
5. _Makefile_, which is a text file containg code written in Linux kernel. It is a simple way to organize code compilation. It contains the instructions for building the content of `output` folder
6. RStudio project file, named `course name.Rproj`

In some courses material folder is included also _data_ folder, which contains data that can't be included in `qdata` package.

## input folder

It includes:

* _Markdown and R Markdown scripts with course content_. Course content is organized in chapters. Each chapter is identified by a script. It is recommended to add a number to the script names for ordering them (e.g. 01-first.Rmd).
* _images_ folder, which contains figures to be included in the course content 
* _TOC_ file, which contains course index. 


### TOC file

TOC files includes the structure of the course manual.

The md or Rmd files must be ordered from the first to the last and must be associated with a title.
In particular, you have to write firstly the title, then "|" and finally the md and Rmd name.
You can also divide the rmd into sections, writing only the title of the section before the belonging Rmds.

Here an example:

First Section 
First Rmd				| 1-first.Rmd
Second Rmd  		| 2-second.Rmd

Second Section
Third Rmd				| 1-third.Rmd


## output folder

It includes:

* _html_ folder, which contains htmls files with the full content of the course and a zip folder containing all html files (the folder name is "course name.zip") 
* _purl_ folder, which contains R script with R code extracted from html (one R script for each html file), and a zip folder containing all R scripts (the folder name is "R.zip")
* _pdf_ folder, which contains pdf file/s of courses exercises (this folder is not always present)

## exercises folder

It includes:

* Markdown and R Markdown scripts with course exercises_.
* _images_ folder, which contains figures to be included in exercises content 

This folder is not populated in all material courses folders.
It is populated in: _010-rbase_, _020-models_, _050-dplyr-datamanage_.   
In _010-rbase_ and _050-dplyr-datamanage_, exercises are organized in chapters. Each chapter is identified by a script. The pdf file/s of courses exercises are built by the _Makefile_ and included in _output/pdf_ folder.   
In _020-models_ script exercises and built pdf and html files are included in _exercises_ folder. They are not built by the _Makefile_, but manually clicking "Knit PDF" from RStudio toolbar, because the exercises are not yet completed. 

 
## Guide for building course material

1. Open RStudio
2. Double-click on the project file
3. Click on "Build All" from RStudio "Build" tab or click "Ctrl+Shift+B" on the keyboard 

The course building follows the instructions provided by _Makefile_. For more details see the _Makefile_ of the course of interest.


# _00-qdata_ folder

This folder contains courses data organized as an R package, named `qdata`.  
It is structured in the following way:

* _data_ folder, which contains data in .RData format included in `qdata` package
* _R_ folder, which contains two R script: `qdata.R` and `qdata-data.R` with package and data documentation (written with roxigen2)
* _pkgs_ folder, which contains `qdata` package versions realized
* _doc_ folder, which contains an R script `raw-data.R`. This script includes some commands of operations done on data before including them in package.
* _rowdata_ folder, which contains original data files
* _DESCRIPTION_ file, which contains library desciption
* _NAMESPACE_ file, which contains informations about imported and exported functions (automatically
created by library ‘build’)
* R project file, named `qdata.Rproj`

On Decembre 20 2016, the version of qdata is 0.27.

## Guide for building `qdata`

### Build `qdata`

`qdata` is an R package so its building works as well as any R package building.

1. Open RStudio
2. Double-click on the project file
3. Click "Build & Reload" on RStudio "Build" tab or click "Ctrl+Shift+B" on the keyboard

_Note:_ When one ore more data file/s are added or when data documentation is modified, the package version MUST be updated. To update the package version modify _Version:_ tag in _DESCRIPTION_ file going forward of one digit (e.g. 027 -> 0.28)  

### Create source package

When you edit a new version of qdata, you MUST build a Source package of the new version:

Follow these steps:

1. Move the folders: _pkgs_ and _rowdata_ from _00-qdata_ folder into another location (cut and paste), in order to not include them in the source package
2. Open RStudio
3. Open "More" window on RStudio "Build" Tab
4. Click on "Build Source package"
5. Reinsert the folders: _pkgs_ and _rowdata_ into _00-qdata_ folder
6. Move the file _qdata\_x.xx.tar.gz_ from "~dev/qtraining/00-qdata" into "~dev/qtraining/00-qdata/pkgs" 


## Guide for installing and loading `qdata`  

1. Open RStudio
2. Install the package typing the following lines on the R console: 

```{r}
install.packages("~/dev/qtraining/00-qdata/pkgs/qdata_0.27.tar.gz", repo = NULL )
```

3. Loading `qdata` package on the workspace, typing:

```{r}
require(qdata)
```

4. Loading data, included in `qdata` package, on the workspace. For example, if we want to load "bank" data we have to type:

```{r}
data("bank")
```

Otherwise, you can install `qdata` from Rstudio "Packages" tab:

1. Open RStudio
2. Click on "Install"
3. Set "Install from" filed to "Package Archive (.tar.gz)"
4. Choose "qdata" for "Packages" field


## qdata locations 

The materials included into _00-qdata_ folder is included also in another github repository:
[https://github.com/quantide/qdata](https://github.com/quantide/qdata).

_qdata_ is a public Quantide repository contining the data necessary for public courses available on Quantide website. So also this version has to be updated. When you update the version on _qtraining_ repository you have to update also that in _qdata_ repository. 

Advice to update version: in _qdata_ repository, add the added .Rdata files into _data_ folder, and replace the scripts included in _R_ folder with that modified of _qtraining_ version.  

_Future Developments:_ develop _qdata_ package into a single location. 


# _include_ folder

This folder contains files with the instructions on output files structure building for each course. It means that the _Makefile_ of each course refers to these files for building the structure of output files.

It is structured in these folders:

* _html_
* _libs_
* _r_
* _tex_


# _courses-index_ folder

The content of this folder is used for building an index of courses.  
It includes:

* _course-index.html_: html file of courses index 
* _images_ folder: which includes figures used in _course-index.html_ file 

## Modify courses index

1. Open _course-index.html_ with a text editor
2. Modify the file. The code is written in HTML
3. Save the file


# Other Details

## Generate a PDF BOOK starting from rmds (bookdown)

To buid a book in PDF containing the rmds:

1. See PDF BOOK section in Makefile of 060-ggplot 
2. Use _bookdown_ package

Using _bookdown_ is the better option.  
It organizes in a better way the materials, avoiding problems with LateX (spaces, positioning, ...)  


### To use _bookdown_:

1. set working directory inside _input_ folder
2. De-comment _bookdown::pdf_book:_ part and comment html_document part
3. Modify _manual-with-written-cover.tex_, lines 174 and 176, respectitively with:

`\begin{flushleft}\includegraphics[scale=.175]{./images/quantide.png}\end{flushleft}`  
`\begin{flushright}\includegraphics[scale=.25]{./images/R-training.png}\end{flushright}`

4. De-comment the first level title in each rmd (# Title)
5. Run

`bookdown::render_book("index.md", "bookdown::pdf_book", new_session = T)`

A _\_book_ folder and other files will be automathically created. _\_main.pdf_ is the PFD book and it is included in
_\_book_ folder.


### To use PDF BOOK section in Makefile of 060-ggplot

1. Copy _images_ folder outside _input_ 
2. Click on _Build All_ in _Build_ tab



