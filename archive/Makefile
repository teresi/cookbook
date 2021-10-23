# Makefile for compressing and archiving the cookbook pdf

ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
IN := $(ROOT_DIR)/../cookbook.pdf
COMPRESSED_BOOK := cookbook_$(DATE).pdf

$(COMPRESSED_BOOK):
	$(ROOT_DIR)/../scripts/compress.bash -l 0 -i $(IN) -o $(ROOT_DIR)
