RESUME ?= resume.md
TOOLS := pandoc pdflatex
MKDIR = mkdir -p


$(foreach bin, $(TOOLS), \
	$(if $(shell command -v $(bin) 2> /dev/null),,$(error Install `$(bin)`)))


all: resume.html resume.pdf

%.html: %.md
	${MKDIR} docs
	pandoc -t html5 --template templates/resume-template.html --standalone --section-divs -o docs/index.html $<

%.pdf:  %.md
	${MKDIR} docs
	pandoc -o docs/$@ $<

clean:
	rm -f *~ *.log *.pdf *.html
