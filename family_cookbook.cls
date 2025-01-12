\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{family_cookbook}[Family cookbook template]

% A minimalistic cookbook.

% AUTHOR
% Michael Teresi
%
% DESIGN
% - derives from the `book` class
% - formats a recipe into:
%   quick info, abstract, ingredients, preparation, variations, experiments
% - formats ingredients into one or two columns,
%   with a table for amount, unit, description
% - does not include graphics to simplify printing and minimize repo size
% - adds ornaments to section, variation, experiments, end of recipe
% - adds notes / hints to margins of the page
%
% ENVIRONMENTS
% `recipestats`        summary w/ icons
% `recipeabstract`     quick recipe info, e.g. prep time, amount, etc
% `ingredientcolumns`  recipe ingredients
% `preparation`        enumerated instructions
% `variation`          itemized options
% `experiments`        itemized ongoing tests
%
% COMMANDS
% `recipeend`          ornament at end of recipe
% `ragmarpar`          add notes to page margins
% `reffull`            add in-text citation to another recipe
% `onehalf`            helper for fractions (and others)

% FUTURE discuss settings for widows etc.
% FUTURE add options (DeclareOption)


\LoadClass[10pt]{book}          % openany to not force chapter open on rhs
\frenchspacing                  % one space after period
\righthyphenmin=3               % don't hyphenate unless N letters after hyphen
\lefthyphenmin=4                % don't hyphenate unless N letters before hyphen


% MAGIC using 6x9 as that's a common format
% these are context dependent and I recommend you tailor it to your needs
\RequirePackage[%
	papersize={6in,9in},%
	twoside,%
	top=0.5in,%
	bottom=0.4in,%
	inner=0.50in,%
	outer=1.0in,%
	marginparsep=0.1in,%
	marginparwidth=0.70in,%
	%includeheadfoot,% BUG fixes head/foot sizes but swaps outer/gutter?
	headsep=0.2in,%
	footskip=0.2in,%
]{geometry}
\RequirePackage[T1]{fontenc}             % hypenate accented letters
\RequirePackage{ae,aecompl}              % handle T1 fonts
\RequirePackage[backend=bibtex]{biblatex}
    \bibliography{bib}
\RequirePackage{ragged2e}                % for \justify
\RequirePackage[fulladjust]{marginnote}  % notes in the margins
\RequirePackage{fancyhdr}                % header / footers
\RequirePackage{lmodern}                 % change font
\RequirePackage[clock, misc]{ifsym}      % symbols
\RequirePackage{cookingsymbols}          % symbols
\RequirePackage{tikzsymbols}             % symbols
\RequirePackage{fontawesome}             % symbols (e.g. \faLeaf)
\RequirePackage{adforn}                  % symbols (fleurons / flowers)
%\RequirePackage{stix}                    % symbols (e.g. \bigstar, \bigwhitestar}
\RequirePackage{fdsymbol}                % symbols (e.g. \largeblackstar, \largewhitestar}
\RequirePackage{xkeyval}                 % commands w/ key/value
\RequirePackage{varioref}                % references decorated w/ page numbers
\RequirePackage{ifthen}                  % if statements
\RequirePackage{longtable}               % column break table
\RequirePackage{multicol}                % multiple columns
\RequirePackage{tabularx}                % tabular w/ more features
\RequirePackage{xfrac}                   % typeset fractions
\RequirePackage{paralist}                % in-text enums
\RequirePackage{xparse}                  % positional arg defaults
\RequirePackage{pgfornament}             % symbols
\RequirePackage{nameref}                 % ref section name etc. w/ \nameref
\RequirePackage{enumitem}                % better enumerations
    \setlist{leftmargin=*}               % don't indent lists
\RequirePackage{sectsty}                 % access sectional units
\RequirePackage{minitoc}                 % table of contents per chapter
\RequirePackage{imakeidx}                % index for backmatter (keywords)
	\indexsetup{othercode=\small}
	\makeindex[program=makeindex,columns=2,intoc=true,options={-s index_style.ist}]
