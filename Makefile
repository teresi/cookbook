#!/usr/bin/make -f

# creates the cookbook PDF

# INFO cookbook.pdf is a phony target in order to have Make delegate to latexmk
#      b/c TeX files need specific make rules (e.g. multiple compile runs etc.)
# INFO the compress recipe writes a file w/ a suffix of the current date
# INFO the compress recipe will compress every call, b/c cookbook.pdf is a phony target
#
# NB the name of the 'archived' pdf is not computed here b/c the phony recipe will always
#    recompress it's input, and therefore Make won't know when to not skip re-compilation


MAKEFLAGS += --no-print-directory

_root_dir := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
_cookbook_in := cookbook.tex
_cookbook_out := cookbook.pdf
_archive_dir := $(_root_dir)/archive
_cookbook_pdf := $(_root_dir)/cookbook.pdf


.PHONY: pdf
pdf: $(_cookbook_out)  ## alias for the cookbook


.PHONY: $(_cookbook_out)
$(_cookbook_out): $(_cookbook_in) family_cookbook.cls
	latexmk -pdf -time -use-make $(_cookbook_in)


.PHONY: help
# SEE https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help:  ## show usage
	@grep -E '^[a-zA-Z^.(]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


.PHONY: clean
clean:  ## remove temporary files
	latexmk -C $(_cookbook_out)
	latexmk -C rescaled.pdf
	latexmk -C book.pdf
	latexmk -C cookbook-imp.pdf


$(_archive_dir):
	mkdir -p $(_archive_dir)


.PHONY: archive
archive: | pdf $(_archive_dir) ## alias to compress a copy to the achive folder
	$(_root_dir)/scripts/compress.bash -l 0 -i $(_cookbook_out) -o $(_archive_dir)


.PHONY: book
book: book.pdf  ## alias for the book formatted for printing


.PHONY: rescaled.pdf
rescaled.pdf: $(_cookbook_out) rescaled.tex
	@# NB we rescale from 6x9 to 5.5x8.5 b/c we want to print a mock-up on an 8.5x11 printer
	@# and we need to have 5.5x8.5 to fit two pages per sheet of letter paper
	@# but printing it natively to 5.5x8.5 doesn't fit the recipes to the pages well,
	@# so the slight change in aspect ratio & size is a good trade-off for the mock-up
	@# TODO have a mockup rule and a book rule (book print would be 11x17 for pro printers?)
	latexmk -pdf -time -use-make rescaled.tex


cookbook-imp.pdf: rescaled.pdf
	@# SEE https://metacpan.org/dist/PDF-Imposition/view/bin/pdf-impose.pl
	@# TODO need install script for PDF-Imposition
	@# TODO need install script for cpan (?)
	@# SEE http://www.cpan.org/modules/INSTALL.html
	pdf-impose.pl rescaled.pdf --schema 2up --paper 8.5in:11in --signature 16 cookbook-imp.pdf


book.pdf: cookbook-imp.pdf
	@# TODO is there a better way to get these margins rather than trial/error?
	@# NB the margins are in points, though there _should_ be 72 pt / inch
	pdfcrop --margins '-41 -41 -41 -41' cookbook-imp.pdf book.pdf
