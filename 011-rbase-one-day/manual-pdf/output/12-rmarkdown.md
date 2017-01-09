
# Reports with R Markdown




\includegraphics[width=4.08in]{./images/flow-info} 

R Markdown provides an authoring framework for data science. R Markdown allows us to turn our analysis into high quality documents, reports, presentations and dashboards. 

\clearpage

We can use a single R Markdown file to both:

* save and execute code
* generate high quality reports that can be shared with an audience

R Markdown documents are fully reproducible and support multiple programming languages like: R, Python, and SQL. It support also dozens of static and dynamic output formats, including HTML, PDF, MS Word, Beamer, HTML5 slides, Tufte-style handouts, books, dashboards, shiny applications, scientific articles, websites, and more. 

## Installation

You can install the R Markdown package from CRAN as follows:


```r
install.packages("rmarkdown")
```


## Markdown Basics

This is an R Markdown file, a plain text file that has the extension `.Rmd`:

\begin{figure}[h]
\includegraphics[width=6.46in]{images/rmd-1} \caption{R Markdown File}(\#fig:g1)
\end{figure}

Notice that the file contains three types of content:

* An (optional) YAML header surrounded by `---`
* R code chunks surrounded by ` ``` `
* text mixed with simple text formatting

Markdown is a simple formatting language designed to make authoring content easy for everyone. Rather than writing complex markup code (e.g. HTML or LaTeX), Markdown enables the use of a syntax much more like plain-text email.

### Basic rules for text 

This section provides quick references to the most commonly used R Markdown syntax.

\begin{figure}[h]
\includegraphics[width=5.23in]{images/rmd-cheatsheet} \caption{Source: R Markdown Cheat Sheet}(\#fig:g2)
\end{figure}

\clearpage

## Rendering Output

To generate a report from the file, run the `render` command:


```r
require(rmarkdown)
render("example.Rmd")
```

Otherwise, use the "Knit" button in the RStudio IDE to render the file and preview the output with a single click or the keyboard shortcut _Ctrl + Shift + K_.


\begin{figure}[h]
\includegraphics[width=6.46in]{images/rmd-3} \caption{R Markdown Output}(\#fig:g3)
\end{figure}


R Markdown generates a new file that contains selected text, code, and results from the .Rmd file. The new file can be a finished web page, PDF, MS Word document, slide show, notebook, handout, book, dashboard, package vignette or other format.
