% !Mode::"TeX:UTF-8"
% Options: chinese

% -------------------- Identification --------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{assignment}[2021/03/08]

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

% -------------------- Handle Options --------------------

\DeclareOption{twocolumn}{\OptionNotUsed}
\DeclareOption{twoside}{\OptionNotUsed}

\newif\ifchinese@option
\DeclareOption{chinese}{%
    \chinese@optiontrue

    \renewcommand{\DocumentClass}{ctexart}

    \renewcommand{\CourseLang}{课程}
    \renewcommand{\DateLang}{日期}
    \renewcommand{\StudentLang}{姓名}
    \renewcommand{\ProfessorLang}{教师}

    \renewcommand{\InstituteStyle}{\sffamily}
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\DocumentClass}}

\ProcessOptions\relax

% -------------------- More Declarations --------------------

\LoadClass[a4paper, 12pt]{\DocumentClass}

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
}

% Modify the sizes of the document

\RequirePackage{geometry}
\geometry{left=2.5cm, right=2.5cm, top=2.5cm, bottom=2.5cm}

% Change page style

\RequirePackage{fancyhdr}
\RequirePackage{lastpage}

\pagestyle{fancy}
\pagenumbering{arabic}

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

% Set theorem style

\RequirePackage{amsmath}
\RequirePackage[thmmarks, amsmath, thref, framed]{ntheorem} % 定理格式.
\RequirePackage{framed}
\RequirePackage[ntheorem]{mdframed} % for \newframedtheorem

\newcommand{\ProblemLang}{Problem}
\newcommand{\NoteLang}{Note}
\newcommand{\ProofLang}{Proof}
\newcommand{\SolutionLang}{Solution}

\ifchinese@option
    \renewcommand{\ProblemLang}{问题}
    \renewcommand{\NoteLang}{注}
    \renewcommand{\ProofLang}{证明}
    \renewcommand{\SolutionLang}{解}
\fi

%%% Problem
\theoremstyle{plain}
\theoremheaderfont{\upshape\bfseries}
\theorembodyfont{\upshape}
\newmdtheoremenv[outerlinewidth=2]{problem}{\ProblemLang}
%%% Note
\theoremstyle{plain}
\theoremheaderfont{\itshape}
\theorembodyfont{\itshape}
\newtheorem{note}{\NoteLang}
%%% Proof
\theoremstyle{nonumberplain}
\theoremheaderfont{\itshape}
\theorembodyfont{\upshape}
\theoremseparator{.}
\theoremsymbol{\ensuremath{\square}}
\newtheorem{proof}{\ProofLang}
%%% Solution
\theoremsymbol{\ensuremath{\blacksquare}}
\newtheorem{solution}{\SolutionLang}

\endinput
