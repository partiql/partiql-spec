SPECPDF=main.pdf

.PHONY: all clean $(SPECPDF)

all: $(SPECPDF)

$(SPECPDF): *.tex
	latexmk	-pdf -pdflatex="pdflatex -interaction=nonstopmode" -use-make main.tex

clean:
	latexmk -C
