SRC = \
  01-programming-functions.rmd \
  02-programming-conditionals.rmd \
	03-programming-loops.rmd

MD = \
  01-programming-functions.md \
  02-programming-conditionals.md \
	03-programming-loops.md 

DIR = input

OUTPUT = BasicProgramming

PANDOC_OPTIONS = \
	--chapters \
  --number-sections \
	--latex-engine xelatex \
	--variable=geometry:a4paper \
	--toc \
	-H include/header.tex \
	-B include/cover.tex

%.md: %.rmd
	Rscript -e "require(knitr); knit('$<', quiet=TRUE)"

all: $(MD)
	pandoc $(PANDOC_OPTIONS) -o $(OUTPUT).pdf $(MD)
	
clean:
	rm -f $^ \
	rm -f *.html \
  rm -f *.Rprof
