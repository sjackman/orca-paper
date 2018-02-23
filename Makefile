pandoc_opt=-Fpandoc-citeproc

.DELETE_ON_ERROR:
.SECONDARY:

all: orca.html orca.pdf

clean:
	rm -f orca.html orca.pdf orca-supp.html orca-supp.pdf

# Download the citation style language (CSL).
orca.csl:
	curl -o $@ https://www.zotero.org/styles/bioinformatics

# Render Markdown to HTML using Pandoc.
%.html: %.md
	pandoc $(pandoc_opt) -s -o $@ $<

# Render Markdown to PDF using Pandoc.
%.pdf: %.md
	pandoc $(pandoc_opt) -o $@ $<

# Generate Table of Contents for supplemental material only
orca-supp.pdf: orca-supp.md
	pandoc $(pandoc_opt) --toc -o $@ $<

# Render Markdown to DOCX using Pandoc.
%.docx: %.md
	pandoc $(pandoc_opt) -o $@ $<

# Render RMarkdown to HTML using R.
%.html: %.rmd
	RScript -e 'rmarkdown::render("$<")'

orca.docx: orca.bib orca.csl
orca.html: orca.bib orca.csl
orca.pdf: orca.bib orca.csl

orca-supp.docx: orca.bib orca.csl
orca-supp.html: orca.bib orca.csl
orca-supp.pdf: orca.bib orca.csl
