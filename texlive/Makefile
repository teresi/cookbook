#!/usr/bin/make -f

# install texlive 2024
#
# SEE https://wiki.debian.org/TeXLive
# SEE https://www.tug.org/texlive/doc/install-tl.html
# SEE https://en.wikibooks.org/wiki/LaTeX/Installation
# SEE https://tug.org/texlive/doc/texlive-en/texlive-en.html#x1-50001.3

# MAGIC output dir of tar decompress is from the version downloaded
# MAGIC texdir is typically $HOME/.texlive2024, by LaTeX convention
# MAGIC paper size is letter b/c that's what I have available
# MAGIC scheme is scheme-small in order to cut down on install size
#       and we are going to install packages w/ tlmgr later
# MAGIC texlive installs binaries to TEXDIR/bin/x86_64-linux,
#       but will change depending on your setup

# NOTE required packages
#	tlmgr install biblatex marginnote ifsym cookingsymbols tikzsymbols fontawesome \
#	adforn fdsymbol paralist pgfornament enumitem minitoc imakeidx sectsty tocloft titlesec lipsum glossaries
#	tikzpagenodes tikzfill tcolorbox


TEXDIR ?= $(HOME)/.texlive2024
PAPER ?= letter
SCHEME ?= scheme-basic
#SCHEME ?= scheme-medium
BASHRC ?= $(HOME)/.bashrc

_root_dir := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
_tar_url := https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
_tar := install-tl-unx.tar.gz
_installer := install-tl-2024
_sig_url := https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz.sha512
_sig := install-tl-unx.tar.gz.sha512
_texlive_bin := $(TEXDIR)/bin
_bashrc_tex := $(HOME)/.config/source_texlive.bash

# append a 'source $3' call to a file $1
#      Appends the line if it does *not* exist
#      Uses the magic keyword as a comment (# delimited) to test if the call exists
#      1    filepath to append to
#      2    magic keyword
#      3    filepath to source
define source_file
	grep -q $(2) $(1) || echo "[ -r $(3) ] && source $(3)  # $(2)" >> $(1)
endef



.PHONY: all
all: $(_installer)


.PHONY: clean
clean:
	rm -rf $(_installer)
	rm -f $(_sig) $(_tar)


.PHONY: install
install: $(_texlive_bin) $(_bashrc_tex)


.PHONY: uninstall
uninstall:
	rm -rf $(TEXDIR)
	rm -f $(_bashrc_tex)
	rm -rf $(_texlive_bin)


$(_sig):
	curl -L -o $(_sig) $(_sig_url)


$(_tar):
	curl -L -o $(_tar) $(_tar_url)


$(_installer): $(_tar) $(_sig)
	@# touch the decompressed file b/c it's timestamp is not it's decompress time
	sha512sum -c $(_sig) && (mkdir -p $(_installer) && tar -xvzf $(_tar) -C $(_installer) && touch $(_installer)) \
		|| (echo "could not validate checksum! $(_sig)"; exit 1)


$(_texlive_bin): $(_installer)
	$(info updating $@...)
	@# cd into install-tl* b/c there is a sub dir starting with install-tl-2024* that is unkown
	cd $(_installer) && cd install-tl-* && \
		perl install-tl \
		-gui text \
		--paper=$(PAPER) \
		--texdir $(TEXDIR) \
		--scheme $(SCHEME) \
		-no-interaction
	@# touch the folder b/c it's timestamp is not the install time
	touch $(_texlive_bin)


$(_bashrc_tex): $(_texlive_bin)
	mkdir -p $(HOME)/.config
	echo "MANPATH+=:$(TEXDIR)/texmf-dist/doc/man" > $(_bashrc_tex)
	echo "INFOPATH+=:$(TEXDIR)/texmf-dist/doc/info" >> $(_bashrc_tex)
	echo "PATH+=:$(_texlive_bin)/x86_64-linux" >> $(_bashrc_tex)
	$(call source_file,$(BASHRC),TEXLIVE2024,$(_bashrc_tex))
