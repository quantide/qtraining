# This makefile builds courses material and exercise book in pdf format
# The first part builds courses materal, the second the exercise book. 
# If you want to build only one of the two parts, change building settings on RStudio build-tab:
# Build/More/Configure Build Tools.../Additional Arguments
# Write here the targets of the part you want to build

########################## COURSES MATERIAL ##########################  
### PARAMETERS DEFINITION

# Project name
PROJECT = dplyr

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
	# mv $(PURL_DIR)/options.R $(INPUT_DIR)/.
	zip -9 -r $(PURL_DIR)/R.zip $(PURL_DIR)/

toc:
	R --slave -e "source('../include/r/build-toc-html.R'); build_toc_html(path='$(INPUT_DIR)/',download_file='$(PROJECT).zip')"

html: $(HTML_FILES)

 
%.html: %.Rmd
	R --slave -e "set.seed(100);rmarkdown::render('$<',output_dir='$(OUTPUT_DIR)/');setwd('$(INPUT_DIR)/');knitr::purl('../$<')"
	

%.html: %.md
	R --slave -e "set.seed(100);rmarkdown::render('$<',output_dir='$(OUTPUT_DIR)/')"


#.PHONY: clean
#clean:
#	$(RM) -rf $(OUTPUT_DIR)/*

###################################################################

########################## EXERCISE BOOK ##########################

### PARAMETERS DEFINITION
    	
### List of source files (without extension: it will be used for .Rmd, .html and .R)
LIST = \
  	1-intro \
	2-0-verbs \
	2-1-select \
	2-2-filter \
	2-3-arrange \
	2-4-mutate \
	2-5-summarise \
	3-group \
	5-do \
	6-combining \
	9-tidyr \
	10-missing-values \
	11-dates \
	12-strings \
	13-case-study \

# Pandoc Path (RSTUDIO VERSION)
PANDOC_PATH = /usr/lib/rstudio/bin/pandoc/pandoc

# Input and output paths
INPUT_PDF_DIR = exercises
OUTPUT_PDF_DIR = output/pdf

# Output file name
PDF_OUT = dplyr-exercises-questions.pdf
PDF_OUT_SOLUTION = dplyr-exercises-solutions.pdf

# List of md files to build pdf 
MD_PATH = $(addprefix exercises/,$(LIST))
MD =      $(addsuffix .md, $(MD_PATH))
MD_SOLUTION = $(addsuffix .solution.md, $(MD_PATH))
MD_LIST = $(addsuffix .md, $(MD_PATH))

# Pandoc pdf options
PANDOC_PDF_OPTIONS = \
  --latex-engine xelatex  \
  --template='./../include/tex/manual-with-written-cover.tex' \
	--variable=geometry:a4paper \
	--variable=links-as-notes \
  --chapters \
  --number-sections \
	--toc


### COMPILE
# all: by default perform all actions

all: knitr pdf clean


# build md files from rmd
%.md: %.Rmd
	Rscript -e "require(knitr); knit('$<', output= '$@', quiet=FALSE)"

%.solution.md: %.Rmd
	Rscript -e "require(knitr); show_solution_mk <- TRUE; knit('$<', output= '$@', quiet=FALSE)"

# build html files from md and upload
#%.html: %.md
#	Rscript -e "require(rmarkdown);  render('$<', html_document())" 
	#sed -i -e '1,/<body>/d' -e '/^<\/body>/,$$d' $*.html

# build R files from rmd and upload
#%.R: %.Rmd
#	Rscript -e "require(knitr);  purl('$<'); getwd()"



# build pdf file from md
$(PDF_OUT): $(MD_LIST)
	$(PANDOC_PATH) $(PANDOC_PDF_OPTIONS) $(MD_LIST) --output $(OUTPUT_PDF_DIR)/$(PDF_OUT)

$(PDF_OUT_SOLUTION): $(MD_SOLUTION)	
	$(PANDOC_PATH) $(PANDOC_PDF_OPTIONS) $(MD_SOLUTION) --output $(OUTPUT_PDF_DIR)/$(PDF_OUT_SOLUTION)


# single actions
knitr: $(MD) $(MD_SOLUTION)
#html: $(addsuffix .html,$(MD_PATH))
#purl: $(addsuffix .R,$(MD_PATH))
pdf: $(PDF_OUT) $(PDF_OUT_SOLUTION)


.PHONY: clean
clean: 
	rm -f $(MD_LIST) $(MD_SOLUTION)
###################################################################



