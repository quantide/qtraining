---
title: '`qtraining` repository'
output:
  pdf_document: default
  html_document: default
---

Date of documentation update: 20161221  
Documentation updated by: Veronica

# Introduction

`qtraining` is a private Github repository containing Quantide training courses material. 

The courses included are:

* __R for Beginners__ (two days course)
* __R for Beginners__ (one day course)
* __Statistical Models with R__
* __Base R programming__
* __Data Manipulation with R__
* __Data Visualization with R__ in english and in italian (under development) 
* __Data Mining with R__
* __Big Data__ (under development)

# Clone `qtraining` repository on your pc

`qtraining` repository is a private Quantide repository on Github, so to work on it you have to belong to Quantide team on Github. 

If you want to work on `qtraining` repository, you have to clone it on your pc.
Github projects must be developed on _dev_ folder inside your "/home/user-name". If you don't have this folder you have to create it.   

Follow these steps:

1. Open your browser
2. Go on [https://github.com/quantide/qtraining](https://github.com/quantide/qtraining)
3. Click on "Clone or Download" green button 
4. Choose "Clone with ssh" and copy the address (press "copy to clickboard" button)
5. Open a shell
6. Place yourself inside _dev_ folder
7. Enter `git clone <address>`

A folder, named _qtraining_ will be created into _dev_ folder. It will include `qtraining` repository.  


# `qtraining` Structure

`qtraining` repository contains both courses development material and courses manuals.  
The structure is organized in the following folders:  

* _00-qdata_: containing courses data organized as an R package, named `qdata`
* _010-rbase-two-days_: containing "R for Beginners" (two days) course
* _011-rbase-one-days_: containing "R for Beginners" (one day) course
* _020-models_: containing "Statistical Models with R" course 
* _030-rprogramming-base_: containing "Base R programming" course
* _050-dplyr-datamanage_: containing "Data Manipulation with R" course
* _060-ggplot_: containing "Data Visualization with R" course in english
* _061-ggplot-ita_: containing "Data Visualization with R" course in italian (under development)
* _080-data-mining_: containing "Data Mining with R" course
* _100-bigdata-spark_: contanis "Big Data" course (under development)
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

* _Markdown and R Markdown scripts with course content_. Course content is organized in chapters. Each chapter is identified by a script. It is recommended to add a number to the script names for ordering them (e.g. 01-first.Rmd). The course material is usually written in english.
* _images_ folder, which contains figures to be included in the course content 
* _TOC_ file, which contains course index. 


### TOC file

TOC files includes the structure of the course manual.

The md or Rmd files must be ordered, in column, from the first to the last.  
Each file must be associated with a title.
In particular, each row identifies a chapter: you have to write firstly the title, then "|" and finally the md and Rmd name related to that chapter.
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
* _purl_ folder, which contains R script with R code extracted from the Rmds (one R script for each Rmd), and a zip folder containing all R scripts (the folder name is "R.zip")
* _pdf_ folder, which contains pdf file/s of courses exercises (this folder is not always present)

## exercises folder

It includes:

* _Markdown and R Markdown scripts with course exercises_.
* _images_ folder, which contains figures to be included in exercises content 

This folder is not populated in all material courses folders.
It is populated in: _010-rbase-two-days_, _020-models_, _050-dplyr-datamanage_.   
In _010-rbase-two-days_ and _050-dplyr-datamanage_, exercises are organized in chapters. Each chapter is identified by a script. The pdf file/s of courses exercises are built by the _Makefile_ and included in _output/pdf_ folder.   
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
* _DESCRIPTION_ file, which contains library description
* _NAMESPACE_ file, which contains informations about imported and exported functions (automatically
created by library ‘build’)
* R project file, named `qdata.Rproj`

Once built the package, _man_ folder is created. It contains documentation files. I recommend you to not add to commit and push this folder. 

On Decembre 20 2016, the version of qdata is 0.27.

## Guide for building `qdata`

### Build `qdata`

`qdata` is an R package so its building works as well as any R package building.

1. Open RStudio
2. Double-click on the project file
3. Click "Build & Reload" on RStudio "Build" tab or click "Ctrl+Shift+B" on the keyboard

_Note:_ When one ore more data file/s are added or when data documentation is modified, the package version MUST be updated. To update the package version modify _Version:_ tag in _DESCRIPTION_ file going forward of one digit (e.g. 027 --> 0.28)  

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
2. Click on "Install" into Rstudio "Packages" tab
3. Set "Install from" field to "Package Archive (.tar.gz)"
4. Choose "qdata" for "Packages" field


## qdata locations 

The materials included into _00-qdata_ folder is included also in another github repository:
[https://github.com/quantide/qdata](https://github.com/quantide/qdata).

_qdata_ is a public Quantide repository contining the data necessary for public courses available on Quantide website. So also this version has to be updated. When you update the version of `qdata` on _qtraining_ repository you have to update also that in _qdata_ repository. 

_Advice to update the version_: in _qdata_ repository, add the new .Rdata files into _data_ folder, and replace the scripts included in _R_ folder with that modified of _qtraining_ version.  

_Future Developments_: develop _qdata_ package into a single location. 


# _include_ folder

This folder contains files with the instructions on output files structure building for each course. It means that the _Makefile_ of each course refers to these files for building the structure of output files.

It is structured in these folders:

* _html_
* _libs_
* _r_
* _tex_


# _courses-index_ folder

The content of this folder is used for building an html index of courses.  
It includes:

* _course-index.html_: html file of courses index 
* _images_ folder: which includes figures to be used in _course-index.html_ file 

## Modify courses index

1. Open _course-index.html_ with a text editor
2. Modify the file. The code is written in HTML
3. Save the file

# Github 

You are working on a team, so you need to remain aligned with your colleagues.

In particular, you have to add your work to the repository and to remain aligned with the work of the others.

You can do these operations on the terminal or from "Git" tab on Rstudio. We will see in details both options. 

## *Add* new files to the repository

Now we should add some new files. Create new files or copy your project files inside this folder. Then FOR EACH FILE we tell git to add them to the list of file to add or update to the repository. Usually, a Github repository includes only the source code, but in this case we will make an exception. Indeed, it is useful to add also compiled files (html and purl) of a stable version of the course material.

__First option: terminal__

1. Open the terminal, position inside repository folder and type this command:
 
	$ git add example-file.R

2. Check the list of added file typing (not mandatory):

	$ git status

3. Finally we add these files with:

	$ git commit -m "comment of this version"

__Second option: Rstudio "Git" tab__

Rstudio "Git" tab includes all files added or modified in the repository.

1. To add the one or more file/s, select it/them into Rstudio "Git" tab.  

2. Then, click on "Commit". A window will appear. That window has a space in top left where you have to write the "comment of this version". 

3. Done this, click on "Commit".

## *Push* changes on the remote repository (github.com)

We want propagate changes to the remote repository.

__First option: terminal__

Git retains the remote repository link so it is enough to type, always in the terminal:

	$ git push

__Second option: Rstudio "Git" tab__

Once you have done a commit, you can push it by clicking on green upward arrow on Rstudio "Git" tab.

## *Pull* changes committed by others

When your colleague `commit` and `push` its changes, you need to
update your local files. 

__First option: terminal__

In order to update them, type on the terminal:

	$ git pull

__Second option: Rstudio "Git" tab__

In order to update them, click on light blue downward arrow on Rstudio "Git" tab.


## Note 

Although you are working on a single project to build a course, Rstudio "Git" tab or `git status` on the terminal, shows the files to be added to commit of all folders of `qtraining` repository. The same when you do the pull, you will pull the committed changes of all folders of `qtraining` repository and not that of the single project (course folder) you are working to.  


# Bookdown

`bookdown` is an R package, built on top of R Markdown, and inherits the simplicity of the Markdown syntax, as well as the possibility of multiple types of output formats (PDF/HTML/Word/…).

To use it, you need a version of RStudio higher than 1.0.0.

First of all you have to install and load `bookdown` package.

To build a book with bookdown, you have to refer to a particular .Rproj file, `bookdown-demo.Rproj`, which is available on [https://github.com/rstudio/bookdown-demo](https://github.com/rstudio/bookdown-demo) repository. I recommend you to download the whole repository as a Zip file and to use it as a structure for your book.

In `qtraining`, I used bookdown-demo into _manual-pdf_ and _exercises_ folders of _011-rbase-one-day_. These folders represents my first trial to use `bookdown`, so I advice you to look at the structure of that folders and to read the [Bookdown web book](https://bookdown.org/yihui/bookdown/get-started.html). 

## My idea of structure

1. Generate into bookdown-demo folder two subfolders, _input_ and _output_ and includes all the content of bookdown-demo into _input_.  

2. Generate your Rmd containing the course content in _input_ folder. Each Rmd represents a chapter of your book, so you have to put a number at the beginning of the Rmd name. The number have to correspond to the Rmd order in the book.  

3. _input_ folder must contain `index.Rmd` file, which will be the first chapter of your book.

4. Open `_bookdown.yml` file and set these parameters:

* `book_filename`: name of the file that will be created
* `chapter_name: "Chapter "`: name to be added at the beginning of each chapter
* `new_session: yes`: set a new session for each rmd run
* `output_dir: "../output"`, in this way the output will be created into _output_ folder

5. Open `_output.yml` and set `bookdown::pdf_book:` if you want to create a pdf book, `bookdown::gitbook:` if you want to create a web book, ... . Here, you have to specify the related .css or .tex files. `preamble.tex` is a style .tex file that contains the instructions to create the cover of my book. You can start from here of you can can create your own style .tex file.   

## Build book

1. Open RStudio
2. Open `bookdown-demo.Rproj`
3. Click on "Build Book" on "Build" tab 

Before building the book I advice you to click on "More" on "Build tab" and to choose "Clean All", in order to delete all old results.  


