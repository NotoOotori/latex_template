% !Mode::"TeX:UTF-8"
% 写一下这个模板做了什么
% Options: 12pt chinese lineno watermark
%
% Known Issues: lineno [mathline] 失效

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
\newcommand{\TitleStyle}{\LARGE\bfseries}
\newcommand{\AuthorStyle}{\itshape}
\newcommand{\CourseStyle}{\itshape}
\newcommand{\ProfessorStyle}{\itshape}
\newcommand{\DateStyle}{\itshape}

\newcommand{\WatermarkStyle}{\itshape\sffamily}

% -------------------- Options --------------------

\DeclareOption{twocolumn}{\OptionNotUsed}
\DeclareOption{twoside}{\OptionNotUsed}

\newif\ifchinese@option
\DeclareOption{chinese}{%
    \chinese@optiontrue

    \renewcommand{\DocumentClass}{ctexart}

    \AtBeginDocument{\renewcommand{\itshape}{\simkai}} % TODO: 观察是否引起问题

    \renewcommand{\CourseLang}{课程}
    \renewcommand{\DateLang}{日期}
    \renewcommand{\StudentLang}{姓名}
    \renewcommand{\ProfessorLang}{教师}

    \renewcommand{\InstituteStyle}{\sffamily}

    \renewcommand{\WatermarkStyle}{\fzstk}
}

\newif\iflineno@option
\DeclareOption{lineno}{\lineno@optiontrue}

\newif\ifwatermark@option
\DeclareOption{watermark}{\watermark@optiontrue}

\PassOptionsToClass{a4paper}{\DocumentClass}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\DocumentClass}}

\ProcessOptions\relax

% -------------------- Bulk Declarations --------------------

\LoadClass{\DocumentClass}

% New title style for the document

\renewcommand{\maketitle}{%
    \thispagestyle{plain}
    \begin{center}
        \ifx\@institute\undefined{}\else{\InstituteStyle\@institute}\\\vspace{10pt}\fi
        \hrule
        \vspace{10pt}
        {\TitleStyle\@title}\\\vspace{5pt}
        \StudentLang: {\AuthorStyle\@author}
        \vspace{8pt}
        \hrule
        \vspace{10pt}
        \ifx\@course\undefined{}\else\CourseLang: {\CourseStyle\@course\ifx\@professor\undefined{}\else{-- }\fi}\fi
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

    \setCJKfamilyfont{fzstk}{FZShuTi} % 方正舒体
    \newcommand{\fzstk}{\CJKfamily{fzstk}}
\fi

% Typeset math

\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{commath} % abs, norm
% \RequirePackage{mathtools} % \xleftrightarrow.

%% Package: unicode-math

\RequirePackage[math-style=TeX, bold-style=TeX, partial=upright]{unicode-math}
\setmathfont{XITS Math}
\setmathfont[range={\mathcal,\mathbfcal}, StylisticSet=1]{XITS Math}

\newcommand*{\diff}{\mathop{}\!\symup{d}}
\newcommand*{\matr}[1]{\symsfit{#1}}
\newcommand*{\vect}[1]{\symbf{#1}}

%% Package: ntheorem

\RequirePackage[thmmarks, amsmath, thref, framed]{ntheorem} % 定理格式.
\RequirePackage{mdframed} % for \newframedtheorem

%%% Problem
\theoremstyle{plain}
\theoremheaderfont{\upshape\bfseries}
\theorembodyfont{\itshape}
\newframedtheorem{problem}{Problem}
%%% Note
\theoremstyle{plain}
\theoremheaderfont{\itshape}
\theorembodyfont{\itshape}
\newtheorem{note}{Note}
%%% Proof
\theoremstyle{nonumberplain}
\theoremheaderfont{\itshape}
\theorembodyfont{\upshape}
\theoremseparator{.}
\theoremsymbol{\ensuremath{\square}}
\newtheorem{proof}{Proof}
%%% Solution
\theoremsymbol{\ensuremath{\blacksquare}}
\newtheorem{solution}{Solution}


% Preload useful packages

\RequirePackage{enumerate}
\RequirePackage{float} % [H].
\RequirePackage{fontspec} % fonts.
\RequirePackage{subcaption} % subcaption and subfigure.
\RequirePackage[dvipsnames]{xcolor} % 颜色声明.

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

\setlength{\headheight}{15pt}
\lhead{Copyright \copyright\ \@author}
\rhead{Page \thepage\ of \pageref{LastPage}}

% Package: graphicx

\RequirePackage{graphicx}

\graphicspath{{resources/}} % 图像文件目录

% Package: hyperref

\RequirePackage{hyperref}

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

%% Title

\renewcommand\lstlistingname{代码}
\renewcommand\lstlistlistingname{代码}

%% Lstinline with color box

\LetLtxMacro{\oldlstinline}{\lstinline}
\renewcommand{\lstinline}[2][]{\colorbox{lightgray}{\oldlstinline[#1]{#2}}}
\newcommand{\matlabinline}[1]{
    \lstinline[style=MATLAB-editor, basicstyle=\mlttfamily]{#1}}

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

% Package: lineno

\iflineno@option
    \RequirePackage[mathlines, edtable]{lineno}

    \renewcommand{\linenumberfont}{\normalfont\scriptsize\sffamily}

    \let\oldlstinputlisting\lstinputlisting
    \renewcommand{\lstinputlisting}[2][\empty]{
        \par\nolinenumbers\oldlstinputlisting[#1]{#2}\linenumbers\par
    }

    \let\oldlstlisting\lstlisting
    \let\oldendlstlisting\endlstlisting
    \renewenvironment{lstlisting}
        {\par\nolinenumbers\oldlstlisting}
        {\oldendlstlisting\endnolinenumbers\par}

    \let\oldtable\table
    \let\oldendtable\endtable
    \renewenvironment{table}
        {\par\nolinenumbers\oldtable}
        {\oldendtable\endnolinenumbers\par}
\fi

% Package: pgfplotstable

\RequirePackage{pgfplotstable} % Need to load xcolor before loading xwatermark
\RequirePackage{booktabs}

\pgfplotsset{width=7cm, compat=1.16}

\pgfplotstableset{
    every head row/.style={before row=\toprule, after row=\midrule},
    every last row/.style={after row=\bottomrule}
}

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
