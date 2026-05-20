# A faire après chaque tâche :
- Remettre à jour la table des matières et le glossaire
- Corriger les warnings de compilation
- Régénérer le book PDF avec : `latexmk -pdf -interaction=nonstopmode -outdir=build -f main.tex`
  (ne jamais utiliser pdflatex directement, les fichiers de build vont dans `build/`)
