# Makefile for Teresi family cookbook

ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
SHELL := /bin/bash
DATE := $(shell date '+%Y%m%d')  # follows the format from compress.bash
PROJECT := cookbook
IN := .tex
OUT := cookbook.pdf

.PHONY: all clean compress
.PHONY: $(PROJECT).pdf  # delegate to latexmk b/c it needs run more than once for LaTeX

cookbook.pdf:
	latexmk -pdf $(PROJECT).tex

all compress: $(PROJECT).pdf
	+$(MAKE) -C archive --no-print-directory

clean:
	latexmk -C $(PROJECT).tex
