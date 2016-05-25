
build_index_html <- function(
  path=getwd(),
  toc_file="TOC", 
  html_toc_template="include/before_body_temp.html",
  html_toc_out="include/before_body.html",
  h1="yaml", h2="yaml", yaml_file="_output.yaml",
  index_description="About this course",
  download_description="Download all",
  download_file="download.zip"
){
  
  # Define trim function to remove leading and trailing spaces
  trim <- function (x) gsub("^\\s+|\\s+$", "", x)
  
  # Define normalize function to remove all non alphanumeric characters
  normalize <- function(text)  {tolower(gsub("[^[:alnum:][_]", "", gsub(" ", "_", text)))}
  
  # Get file with table of contents
  toc <- read.table(file.path(path, toc_file), sep="|", fill=TRUE, header=FALSE)
  
  toc_ol <- ""
  
  # Get file with link to home page
  toc_ol <- c(toc_ol, sprintf("<ul id='index-link' class='nav nav-list well sidebar-nav'>"))
  toc_ol <- c(toc_ol, sprintf("  <li><a href='index.html'>%s</a></li>", index_description))
  toc_ol <- c(toc_ol, sprintf("</ul>"))
  
  # Get link to zip file
  toc_ol <- c(toc_ol, sprintf("<ul id='download' class='nav nav-list well sidebar-nav'>"))
  toc_ol <- c(toc_ol, sprintf("  <li><a href='%s'>%s</a></li>", download_file, download_description))
  toc_ol <- c(toc_ol, sprintf("</ul>"))
  
  # Get links to chapters
  toc_ol <- c(toc_ol, sprintf("<ul id='stickyheader' class='main-menu nav nav-list well sidebar-nav'>"))
  for(i_toc in 1:nrow(toc)) {
    if(toc[i_toc, 2]=="") {
      if(i_toc > 1) {toc_ol <- c(toc_ol, sprintf("  </li>"))}
      if(i_toc > 1) {toc_ol <- c(toc_ol, sprintf("    </ul>"))}
      toc_ol <- c(toc_ol, sprintf("  <li class='reveal nav-header'>%s", trim(toc[i_toc,1])))
      toc_ol <- c(toc_ol, sprintf("    <ul id='%s' class='nav nav-list well sidebar-nav'>", normalize(toc[i_toc,1])))
    } else {
      toc_ol <- c(toc_ol, sprintf("      <li><a href='%s'>%s</a></li>", sub(".Rmd", ".html", trim(toc[i_toc,2])), trim(toc[i_toc,1])))
    }
  }
  toc_ol <- c(toc_ol, sprintf("    </ul>"))
  toc_ol <- c(toc_ol, sprintf("  </li>"))
  toc_ol <- c(toc_ol, sprintf("</ul>"))
  
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
