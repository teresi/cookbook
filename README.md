# TERESI FAMILY COOKBOOK

- [cookbook.pdf (Nov 2023)](https://github.com/teresi/teresi.github.io/blob/master/cookbook/archive/cookbook_20231121.pdf)


## HOW TO

```bash
$ make pdf           # cook book pdf
$ make book          # printing mockup
$ make submodules    # download submodules
$ make help          # usage
```

![title](https://github.com/teresi/teresi.github.io/blob/master/title.png)
![preface](https://github.com/teresi/teresi.github.io/blob/master/preface.png)


## DESIGN
- minimal style
- black and white
- 6x9" book trim, single column
- minimal graphics to simplify printing
- provides environments / commands
    - SEE `./recipe_snippet.tex`


## DEPENDENCIES
Requires LaTeX and BibTeX.

Optionally requires `make`, `latexmk`, `ghostscript`, `perl`

e.g. in Ubuntu:
```bash

# apt install texlive-full               # required
# apt install texlive-bibtex-extra       # required
# apt install make latexmk               # optional, build tools
# apt install ghostscript                # optional, pdf compression
# apt install perl                       # optional, for printing
# apt install git-lfs                    # optional, for imagery
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

- [x] add imposition
- [x] add book mock-up
- [x] refactor drinks w/ sub sections by base ingredient
- [ ] add book for large format printer
- [ ] cleanup perl / cpan script, add to makefile if possible
- [ ] refactor folder structure
- [ ] refactor `cls` out of this project
- [ ] add license
- [ ] add front matter according to the [novel package](https://mirror2.sandyriver.net/pub/ctan/macros/luatex/latex/novel/doc/novel-documentation.html) docs?
- [ ] fix spacing for 1 col ingredients (before/after)
- [ ] fleshout index by ingredient or keywords etc.
- [ ] find a way to reduce size of dependencies? (maybe use `tlmgr`?)
- [x] refactor frontispiece / title graphics, commit images somewhere
- [ ] automate hiding hyper ref links between pdf / book
