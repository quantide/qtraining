
build_toc_html <- function(
  path=getwd(),
  toc_file="TOC", 
  html_toc_template="include/html/before-body-template.html",
  html_toc_out="include/html/before-body.html",
  h1="yaml", h2="yaml", yaml_file="input/_output.yaml",
  index_description="About this course",
  acknowledgements_description="Acknowledgements",
  download_description="Download Data",
  download_file="data.zip"
){
  
  # Define trim function to remove leading and trailing spaces
  trim <- function (x) gsub("^\\s+|\\s+$", "", x)
  
  # Get file with table of contents
  if(! is.null(toc_file)){
    toc <- read.table(file.path(path, toc_file), sep="|", fill=TRUE, header=FALSE)
  }
  
  # Build table of contents from RMD (DA COMPLETARE!!!)
  if(is.null(toc_file)){
    file_list <- list.files(path, pattern=".Rmd")
    
    for (index in 1:length(file_list)) {
      file_title <- readLines(file_list[index], n=20)[grep("title",readLines(file_list[index], n=20))]
      file_title <- sub("title:", "", file.title)
      file_title <- sub("'", "", file.title)
      file_title <- trim(file.title)
    }
  }
  
  toc_ol <- ""

  # Get file with link to home page
  toc_ol <- c(toc_ol, sprintf("<ul class='nav nav-list well sidebar-nav'>"))
  toc_ol <- c(toc_ol, sprintf("  <li><a href='index.html'>%s</a></li>", index_description))
  toc_ol <- c(toc_ol, sprintf("</ul>"))


  # Get file with link to acknowledgements section
  toc_ol <- c(toc_ol, sprintf("<ul class='nav nav-list well sidebar-nav'>"))
  toc_ol <- c(toc_ol, sprintf("  <li><a href='acknowledgements.html'>%s</a></li>", acknowledgements_description))
  toc_ol <- c(toc_ol, sprintf("</ul>"))


  # Get links to chapters
  toc_ol <- c(toc_ol, sprintf("<ul class='nav nav-list well sidebar-nav'>"))
  for(i_toc in 1:nrow(toc)) {
    if(toc[i_toc, 2]=="") {
      toc_ol <- c(toc_ol, sprintf("  <li class='nav-header'>%s</li>", trim(toc[i_toc,1])))
    } else {
      toc_ol <- c(toc_ol, sprintf("  <li><a href='%s'>%s</a></li>", sub(".Rmd", ".html", trim(toc[i_toc,2])), trim(toc[i_toc,1])))
    }
  }
  toc_ol <- c(toc_ol, sprintf("</ul>"))


  # Get link to zip file
  #toc_ol <- c(toc_ol, sprintf("<ul class='nav nav-list well sidebar-nav'>"))
  #toc_ol <- c(toc_ol, sprintf("  <li><a href='%s'>%s</a></li>", download_file, download_description))
  #toc_ol <- c(toc_ol, sprintf("</ul>"))

  # Write sidebar menu with table of contents
  text <- sub("TOC", paste0(toc_ol, collapse="\n"), paste0(readLines(html_toc_template), collapse="\n"))
  
  # Get titles
  if(h1=="yaml") {
    h1 <- readLines(yaml_file)
    if(any(grepl("course_title", h1))){h1 <- sub("  course_title: ", "", h1[grep("course_title", h1)])} else {h1<-""}
  }
  if(h2=="yaml") {
    h2 <- readLines(yaml_file)
    if(any(grepl("course_subtitle", h2))){h2 <- sub("  course_subtitle: ", "", h2[grep("course_subtitle", h2)])} else {h2<-""}
  }
  
  # Write titles
  text <- sub("H1", paste0(h1, collapse="\n"), text)
  text <- sub("H2", paste0(h2, collapse="\n"), text)
  
  writeLines(text, html_toc_out)
  
  message("Titles and Table of contents added to ", html_toc_out)
  
}
