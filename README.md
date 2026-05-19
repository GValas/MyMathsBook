# Leçons de Mathématiques — Maths Sup/Spé

Projet LaTeX structuré pour un recueil de leçons de mathématiques de classes préparatoires.

## Structure du projet

```
mathsup/
├── main.tex                  ← Point d'entrée, compiler celui-ci
├── .vscode/
│   └── settings.json         ← Configuration LaTeX Workshop (VS Code)
├── style/
│   └── mathsup.sty           ← Feuille de style commune (palette, barres, boîtes)
├── frontmatter/
│   ├── pagedeGarde.tex       ← Page de garde
│   └── preface.tex           ← Avant-propos
├── lecons/
│   ├── analyse/
│   │   ├── bolzano.tex       ← Bolzano-Weierstrass
│   │   ├── tvi.tex           ← Théorème des valeurs intermédiaires
│   │   └── wallis.tex        ← Intégrales de Wallis
│   └── algebre/
│       ├── cayley.tex        ← Cayley-Hamilton
│       └── spectral.tex      ← Théorème spectral
└── backmatter/
    ├── glossaire.tex         ← Définitions du glossaire
    └── references.bib        ← Bibliographie BibTeX
```

## Compilation sous VS Code

1. Installer l'extension **LaTeX Workshop** (James Yu)
2. Ouvrir le dossier `mathsup/` dans VS Code
3. Ouvrir `main.tex` et sauvegarder : la compilation démarre automatiquement
4. La recette complète est : `pdflatex → makeindex → makeglossaries → bibtex → pdflatex → pdflatex`

## Compilation en ligne de commande

```bash
cd mathsup
pdflatex main
makeindex main
makeglossaries main
bibtex main
pdflatex main
pdflatex main
```

## Ajouter une nouvelle leçon

1. Créer `lecons/<section>/nom.tex` en suivant la structure des leçons existantes
2. Utiliser les commandes du style :
   - `\lecontitle{Titre}{Sous-titre}` — en-tête de la leçon
   - `\secnum{navyblue}{1}{Titre de section}` — section numérotée
   - `\rubriq{Nom}` — sous-rubrique
   - `\decsep` — séparateur décoratif
   - `\leconfooter{Référence}` — pied de page
3. Environnements disponibles :
   - `tcolorbox[thmbox]` — boîte théorème bleue
   - `mdframed[style=proofbar]` — barre bleu (preuve)
   - `mdframed[style=exbar]` — barre verte (exemples)
   - `mdframed[style=cexbar]` — barre rouge (contre-exemples)
   - `mdframed[style=exobar]` — barre or (exercices)
4. Ajouter `\input{lecons/<section>/nom}` dans `main.tex` au bon endroit

## Palette de couleurs

| Nom          | Hex       | Usage                    |
|--------------|-----------|--------------------------|
| `navyblue`   | `#1A2E4A` | Titres, cadres, preuves  |
| `goldaccent` | `#C9A84C` | Séparateurs, exercices   |
| `exgreen`    | `#2E6B3E` | Exemples                 |
| `counterred` | `#8B2020` | Contre-exemples          |
| `theorembg`  | `#EDF2F9` | Fond boîte théorème      |
