INPUT_DIR = input
INPUT_RMD = $(INPUT_DIR)/*.Rmd
EXERCISES_DIR = exercises

OUTPUT_DIR = output
OUTPUT_HTML_DIR = $(OUTPUT_DIR)/html
OUTPUT_PURL_DIR = $(OUTPUT_DIR)/purl
OUTPUT_PDF_DIR = $(OUTPUT_DIR)/pdf

PDF_OUT = $(OUTPUT_PDF_DIR)/r-base-exercises-questions.pdf
PDF_OUT_SOLUTIONS = $(OUTPUT_PDF_DIR)/r-base-exercises-solutions.pdf

HTML_FILES = $(patsubst %.Rmd, %.html, $(wildcard $(INPUT_DIR)/*.Rmd)) \
             $(patsubst %.md, %.html, $(wildcard $(INPUT_DIR)/*.md))
OUTPUT_HTML_FILES = $(patsubst $(INPUT_DIR)/%, $(OUTPUT_HTML_DIR)/%, $(HTML_FILES))

PURL_FILES = $(patsubst %.Rmd, %.R, $(wildcard $(INPUT_DIR)/*.Rmd)) \
             $(patsubst %.md,  %.R, $(wildcard $(INPUT_DIR)/*.md))
OUTPUT_PURL_FILES = $(patsubst $(INPUT_DIR)/%, $(OUTPUT_PURL_DIR)/%, $(PURL_FILES))

TMP_MD_FILES = tmp_md
EXERCISES_FILES = $(EXERCISES_DIR)
EXERCISES_MD = $(patsubst %.Rmd, %.md, $(sort $(wildcard $(EXERCISES_FILES)/*.Rmd)))
EXERCISES_SOLUTIONS = $(patsubst %.Rmd, %.solution.md, $(sort $(wildcard $(EXERCISES_FILES)/*.Rmd)))


# Pandoc Path (RSTUDIO VERSION)
PANDOC_PATH = /usr/lib/rstudio/bin/pandoc/pandoc

# Pandoc pdf options
PANDOC_PDF_OPTIONS = \
	--latex-engine xelatex  \
	--template='./../include/tex/manual-with-written-cover.tex' \
	--variable=geometry:a4paper \
	--variable=links-as-notes \
	--chapters \
	--number-sections \
	--toc

.PHONY: all
all: manual exercise

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

.PHONY: exercise
exercise: $(PDF_OUT) $(PDF_OUT_SOLUTIONS) clean_md

$(PDF_OUT): $(EXERCISES_MD)
	$(PANDOC_PATH) $(PANDOC_PDF_OPTIONS) $^ --output $@

$(PDF_OUT_SOLUTIONS): $(EXERCISES_SOLUTIONS)
	$(PANDOC_PATH) $(PANDOC_PDF_OPTIONS) $^ --output $@

$(EXERCISES_DIR)/%.md: $(EXERCISES_DIR)/%.Rmd
	Rscript -e \
	"require(knitr); \
	knit('$<', output= '$@', quiet=FALSE)"

$(EXERCISES_DIR)/%.solution.md: $(EXERCISES_DIR)/%.Rmd
	Rscript -e \
	"require(knitr); \
	show_solution_mk <- TRUE; \
	knit('$<', output= '$@', quiet=FALSE)"

.PHONY: clean_md
clean_md:
	rm -rf $(EXERCISES_DIR)/*.md $(EXERCISES_DIR)/*.solution.md
	
.PHONY: clean
clean:
	rm -rf $(OUTPUT_HTML_DIR)/*
	rm -rf $(OUTPUT_PURL_DIR)/*
	rm -rf $(OUTPUT_PDF_DIR)/*

