#!/usr/bin/make -f

# creates the cookbook PDF

# INFO cookbook.pdf is a phony target in order to have Make delegate to latexmk
#      b/c TeX files need specific make rules (e.g. multiple compile runs etc.)
# INFO the compress recipe writes a file w/ a suffix of the current date
# INFO the compress recipe will compress every call, b/c cookbook.pdf is a phony target
#
# NB the name of the 'archived' pdf is not computed here b/c the phony recipe will always
#    recompress it's input, and therefore Make won't know when to not skip re-compilation


_root_dir := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
_cookbook_in := cookbook.tex
_cookbook_out := cookbook.pdf
_archive_dir := $(_root_dir)/archive
_cookbook_pdf := $(_root_dir)/cookbook.pdf


.PHONY: pdf
pdf: $(_cookbook_in)  ## alias for the cookbook
	latexmk -pdf $(_cookbook_in)


.PHONY: archive
archive: | pdf $(_archive_dir) ## alias to compress a copy to the achive folder
	$(_root_dir)/scripts/compress.bash -l 0 -i $(_cookbook_out) -o $(_archive_dir)


.PHONY: clean
clean:  ## remove temporary files
	latexmk -C $(_cookbook_out)


$(_archive_dir):
	mkdir -p $(_archive_dir)


.PHONY: help
# SEE https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help:  ## show usage
	@grep -E '^[a-zA-Z^.(]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
