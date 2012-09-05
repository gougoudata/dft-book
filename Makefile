EMACS=emacs
BATCH_EMACS=$(EMACS) --batch -l ~/Dropbox/.emacs.d/init.el dft.org
REQUIREMENTS=python
PDFLATEX=pdflatex -shell-escape
LATEX=latex -shell-escape
org:
	emacs dft.org &

all: pdf html mobi

tex: dft.org dft.bib
	$(BATCH_EMACS) -f org-export-as-latex

pdf: tex
	pdflatex -shell-escape dft
	bibtex dft
	pdflatex -shell-escape dft
	makeindex dft
	pdflatex -shell-escape dft

xhtml:
	htlatex dft.tex "xhtml,mathml" " -cunihtf" "-cvalidate"

html:
	$(BATCH_EMACS) -f org-export-as-html

mobi: html
	/home/jkitchin/kindlegen/kindlegen dft.html

clean:
	rm -f *.aux *.log *.dvi *.blg *.bbl *.toc *~ *.out *.idx *.ilg *.ind *.lof *.lot *.css *.idv *.lg *.tmp *.xref *.4ct *.4tc
