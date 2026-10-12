% Intro Options
\ProvidesClass{deedy-resume-openfont}[2014/04/30 CV class]
\NeedsTeXFormat{LaTeX2e}
\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions\relax
\LoadClass{article}

% Package Imports
\usepackage[hmargin=1.25cm, vmargin=0.75cm]{geometry}
\usepackage[hidelinks]{hyperref}

% Publications
\usepackage{cite}
\renewcommand\refname{\vskip -1.5cm}

% Color definitions
\usepackage[dvipsnames]{xcolor} 
\definecolor{date}{HTML}{666666} 
\definecolor{primary}{HTML}{2b2b2b} 
\definecolor{headings}{HTML}{6A6A6A}
\definecolor{subheadings}{HTML}{333333}

% Set main fonts
\usepackage{fontspec}
\setmainfont[Color=primary, Path = fonts/lato/,BoldItalicFont=Lato-RegIta,BoldFont=Lato-Reg,ItalicFont=Lato-LigIta]{Lato-Lig}
\setsansfont[Scale=MatchLowercase,Mapping=tex-text, Path = fonts/raleway/]{Raleway-ExtraLight}

% Date command
\usepackage[absolute]{textpos}
\usepackage[UKenglish]{isodate}
\setlength{\TPHorizModule}{1mm}
\setlength{\TPVertModule}{1mm}
\newcommand{\lastupdated}{\begin{textblock}{60}(155,5)
\color{date}\fontspec[Path = fonts/raleway/]{Raleway-ExtraLight}\fontsize{8pt}{10pt}\selectfont 
Last Updated on \today
\end{textblock}}

% Name command
\newcommand{\namesection}[3]{
\centering{
\fontsize{36pt}{42pt}
\fontspec[Path = fonts/lato/]{Lato-Hai}\selectfont #1 
\fontspec[Path = fonts/lato/]{Lato-Lig}\selectfont #2
} \\[4pt]
\centering{
\color{headings}
\fontspec[Path = fonts/raleway/]{Raleway-Medium}\fontsize{10pt}{12pt}\selectfont #3}
\noindent\makebox[\linewidth]{\color{headings}\rule{\paperwidth}{0.4pt}}
\vspace{-18pt}
}

% Section seperators 
\usepackage{titlesec}
\titlespacing{\section}{0pt}{0pt}{0pt} 
\titlespacing{\subsection}{0pt}{0pt}{0pt}
\newcommand{\sectionsep}{\vspace{4pt}}

% Headings command
\titleformat{\section}{\color{headings}
\fontspec[Path = fonts/lato/]{Lato-Lig}\fontsize{14pt}{18pt}\selectfont \raggedright\uppercase}{}{0em}{}

% Subeadings command
\titleformat{\subsection}{
\color{subheadings}\fontspec[Path = fonts/lato/]{Lato-Bol}\fontsize{11pt}{11pt}\selectfont\uppercase}{}{0em}{}

\newcommand{\runsubsection}[1]{
\color{subheadings}\fontspec[Path = fonts/lato/]{Lato-Bol}\fontsize{11pt}{11pt}\selectfont\uppercase {#1} \normalfont}

% Descriptors command
\newcommand{\descript}[1]{
\color{subheadings}\raggedright\fontspec[Path = fonts/raleway/]{Raleway-Medium}\fontsize{10pt}{11pt}\selectfont {#1 \\} \normalfont}

% Location command
\newcommand{\location}[1]{
\color{headings}\raggedright\fontspec[Path = fonts/raleway/]{Raleway-Medium}\fontsize{9pt}{10.5pt}\selectfont {#1\\} \normalfont}

% Bullet Lists with fewer gaps command
\newenvironment{tightemize}{
\begin{itemize}\itemsep0.5pt \parskip0pt \parsep0pt}
{\end{itemize}}


% ---------------------------------------------------------------------
% Profile photo (optional)
% The photo is only drawn when \withphoto is defined, so one source can
% build both variants, e.g.:
%   latexmk -xelatex -usepretex="\def\withphoto{}" file.tex
% \resumephoto[<diameter>]{<x offset>}{<y offset>} places a circular photo
% at an absolute position on the first page (offsets from top-left corner).
% ---------------------------------------------------------------------
\usepackage{graphicx}
\usepackage{tikz}
\providecommand{\photofile}{assets/profile-photo.jpg}
\newcommand{\resumephoto}[3][23mm]{%
  \ifdefined\withphoto
  \begin{textblock*}{#1}(#2,#3)
  \begin{tikzpicture}
    \begin{scope}
      \clip (0,0) circle ({#1/2});
      \node[inner sep=0pt] at (0,0) {\includegraphics[width=#1]{\photofile}};
    \end{scope}
    \draw[headings, line width=0.5pt] (0,0) circle ({#1/2});
  \end{tikzpicture}
  \end{textblock*}
  \fi}

% ---------------------------------------------------------------------
% Multi-page helpers
% ---------------------------------------------------------------------
\usepackage{lastpage}
% Footer with name and page x/y for resumes longer than one page
\newcommand{\pagefooter}[1]{%
  \fancyfoot[C]{\color{date}\fontspec[Path = fonts/raleway/]{Raleway-Medium}\fontsize{7.5pt}{9pt}\selectfont #1 \textbullet{} page \thepage{} of \pageref*{LastPage}}}

% Full-width entry: title | role on the left, dates/place on the right
\newcommand{\cventry}[3]{%
  \par\noindent{\color{subheadings}\fontspec[Path = fonts/lato/]{Lato-Bol}\fontsize{11pt}{13pt}\selectfont\uppercase{#1}}%
  {\color{subheadings}\fontspec[Path = fonts/raleway/]{Raleway-Medium}\fontsize{10pt}{13pt}\selectfont\ #2}%
  \hfill{\color{headings}\fontspec[Path = fonts/raleway/]{Raleway-Medium}\fontsize{9pt}{13pt}\selectfont #3}\par\normalfont}

% Opt-in fix for the stray blank line between \location and a following
% bullet list: zero the list top spacing and end the location line with par.
% (Not applied by default so the general resume keeps its approved layout.)
\newcommand{\fixlocationgap}{%
  \RequirePackage{enumitem}\setlist[itemize]{topsep=0pt}%
  \renewcommand{\location}[1]{%
    \color{headings}\raggedright\fontspec[Path = fonts/raleway/]{Raleway-Medium}\fontsize{9pt}{10.5pt}\selectfont {##1\par} \normalfont}}
