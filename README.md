# TERESI FAMILY COOKBOOK

- [cookbook.pdf (Nov 2023)](https://github.com/teresi/teresi.github.io/blob/master/cookbook/archive/cookbook_20231121.pdf)


## HOW TO

```bash
$ make               # cookbook.pdf
$ make help          # usage
$ make submodules    # download submodules
$ make book          # mockup
```

![title](https://github.com/teresi/teresi.github.io/blob/master/title.png)
![preface](https://github.com/teresi/teresi.github.io/blob/master/preface.png)


## DESIGN
- black and white
- 6x9" trim
- simple graphics
- commands in `family_cookbook.cls`
- example in `./recipe_snippet.tex`


## DEPENDENCIES
Requires LaTeX 2024 or later.

e.g. in Ubuntu:
```bash
# apt install make curl perl coreutils   # build tools
$ make install -C texlive                # TeX Live 2024, see https://www.tug.org/texlive/
$ source ~/.bashrc                       # update your PATH for 2024
$ tlmgr install `cat requirements.txt`   # TeX Live packages
```

recommended:
```bash
# apt install ghostscript                # compression
# apt install perl                       # printing
# apt install git-lfs wget imagemagick   # images
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
- [x] refactor folder structure
- [ ] refactor `cls` out of this project
- [ ] add license
- [ ] add front matter according to the [novel package](https://mirror2.sandyriver.net/pub/ctan/macros/luatex/latex/novel/doc/novel-documentation.html) docs?
- [ ] fix spacing for 1 col ingredients (before/after)
- [ ] fleshout index by ingredient or keywords etc.
- [x] find a way to reduce size of dependencies? (maybe use `tlmgr`?)
- [x] refactor frontispiece / title graphics, commit images somewhere
- [ ] automate hiding hyper ref links between pdf / book
