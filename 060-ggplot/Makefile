# This makefile builds courses material and exercise book in pdf format
# The first part builds courses materal, the second the exercise book. 
# If you want to build only one of the two parts, change building settings on RStudio build-tab:
# Build/More/Configure Build Tools.../Additional Arguments
# Write here the targets of the part you want to build

########################## COURSES MATERIAL ##########################  
### PARAMETERS DEFINITION


# Project name
PROJECT = ggplot

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










