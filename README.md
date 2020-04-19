# COOKBOOK

Teresi family cookbook.


## CONTRIBUTING

- copy an existing recipe, rename, move to a folder according to the genre
- add a the recipe to the top level `/cookbook.tex` using an `\include` call in the appropriate section.
- add graphics to the `img` subfolder of the genre
- update `\graphicspath` with new image folders as necessary


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
- [ ] add compilation automation w/ `latexmk` | `CMake`
- [ ] add git lfs for images
- [ ] add ghostscript helper to compress pdf


## HOW TO (FOR NEW USERS)

### WINDOWS
Download the project, LaTeX, and an editor, then build the pdf.

- download the zipped project from github, or clone w/ Git
    - e.g.: https://www.atlassian.com/git/tutorials/install-git#windows
- install MiKTeX (SEE https://miktex.org/howto/install-miktex)
- install TeXStudio or other editor (https://www.texstudio.org/)
- open `/cookbook.tex` and compile to pdf (F5 in TeXStudio)

### LINUX
Install your preferred LaTeX distribution, IDE if desired, compile `/cookbook.tex`.

e.g. Ubuntu:
```bash
# apt-get install git texlive texstudio
```
