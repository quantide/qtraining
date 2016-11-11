# This makefile builds courses material and exercise book in pdf format
# The first part builds courses materal, the second the exercise book. 
# If you want to build only one of the two parts, change building settings on RStudio build-tab:
# Build/More/Configure Build Tools.../Additional Arguments
# Write here the targets of the part you want to build

########################## COURSES MATERIAL ##########################  
### PARAMETERS DEFINITION


# Project name
##PROJECT = ggplot

# Input, Output and purl paths
##INPUT_DIR = input
##OUTPUT_DIR = output/html
##PURL_DIR = output/purl


##HTML_FILES := $(patsubst %.Rmd, %.html, $(wildcard $(INPUT_DIR)/*.Rmd)) \
##              $(patsubst %.md, %.html, $(wildcard $(INPUT_DIR)/*.md))

### COMPILE
##all: toc html zip

##zip:
##	rm -f $(OUTPUT_DIR)/$(PROJECT).zip
##	rm -f $(PURL_DIR)/R.zip
##	zip -9 -r $(PROJECT).zip $(OUTPUT_DIR)/
##	mv $(PROJECT).zip $(OUTPUT_DIR)/
##	mv $(INPUT_DIR)/*.R $(PURL_DIR)/
##	# mv $(PURL_DIR)/options.R $(INPUT_DIR)/.
##	zip -9 -r $(PURL_DIR)/R.zip $(PURL_DIR)/

##toc:
##	R --slave -e "source('../include/r/build-toc-html.R'); build_toc_html(path='$(INPUT_DIR)/',download_file='$(PROJECT).zip')"

##html: $(HTML_FILES)

 
##%.html: %.Rmd
##	R --slave -e "set.seed(100);rmarkdown::render('$<',output_dir='$(OUTPUT_DIR)/');setwd('$(INPUT_DIR)/');knitr::purl('../$<')"
	

##%.html: %.md
##	R --slave -e "set.seed(100);rmarkdown::render('$<',output_dir='$(OUTPUT_DIR)/')"

## commenti da togliere

########################## EXERCISE BOOK ##########################

### PARAMETERS DEFINITION
    	
### List of source files (without extension: it will be used for .Rmd, .html and .R)
LIST = \
  00-1-intro \
	01-1-scatterplot \
	01-2-lineplot \
	01-3-barplot \
	01-4-histogram \
	01-5-boxplot \
	01-6-surface-plot \
	02-1-scales \
	02-2-axes \
	02-3-legend \
	02-4-facet \
	02-5-theme \
	02-6-stats \
	03-1-ggfamily \
	03-2-presenting \

# Pandoc Path (RSTUDIO VERSION)
PANDOC_PATH = /usr/lib/rstudio/bin/pandoc/pandoc

# Input and output paths
INPUT_PDF_DIR = input
OUTPUT_PDF_DIR = output/pdf

# Output file name
#PDF_OUT = data-programming-exercises-questions.pdf
PDF_OUT = data-visualization.pdf

# List of md files to build pdf 
MD_PATH = $(addprefix input/,$(LIST))
MD = $(addsuffix .md,$(MD_PATH))
MD_LIST = $(addsuffix .md,$(MD_PATH))

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
	Rscript -e "require(knitr); knit('$<', output= '$@', quiet=FALSE); getwd()"


# build R files from rmd and upload
#%.R: %.Rmd
#	Rscript -e "require(knitr);  purl('$<'); getwd()"



# build pdf file from md
$(PDF_OUT): $(MD_LIST)
	$(PANDOC_PATH) $(PANDOC_PDF_OPTIONS) $(MD_LIST) --output $(OUTPUT_PDF_DIR)/$(PDF_OUT)

# single actions
knitr: $(MD)
#html: $(addsuffix .html,$(MD_PATH))
#purl: $(addsuffix .R,$(MD_PATH))
pdf: $(PDF_OUT)


.PHONY: clean
clean: 
	rm -f $(MD_LIST)	
###################################################################







