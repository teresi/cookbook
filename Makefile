#!/usr/bin/make -f

# creates the cookbook PDF

# INFO cookbook.pdf is a phony target in order to have Make delegate to latexmk
#      b/c TeX files need specific make rules (e.g. multiple compile runs etc.)
# INFO the compress recipe writes a file w/ a suffix of the current date
# INFO the compress recipe will compress every call, b/c cookbook.pdf is a phony target


root_dir := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

.PHONY: pdf all cookbook.pdf compress clean help

pdf: cookbook.pdf  ## alias to compile to PDF (DEFAULT)

all: compress  ## alias to compile and compress

cookbook.pdf:  ## the pdf target
	latexmk -pdf cookbook.tex

compress: cookbook.pdf  | archive  ## make and compress the PDF
	$(root_dir)/scripts/compress.bash -l 0 -i cookbook.pdf -o $(root_dir)/archive

clean:  ## remove temporary files
	latexmk -C cookbook.tex

archive:  ## destination for compressed PDFs
	mkdir -p $(root_dir)/archive

.PHONY: help
# SEE https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help:  ## show usage
	@grep -E '^[a-zA-Z^.(]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
