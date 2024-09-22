# TERESI FAMILY COOKBOOK

- [cookbook.pdf (Sept 2024)](https://github.com/teresi/teresi.github.io/blob/master/cookbook/archive/cookbook_20240922.pdf)


## HOW TO

```bash
$ make                     # cookbook.pdf
$ make help                # usage
$ make submodules          # download submodules
$ make book                # book.pdf (mockup)
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
Requires LaTeX 2024 or later.

e.g. on Ubuntu:
```bash
# apt install make curl perl coreutils   # build tools
$ make install -C texlive                # TeX Live 2024, see https://www.tug.org/texlive/
$ source ~/.bashrc                       # update your PATH for 2024
$ tlmgr init-usertree                    # initialize directories
$ tlmgr install `cat requirements.txt`   # install TeX packages
$ make clean                             # clean old builds if upgrading TeX
```

recommended:
```bash
# apt install ghostscript                # compress pdf
# apt install git-lfs wget imagemagick   # create images
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
- [ ] fleshout index by ingredient or keywords etc.
- [ ] add license
- [ ] cleanup perl / cpan script, add to makefile
- [ ] try using \includepdf for imposition instead of perl to reduce dependencies
- [ ] refactor `cls` out of this project
- [ ] add front matter according to the [novel package](https://mirror2.sandyriver.net/pub/ctan/macros/luatex/latex/novel/doc/novel-documentation.html) docs?
- [ ] fix spacing for 1 col ingredients (before/after)
