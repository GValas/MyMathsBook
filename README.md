# Leçons de Mathématiques — Maths Sup/Spé

Projet LaTeX structuré pour un recueil de leçons de mathématiques de classes préparatoires.

## Structure du projet

```
MyMathsBook/
├── main.tex                  ← Point d'entrée, compiler celui-ci
├── .latexmkrc                ← Configuration de la recette latexmk
├── build/                    ← Sortie de compilation (PDF, .aux, .log…)
├── .vscode/
│   └── settings.json         ← Configuration LaTeX Workshop (VS Code)
├── style/
│   └── mathsup.sty           ← Feuille de style commune (palette, barres, boîtes)
├── frontmatter/
│   ├── pagedeGarde.tex       ← Page de garde
│   └── preface.tex           ← Avant-propos
├── lecons/                   ← 42 leçons réparties en 6 parties
│   ├── analyse/              ← Analyse réelle (suites, continuité, intégration…)
│   ├── algebre/              ← Structures algébriques & algèbre linéaire
│   ├── ensembles/            ← Construction des nombres (ℕ, ℤ, ℚ, ℝ, ℂ, ℍ)
│   ├── arithmetique/         ← Nombres premiers, irrationalité
│   ├── combinatoire/         ← Partitions d'ensembles (Bell)
│   └── topologie/            ← Espaces métriques complets (Baire)
└── backmatter/
    ├── glossaire.tex         ← Définitions du glossaire
    └── references.bib        ← Bibliographie BibTeX
```

Le livre est organisé en six parties :
1. **Analyse réelle** — Suites, continuité, dérivabilité, intégration, fonctions élémentaires, valeurs remarquables du cosinus, fonctions spéciales (Gamma, zêta de Riemann, Bernoulli), polynômes orthogonaux (Tchebychev, Legendre, Jacobi, Hermite, Laguerre), interpolation et approximation polynomiale (Lagrange, Newton, Bernstein), géométrie en grande dimension.
2. **Structures algébriques** — Relations et ensembles quotients, construction des nombres (ℕ, ℤ, ℚ, ℝ, ℂ, ℍ), groupes, anneaux et corps, corps des fractions, nombres complexes.
3. **Arithmétique** — Nombres premiers, irrationalité, polynômes cyclotomiques.
4. **Combinatoire** — Partitions d'ensembles.
5. **Topologie** — Espaces métriques complets.
6. **Algèbre linéaire** — Applications linéaires, déterminant, endomorphismes, exponentielle matricielle, produit scalaire, matrices orthogonales, endomorphismes autoadjoints.

## Compilation sous VS Code

1. Installer l'extension **LaTeX Workshop** (James Yu)
2. Ouvrir le dossier `MyMathsBook/` dans VS Code
3. Ouvrir `main.tex` et sauvegarder : la compilation démarre automatiquement
4. La recette `latexmk` enchaîne automatiquement `pdflatex`, `makeindex`,
   `makeglossaries` et `bibtex` autant de fois que nécessaire.

## Compilation en ligne de commande

La compilation se fait **toujours** via `latexmk` (jamais `pdflatex`
directement) ; tous les fichiers intermédiaires sont écrits dans `build/` :

```bash
latexmk -pdf -interaction=nonstopmode -outdir=build -f main.tex
```

Le PDF final est produit dans `build/main.pdf` (et recopié en `main.pdf`
à la racine).

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

| Nom          | Valeur      | Usage                                   |
|--------------|-------------|-----------------------------------------|
| `thmblue`    | `#2E5FA0`   | Cadres et titres de théorèmes           |
| `proofgreen` | `#2E6B3E`   | Preuves & exemples                      |
| `exred`      | `#8B2020`   | Exercices & contre-exemples             |
| `ideegray`   | `gray 0.32` | « Idée de la preuve » (italique gris)   |
| `goldaccent` | `gray 0.45` | Séparateurs décoratifs                  |
| `rulegray`   | `gray 0.55` | Filets et règles                        |
| `theorembg`  | `#FFFFFF`   | Fond des boîtes théorème                |