\RequirePackage{tocloft}                 % fix TOC, and control Table Of Contents etc


% NB `GoudyIn` can't be embedded into the pdf (for lettrine / large first character)


% NOTE what are the right settings for `nowidow` to work?
% adding \noclub to variation env doesn't seem to work
% wrecks ingredient so just load macros (no options)
%\RequirePackage[]{nowidow}          % prevent widows / orphans
\widowpenalty8000
\clubpenalty8000
%\postdisplaypenalty1000


% don't start a recipe at the bottom of the page
% *but also* don't split a recipe across pages...
% large bottomtitlespace seems to move paragraphs to new pages
% this could use some improvement but is difficult b/c it also
% interacts poorly with the double column ingredients and titlespacing
\RequirePackage[nobottomtitles*]{titlesec}  % better section placement
% space at bottom to move titles to next page
% MAGIC, experimental, default 0.2\textheight
%        the two column ingredients get cutoff sometimes, so this helps prevent that
\renewcommand{\bottomtitlespace}{0.32\textheight}
% space left, before, after section
\titlespacing*{\section}{0em}{4ex plus 4ex minus 4ex}{1ex}

\cftsetindents{section}{1em}{3em}  % prevent title from colliding w/ section number in ToC

% NB use `hyperref` flag `pdfa` to stop removal of links after compressing w/ ghostscript
\RequirePackage[pdfa]{hyperref}    % links etc. (must be the last package)


\hbadness=1000	% limit reporting on overfull horz boxes

\pagestyle{fancy}               % from `fancyhdr`, customize header/footers
\newcommand{\changefont}{%
	\fontsize{9}{11}\selectfont
}
\fancyhf{}
\fancyhead[LE,RO]{\changefont~\slshape \rightmark}% %section
\fancyhead[RE,LO]{\changefont~\slshape \leftmark}% %chapter
\fancyfoot[C]{\changefont~\thepage} %footer


% add an ornament to the section numbers
\makeatletter
\def\@seccntformat#1{\adforn{33} \csname the#1\endcsname\quad}
\makeatother


