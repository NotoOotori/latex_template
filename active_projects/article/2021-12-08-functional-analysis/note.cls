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

\LoadClass[10pt]{book}

\RequirePackage{etoolbox}
\RequirePackage{fontspec}
\RequirePackage{amsmath}
\RequirePackage{unicode-math}
\RequirePackage{geometry}
\RequirePackage{enumitem}

\setmainfont{TeX Gyre Pagella}
\setmathfont{Asana Math}

\geometry{
  paperwidth = 6in,
  paperheight = 9in,
  inner = 0.5in,
  outer = 0.5in,
  top = 0.5in,
  bottom = 0.5in,
  includeheadfoot,
}

\usepackage[amsmath,thmmarks,hyperref,thref]{ntheorem}
\AtEndPreamble{\RequirePackage{hyperref}}

% One should always load \usepackage{hyperref} before the first use of \newtheorem to obtain correct handling and referencing of counters.
\AtBeginDocument{
  \theoremstyle{plain}
  \theoremheaderfont{\bfseries\upshape}\theorembodyfont{\upshape}
  \theoremindent0pt
  \newtheorem{theorem}{Theorem}
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
  \newtheorem{sketch}{Sketch of Proof}
  \theoremsymbol{}
}

\emergencystretch=.5em

\endinput
