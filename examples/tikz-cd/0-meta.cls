\NeedsTeXFormat{LaTeX2e}[2020/10/01]
\ProvidesClass{0-meta}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[12pt]{article}

\RequirePackage{geometry}
\geometry{a4paper, includeheadfoot, scale=0.8}

\RequirePackage[quiet]{fontspec}
\setmainfont{times}[%
  Ligatures = TeX,
  Extension = .ttf,
  BoldFont = timesbd,
  ItalicFont = timesi,
  BoldItalicFont = timesbi,
]
\RequirePackage{unicode-math}
\unimathsetup{%
  math-style = ISO,
  bold-style = ISO,
  nabla = upright,
  partial = upright,
}
\setmathfont{XITSMath-Regular}[
  Extension = .otf,
  BoldFont = XITSMath-Bold,
  StylisticSet = 8,
]
\setmathfont{XITSMath-Regular}[
  Extension = .otf,
  BoldFont = XITSMath-Bold,
  StylisticSet = 1,
  range = {cal, bfcal},
]
\setmathfont{XITSMath-Regular}[
  Extension = .otf,
  BoldFont = XITSMath-Bold,
  range = it/{greek,Greek,latin,Latin},
]
\setmathfont{XITSMath-Regular}[
  Extension = .otf,
  BoldFont = XITSMath-Bold,
  range = up/{greek,Greek,latin,Latin},
]
\setmathfont{XITSMath-Regular}[
  Extension = .otf,
  BoldFont = XITSMath-Bold,
  range = {
    "2212,"002B,"003D,"0028,"0029,"005B,%
    "005D,"221A,"2211,"2248,"222B,"007C,"2026,"2202,"00D7,"0302,%
    "2261,"0025,"22C5,"00B1,"2194,"21D4%
  },
]
\setmathfont{times}[
  Extension = .ttf,
  range = up/{num},
  BoldFont = timesbd,
]
\setmathfont{timesbd}[
  Extension = .ttf,
  range = bfup/{num},
  BoldFont = timesbd,
]

\RequirePackage{enumitem}
\setlist*{nosep}

\linespread{1.2}

\endinput
