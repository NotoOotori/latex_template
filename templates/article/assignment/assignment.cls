% !Mode::"TeX:UTF-8"
% TODO: 写一下这个模板做了什么
% Options: chinese lineno watermark biblatex

% -------------------- Identification --------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{assignment}

% -------------------- Preliminary Declarations --------------------

\newcommand{\DocumentClass}{article}

\newcommand{\professor}[1]{\newcommand{\@professor}{#1}}
\newcommand{\course}[1]{\newcommand{\@course}{#1}}
\newcommand{\institute}[1]{\newcommand{\@institute}{#1}}

\newcommand{\subject}[1]{\newcommand{\@subject}{#1}}
\newcommand{\keywords}[1]{\newcommand{\@keywords}{#1}}

\newcommand{\CourseLang}{Course}
\newcommand{\DateLang}{Date}
\newcommand{\StudentLang}{Student name}
\newcommand{\ProfessorLang}{Professor}

\newcommand{\InstituteStyle}{\scshape}
\newcommand{\TitleStyle}{\bfseries}
\newcommand{\TitleSize}{\LARGE}
\newcommand{\AuthorStyle}{\itshape}
\newcommand{\CourseStyle}{\itshape}
\newcommand{\ProfessorStyle}{\itshape}
\newcommand{\DateStyle}{\itshape}

\newcommand{\WatermarkStyle}{\itshape\sffamily}

% Package: varioref

\newcommand{\LstlistingLabel}[1]{Code #1}
\newcommand{\EquationLabel}[1]{Equation (#1)}
\newcommand{\FigureLabel}[1]{Figure #1}
\newcommand{\TableLabel}[1]{Table #1}
\newcommand{\ProblemLabel}[1]{Problem #1}

\newcommand{\ProblemLang}{Problem}
\newcommand{\NoteLang}{Note}
\newcommand{\ProofLang}{Proof}
\newcommand{\SolutionLang}{Solution}
\newcommand{\LstlistingLang}{Code}

% -------------------- Options --------------------

\DeclareOption{twocolumn}{\OptionNotUsed}
\DeclareOption{twoside}{\OptionNotUsed}

\newif\ifchinese@option
\DeclareOption{chinese}{%
    \chinese@optiontrue

    \renewcommand{\DocumentClass}{ctexart}

    \AtBeginDocument{\renewcommand{\itshape}{\simkai}} % TODO: 观察是否引起问题
    \AtBeginDocument{\renewcommand{\bfseries}{\simhei}} % TODO: 观察是否引起问题

    \renewcommand{\CourseLang}{课程}
    \renewcommand{\DateLang}{日期}
    \renewcommand{\StudentLang}{姓名}
    \renewcommand{\ProfessorLang}{教师}

    \renewcommand{\InstituteStyle}{\sffamily}

    \renewcommand{\WatermarkStyle}{\fzstk}

    % Package: varioref

    \renewcommand{\LstlistingLabel}[1]{代码#1}
    \renewcommand{\EquationLabel}[1]{式(#1)}
    \renewcommand{\FigureLabel}[1]{图#1}
    \renewcommand{\TableLabel}[1]{表#1}
    \renewcommand{\ProblemLabel}[1]{问题#1}

    \renewcommand{\ProblemLang}{问题}
    \renewcommand{\NoteLang}{注}
    \renewcommand{\ProofLang}{证明}
    \renewcommand{\SolutionLang}{解}
    \renewcommand{\LstlistingLang}{代码}
}

\newif\ifbiblatex@option
\DeclareOption{biblatex}{\biblatex@optiontrue}

\newif\iflineno@option
\DeclareOption{lineno}{\lineno@optiontrue}

\newif\ifwatermark@option
\DeclareOption{watermark}{\watermark@optiontrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\DocumentClass}}

\ProcessOptions\relax

% -------------------- Bulk Declarations --------------------

\LoadClass[a4paper, 12pt]{\DocumentClass}

% Preload useful packages

\RequirePackage{enumerate}
\RequirePackage{float} % [H].
\RequirePackage{fontspec} % fonts.
\RequirePackage{subcaption} % subcaption and subfigure.
\RequirePackage[dvipsnames]{xcolor} % 颜色声明.

% New title style for the document

\renewcommand{\maketitle}{%
    \thispagestyle{plain}
    \begin{center}
        \ifx\@institute\undefined{}\else{\InstituteStyle\@institute}\\\vspace{10pt}\fi
        \hrule
        \vspace{10pt}
        {\TitleSize\TitleStyle\@title}\\\vspace{5pt}
        \StudentLang: {\AuthorStyle\@author}
        \vspace{8pt}
        \hrule
        \vspace{10pt}
        \ifx\@course\undefined{}\else\CourseLang: {\CourseStyle\@course\ifx\@professor\undefined{}\else{ -- }\fi}\fi
        \ifx\@professor\undefined{}\else{\ProfessorLang: {\ProfessorStyle\@professor}}\fi\\
        \DateLang: {\DateStyle\@date}
        \vspace{20pt}
    \end{center}
    
    \pagestyle{fancy}
    \pagenumbering{arabic}
    \iflineno@option\linenumbers\fi
}

% Modify the sizes of the document

\RequirePackage{geometry}
\geometry{left=2.5cm, right=2.5cm, top=2.5cm, bottom=2.5cm}

% Language support

%% Package: ctex

\ifchinese@option
    \setCJKfamilyfont{simkai}{KaiTi}
    \newcommand{\simkai}{\CJKfamily{simkai}}

    \setCJKfamilyfont{simhei}{SimHei}
    \newcommand{\simhei}{\CJKfamily{simhei}}

    \setCJKfamilyfont{fzstk}{FZShuTi} % 方正舒体
    \newcommand{\fzstk}{\CJKfamily{fzstk}}
\fi

% Citation

\ifbiblatex@option

    % \RequirePackage[british]{babel} % Need to load before ntheorem
    % \RequirePackage{csquotes} % Need to load after lineno
    % \RequirePackage{xpatch}

    \RequirePackage[backend=biber, citestyle=numeric-comp, bibstyle=numeric]{biblatex}
    \addbibresource{bibliography.bib}

\fi

% Typeset math

\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{commath} % abs, norm
% \RequirePackage{mathtools} % \xleftrightarrow.

%% Package: unicode-math

\RequirePackage[math-style=TeX, bold-style=TeX, partial=upright]{unicode-math}
\setmathfont{XITS Math}
\setmathfont[range={\mathcal,\mathbfcal}, StylisticSet=1]{XITS Math} % Script

\newcommand*{\diff}{\mathop{}\!\symup{d}}
\newcommand*{\matr}[1]{\symsfit{#1}}
\newcommand*{\vect}[1]{\symbf{#1}}

%% Package: ntheorem

\RequirePackage[thmmarks, amsmath, thref, framed]{ntheorem} % 定理格式.
\RequirePackage{framed}
\RequirePackage[ntheorem]{mdframed} % for \newframedtheorem

%%% Problem
\theoremstyle{plain}
\theoremheaderfont{\upshape\bfseries}
\theorembodyfont{\itshape}
\newmdtheoremenv[outerlinewidth=2]{problem}{\ProblemLang}
%%% Note
\theoremstyle{plain}
\theoremheaderfont{\itshape}
\theorembodyfont{\itshape}
\newtheorem{note}{\NoteLang}
%%% Proof TODO: colour
\theoremstyle{nonumberplain}
\theoremheaderfont{\itshape}
\theorembodyfont{\upshape}
\theoremseparator{.}
\theoremsymbol{\ensuremath{\square}}
\newtheorem{proof}{\ProofLang}
%%% Solution
\theoremsymbol{\ensuremath{\blacksquare}}
\newtheorem{solution}{\SolutionLang}

% Package: lineno

\iflineno@option
    \RequirePackage[mathlines, edtable]{lineno} % Need to load before csquotes

    \renewcommand{\linenumberfont}{\normalfont\scriptsize\sffamily}

    \let\oldtable\table
    \let\oldendtable\endtable
    \renewenvironment{table}
        {\par\nolinenumbers\oldtable}
        {\oldendtable\endnolinenumbers\par}
\fi

% Package: pgfplotstable

\RequirePackage{pgfplotstable} % Need to load before xwatermark
\RequirePackage{booktabs}

\pgfplotsset{width=7cm, compat=1.16}

\pgfplotstableset{
    every head row/.style={before row=\toprule, after row=\midrule},
    every last row/.style={after row=\bottomrule}
}

% Package: caption

\RequirePackage{caption}

\captionsetup{
    margin    =   6pt,
    font      =   small,
    labelfont =   bf
}

% Package: fancyhdr

\RequirePackage{fancyhdr}
\RequirePackage{lastpage}

\newcommand{\PageHead}[2]{\ifchinese@option{第#1页\ 共\ #2\ 页}\else{Page #1\ of #2}\fi}

\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0.4pt}
\setlength{\headheight}{15pt}
\fancyhead[L]{\footnotesize{\ifx\@course\undefined{}\else{\CourseStyle\@course{ -- }\fi}\TitleStyle\@title}}
\fancyhead[C]{}
\fancyhead[R]{\footnotesize{\PageHead{\thepage}{\pageref{LastPage}}}}
\fancyfoot[L, C]{}
\fancyfoot[C]{}
\fancyfoot[R]{\footnotesize\AuthorStyle\@author}

% Package: graphicx

\RequirePackage{graphicx}

\graphicspath{{resources/}}

% Package: hyperref

\RequirePackage{hyperref}
% TODO: color
\hypersetup{
    linktoc             =   all,
    colorlinks          =   true,
    linkcolor           =   cyan,
    anchorcolor         =   black,
    citecolor           =   green,
    filecolor           =   cyan,
    menucolor           =   red,
    runcolor            =   filecolor,
    urlcolor            =   magenta,
    bookmarksnumbered   =   true,
    pdfstartview        =   FitH,
    pdfpagelayout       =   OneColumn
}

\AtBeginDocument{\hypersetup{
	pdftitle           	=   {\@title},
	pdfauthor          	=   {\@author},
	pdfsubject         	=   {\ifx\@subject\undefined{}\else{\@subject}\fi},
	pdfcreator			=	{Visual Studio Code},
	pdfproducer			=	{XeLaTeX with documentclass assignment},
	pdfkeywords        	=   {\ifx\@keywords\undefined{}\else{\@keywords}\fi},
}}

% Package: listings

\RequirePackage{listings}
\RequirePackage{letltxmacro} % \let
\RequirePackage[numbered, framed]{matlab-prettifier}
\RequirePackage[T1]{fontenc}

%% Title

\renewcommand\lstlistingname{\LstlistingLang}
% \renewcommand\lstlistlistingname{代码} % We don't use the list of listings

\lstset{
    breaklines=true,
    backgroundcolor=\color{lightgray},
    basicstyle=\scriptsize,
    inputpath=resources/,
    numbers=left,
    numberstyle={\color{black!33}\scriptsize\sffamily},
    xleftmargin=2em,
    xrightmargin=2em
}

%% Lstinline with color box

\LetLtxMacro{\oldlstinline}{\lstinline}
\renewcommand{\lstinline}[2][]{\colorbox{lightgray}{\oldlstinline[#1]{#2}}}

%% Remove line numbers from lineno

\iflineno@option

    \let\oldlstinputlisting\lstinputlisting
    \renewcommand{\lstinputlisting}[2][\empty]{
        \par\nolinenumbers\oldlstinputlisting[#1]{#2}\linenumbers\par
    }

    \let\oldlstlisting\lstlisting
    \let\oldendlstlisting\endlstlisting
    \renewenvironment{lstlisting}
        {\par\nolinenumbers\oldlstlisting}
        {\oldendlstlisting\endnolinenumbers\par}

\fi

%% MATLAB presets

\newcommand{\matlabinline}[1]{
    \lstinline[style=MATLAB-editor, basicstyle=\mlttfamily]{#1}
}
\newcommand{\matlabinputlisting}[2][]{ % #1: caption or label
    \lstinputlisting[
        style=MATLAB-editor,
        basicstyle=\mlttfamily\scriptsize,
        #1
    ]{#2}
}

% Package: varioref

\RequirePackage{varioref} % For Cross References.

\labelformat{lstlisting}{\LstlistingLabel{#1}}
\labelformat{equation}{\EquationLabel{#1}}
\labelformat{figure}{\FigureLabel{#1}}
\labelformat{table}{\TableLabel{#1}}
\labelformat{problem}{\ProblemLabel{#1}}

% Package: xwatermark

\ifwatermark@option
    \RequirePackage{tikz}
    \RequirePackage[printwatermark]{xwatermark}

    \AtBeginDocument{
        \newsavebox\mybox
        \savebox\mybox{\tikz[color=cyan, opacity=0.2]\node{\WatermarkStyle\ifx\@subject\undefined{\@title}\else{\@subject}\fi};}
        \newwatermark*[
            fontfamily=lmr,
            allpages,
            angle=45,
            scale=6,
            xpos=-20,
            ypos=15
        ]{\usebox\mybox}
    }
\fi

\endinput
