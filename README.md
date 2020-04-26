# COOKBOOK

Teresi family cookbook.

[cookbook.pdf (April 2020)](https://github.com/teresi/teresi.github.io/blob/master/cookbook/archive/cookbook_20200419.pdf)


## HOW TO

### LINUX
```bash
make clean
make
```

Requires `texlive`.
```bash
# apt-get install texlive      # ubuntu, building, required
# apt-get install ghostscript  # ubuntu, compress, optional
```


### WINDOWS
Download the project, LaTeX, and an editor, then build the pdf.

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
    - to the folder you copied your recipe, add your image into `img` subfolder
    - if you created a new `img` subfolder,
      update `\graphicspath` in `/cookbook.tex` with the new entry


## DESIGN

- uses `xcookybooky` for formatting
- the top level `TeX` file is `/cookbook.tex`
- recipes are added using `\include` calls to the top level file
- recipes are grouped according to genre: `/<my_section>/<recipe>.tex`
- images are grouped in sub folders: `/<my_section>/img/`
- bibliography is stored in `/bib.bib`


## FUTURE

- [ ] add hints to the margins
- [ ] modify 'Ingredients' blocks to three columns (amount, unit, ingredient)
- [ ] add cover
- [ ] add image collage to start of sections
- [x] add bibliography
- [ ] add custom class for recipe, reduce code repitition and standardize input
- [x] add compilation automation w/ `latexmk' / Makefile
- [ ] add git lfs for images
- [x] add ghostscript helper to compress pdf


