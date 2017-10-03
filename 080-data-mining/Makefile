INPUT_DIR = input
INPUT_RMD = $(INPUT_DIR)/*.Rmd

OUTPUT_DIR = output
OUTPUT_HTML_DIR = $(OUTPUT_DIR)/html
OUTPUT_PURL_DIR = $(OUTPUT_DIR)/purl

HTML_FILES = $(patsubst %.Rmd, %.html, $(wildcard $(INPUT_DIR)/*.Rmd)) \
             $(patsubst %.md, %.html, $(wildcard $(INPUT_DIR)/*.md))
OUTPUT_HTML_FILES = $(patsubst $(INPUT_DIR)/%, $(OUTPUT_HTML_DIR)/%, $(HTML_FILES))

PURL_FILES = $(patsubst %.Rmd, %.R, $(wildcard $(INPUT_DIR)/*.Rmd)) \
             $(patsubst %.md,  %.R, $(wildcard $(INPUT_DIR)/*.md))
OUTPUT_PURL_FILES = $(patsubst $(INPUT_DIR)/%, $(OUTPUT_PURL_DIR)/%, $(PURL_FILES))


.PHONY: all
all: manual 

.PHONY: manual
manual: $(OUTPUT_HTML_FILES) purl toc

.PHONY: toc
toc:
	R --slave -e "source('../include/r/build-toc-html.R'); build_toc_html(path='$(INPUT_DIR)/',download_file='$(PROJECT).zip')"

.PHONY: purl
purl: $(OUTPUT_PURL_FILES)

$(OUTPUT_HTML_DIR)/%.html: $(INPUT_DIR)/%.Rmd
	R --slave -e \
	"set.seed(100); \
	rmarkdown::render('$<',output_dir='$(OUTPUT_HTML_DIR)/')"
	

$(OUTPUT_PURL_DIR)/%.R: $(INPUT_DIR)/%.Rmd
	R --slave -e \
	"set.seed(100); \
	knitr::purl('$<', output = '$@')"

$(OUTPUT_PURL_DIR)/%.R: $(INPUT_DIR)/%.md
	R --slave -e \
	"set.seed(100); \
	knitr::purl('$<', output = '$@')"


$(OUTPUT_HTML_DIR)/%.html: $(INPUT_DIR)/%.md
	R --slave -e \
	"set.seed(100); \
	rmarkdown::render('$<',output_dir='$(OUTPUT_HTML_DIR)/')"

	
.PHONY: clean
clean:
	rm -rf $(OUTPUT_HTML_DIR)/*
	rm -rf $(OUTPUT_PURL_DIR)/*

