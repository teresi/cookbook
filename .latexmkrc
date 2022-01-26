# latexmk configuration file


# add extensions to be deleted on clean
push @generated_exts, 'glo', 'gls', 'glg';    # glossary
push @generated_exts, 'acn', 'acr', 'alg';    # acronym
push @generated_exts, 'maf', 'mtc*', 'mlf*';  # minitoc
push @generated_exts, 'ist', 'xdy';           # makeindex
$bibtex_use = 2;                              # bibtex, bbl files
push @generated_exts, 'run.xml';              # biber
push @generated_exts, 'nav', 'snm';           # beamer navigation
$clean_ext .= ' %R-blx.bib';                  # biblatex
