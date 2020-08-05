# COOKBOOK

Teresi family cookbook.

- [cookbook.pdf (April 2020)](https://github.com/teresi/teresi.github.io/blob/master/cookbook/archive/cookbook_20200419.pdf)


## HOW TO
See `Makefile`

```bash
make cookbook.pdf
```


## DESIGN
See top of `/cookbook.tex`; in summary:

- targets a 6x9 inch book trim, single column
- layout encoded in environments & commands (SEE recipe_snippet.tex)
- images are not tracked in this repository
    - to save space
    - to simplify printing


## DEPENDENCIES
Requires LaTeX.

E.g. in Ubuntu:
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

1. create a new recipe file
    - copy & rename `scripts/recipe_snippet.tex` to your desired folder.
2. add the new recipe to the cookbok
    - in `/cookbook.tex`, add an `\include{}` line to your desired chapter
    - `\section{Breakfast}                           % the chapter`
    - `\include{./breakfasts/eggscellent_challenge}  % your new filename (no extension)
3. add images (optional)
    - add images out of source, e.g. `/../cookbook_img`


## TODO

- [x] add custom layout (remove xcoookybooky)
- [x] add custom style
- [x] add hints to the margins
- [x] modify 'Ingredients' blocks to three columns (amount, unit, ingredient)
- [x] add cover
- [x] remove all images tracked in this repository
- [ ] add front matter according to the novel package docs
- [ ] add license?
- [ ] add index by ingredient or keywords etc.
- [ ] add calendar to icon matrix (default no entry), use \faCalendar0?
- [ ] fix spacing for 1 col ingredients (before/after)
- [ ] handle widows (`nowidow` brakes the tables, `titlesec` not working?)
- [ ] add image collage
- [ ] add switch to include images
- [x] add bibliography
- [x] add compilation automation w/ `latexmk' / Makefile
- [x] remove all images from history (move any images out of source)
- [x] add ghostscript helper to compress pdf
- [ ] add gluten free / vegetarian icons to `recipestats`
- [ ] add list of gluten free / vegetarian?

