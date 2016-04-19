PROJECT = dplyr

INPUT_DIR = input

OUTPUT_DIR = output/html

PURL_DIR = output/purl

HTML_FILES := $(patsubst %.Rmd, %.html, $(wildcard $(INPUT_DIR)/*.Rmd)) \
              $(patsubst %.md, %.html, $(wildcard $(INPUT_DIR)/*.md))

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

.PHONY: change_dir

change_dir:
	$(MAKE) -C $(INPUT_DIR)
 
%.html: %.Rmd
	R --slave -e "set.seed(100);rmarkdown::render('$<',output_dir='$(OUTPUT_DIR)/');setwd('$(INPUT_DIR)/');knitr::purl('../$<')"
	

%.html: %.md
	R --slave -e "set.seed(100);rmarkdown::render('$<',output_dir='$(OUTPUT_DIR)/')"


.PHONY: clean
clean:
	$(RM) -rf $(OUTPUT_DIR)/*
    	


