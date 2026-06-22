#!/usr/bin/env -S make -f

# creates the cookbook PDF

# NB the name of the 'archived' pdf is not computed here b/c the phony recipe will always
#    recompress it's input, and therefore Make won't know when to not skip re-compilation


MAKEFLAGS += --no-print-directory
LATEXFLAGS = -bibtex -pdf -time -use-make
_root_dir := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

SRC := cookbook.tex
OBJ := cookbook.pdf

# FUTURE: move class file to it's own repo
SRC += family_cookbook.cls
# recipes are in ./src/
SRC += $(shell find ./src -name "*.tex" -type f)

OBJ_ARCHIVE := cookbook_$(shell date +"%Y%m%d").pdf
_archive_dir := $(_root_dir)/archive



.PHONY: all
all: images cookbook.pdf  ## alias for the cookbook


.PHONY: images
images:                   ## alias for image dependencies
	$(MAKE) -ik -C ./images/cookbook_assets


.PHONY: help
help:                     ## show usage
	@# SEE: https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
	@grep -E '^[a-zA-Z^.(]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


# dummy dependency to force gnu make to delegate to latexmk
FORCE_MAKE:


%.pdf: %.tex FORCE_MAKE
	max_print_line=96 latexmk $(LATEXFLAGS) $<


.PHONY: book
book: book.pdf            ## alias for the cookbook with imposition


.PHONY: install
install: SHELL:=/usr/bin/env bash
install:                  ## install LaTeX dependencies w/ tlmgr
	tlmgr install $$(<requirements.txt)


.PHONY: clean
clean:  ## remove temporary files
	latexmk -f -C cookbook.pdf
	latexmk -f -C rescaled.pdf
	latexmk -f -C book.pdf
	latexmk -f -C cookbook-imp.pdf
	latexmk -f -C endpaper.pdf
	$(MAKE) -ik -C $(_root_dir)/images/cookbook_assets/ clean


.PHONY: submodules
submodules:               ## initialize the submodules
	git submodule update --init --recursive


$(_archive_dir):
	mkdir -p $(_archive_dir)


.PHONY: archive
archive: $(OBJ_ARCHIVE)   ## alias to compress a copy to the achive folder


$(OBJ_ARCHIVE): cookbook.pdf $(_archive_dir)
	$(_root_dir)/scripts/compress.bash -l 0 -i cookbook.pdf -o $(_archive_dir)


endpaper.pdf: endpaper.tex


.PHONY: rescaled.pdf
rescaled.pdf: rescaled.tex cookbook.pdf
	# TODO: rename; this is no longer a rescale, but a way to add the frontispiece
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
