# COOKBOOK

Teresi family cookbook.

- [cookbook.pdf (August 2020)](https://github.com/teresi/teresi.github.io/blob/master/cookbook/archive/cookbook_20200809.pdf)
- [cookbook.pdf (August 2021)](https://github.com/teresi/teresi.github.io/blob/master/cookbook/archive/cookbook_20210806.pdf)


## HOW TO

```bash
$ make cookbook.pdf
```


## DESIGN
- 6x9 inch book trim, single column
- environments / commands for formatting
    - SEE `./recipe_snippet.tex`
- no images committed to this repo
    - to save space
    - to simplify printing


## DEPENDENCIES
Requires LaTeX.

e.g. in Ubuntu:
```bash
# apt install texlive      # for compiling, required
# apt install ghostscript  # for compressing, optional
# apt install make         # for convenience, optional
```

### WINDOWS
Download the project, install LaTeX and an editor, then build the pdf.

- download the zipped project or clone w/ Git
    - e.g.: https://www.atlassian.com/git/tutorials/install-git#windows
- install MiKTeX (SEE https://miktex.org/howto/install-miktex)
- install an editor (e.g. TeXstudio https://www.texstudio.org/)
- open `cookbook.tex` and compile to pdf (F5 in TeXstudio)


## CONTRIBUTING

1. create recipe file
    - `$ cp recipe_snippet.tex <category>/<recipe_title>.tex`
2. add the new recipe to the cookbook
    - find your chapter in `cookbook.tex`, e.g. `\section{Breakfast}`
    - add the new recipe using `\input{}` to said section
        - `\include{./breakfasts/eggscellent_challenge}  % your new filename (no extension)
3. modify your new recipe using the commands provided in `recipe_snippet.tex`
    - see Preface for a compiled example
4. comple with `make`


## FUTURE

- [x] add custom layout (remove xcoookybooky)
- [x] add custom style
- [x] add hints to the margins
- [x] modify 'Ingredients' blocks to three columns (amount, unit, ingredient)
- [x] add cover
- [x] remove all images tracked in this repository
- [ ] add front matter according to the novel package docs
- [ ] add license
- [ ] fleshout index by ingredient or keywords etc.
- [ ] fix spacing for 1 col ingredients (before/after)
- [x] handle widows (`nowidow` brakes the tables, `titlesec` not working?)
- [x] add bibliography
- [x] add compilation automation w/ `latexmk' / Makefile
- [x] remove all images from history (move any images out of source)
- [x] add ghostscript helper to compress pdf
- [x] add vegetarian icon
