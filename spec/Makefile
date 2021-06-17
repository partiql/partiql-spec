SPECPDF=main.pdf
OUTDIR=build

.PHONY: all clean $(SPECPDF)

all: $(SPECPDF)

$(SPECPDF): *.tex
	latexmk	-pdf -pdflatex="pdflatex -interaction=nonstopmode" -use-make main.tex -outdir=$(OUTDIR)
clean:
	latexmk -C -outdir=$(OUTDIR)
