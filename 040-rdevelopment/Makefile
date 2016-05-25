
HTML_FILES := $(patsubst %.Rmd, %.html ,$(wildcard *.Rmd)) \
              $(patsubst %.md, %.html ,$(wildcard *.md))

#HTML_FILES := \
#12-intro.html\
#20-robjects.html

all: clean index html move zip

zip:
	zip -9 -r download.zip report/
	mv download.zip report/rDevelopment.zip
	rm -rf report/data/
	rm report/*.R

move:
	mv *.R report/
	mv *.html report/
	cp -R data/ report/

index:
	R --slave -e "source('r/build_index_html.R'); build_index_html(download_file='rDevelopment.zip')"

html: $(HTML_FILES)

%.html: %.Rmd
	R --slave -e "set.seed(100);rmarkdown::render('$<');knitr::purl('$<')"

%.html: %.md
	R --slave -e "set.seed(100);rmarkdown::render('$<')"


.PHONY: clean
clean:
	$(RM) *.html
	$(RM) *.R
	$(RM) -rf report/*
	$(RM) *.Rprof
