# latexmk configuration file


# handle glossaries (may not be strictly necessary)
# see: https://tex.stackexchange.com/questions/1226/how-to-make-latexmk-use-makeglossaries
add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');
sub run_makeglossaries {
    my ($base_name, $path) = fileparse( $_[0] ); #handle -outdir param by splitting path and file, ...
    pushd $path; # ... cd-ing into folder first, then running makeglossaries ...
    if ( $silent ) {
        system "makeglossaries -q '$base_name'"; #unix
        # system "makeglossaries", "-q", "$base_name"; #windows
    }
    else {
        system "makeglossaries '$base_name'"; #unix
        # system "makeglossaries", "$base_name"; #windows
    };
    popd; # ... and cd-ing back again
}


# add extensions to be deleted on clean
push @generated_exts, 'glo', 'gls', 'glg';    # glossary
push @generated_exts, 'acn', 'acr', 'alg';    # acronym
push @generated_exts, 'maf', 'mtc*', 'mlf*';  # minitoc
push @generated_exts, 'ist', 'xdy';           # makeindex
$bibtex_use = 2;                              # bibtex, bbl files
push @generated_exts, 'run.xml';              # biber
push @generated_exts, 'nav', 'snm';           # beamer navigation
$clean_ext .= ' %R-blx.bib';                  # biblatex
