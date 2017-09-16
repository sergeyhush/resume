RESUME ?= resume.md
TOOLS := pandoc pdflatex

$(foreach bin, $(TOOLS), \
	$(if $(shell command -v $(bin) 2> /dev/null),,$(error Install `$(bin)`)))


all: resume.html resume.pdf

%.html: %.md
	pandoc -t html5 --template templates/resume-template.html --standalone --section-divs -o $@ $<

%.pdf:  %.md
	pandoc -o $@ $<

clean:
	rm -f *~ *.log *.pdf *.html
