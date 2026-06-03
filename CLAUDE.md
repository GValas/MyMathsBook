# A faire après chaque tâche :
- Remettre à jour la table des matières et le glossaire
- Remmetre à jour le README.md
- Corriger les warnings de compilation
- Régénérer le book PDF avec : `latexmk -pdf -interaction=nonstopmode -outdir=build -f main.tex`
  (ne jamais utiliser pdflatex directement, les fichiers de build vont dans `build/`)
- Créer une nouvelle branche pour chaque nouvelle tache, et repasser sur main une fois tous les commits faits