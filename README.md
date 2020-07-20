# COOKBOOK

Teresi family cookbook.

- [cookbook.pdf (April 2020)](https://github.com/teresi/teresi.github.io/blob/master/cookbook/archive/cookbook_20200419.pdf)


## HOW TO

```bash
make cookbook.pdf
```

## DESIGN

In summary:
- `xcookybooky` provides formatting
- `/cookbook.tex` is the top level (add recipes using `\include` or `\input`)
- images are not tracked in this repository in order to:
    - save space
    - simplify printing

See `/cookbook.tex` for more details.


## DEPENDENCIES
Requires a standard LaTeX distribution.

Optionally requires `ghostscript` for compressing the pdf.

```bash
# apt-get install texlive      # ubuntu, building, required
# apt-get install ghostscript  # ubuntu, compress, optional
```

### WINDOWS
Download the project, install LaTeX and an editor, then build the pdf.

- download the zipped project from github, or clone w/ Git
    - e.g.: https://www.atlassian.com/git/tutorials/install-git#windows
- install MiKTeX (SEE https://miktex.org/howto/install-miktex)
- install TeXStudio or other editor (https://www.texstudio.org/)
- open `/cookbook.tex` and compile to pdf (F5 in TeXStudio)


## CONTRIBUTING

1. create a new recipe file
    - copy & rename `scripts/recipe_snippet.tex` to your desired folder.
2. add the new recipe to the cookbok
    - in `/cookbook.tex`, add an `\include{}` line to your desired chapter
    - `\section{Breakfast}                           % the chapter`
    - `\include{./breakfasts/eggscellent_challenge}  % your new filename (no extension)`
3. add images (optional)
    - add images out of source, e.g. `/../cookbook_img`


## FUTURE

- [ ] add hints to the margins
- [ ] modify 'Ingredients' blocks to three columns (amount, unit, ingredient)
- [x] add cover
- [x] remove all images tracked in this repository
- [ ] add image collage to start of sections
- [x] add bibliography
- [ ] add custom class for recipe, reduce code repitition and standardize input
- [x] add compilation automation w/ `latexmk' / Makefile
- [ ] add git lfs for images
- [x] add ghostscript helper to compress pdf


