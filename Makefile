# Makefile for Teresi family cookbook

ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
SHELL := /bin/bash
DATE := $(shell date '+%Y%m%d')  # follows the format from compress.bash
OUT := $(ROOT_DIR)/cookbook.pdf
OUT_ARCHIVE := $(ROOT_DIR)/archive/cookbook_$(DATE).pdf

.PHONY: all
all: cookbook.pdf $(OUT_ARCHIVE)

.PHONY: cookbook.pdf  # allow latexmk to handle multiple calls
cookbook.pdf:
	latexmk -pdf $(ROOT_DIR)/cookbook.tex

.PHONY: clean
clean:
	-rm -rf $(OUT)
	-rm -rf $(OUT_ARCHIVE)

$(OUT_ARCHIVE): cookbook.pdf
	$(ROOT_DIR)/scripts/compress.bash -l 4

.PHONY: archive
.ONESHELL:
archive: cookbook.pdf $(OUT_ARCHIVE)