% show servings, time, etc. w/ icons
\ExplSyntaxOn
% keys
\keys_define:nn { mymodule/recipestats }
{
	servings .tl_set:N = \l_mymodule_servings_tl,
	preptime .tl_set:N = \l_mymodule_preptime_tl,
	bakingtime .tl_set:N = \l_mymodule_bakingtime_tl,
	source .tl_set:N = \l_mymodule_source_tl,
	original .tl_set:N = \l_mymodule_origin_tl,
	inactivetime .tl_set:N = \l_mymodule_inactivetime_tl,
}
\NewDocumentEnvironment{recipestats}{O{}}
{
	\keys_set:nn { mymodule/recipestats } { #1 }
	% BUG a multicols doesn't left justify the icons?
	% FUTURE using a multicols may be preferred so that missing icons aren't just blank cells?
	% but that would change the order...
	\begin{tabular}{clclcl}
		\tl_if_empty:NTF \l_mymodule_preptime_tl
		{& &}
		{\Gloves & \l_mymodule_preptime_tl &}

		\tl_if_empty:NTF \l_mymodule_bakingtime_tl
		{& &}
		{\oven & \l_mymodule_bakingtime_tl &}

		\tl_if_empty:NTF \l_mymodule_source_tl
		{& \\}
		{\PaperLandscape & \l_mymodule_source_tl \\}

		\tl_if_empty:NTF \l_mymodule_servings_tl
		{& &}
		{\Dish & \l_mymodule_servings_tl &}

		\tl_if_empty:NTF \l_mymodule_inactivetime_tl
		{& &}
		{\faClockO & \l_mymodule_inactivetime_tl &}

		\tl_if_empty:NTF \l_mymodule_origin_tl
		{& \\}
		{\faBook & \l_mymodule_origin_tl \\}
}
{
	\end{tabular}
}
\ExplSyntaxOff


\newenvironment{recipeabstract}%
{\medskip\itshape}
{\medbreak}


% a 3 col tabular for ingredients
% can be used to specify which componenet the ingredients are for
% can be used to have multiple tabulars in columns
% Args:
%    (str): name of ingredient 'section', no name if None
\ExplSyntaxOn % for \tl_if_blank:nTF
\NewDocumentEnvironment{ingredientblock}{O{}}
{
	% default args:
	% https://tex.stackexchange.com/questions/29973/more-than-one-optional-argument-for-newcommand
	\tl_if_blank:nTF {#1}
	{}  % empty
	{\textit{#1}\\}  % not empty
	\setlength{\tabcolsep}{4pt}
	\begin{tabular}[t]{rl>{\bfseries}l}
}
{
	\end{tabular}
}
\ExplSyntaxOff % for \tl_if_blank:nTF


% wrapper around a multicols
% Args:
%     (int): number of columns, 2 if None
\newcommand{\tempwidowpenalty}{\widowpenalty}
\newcommand{\tempclubpenalty}{\clubpenalty}
\NewDocumentEnvironment{ingredientcolumns}{O{2}}
{
	% NB better to use skips/breaks after abstract and before preparation
	%    b/c there are sometimes multiple ingredient blocks and it looks better
	% temporarily reduce widow/club penalty
	% so the long table still adds a column break
	\renewcommand{\tempclubpenalty}{\clubpenalty}
	\renewcommand{\tempwidowpenalty}{\widowpenalty}
	\clubpenalty0
	\widowpenalty0
	\setlength\columnsep{0.5ex}
	% NOTE is there a better way to fix the spacing?
	% The 1col ingredientcolumns has weird spacing so add a skip
	% try using a \bigskip before each col?
	\ifthenelse{\equal{#1}{1}}{\vskip1ex}{}
	\centering
	\begin{multicols}{#1}
}
{
	\end{multicols}
	\clubpenalty\tempclubpenalty
	\widowpenalty\tempwidowpenalty
	% par required for 1col else it gets left justified for some reason
	\ifthenelse{\equal{#1}{1}}{\par}{}
}


% \ingredient[<quantity>][<unit>]{<name>}
% ingredient for a 3 column tabular
% intended for: quantity & unit & food
% default empty quantity and unit:
% e.g. \food[col1][col2]{col3}
% e.g. \food[quantity][unit]{name}
% e.g. \food{<ingredient name>}
\NewDocumentCommand{\ingredient}{O{} O{} m }{
	\ensuremath{#1} & \ensuremath{#2} & #3
}


\newenvironment{preparation}%
{
	% can also be controlled globally using
	% \setlist[enumerate]{<options>}
	% slightly encourage a page break here w/ \pagebreak
	%\pagebreak[0]  % MAGIC NUMBER experimental, [0...4] higher is more insistent
	%\medskip
	\medbreak
	\begin{enumerate}[topsep=0pt,itemsep=0ex,partopsep=0ex,parsep=0.5ex,label=\textbf{\arabic*}.]
	\setcounter{enumi}{-1}
	}
{
	\end{enumerate}
	\par
}


% using \bigskip\noindent\textbf interacts better with \bottomtitlespace
% compared to \paragraph, as it doesn't move this block to the next
% page as often
\newenvironment{experiments}%
{
	\medbreak%
	\noindent
	\textbf{EXPERIMENTS}\nopagebreak
	\smallskip
	\begin{itemize}[label=\faFlask,topsep=0pt,itemsep=0ex,partopsep=1ex,parsep=1ex]
}
{
	\end{itemize}
	\par
}


\newenvironment{variation}%
{
	% using \bigskip\noindent\textbf interacts better with \bottomtitlespace
	% compared to \paragraph, as it doesn't move this block to the next
	% page as often
	%\pagebreak[2]  % MAGIC NUMBER experimental, [0...4] higher is more insistent
	\medbreak%
	\noindent
	\textbf{VARIATIONS}\nopagebreak
	\smallskip
	\begin{itemize}[label=\adforn{28},topsep=0pt,itemsep=0ex,partopsep=1ex,parsep=1ex]
}
{
	\end{itemize}
	\par
}


% use a savebox to reduce call count to TikZ
% https://tex.my/2020/05/24/creating-tiled-background-patterns/
% ~1.15x speedup on 64 pages w/ dual core (~3.75s --> 3.25s)
\newsavebox{\armOrnament}
\sbox{\armOrnament}{%
	{\pgfornament[scale=0.45]{88}}
}


% \recipeend
% add a flourished section break, signifying end of the recipe
\newcommand{\recipeend}[0]{%
	%{\centering \pgfornament[scale=0.55]{88} \smallbreak \smallskip}
	{\centering \usebox{\armOrnament} \medbreak}
	% NB adding a \pagebreak here appears to mess up the margin notes
	% FUTURE try a '\filbreak' here? it messes up a few recipes but looks like a good option
	% see https://tex.stackexchange.com/questions/72782/keep-text-together-with-minipage-leave-space-at-end-of-previous-page/72787#72787
}


% marginpar with ragged justification
% NOTE had to use marginpar b/c marginnote produce notes on wrong side (after adding preface?)
% https://latex.org/forum/viewtopic.php?t=6041
% see also (for marginnote)
% https://tex.stackexchange.com/questions/247449/making-marginnote-to-appear-either-side-of-twocolumn-twoside-document-part-ii
\newcounter{pl}
\newcommand\ragmarpar[1]{%
	\stepcounter{pl}\label{pl-\thepl}%
	\ifthenelse{\isodd{\pageref{pl-\thepl}}}%
	%\marginnote adds spacing between recipes steps
	% (and also causes problems with justification?)
	{\marginpar{\RaggedLeft \it{#1}}}
	{\marginpar{\RaggedRight \it{#1}}}
}


% reference for a label w/ name, section, page number
% <title> <section #> <on page...>
% NOTE use ~page~\pageref{#1} instead of ~\vref{#1}?
\newcommand\reffull[1]{%
	\nameref{#1}~\vref{#1}%
}


% abbreviations / aliases
% use math mode for units for consistent style
% NOTE since \day is already defined, maybe make all time commands uppercase?
\newcommand\second{\ensuremath{sec}}
\newcommand\minute{\ensuremath{min}}
\newcommand\hour{\ensuremath{hr}}
\newcommand\Day{\ensuremath{day}}
\newcommand\week{\ensuremath{week}}
\newcommand\Month{\ensuremath{month}}
\newcommand\Year{\ensuremath{year}}

\newcommand\onehalf{\sfrac{1}{2}}
\newcommand\onethird{\sfrac{1}{3}}
\newcommand\onefourth{\sfrac{1}{4}}
\newcommand\oneeighth{\sfrac{1}{8}}
\newcommand\onetenth{\sfrac{1}{10}}

\newcommand\twothird{\sfrac{2}{3}}

\newcommand\threehalf{\sfrac{3}{2}}
\newcommand\threefourth{\sfrac{3}{4}}
\newcommand\threeeighth{\sfrac{3}{8}}

\newcommand\Tablespoon{\ensuremath{Tbs}}
\newcommand\teaspoon{\ensuremath{tsp}}
\newcommand\ounce{\ensuremath{oz}}
\newcommand\fluidounce{\ensuremath{fl\;oz}}
\newcommand\quart{\ensuremath{quart}}
\newcommand\pound{\ensuremath{lb}}

\newcommand\Celsius{\ensuremath{C^\circ}}
\newcommand\Fahrenheit{\ensuremath{F^\circ}}

\newcommand\milliliter{\ensuremath{ml}}
\newcommand\ml{\ensuremath{ml}}
\newcommand\gram{\ensuremath{g}}

% NB have been using '' not " for inch symbol (synatax checker suggested)
% NOTE when should one use $inch$ and not ''?
\newcommand\inch{\ensuremath{inch}}


%% wrapper around a multicols
%% Args:
%%     (int): number of columns, 2 if None
%\newsavebox\ltmcbox
%\NewDocumentEnvironment{ingredientmulticols}{O{2}}
%{
%	\vbox\bgroup
%	\setlength\columnsep{0ex}
%	\centering
%	\begin{multicols}{#1}
%		\setbox\ltmcbox
%			\makeatletter\col@number\@ne
%			\begin{longtable}{rl>{\bfseries}l}
%}
%{
%	\end{longtable}
%	\unskip
%	\unpenalty
%	\unpenalty
%	\egroup
%	\unvbox\ltmcbox
%	\end{multicols}
%}


% box for a multi column long table
% SEE https://tex.stackexchange.com/questions/161827/balanced-longtables-multicol-and-page-breaks
%\makeatletter
%\newsavebox\ltmcbox
%\newsavebox\xxbox
%\newenvironment{multicolslongtable}[1]{
%	\setbox\ltmcbox\vbox\bgroup
%	\col@number\@ne
%	\begin{longtable}{#1}
%	}
%	{
%	\end{longtable}
%	\unskip
%	\unpenalty
%	\unpenalty\egroup
%	\unvbox\ltmcbox
%}
%\makeatother


% environment to accept table input and produce multicol
%\NewDocumentEnvironment{ingredientmulticols}{O{2}}
%{
%	\savebox\xxbox\bgroup
%	\begin{minipage}{\textwidth}
%		\begin{multicols}{#1}
%			\begin{multicolslongtable}{| l | l | l |}
%			}
%			{
%			\end{multicolslongtable}
%		\end{multicols}
%	\end{minipage}
%	\egroup
%	\begin{multicols}{#1}
%		\centering
%		\usebox\xxbox
%	\end{multicols}
%}


% patch multicols to allow for one column
% SEE https://tex.stackexchange.com/questions/233866/one-column-multicol-environment
\let\multicolmulticols\multicols%
\let\endmulticolmulticols\endmulticols%
\RenewDocumentEnvironment{multicols}{mO{}}
{%
	\ifnum#1=1
	#2%
	\else % More than 1 column
	\multicolmulticols{#1}[#2]
	\fi
}
{%
	\ifnum#1=1
	\else % More than 1 column
	\endmulticolmulticols%
	\fi
}


% \vegan
% show a vegetarian/vegan symbol on the margin
% justify to outer direction
%\def\vegan#1{\marginpar{\Large\faLeaf}}
%\newcounter{pl}  %already defined (page left)
% using this in a section title requires using both short/long titles
\newcommand\vegan[0]{%
	\stepcounter{pl}\label{pl-\thepl}%
	\ifthenelse{\isodd{\pageref{pl-\thepl}}}%
	% marginnote doesn't work when using this inside a section title
	{\marginpar{\RaggedLeft \Large\faLeaf}}
	{\marginpar{\RaggedRight \Large\faLeaf}}
}


% \stars[<max_stars=5>]{<filled_stars>}
% star rating using filled/open stars
% NB \bigstar / \bigwhitestar, from `stix`, work for max 5 stars
% NB \largewhitestar / \largeblackstar, from `fdsymbol`, are bigger but 5 don't fit in margin
% FUTURE the stars appear not to be justified towards the outside of the page,
%        but the spacing is sensitive, perhaps it can be improved?
% FUTURE can this be sped up w/ a savebox or case statement?
% BUG syntax checker recommends not using '\advance'
\newcommand{\stars}[2][3]{%
	\newcount\loopi\loopi=0
	\loop\ifnum\loopi<#2
		\ensuremath{\largeblackstar}\hfill
		\advance\loopi by1
	\repeat%
	\loop\ifnum\loopi<#1
		\ensuremath{\largewhitestar}\hfill
		\advance\loopi by1
	\repeat%
}


% \ragStars[<max_stars=5>]{<filled_stars>}
% star rating in the margin
% respecting ragged left/right
% NB \noindent is used to prevent a vertical spacing
\newcommand{\ragStars}[2][3]{%
	\stepcounter{pl}\label{pl-\thepl}%
	\ifthenelse{\isodd{\pageref{pl-\thepl}}}%
	{\marginpar{\RaggedLeft\noindent\stars[#1]{#2}}}
	{\marginpar{\RaggedRight\noindent\stars[#1]{#2}}}
}
