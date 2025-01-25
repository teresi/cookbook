#!/usr/bin/env -S make -f

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


.PHONY: all
all: $(_cookbook_out)  ## the cookbook


.PHONY: install
install: SHELL:=/usr/bin/env bash
install:               ## install LaTeX dependencies w/ tlmgr
	tlmgr install $$(<requirements.txt)


# using phony b/c latexmk handles rebuilds
# FUTURE remove phony, add dependency on image files
.PHONY: $(_cookbook_out)
$(_cookbook_out): $(_cookbook_in) family_cookbook.cls
	$(MAKE) -ik -C ./images/cookbook_assets
	max_print_line=96 \
		latexmk -bibtex -pdf -time -use-make $(_cookbook_in)


.PHONY: help
# SEE https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help:  ## show usage
	@grep -E '^[a-zA-Z^.(]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


.PHONY: clean
clean:  ## remove temporary files
	latexmk -f -C $(_cookbook_out)
	latexmk -f -C rescaled.pdf
	latexmk -f -C book.pdf
	latexmk -f -C cookbook-imp.pdf
	latexmk -f -C endpaper.pdf
	$(MAKE) -ik -C $(_root_dir)/images/cookbook_assets/ clean


.PHONY: submodules
submodules:    ## initialize the submodules
	git submodule update --init --recursive


$(_archive_dir):
	mkdir -p $(_archive_dir)


.PHONY: archive
archive: | pdf $(_archive_dir) ## alias to compress a copy to the achive folder
	$(_root_dir)/scripts/compress.bash -l 0 -i $(_cookbook_out) -o $(_archive_dir)


.PHONY: book
book: book.pdf                 ## alias for the book formatted for printing


endpaper.pdf: endpaper.tex
	max_print_line=96 \
		latexmk -pdf -time -use-make $(endpaper.tex)


.PHONY: rescaled.pdf
rescaled.pdf: $(_cookbook_out) rescaled.tex
	# TODO rename; this is no longer a rescale, but a way to add the frontispiece
	latexmk -pdf -time -use-make rescaled.tex


# TODO rename rescaled.tex to book.tex, b/c we aren't rescaling anymore
cookbook-imp.pdf: rescaled.pdf
	@# SEE https://metacpan.org/dist/PDF-Imposition/view/bin/pdf-impose.pl
	@# TODO need install script for PDF-Imposition
	@# TODO need install script for cpan (?)
	@# SEE http://www.cpan.org/modules/INSTALL.html
	@# NOTE previously I had a rescale rule to go from 6x9 to 5.5x11, but
	@# working directly in the 8.5x11 format was easier to handle the spacing for
	pdf-impose.pl rescaled.pdf --schema 2up --paper 8.5in:11in --signature 16 cookbook-imp.pdf
	@# TODO see if this can be replaced with pdfpages https://mirror2.sandyriver.net/pub/ctan/macros/latex/contrib/pdfpages/pdfpages.pdf


book.pdf: cookbook-imp.pdf  ## cookbook as a mock-up for printing on letter paper
	@# TODO is there a better way to get these margins rather than trial/error?
	@# NB the margins are in points, though there _should_ be 72 pt / inch
	pdfcrop --margins '-41 -41 -41 -41' cookbook-imp.pdf book.pdf


.PHONY: uploads            # PNGs for use in the readme, via teresi.github.io
uploads: ./githubio/title.png ./githubio/preface.png


./githubio:
	mkdir -p ./githubio


./githubio/title.png: cookbook.pdf | githubio
	pdfjam cookbook.pdf 1 --fitpaper true -o ./githubio/title.pdf
	#pdfseparate cookbook.pdf -f 1 -l 1 ./archive/title.pdf 2>/dev/null
	pdftoppm -gray -png -singlefile -r 75 ./githubio/title.pdf ./githubio/title && rm ./githubio/title.pdf
	-cp ./githubio/title.png ../teresi.github.io/


./githubio/preface.png: cookbook.pdf | githubio
	@# NB the page number will need manual updating when the ToC changes
	@# the preface could be compiled on it's own to simplify this
	pdfjam cookbook.pdf 6 --fitpaper true -o ./githubio/preface.pdf
	#pdfseparate cookbook.pdf -f 6 -l 6 ./archive/preface.pdf 2>/dev/null
	pdftoppm -gray -png -singlefile -r 75 ./githubio/preface.pdf ./githubio/preface && rm ./githubio/preface.pdf
	-cp ./githubio/preface.png ../teresi.github.io/
