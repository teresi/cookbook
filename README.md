# TERESI FAMILY COOKBOOK

Recipes from friends and family.

- [cookbook.pdf (December 2022)](https://github.com/teresi/teresi.github.io/blob/master/cookbook/archive/cookbook_20221222.pdf)


## HOW TO

```bash
$ make cookbook.pdf  # the book
$ make help          # show usage
```

![preface](https://github.com/teresi/teresi.github.io/blob/master/preface.png)


## DESIGN
- typesets recipes w/ a minimlist style
- 6x9" book trim, single column
- defines environments and commands for formatting
    - SEE `./recipe_snippet.tex`
- no images committed to this repo
    - to save space
    - to simplify printing


## DEPENDENCIES
Requires LaTeX and BibTeX.

e.g. in Ubuntu and etc.:
```bash

# apt install texlive-full               # required
# apt install texlive-bibtex-extra       # required
# apt install make latexmk               # optional
# apt install ghostscript                # optional
```

## CONTRIBUTING

1. create blank recipe using the snippet
    - `$ cp recipe_snippet.tex <category>/<recipe_title>.tex`
2. add the new recipe to the main file
    - find your chapter in `cookbook.tex`, e.g. `\section{Breakfast}`
    - add the new recipe using `\input{}` to said section
        - `\include{./breakfasts/eggscellent_challenge}  % your new filename (no extension)`
3. update snippet w/ your recipe, compile


## FUTURE

- [ ] refactor `cls` out of this project
- [ ] add license
- [ ] add front matter according to the novel package docs
- [ ] fix spacing for 1 col ingredients (before/after)
- [ ] fleshout index by ingredient or keywords etc.
- [ ] find a way to reduce size of dependencies? (maybe use `tlmgr`?)
