# TERESI FAMILY COOKBOOK

- [cookbook.pdf (November 2025)](https://github.com/teresi/teresi.github.io/blob/master/cookbook/archive/cookbook_20251121.pdf)


## HOW TO

```bash
$ make                     # cookbook.pdf
$ make book                # book.pdf (mockup)
$ make help                # usage
$ make install             # install packages from CTAN (tlmgr)
$ make submodules          # download submodules (git)
$ less recipe_snippet.tex  # example recipe
```

![title](https://github.com/teresi/teresi.github.io/blob/master/title.png)
![preface](https://github.com/teresi/teresi.github.io/blob/master/preface.png)


## DESIGN
- top level input: `cookbook.tex`
    + recipes in `./src/*`
    + class definition: `family_cookbook.cls`
- print on a standard printer
    + black and white
    + 5.5 x 8.5" trim
    + 2-page imposition (folio)
- long term project
    + simple graphics
    + space for notes in margin


## DEPENDENCIES

Basic dependencies:
```
bash make perl coreutils latexmk
git git-lfs curl wget
imagemagick                  # image processing
ghostcript                   # pdf compression
```

Tested on TeX Live 2024, see `https://www.tug.org/texlive/`.
```bash
make install -C texlive      # installs texlive, scheme-basic
source ~/.bashrc             # update your PATH
tlmgr init-usertree          # initialize directories
make install                 # install packages from CTAN
```


## CONTRIBUTING

1. create blank recipe using the snippet
    - `$ cp recipe_snippet.tex <category>/<recipe_title>.tex`
2. add the new recipe to the main file
    - find your chapter in `cookbook.tex`, e.g. `\section{Breakfast}`
    - add the new recipe using `\input{}` to said section
        - `\include{./breakfasts/eggscellent_challenge}  % your new filename (no extension)`
3. update snippet w/ your recipe, compile


## TODO

- [x] simplify folder structure
- [x] organize drinks into sub sections
- [x] add imposition for printing
- [x] add book output for printing
- [x] find a good resolution for printing
- [x] find a way to reduce size of LaTeX dependencies
- [x] refactor frontispiece / title graphics, commit images somewhere
- [x] reduce requirements list
- [x] upgrade from nicefrac to xfrac
- [ ] warning on minitoc: you have used minitoc but not tableofcontents
- [ ] fleshout index by ingredient or keywords etc.
- [ ] move family_cookbook.cls to another repo
- [ ] remove texlive installer
- [ ] add license
- [ ] cleanup perl / cpan script, add to makefile
- [ ] try using \includepdf for imposition instead of perl to reduce dependencies
- [ ] add front matter according to the [novel package](https://mirror2.sandyriver.net/pub/ctan/macros/luatex/latex/novel/doc/novel-documentation.html) docs?
- [ ] fix spacing for 1 col ingredients (before/after)
