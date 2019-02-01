pandoc_opt=-Fpandoc-crossref -Fpandoc-citeproc

.DELETE_ON_ERROR:
.SECONDARY:

all: orca.pdf orca-bioinfo.pdf

clean:
	rm -f orca.pdf

# Fetch BibTex records from a list of DOI.
%.doi.bib: %.doi
	brew cite $$(<$<) | sort >$@

# Concatentate the citations with and without DOI.
%.bib: %.doi.bib %.other.bib
	sort $^ | sed 's~http://dx.doi.org~https://doi.org~' >$@

# Download the citation style language (CSL).
orca.csl:
	curl -o $@ https://www.zotero.org/styles/bioinformatics

# Download the Bioinformatics LaTeX template.
cabios-template.zip:
	curl -L -o $@ https://academic.oup.com/DocumentLibrary/Bioinformatics/cabios-template.zip

# Render Markdown to HTML using Pandoc.
%.html: %.md %.bib %.csl
	pandoc $(pandoc_opt) -s -o $@ $<

# Convert Markdown to LaTeX using Pandoc.
%.tex: %.md %.bib %.csl
	pandoc $(pandoc_opt) -s -o $@ $<

# Render Markdown to PDF using Pandoc.
%.pdf: %.md %.bib %.csl
	pandoc $(pandoc_opt) -o $@ $<

# Render Markdown to DOCX using Pandoc.
%.docx: %.md %.bib %.csl
	pandoc $(pandoc_opt) -o $@ $<

# Render LaTeX to PDF using pdflatex.
%.pdf: %.tex
	pdflatex $<
