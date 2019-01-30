pandoc_opt=-Fpandoc-crossref -Fpandoc-citeproc

.DELETE_ON_ERROR:
.SECONDARY:

all: orca.pdf

clean:
	rm -f orca.pdf

# Download the citation style language (CSL).
orca.csl:
	curl -o $@ https://www.zotero.org/styles/bioinformatics

# Render Markdown to HTML using Pandoc.
%.html: %.md %.bib %.csl
	pandoc $(pandoc_opt) -s -o $@ $<

# Render Markdown to PDF using Pandoc.
%.pdf: %.md %.bib %.csl
	pandoc $(pandoc_opt) -o $@ $<

# Render Markdown to DOCX using Pandoc.
%.docx: %.md %.bib %.csl
	pandoc $(pandoc_opt) -o $@ $<
