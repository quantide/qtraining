########################## COURSE MATERIAL ##########################

# Project name
PROJECT = models

# Input, Output and purl paths
INPUT_DIR = input
OUTPUT_DIR = output/html
PURL_DIR = output/purl


HTML_FILES := $(patsubst %.Rmd, %.html, $(wildcard $(INPUT_DIR)/*.Rmd)) \
              $(patsubst %.md, %.html, $(wildcard $(INPUT_DIR)/*.md))

### COMPILE
all: toc html zip

zip:
	rm -f $(OUTPUT_DIR)/$(PROJECT).zip
	rm -f $(PURL_DIR)/R.zip
	zip -9 -r $(PROJECT).zip $(OUTPUT_DIR)/
	mv $(PROJECT).zip $(OUTPUT_DIR)/
	mv $(INPUT_DIR)/*.R $(PURL_DIR)/
	mv $(PURL_DIR)/options.R $(INPUT_DIR)/.
	zip -9 -r $(PURL_DIR)/R.zip $(PURL_DIR)/

toc:
	R --slave -e "source('../include/r/build-toc-html.R'); build_toc_html(path='$(INPUT_DIR)/',download_file='$(PROJECT).zip')"

html: $(HTML_FILES)

#.PHONY: change_dir

#change_dir:
#	$(MAKE) -C $(INPUT_DIR)
 
%.html: %.Rmd
	R --slave -e "set.seed(100);rmarkdown::render('$<',output_dir='$(OUTPUT_DIR)/');setwd('$(INPUT_DIR)/');knitr::purl('../$<')"
	

%.html: %.md
	R --slave -e "set.seed(100);rmarkdown::render('$<',output_dir='$(OUTPUT_DIR)/')"


#.PHONY: clean
#clean:
#	$(RM) -rf $(OUTPUT_DIR)/*





########################## EXERCISE BOOK ##########################

### PARAMETERS DEFINITION
    	
### List of source files (without extension: it will be used for .Rmd, .html and .R)
#LIST = \
#  1-intro \
#	es-data-obj \
#	es-data-import \
	

# Pandoc Path (RSTUDIO VERSION)
#PANDOC_PATH = /usr/lib/rstudio/bin/pandoc/pandoc

# Input and output paths
#INPUT_PDF_DIR = exercises
#OUTPUT_PDF_DIR = output/pdf

# Output file name
#PDF_OUT = data-programming-exercises-questions.pdf
#PDF_OUT = data-programming-exercises-solutions.pdf

# List of md files to build pdf 
#MD_PATH = $(addprefix exercises/,$(LIST))
#MD = $(addsuffix .md,$(MD_PATH))
#MD_LIST = $(addsuffix .md,$(MD_PATH))

# Pandoc pdf options
#PANDOC_PDF_OPTIONS = \
#  --latex-engine xelatex  \
#  --template='./../include/tex/manual-with-written-cover.tex' \
#	--variable=geometry:a4paper \
#	--variable=links-as-notes \
#  --chapters \
#  --number-sections \
#	--toc


### COMPILE
# all: by default perform all actions

#all: knitr pdf

#.PHONY: change_dir

#change_dir:
#	$(MAKE) -C $(INPUT_PDF_DIR)
	
# build md files from rmd
#%.md: %.Rmd
#	Rscript -e "require(knitr); knit('$<', output= '$@', quiet=FALSE)"


# build R files from rmd and upload
#%.R: %.Rmd
#	Rscript -e "require(knitr);  purl('$<'); getwd()"



# build pdf file from md
#$(PDF_OUT): $(MD_LIST)
#	$(PANDOC_PATH) $(PANDOC_PDF_OPTIONS) $(MD_LIST) --output $(OUTPUT_PDF_DIR)/$(PDF_OUT)

# single actions
#knitr: $(MD)
#html: $(addsuffix .html,$(MD_PATH))
#purl: $(addsuffix .R,$(MD_PATH))
#pdf: $(PDF_OUT)


#.PHONY: clean
#clean: 
#	rm -f *.md 	
#	mv 	*.R $(PURL_DIR)/

#	rm -f *.md *.html *.R	
###################################################################


