# LaTeX Template

[![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)

> A LaTeX template used by NotoOotori.

LaTeX Template aims to build templates to cover most of common scenarios including assignments, thesis and slides.

## Install

1. Install LaTeX by downloading and installing TeXlive or MikTeX.
2. Install required packages.
   - If willing to use LaTeXmk engine to compile TeX files, please install Perl.

## Usage

1. Change to some directory under `templates/`.
2. Run `latexmk -xelatex %DOCFILE%`, where `%DOCFILE%` refers to the TeX file name.
3. View the output pdf.

## Contributing

Feel free to contribute. [Open an issue](https://github.com/NotoOotori/latex_template/issues) or submit PRs.

## License

The repository is UNLICENSED. All rights reserved.
