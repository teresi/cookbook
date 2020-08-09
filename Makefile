# Makefile for Teresi family cookbook

ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
SHELL := /bin/bash
DATE := $(shell date '+%Y%m%d')  # follows the format from compress.bash
OUT := $(ROOT_DIR)/cookbook.pdf
OUT_ARCHIVE := $(ROOT_DIR)/archive/cookbook_$(DATE).pdf

$(OUT_ARCHIVE): cookbook.pdf
	$(ROOT_DIR)/scripts/compress.bash -l 0

.PHONY: cookbook.pdf  # allow latexmk to handle multiple calls
cookbook.pdf:
	latexmk -pdf $(ROOT_DIR)/cookbook.tex

.PHONY: clean
clean:
	-rm -rf $(OUT)
	-rm -rf $(OUT_ARCHIVE)
