Date of documentation update: 20160906  
Documentation updated by: Veronica

# `qtraining` repository

`qtraining` repository contains Quantide training courses material. 

The courses included are:

* R for Beginners
* Statistical Models with R
* Base R programming 
* Data Manipulation with R
* Data Visualization with R
* Data Mining with R

## Structure

`qtraining` repository contains both courses development material and courses manuals.  
The structure is organized in the following folders:  

* _00-qdata_: containing courses data organized as an R package, named `qdata`
* _010-rbase_: containing "R for Beginners" course
* _020-models_: containing "Statistical Models with R" course  
* _030-rprogramming-base_: containing "Base R programming" course
* _050-dplyr-datamanage_: containing "Data Manipulation with R" course
* _060-ggplot_: containing "Data Visualization with R" course 
* _080-data-mining_: containing "Data Mining with R" course
* _courses-index_: containing courses index
* _include_: containing files for output structure building

### Courses material folders

The courses material folders are: _010-rbase_, _020-models_, _030-rprogramming-base_, _050-dplyr-datamanage_, _060-ggplot_ and _080-data-mining_.  

Each course material folder name must be identified by a number and by the course name, in the following format: "number-course name".  
The number to be assigned to the course name must consist of three digits.

These folders have the same base structure:

1. _input_ folder, which contains source files of course material  
2. _output_ folder, which contains built course materials 
3. _exercises_ folder, which contains source files of exercises 
4. _docs_ folder, which contains documents useful for course development  
5. _Makefile_, which is a text file containg code written in Linux kernel. It is a simple way to organize code compilation. It contains the instructions for building the content of `output` folder
6. RStudio project file, named `course name.Rproj`

In some courses material folder is included also __data__ folder, which contains data that can't be included in `qdata` package.

In particular:

__input__ folder includes:

* _Markdown and R Markdown scripts with course content_. Course content is organized in chapters. Each chapter is identified by a script.  
* _images_ folder, which contains figures to be included in course content 
* _TOC_ file, which contains course index. In particular, it associates each md or rmd script with its title, in the correct order.


__output__ folder includes:

* _html_ folder, which contains htmls files with the full content of the course and a zip folder containing all html files (the folder name is "course name.zip") 
* _purl_ folder, which contains R script with R code extracted from html (one R script for each html file), and a zip folder containing all R scripts (the folder name is "R.zip")
* _pdf_ folder, which contains pdf file/s of courses exercises (this folder is not always present)


__exercises__

* _Markdown and R Markdown scripts with course exercises_.  
* _images_ folder, which contains figures to be included in exercises content 

This folder is not populated in all material courses folders.
It is populated in: _010-rbase_, _020-models_, _050-dplyr-datamanage_.   
In _010-rbase_ and _050-dplyr-datamanage_, exercises are organized in chapters. Each chapter is identified by a script. The pdf file/s of courses exercises are built by the _Makefile_ and included in _output/pdf_ folder.   
In _020-models_ script exercises and built pdf and html files are included in _exercises_ folder. They are not built by the _Makefile_, but manually clicking "Knit PDF" from RStudio toolbar, because the exercises are not yet completed. 

 
### Guide for building course material

1. Open RStudio
2. Double-click on the project file
3. Click on "Build All" from RStudio "Build" tab or click "Ctrl+Shift+B" on the keyboard 

The course building follows the instructions provided by _Makefile_. For more details see the _Makefile_ of the course of interest.

### _00-qdata_ folder

This folder contains courses data organized as an R package, named `qdata`.  
It is structured in the following way:

* _data_ folder, which contains data in .RData format included in `qdata` package
* _R_ folder, which contains two R script: `qdata.R` and `qdata-data.R` with package and data documentation (written in roxigen2)
* _pkgs_ folder, which contains `qdata` package versions realized
* _doc_ folder, which contains an R script `raw-data.R`. This script includes some commands of operations done on data before including them in package.  
* _rowdata_ folder, which contains original data files
* _DESCRIPTION_ file, which contains library desciption
* _NAMESPACE_ file, which contains informations about imported and exported functions (automatically
created by library ‘build’)
* R project file, named `qdata.Rproj`

### Guide for building `qdata`

`qdata` is an R package so its building works as well as any R package building.

1. Open RStudio
2. Double-click on the project file
3. Click "Build & Reload" on RStudio "Build" tab or click "Ctrl+Shift+B" on the keyboard

### Guide for installing and loading `qdata`  

1. Open RStudio
2. Install the package typing the following lines on the R console: 

```{r}
install.packages("~/dev/qtraining/00-qdata/pkgs/qdata_0.24.tar.gz", repo = NULL )
```

3. Loading `qdata` package on the workspace, typing:

```{r}
require(qdata)
```

4. Loading data, included in `qdata` package, on the workspace. For example, if we want to load "bank" data we have to type:

```{r}
data("bank")
```

## _include_ folder

This folder contains files with the instructions on output files structure building for each course. It means that the _Makefile_ of each course refers to these files for building the structure of output files.

It is structured in these folders:

* _html_
* _libs_
* _r_
* _tex_

## _courses-index_ folder

The content of this folder is used for building an index of courses.  
It includes:

* _course-index.html_, html file of courses index 
* _images_ folder, which includes figures used in _course-index.html_ file 

### Modify courses index

1. Open _course-index.html_ with a text editor
2. Modify the file. The code is written in HTML
3. Save the file

