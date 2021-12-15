% !Mode::"TeX:UTF-8"
% Options: chinese

% -------------------- Identification --------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{note}[0000/00/00]

% -------------------- Preliminary Declarations --------------------

% -------------------- Handle Options --------------------

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\DocumentClass}}

\ProcessOptions\relax

% -------------------- More Declarations --------------------

\PassOptionsToPackage{quiet}{fontspec}

\LoadClass[10pt]{book}

\RequirePackage{etoolbox}
\RequirePackage{fontspec}
\RequirePackage{amsmath}
\RequirePackage{unicode-math}
\RequirePackage{geometry}
\RequirePackage{enumitem}

\emergencystretch=.5em

\setmainfont{TeX Gyre Pagella}

\geometry{
  paperwidth = 6in,
  paperheight = 9in,
  inner = 0.5in,
  outer = 0.5in,
  top = 0.5in,
  bottom = 0.5in,
  includeheadfoot,
}

\setmathfont{Asana Math}
\unimathsetup{%
  math-style = ISO,
  bold-style = ISO,
  nabla = upright,
  partial = upright,
}
\setmathfont{texgyretermes-regular}[
  Extension = .otf,
  range = up/{num},
  BoldFont = texgyretermes-bold,
]
\setmathfont{texgyretermes-bold}[
  Extension = .otf,
  range = bfup/{num},
  BoldFont = texgyretermes-bold,
]
\setmathfont{Asana Math}[
  % Extension = .otf,
  % BoldFont = \tju@font@name@xits@math@bf,
  StylisticSet = 8,
]
\setmathfont{Asana Math}[
  % Extension = .otf,
  % BoldFont = \tju@font@name@xits@math@bf,
  StylisticSet = 1,
  range = {cal, bfcal},
]
\setmathfont{Asana Math}[
  % Extension = .otf,
  % BoldFont = \tju@font@name@xits@math@bf,
  range = it/{greek,Greek,latin,Latin},
]
\setmathfont{Asana Math}[
  % Extension = .otf,
  % BoldFont = \tju@font@name@xits@math@bf,
  range = up/{greek,Greek,latin,Latin},
]
\setmathfont{Asana Math}[
  % Extension = .otf,
  % BoldFont = \tju@font@name@xits@math@bf,
  range = {
    "2212,"002B,"003D,"0028,"0029,"005B,%
    "005D,"221A,"2211,"2248,"222B,"007C,"2026,"2202,"00D7,"0302,%
    "2261,"0025,"22C5,"00B1,"2194,"21D4%
  },
]

\setlist{nosep}
\setlist[enumerate]{wide, label=(\arabic*)}

\usepackage[amsmath,thmmarks,hyperref,thref]{ntheorem}
\AtEndPreamble{%
  \RequirePackage{hyperref}
  \hypersetup{%
    bookmarksopen = true,
    bookmarksopenlevel = 2,
    bookmarksnumbered = true,
    pdfpagemode = UseNone,
    pdfstartview = Fit,
    pdfpagelayout = TwoPageRight,
  }
}

% One should always load \usepackage{hyperref} before the first use of \newtheorem to obtain correct handling and referencing of counters.
\AtBeginDocument{
  \theoremstyle{plain}
  \theoremheaderfont{\bfseries\upshape}\theorembodyfont{\upshape}
  \theoremindent0pt
  \newtheorem{theorem}{Theorem}[chapter]
  \newtheorem{corollary}[theorem]{Corollary}
  \newtheorem{lemma}[theorem]{Lemma}
  \newtheorem{proposition}[theorem]{Proposition}
  \theoremsymbol{\ensuremath{\mdlgwhtsquare}}
  \newtheorem{theoremnoproof}[theorem]{Theorem}
  \newtheorem{propositionnoproof}[theorem]{Proposition}
  \theoremsymbol{}\theorembodyfont{\upshape}
  \newtheorem{definition}[theorem]{Definition}
  \newtheorem{remark}[theorem]{Remark}
  \newtheorem{example}[theorem]{Example}
  \theoremstyle{nonumberplain}
  \theoremheaderfont{\bfseries}\theorembodyfont{\upshape}
  \theoremindent0pt
  \theoremsymbol{\ensuremath{\mdlgwhtsquare}}
  \newtheorem{proof}{Proof}
  \newtheorem{hint}{Hint}
  \theoremsymbol{}
}

\renewcommand{\maketitle}{%
  \thispagestyle{empty}
  \vspace*{\fill}
  \begin{center}
    \Huge\bf\@title
  \end{center}
  % \vspace{10cm}
  \vfill % equivalent to \vspace{\fill}
  \cleardoublepage
}

\endinput
