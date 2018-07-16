RESUME ?= resume.md
TOOLS := pandoc pdflatex
MKDIR = mkdir -p
TEMPLATE ?= default
TEMPLATEDIR = templates/$(TEMPLATE)
OUTFILES = resume.html resume.pdf
noop=
space = $(noop) $(noop)
CSS := $(addprefix --include-in-header=,$(wildcard $(TEMPLATEDIR)/css/*.css))

$(foreach bin, $(TOOLS), \
	$(if $(shell command -v $(bin) 2> /dev/null),,$(error Install `$(bin)`)))

all: $(OUTFILES)

%.html: %.md
	${MKDIR} docs
	pandoc -t html5 \
		$(CSS) \
		--template $(TEMPLATEDIR)/index.html \
		--standalone --section-divs -o $@ $<

%.pdf:  %.html
	wkhtmltopdf --print-media-type $< $@

clean:
	rm -f *~ *.log $(OUTFILES)
