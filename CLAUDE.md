# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

MyMathsBook is a LaTeX book (`book` class, a4paper 11pt) collecting ~58 mathematics lessons for French
*classes préparatoires* (Maths Sup/Spé). Content and prose are in French.

## Build

Always compile through `latexmk`, **never** `pdflatex` directly — the recipe in `.latexmkrc` chains
`pdflatex → makeindex → makeglossaries → bibtex → pdflatex ×2` and writes all intermediates to `build/`:

```bash
latexmk -pdf -interaction=nonstopmode -outdir=build -f main.tex
```

- The final PDF is `build/main.pdf`; `.latexmkrc`'s `$success_cmd` copies it to `main.pdf` at the repo root.
- `.latexmkrc` also copies `backmatter/references.bib` into `build/` (bibtex resolves paths from `build/`),
  registers glossary custom deps (`.glo→.gls`, `.acn→.acr`), and forces `TZ=Europe/Paris` so the title
  page date is correct.
- Under VS Code, the **LaTeX Workshop** extension runs this recipe on save of `main.tex`.

There are no tests or linters; `chktex` is available in the devcontainer for optional style checking.

## Architecture

- **`main.tex` is the single source of truth for document assembly.** It loads `style/mathsup.sty`, then
  uses `\input` to pull in each lesson under the right `\part`/`\chapter`. Adding a lesson means creating
  `lecons/<section>/name.tex` **and** wiring an `\input{lecons/<section>/name}` into `main.tex` at the
  correct structural position — the file on disk is invisible to the build until that line exists.
- **Six parts**: Analyse réelle, Structures algébriques, Arithmétique, Combinatoire, Topologie, Algèbre
  linéaire. Note `lecons/` subdirectories (`analyse/`, `algebre/`, `ensembles/`, …) are an authoring
  convention and do **not** map one-to-one onto the book parts — e.g. `ensembles/` lessons live under the
  "Structures algébriques" part. The authoritative ordering is the sequence of `\input` lines in `main.tex`.
- **`style/mathsup.sty` defines all presentation.** Lessons use its semantic commands/environments rather
  than raw LaTeX styling, so visual changes are made centrally here:
  - Layout: `\lecontitle{Title}{Subtitle}`, `\secnum{color}{n}{Title}`, `\rubriq{Name}`, `\decsep`,
    `\leconfooter{Ref}`
  - Boxes/sidebars: `tcolorbox[thmbox]` (theorem, blue), `mdframed[style=proofbar]` (proof, blue bar),
    `[exbar]` (examples, green), `[cexbar]` (counter-examples, red), `[exobar]` (exercises, gold)
  - Palette: `thmblue` `#2E5FA0`, `proofgreen` `#2E6B3E`, `exred` `#8B2020`, plus gray accents
    `ideegray`/`goldaccent`/`rulegray`
- **Glossary, index, bibliography** are assembled in `main.tex`: glossary entries are defined in
  `backmatter/glossaire.tex` (loaded in the frontmatter, printed in backmatter via `\glsaddall`); the index
  uses `\makeindex`/`\printindex`; the bibliography is `backmatter/references.bib` with `\nocite{*}`.
- **`previews/`** holds standalone styling variants and is not part of the book build.

## Conventions

- After changing content, keep the table of contents, glossary, and `README.md` in sync, resolve
  compilation warnings, and regenerate the PDF with the `latexmk` command above.
- Use a dedicated branch per task and return to `main` once the commits are made.

## Environment

Devcontainer (`.devcontainer/Dockerfile`) is based on `texlive/texlive:latest-full` as user `vscode`, with
git and Claude Code preinstalled. `build/`, `.vscode/`, and most of `.claude/` are gitignored
(`.claude/agents/` is tracked to share agent definitions).
