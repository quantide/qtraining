
# R and R-Studio installation and configuration




## Installing and Updating R

### Design of the R System

The R system is divided into two conceptual parts:

1. The "base" R system that you download from CRAN.
2. Everything else.

R functionality is divided into a number of packages. The "base" R system contains, among other things, the _base_ package which is required to run R and contains the most fundamental functions. The "base" system contains also some other packages. Furthermore, every R installation contains "recommended" packages, that are not necessarily maintained by R Core.

"Everything else" point out CRAN "contributed" packages and packages that are not on CRAN. This does not mean that these packages are necessarily of lesser quality than the above, e.g., many contributed packages on CRAN are written and maintained by R Core members. The goal is simply to try to keep the base distribution as lean as possible. Beyond CRAN, many packages are avalaible in BioConductor project or in Github repositories.

\clearpage

### Installing R

R is available for Windows, Mac Os and Linux.

The base R can be downloaded from the Comprehensive R Archive Network (CRAN) website. The CRAN is a collection of sites which carry identical material, consisting of the R distribution(s), the contributed extensions, documentation for R, and binaries.

Go to [www.r-project.org](http://www.r-project.org/). Here you can read about R and see what's new in the latest version.



\includegraphics[width=4.44in]{./images/r-project} 


Click on CRAN under Download in the left list. That'll take you to a list of servers (mirrors) in different countries where you can download R.

Now you can choose what operative system you have. Choose within the upper box with _Download and Install R_. The box contains _Precompiled binary distributions_; sounds complicated, but means that the program is ready to use, with installation program and all.

Windows users click on "base" and then click _Download R X.X.X for Windows_.

Mac users click on _R-X.X.X.pkg (latest version)_.

Linux users find download files and installation instructions for their Linux distribution in the website. 

X.X.X identify the current version of R. In December 2016, the current version is the 3.3.2.

To install R, Windows and Mac users must just double click on the file and follow the installation instructions.

Linux users can download and install R using the precompiled R binary for their distribution. Alternatively, experienced Linux users can compile R from sources. Currently, precompiled R binary are available for Debian, Ubuntu, Suse and RedHat. 

The Figure [Screenshot of a first try with R](#fig:ssFirsttry) shows a first try with R, just after installation.

<div id="fig:ssFirsttry">


\includegraphics[width=3.94in]{./images/RfirstPlot} 

</div>

### Updating R

In Windows and Mac, there is not an automatic way to update R. Two or more versions of R can coexist in the same machine, so a newer release of R can be installed beside the old release. Unfortunately, packages must be re-installed in the "new" R version. A copy-and-paste of package files from the directory containing the packages of the "old" R version to the directory containing the packages of the "new" R version may be useful when many packages are installed. Within R, the `.Library` variable shows the directory containing the packages. After the copy-and-paste, packages of the "new" R version should be updated.

In Linux, usually one R version at time can be installed. R can be updated following the instructions in the CRAN website.


## Graphical User Interfaces

### R Default Interfaces

R is provided with a Command Line Interface (CLI), which is the preferred user interface for power users because it allows direct control on calculations and it is flexible. However, good knowledge of the language is required. CLI is thus intimidating for beginners. 


R is available for many different operative systems so it does not provide the same graphical interface. When you use the R program interactively, it issues a prompt when it expects input commands. The default prompt is '>'. In Windows, RGui is the default GUI. Inside RGui there is the RConsole window. In Macintosh, RConsole is the default GUI. In Linux, R does not provide any graphical interface by default and it can be used through CLI.


\includegraphics[width=6.13in]{./images/ssDefaultGui} 

\clearpage

### RStudio 

**RStudio** [(www.rstudio.org)](http://www.rstudio.org/) is a free and open source multi-platform integrated development environment (IDE) for R. It provides syntax highlighting, code completion and smart indentation. Moreover, it executes R code directly from the source editor and it manages easily multiple working directories using projects. It provides:

 - workspace browser and data viewer;
 - plot history, zooming, and flexible image and PDF export;
 - integrated R help and documentation;
 - Sweave authoring including one-click PDF preview;
 - searchable command history.


\includegraphics[width=6.33in]{./images/ssGuiRstudio} 


### Installing RStudio

RStudio is available for Windows, Mac Os and Linux and you can install it from its website [(www.rstudio.org)](http://www.rstudio.org/), clicking on _Download RStudio_. Next, click _Download RStudio Desktop_. At this stage, click the link to the version of RStudio appropriate for your system in _Installers for Supported Platforms_ section, which downloads RStudio to your computer. Run the installation file and RStudio will be installed on your system. 


## R Packages

### Installing R Packages

R functions are collected in packages. Packages that are not contained in the "base" R systems can be downloaded from the CRAN website. A list of R packages accompanied by a brief description can be found on the CRAN website where there are more than 9500 packages available. Many of these packages are very useful; however, there are some packages in prerelease, incomplete packages, "abandoned" packages (i.e. not more updated) and/or packages containing functions with errors or compatibility troubles.

This is the R package universe!


\includegraphics[width=3.04in]{./images/r-packages-universe} 


The simple way to install an R package is through the `install.packages()` function, directly from R. In Linux, R must be executed as administrator to install a package. Installation must be executed before the first use of a library.

When a function of a package that is not contained in the "base" R systems is required, the package must be loaded. The `require(pkg)` function load the _pkg_ package. 

### Updating R Packages

R packages can be updated typing `update.packages()` within R. In Linux, R must be executed as administrator to update a package. Packages should be updated regularly.

